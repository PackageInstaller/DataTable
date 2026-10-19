using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Config;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class MonsterPointData : StateWorldAssetData
{
	[SerializeField]
	private ServiceSaveTag _serviceSaveTag = ServiceSaveTag.Monster;

	[SerializeField]
	private int m_initialStateId;

	public bool sixtyBossPoint;

	[NonSerialized]
	public int bossPoint;

	[NonSerialized]
	public int bossIndex;

	public int monsterPointId;

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
	private YooAssetReference _scenePointPrefabAssetID;

	[SerializeField]
	public Pos[] patrolPoint = new Pos[0];

	public Pos[] infoPoint = new Pos[0];

	[HideInInspector]
	public Vector3 pathOffset = Vector3.zero;

	public Dictionary<int, int> aiDictionary = new Dictionary<int, int>();

	public Dictionary<string, string> monsterBornBehaviorDict = new Dictionary<string, string>();

	[SerializeField]
	private StateWorldUid _wildBossCollectionUid;

	[SerializeField]
	private Pos _wildBossTpPoint;

	public override YooAssetReference addressAssetID => GameLoader.meta.monsterPointReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => _serviceSaveTag;

	public override int initialStateId => m_initialStateId;

	public Vector3 monsterPosition => initPos;

	public YooAssetReference ScenePointPrefabAssetID => _scenePointPrefabAssetID;

	public override LoadTiming loadTiming => LoadTiming.AfterSceneLoad;

	public override int resetStateId => 0;

	public override UniTask CollectPrecacheAsync(PrecacheCollector collector, CancellationToken ct = default(CancellationToken))
	{
		return CharacterPrecacheCollectUtility.CollectEnemyByMonsterPointIdAsync(monsterPointId, collector, ct);
	}

	public StateWorldUid GetWildBossCollectionUid()
	{
		return _wildBossCollectionUid;
	}

	public override Vector3 GetTeleportPos()
	{
		if (serviceSaveTag == ServiceSaveTag.WildBoss)
		{
			return _wildBossTpPoint.value;
		}
		return base.GetTeleportPos();
	}

	public override Vector3 GetSpawnPos()
	{
		if (serviceSaveTag == ServiceSaveTag.WildBoss)
		{
			return _wildBossTpPoint.value;
		}
		return base.GetSpawnPos();
	}
}
