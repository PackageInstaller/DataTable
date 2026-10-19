using System;
using System.Threading;
using ACT.Config;
using ACT.Core;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class WorldMonsterPointData : StateWorldAssetData
{
	public int uniqueIndex = -1;

	public int InitialStateId;

	public bool useBoxColliderRange;

	[Tooltip("区域大小")]
	public float hartedSizeX;

	[Tooltip("区域大小")]
	public float hartedSizeY;

	[Tooltip("区域大小")]
	public float hartedSizeZ;

	[Tooltip("偏移位置")]
	public float hartedOffsetX;

	[Tooltip("偏移位置")]
	public float hartedOffsetY;

	[Tooltip("偏移位置")]
	public float hartedOffsetZ;

	[Tooltip("默认不能")]
	public bool useRayCastCheckBlock;

	public bool useEntityPositionForHatredRange;

	[Tooltip("脱战区域大小")]
	public float loseBattleSizeX;

	[Tooltip("脱战区域大小")]
	public float loseBattleSizeY;

	[Tooltip("脱战区域大小")]
	public float loseBattleSizeZ;

	[Tooltip("偏移位置")]
	public float loseBattleOffsetX;

	[Tooltip("偏移位置")]
	public float loseBattleOffsetY;

	[Tooltip("偏移位置")]
	public float loseBattleOffsetZ;

	[Tooltip("默认不能")]
	public bool loseBattleCanCheckBlock;

	public bool useEntityPositionForLoseRange = true;

	public int groupUid = -1;

	[Tooltip("组ai")]
	public int groupAI = -1;

	public bool usePathOffsetChange = true;

	public bool isHaveBornEffect = true;

	[Tooltip("不勾选代表出生时朝右，勾选代表出生时朝左")]
	public bool isLeft = true;

	public string[] buffList;

	[SerializeField]
	public Pos[] patrolPoint = new Pos[0];

	public Pos[] infoPoint = new Pos[0];

	[HideInInspector]
	public Vector3 pathOffset = Vector3.zero;

	public override YooAssetReference addressAssetID => GameLoader.meta.worldMonsterPointReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.WorldMonsterPoint;

	public override int initialStateId => InitialStateId;

	public Vector3 monsterPosition => initPos + pathOffset;

	public override LoadTiming loadTiming => LoadTiming.AfterSceneLoad;

	public override UniTask CollectPrecacheAsync(PrecacheCollector collector, CancellationToken ct = default(CancellationToken))
	{
		int num = CharacterPrecacheCollectUtility.ResolveWorldMonsterPointId(this);
		if (num > 0)
		{
			return CharacterPrecacheCollectUtility.CollectEnemyByMonsterPointIdAsync(num, collector, ct);
		}
		return UniTask.CompletedTask;
	}

	public bool HasMonster()
	{
		return CoreUtils.ServiceBehaveId(Singleton<GameManager>.instance.worldManager.ActiveWorldId, stateWorldAssetUid) > 0;
	}
}
