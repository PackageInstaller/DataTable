using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Unity.VisualScripting;
using UnityEngine;

namespace ACT.BluePrint;

[UnitCategory("ACT")]
public sealed class TeamChallengeSpawnMonsterUnit : WaitUnit, IGraphElementWithData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	private sealed class Data : IGraphElementData
	{
		public readonly List<WorldMonsterPointData> MonsterPoints = new List<WorldMonsterPointData>();

		public readonly List<Entity> Monsters = new List<Entity>();

		public readonly List<float> RefillDueTimes = new List<float>();

		public CancellationTokenSource CancellationTokenSource;

		public int NextPointIndex;

		public int IssuedCount;

		public int SpawnedCount;

		public int WorldMonsterPointConfigId;

		public int SpawnLimit;

		public bool ReachedPointEnd;

		public bool UseDeathRefill;

		public bool Cancelled;

		public bool CanExit;
	}

	private const int MaxSpawnCount = 99;

	private const int WaveSpawnCount = 3;

	private const int WaveAliveLimit = 6;

	private const float WaveIntervalSeconds = 5f;

	private const int RefillInitialSpawnCount = 5;

	private const int RefillAliveLimit = 5;

	private const float RefillDelaySeconds = 2f;

	private const TeamChallengeSpawnDifficulty DefaultSpawnDifficulty = TeamChallengeSpawnDifficulty.DeathDelayedRefillOne;

	[DoNotSerialize]
	public ControlInput cancel;

	[DoNotSerialize]
	public ControlOutput onWaveSpawned;

	protected override void Definition()
	{
		base.Definition();
		cancel = ControlInput("cancel", Cancel);
		onWaveSpawned = ControlOutput("onWaveSpawned");
		Succession(enter, onWaveSpawned);
	}

	protected override IEnumerator Await(Flow flow)
	{
		Data data = flow.stack.GetElementData<Data>(this);
		yield return RunAsync(flow, data).ToCoroutine();
		yield return data.CanExit ? exit : null;
	}

	public IGraphElementData CreateData()
	{
		return new Data();
	}

	public override void Uninstantiate(GraphReference instance)
	{
		Release(instance.ToStackPooled().GetElementData<Data>(this));
		base.Uninstantiate(instance);
	}

	private ControlOutput Cancel(Flow flow)
	{
		Release(flow.stack.GetElementData<Data>(this));
		return null;
	}

	private async UniTask RunAsync(Flow flow, Data data)
	{
		Release(data);
		data.Cancelled = false;
		data.CanExit = false;
		data.CancellationTokenSource = new CancellationTokenSource();
		CancellationToken token = data.CancellationTokenSource.Token;
		if (!TryCollectCurrentWorldMonsterPoints(data))
		{
			Debug.LogError("TeamChallengeSpawnMonsterUnit: 当前副本世界未注册配队挑战怪点组。");
			return;
		}
		List<WorldMonsterPointData> points = data.MonsterPoints;
		int num = Model<TeamTeachingModel>.Interface.CurrentTrainingContent?.worldMonsterPointID ?? 0;
		if (RuntimeConfigs.data?.worldMonsterPoints == null || num <= 0 || !RuntimeConfigs.data.worldMonsterPoints.TryGetValue(num, out var value) || value.spawnPoint == null || value.spawnPoint.Count == 0)
		{
			Debug.LogError($"TeamChallengeSpawnMonsterUnit: missing training worldMonsterPoint config. id={num}.");
			return;
		}
		data.WorldMonsterPointConfigId = num;
		data.SpawnLimit = Mathf.Min(99, points.Count);
		TeamChallengeSpawnDifficulty spawnDifficulty = GetSpawnDifficulty();
		data.UseDeathRefill = spawnDifficulty == TeamChallengeSpawnDifficulty.DeathDelayedRefillOne || spawnDifficulty == TeamChallengeSpawnDifficulty.DeathDelayedRefillTwo;
		switch (spawnDifficulty)
		{
		case TeamChallengeSpawnDifficulty.WaveInterval:
			await RunWaveIntervalAsync(flow, data, points, token);
			break;
		case TeamChallengeSpawnDifficulty.DeathDelayedRefillOne:
		case TeamChallengeSpawnDifficulty.DeathDelayedRefillTwo:
			await RunDeathDelayedRefillAsync(flow, data, points, token);
			break;
		}
		if (!data.Cancelled)
		{
			data.CanExit = data.SpawnedCount > 0;
			if (!data.CanExit)
			{
				Debug.LogError($"TeamChallengeSpawnMonsterUnit: no monster was spawned. points={points.Count}, issued={data.IssuedCount}.");
			}
		}
	}

	private static TeamChallengeSpawnDifficulty GetSpawnDifficulty()
	{
		return (Model<TeamTeachingModel>.Interface.CurrentTrainingContent?.level ?? 0) switch
		{
			1 => TeamChallengeSpawnDifficulty.WaveInterval, 
			2 => TeamChallengeSpawnDifficulty.DeathDelayedRefillOne, 
			3 => TeamChallengeSpawnDifficulty.DeathDelayedRefillTwo, 
			_ => TeamChallengeSpawnDifficulty.DeathDelayedRefillOne, 
		};
	}

	private async UniTask RunWaveIntervalAsync(Flow flow, Data data, IReadOnlyList<WorldMonsterPointData> points, CancellationToken cancellationToken)
	{
		if (await SpawnUpToAsync(data, points, 3, 6, cancellationToken))
		{
			flow.Invoke(onWaveSpawned);
		}
		while (!cancellationToken.IsCancellationRequested && !data.ReachedPointEnd && data.IssuedCount < data.SpawnLimit)
		{
			await UniTask.Delay(TimeSpan.FromSeconds(5.0), ignoreTimeScale: false, PlayerLoopTiming.Update, cancellationToken).SuppressCancellationThrow();
			if (cancellationToken.IsCancellationRequested)
			{
				return;
			}
			if (await SpawnUpToAsync(data, points, 3, 6, cancellationToken))
			{
				flow.Invoke(onWaveSpawned);
			}
		}
		await WaitAllMonstersDeadAsync(data, cancellationToken);
	}

	private async UniTask RunDeathDelayedRefillAsync(Flow flow, Data data, IReadOnlyList<WorldMonsterPointData> points, CancellationToken cancellationToken)
	{
		if (await SpawnUpToAsync(data, points, 5, 5, cancellationToken))
		{
			flow.Invoke(onWaveSpawned);
		}
		if (data.Monsters.Count == 0)
		{
			return;
		}
		while (!cancellationToken.IsCancellationRequested)
		{
			PruneInvalidMonsters(data);
			if ((data.IssuedCount >= data.SpawnLimit || data.ReachedPointEnd) && data.RefillDueTimes.Count == 0 && data.Monsters.Count == 0)
			{
				break;
			}
			bool flag = false;
			float now = Time.time;
			for (int i = data.RefillDueTimes.Count - 1; i >= 0; i--)
			{
				if (!(data.RefillDueTimes[i] > now))
				{
					data.RefillDueTimes.RemoveAt(i);
					bool flag2 = flag;
					flag = flag2 | await SpawnUpToAsync(data, points, 1, 5, cancellationToken);
					if (cancellationToken.IsCancellationRequested)
					{
						return;
					}
				}
			}
			if (flag)
			{
				flow.Invoke(onWaveSpawned);
			}
			await UniTask.Yield(PlayerLoopTiming.Update, cancellationToken).SuppressCancellationThrow();
		}
	}

	private async UniTask WaitAllMonstersDeadAsync(Data data, CancellationToken cancellationToken)
	{
		while (!cancellationToken.IsCancellationRequested)
		{
			PruneInvalidMonsters(data);
			if (data.Monsters.Count == 0)
			{
				break;
			}
			await UniTask.Yield(PlayerLoopTiming.Update, cancellationToken).SuppressCancellationThrow();
		}
	}

	private async UniTask<bool> SpawnUpToAsync(Data data, IReadOnlyList<WorldMonsterPointData> points, int requestedCount, int aliveLimit, CancellationToken cancellationToken)
	{
		bool spawned = false;
		int spawnedCount = 0;
		while (spawnedCount < requestedCount && !cancellationToken.IsCancellationRequested)
		{
			PruneInvalidMonsters(data);
			if (data.Monsters.Count >= aliveLimit || data.IssuedCount >= data.SpawnLimit || data.ReachedPointEnd)
			{
				break;
			}
			if (await SpawnNextAsync(data, points, cancellationToken))
			{
				spawned = true;
				spawnedCount++;
			}
		}
		return spawned;
	}

	private async UniTask<bool> SpawnNextAsync(Data data, IReadOnlyList<WorldMonsterPointData> points, CancellationToken cancellationToken)
	{
		while (data.NextPointIndex < data.SpawnLimit)
		{
			WorldMonsterPointData point = points[data.NextPointIndex++];
			if (!TryBuildSpawnParams(point, data.WorldMonsterPointConfigId, out var spawnParams))
			{
				continue;
			}
			data.IssuedCount++;
			Entity entity = GameManager.entities.factory.CreateEnemy(spawnParams.id);
			await MonoECS.instance.CoServerSpawnMonster(entity, spawnParams);
			if (cancellationToken.IsCancellationRequested)
			{
				if (entity.IsValid)
				{
					MonoECS.instance.TryRemoveBehave(entity);
				}
				return false;
			}
			if (!entity.IsValid || !entity.IsAlive())
			{
				return false;
			}
			string[] buffList = point.buffList;
			if (buffList != null && buffList.Length > 0)
			{
				entity.GetCompAbility().AddAbilities(point.buffList, AbilitySource.BluePrint);
			}
			entity.GetCompAbility().onDie += (Action<Entity>)((Entity deadEntity) =>
			{
				OnMonsterDie(data, deadEntity);
			});
			data.Monsters.Add(entity);
			data.SpawnedCount++;
			return true;
		}
		data.ReachedPointEnd = true;
		return false;
	}

	private void OnMonsterDie(Data data, Entity deadEntity)
	{
		data.Monsters.Remove(deadEntity);
		if (!data.Cancelled && data.UseDeathRefill && data.IssuedCount + data.RefillDueTimes.Count < data.SpawnLimit && !data.ReachedPointEnd)
		{
			data.RefillDueTimes.Add(Time.time + 2f);
		}
	}

	private static void PruneInvalidMonsters(Data data)
	{
		for (int num = data.Monsters.Count - 1; num >= 0; num--)
		{
			Entity entity = data.Monsters[num];
			if (!entity.IsValid || !entity.IsAlive())
			{
				data.Monsters.RemoveAt(num);
			}
		}
	}

	private static bool TryCollectCurrentWorldMonsterPoints(Data data)
	{
		data.MonsterPoints.Clear();
		WorldManager worldManager = Fundamental.Singleton<GameManager>.instance?.worldManager;
		if (worldManager == null)
		{
			return false;
		}
		foreach (StateWorldAssetData item in worldManager.FetchActiveWorldStateAssetDatas())
		{
			if (item is WorldMonsterPointData { uniqueIndex: >=0 } worldMonsterPointData)
			{
				data.MonsterPoints.Add(worldMonsterPointData);
			}
		}
		data.MonsterPoints.Sort((WorldMonsterPointData left, WorldMonsterPointData right) => left.uniqueIndex.CompareTo(right.uniqueIndex));
		return data.MonsterPoints.Count > 0;
	}

	private static bool TryBuildSpawnParams(WorldMonsterPointData pointData, int worldMonsterPointConfigId, out SpawnMonsterParams spawnParams)
	{
		spawnParams = null;
		if (pointData == null || RuntimeConfigs.data?.worldMonsterPoints == null || RuntimeConfigs.data.enemySpawns == null)
		{
			return false;
		}
		if (!RuntimeConfigs.data.worldMonsterPoints.TryGetValue(worldMonsterPointConfigId, out var value))
		{
			return false;
		}
		int num = 0;
		foreach (ItemKv item in value.spawnPoint)
		{
			if (item.id == pointData.uniqueIndex)
			{
				num = item.count;
				break;
			}
		}
		if (num <= 0 || !RuntimeConfigs.data.enemySpawns.TryGetValue(num, out var value2) || value2.enemy == null || value2.enemy.Count == 0)
		{
			return false;
		}
		int num2 = 0;
		int num3 = int.MinValue;
		for (int i = 0; i < value2.enemy.Count; i++)
		{
			Maybe maybe = value2.enemy[i];
			if (maybe.weight >= num3)
			{
				num3 = maybe.weight;
				num2 = maybe.id;
			}
		}
		if (num2 <= 0)
		{
			return false;
		}
		spawnParams = SpawnMonsterParams.SpawnMonsterParamsPool.Get();
		spawnParams.id = num2;
		spawnParams.monsterPointId = num;
		spawnParams.levelType = value2.enemyLevelType;
		spawnParams.level = value2.enemyLevelOffset;
		spawnParams.pos = pointData.monsterPosition;
		spawnParams.hatredSize = new Vector3(pointData.hartedSizeX, pointData.hartedSizeY, pointData.hartedSizeZ);
		spawnParams.hatredOffset = new Vector3(pointData.hartedOffsetX, pointData.hartedOffsetY, pointData.hartedOffsetZ);
		spawnParams.useRayCastCheckBlock = pointData.useRayCastCheckBlock;
		spawnParams.useDirectMonsterPointRange = pointData.useBoxColliderRange;
		spawnParams.useEntityPositionForHatredRange = pointData.useEntityPositionForHatredRange;
		spawnParams.useEntityPositionForLoseBattleRange = pointData.useEntityPositionForLoseRange;
		spawnParams.loseBattleSize = new Vector3(pointData.loseBattleSizeX, pointData.loseBattleSizeY, pointData.loseBattleSizeZ);
		spawnParams.loseBattleOffset = new Vector3(pointData.loseBattleOffsetX, pointData.loseBattleOffsetY, pointData.loseBattleOffsetZ);
		spawnParams.loseBattleCanCheckBlock = pointData.loseBattleCanCheckBlock;
		spawnParams.buffList = pointData.buffList;
		spawnParams.isLeft = pointData.isLeft;
		spawnParams.groupUid = pointData.groupUid;
		spawnParams.groupAi = pointData.groupAI;
		spawnParams.usePathOffsetChange = pointData.usePathOffsetChange;
		spawnParams.isHaveBornEffect = pointData.isHaveBornEffect;
		if (pointData.patrolPoint != null)
		{
			Pos[] patrolPoint = pointData.patrolPoint;
			foreach (Pos pos in patrolPoint)
			{
				spawnParams.patrolPoints.Add(pos);
			}
		}
		if (pointData.infoPoint != null)
		{
			Pos[] patrolPoint = pointData.infoPoint;
			foreach (Pos pos2 in patrolPoint)
			{
				spawnParams.infoPos.Add(pos2);
				spawnParams.infoPosName.Add(pos2.posName);
			}
		}
		return true;
	}

	private static void Release(Data data)
	{
		data.Cancelled = true;
		data.CancellationTokenSource?.Cancel();
		data.CancellationTokenSource?.Dispose();
		data.CancellationTokenSource = null;
		for (int i = 0; i < data.Monsters.Count; i++)
		{
			Entity eb = data.Monsters[i];
			if (eb.IsValid)
			{
				MonoECS.instance.TryRemoveBehave(eb);
			}
		}
		data.Monsters.Clear();
		data.MonsterPoints.Clear();
		data.RefillDueTimes.Clear();
		data.NextPointIndex = 0;
		data.IssuedCount = 0;
		data.SpawnedCount = 0;
		data.WorldMonsterPointConfigId = 0;
		data.SpawnLimit = 0;
		data.ReachedPointEnd = false;
		data.UseDeathRefill = false;
		data.CanExit = false;
	}
}
