using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.UI;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Unity.VisualScripting;
using UnityEngine;

namespace ACT.BluePrint;

[UnitCategory("ACT")]
public class SpawnMonsterUnit : WaitUnit, IGraphElementWithData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	private sealed class Data : IGraphElementData
	{
		public CancellationTokenSource CancellationTokenSource;

		public List<Entity> Monsters;
	}

	[DoNotSerialize]
	public ControlInput cancel;

	[DoNotSerialize]
	public ControlOutput onMonsterSpawn;

	[DoNotSerialize]
	public ValueInput spawnMonsterPoint;

	protected override void Definition()
	{
		base.Definition();
		cancel = ControlInput("cancel", Cancel);
		onMonsterSpawn = ControlOutput("onMonsterSpawn");
		spawnMonsterPoint = ValueInput<List<SpawnMonsterPoint>>("spawnMonsterPoint", null);
		Succession(enter, onMonsterSpawn);
	}

	protected override IEnumerator Await(Flow flow)
	{
		Data data = flow.stack.GetElementData<Data>(this);
		yield return SpawnMonsters(flow).ToCoroutine();
		CancellationTokenSource cancellationTokenSource = data.CancellationTokenSource;
		yield return (cancellationTokenSource != null && cancellationTokenSource.IsCancellationRequested) ? null : exit;
	}

	private ControlOutput Cancel(Flow flow)
	{
		Data elementData = flow.stack.GetElementData<Data>(this);
		ReleaseMonster(elementData);
		return null;
	}

	private async UniTask SpawnMonsters(Flow flow)
	{
		Data data = flow.stack.GetElementData<Data>(this);
		data.CancellationTokenSource = new CancellationTokenSource();
		List<SpawnMonsterPoint> value = flow.GetValue<List<SpawnMonsterPoint>>(spawnMonsterPoint);
		await SpawnMonster(value, data.CancellationTokenSource.Token, data.Monsters).ToCoroutine();
		flow.Invoke(onMonsterSpawn);
		await UniTask.WaitUntil(() => data.Monsters.Count == 0, PlayerLoopTiming.Update, data.CancellationTokenSource.Token).SuppressCancellationThrow();
	}

	public override void Uninstantiate(GraphReference instance)
	{
		Data elementData = instance.ToStackPooled().GetElementData<Data>(this);
		ReleaseMonster(elementData);
		base.Uninstantiate(instance);
	}

	public IGraphElementData CreateData()
	{
		return new Data
		{
			Monsters = new List<Entity>()
		};
	}

	private void ReleaseMonster(Data data)
	{
		data.CancellationTokenSource?.Cancel();
		foreach (Entity monster in data.Monsters)
		{
			if (monster.IsValid)
			{
				MonoECS.instance.TryRemoveBehave(monster);
			}
		}
	}

	private async UniTask SpawnMonster(List<SpawnMonsterPoint> p, CancellationToken cancellationToken, List<Entity> monsters)
	{
		List<float> list = new List<float>(GameLoader.meta.pathOffsetChangeArray);
		list.RandomSort(0, list.Count - 1);
		List<UniTask> tasks = Fundamental.ListPool<UniTask>.Get();
		EntityFactory factory = GameManager.entities.factory;
		for (int i = 0; i < p.Count; i++)
		{
			SpawnMonsterParams spawnMonsterParams = p[i].GetSpawnMonsterParams();
			Entity eb = factory.CreateEnemy(spawnMonsterParams.id);
			tasks.Add(ServerSpawnMonster(p[i], spawnMonsterParams, eb, cancellationToken, list, i, monsters));
		}
		await UniTask.WhenAll(tasks);
		Fundamental.ListPool<UniTask>.Release(tasks);
	}

	private async UniTask ServerSpawnMonster(SpawnMonsterPoint smp, SpawnMonsterParams param, Entity eb, CancellationToken cancellationToken, List<float> pathIndexList, int curPathIndex, List<Entity> monsters)
	{
		await MonoECS.instance.CoServerSpawnMonster(eb, param);
		if (smp.buffList != null)
		{
			AddBuff(eb, smp.buffList);
		}
		if (smp.usePathOffsetChange && eb.GetEntityType() == EntityType.Monster && eb.GetConfig().MonsterAttackType != MonsterAttackType.support)
		{
			smp.pathOffset = new Vector3(0f, 0f, pathIndexList[curPathIndex % pathIndexList.Count]);
		}
		else
		{
			smp.pathOffset = Vector3.zero;
		}
		eb.GetCompPhysics().SetPathOffset(smp.pathOffset);
		if (cancellationToken.IsCancellationRequested)
		{
			MonoECS.instance.TryRemoveBehave(eb);
			return;
		}
		eb.GetCompAbility().onDie += (Action<Entity>)((Entity entity) =>
		{
			monsters.Remove(entity);
		});
		monsters.Add(eb);
	}

	private void AddBuff(Entity entity, string[] names)
	{
		if (!entity.IsValid)
		{
			return;
		}
		entity.GetCompAbility().AddAbilities(names, AbilitySource.BluePrint);
		if (entity == MonoECS.instance.mainEntity)
		{
			foreach (string item in names)
			{
				StageChallengeManager.localChallengeBuff.Add(item);
			}
		}
	}
}
