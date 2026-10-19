using System;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.World.Asset;
using UnityEngine;

namespace ACT.BluePrint;

[Serializable]
public class SpawnMonsterPoint : MonoBehaviour, ISpawnMonsterParams
{
	public int id;

	[HideInInspector]
	public bool useWorldLevel = true;

	[HideInInspector]
	public int level;

	public bool useServerPos;

	[HideInInspector]
	public Vector3 pathOffset = Vector3.zero;

	public bool useBoxColliderRange;

	public float hatredSizeX;

	public float hatredSizeY;

	public float hatredSizeZ;

	public float hatredOffsetX;

	public float hatredOffsetY;

	public float hatredOffsetZ;

	public bool useRayCastCheckBlock;

	public bool useEntityPositionForHatredRange;

	public float loseBattleSizeX;

	public float loseBattleSizeY;

	public float loseBattleSizeZ;

	public float loseBattleOffsetX;

	public float loseBattleOffsetY;

	public float loseBattleOffsetZ;

	public bool loseBattleCanCheckBlock;

	public bool useEntityPositionForLoseRange = true;

	[Tooltip("颜色")]
	public Color loseBattleColor = Color.green;

	public int groupUid = -1;

	public int groupIndex = -1;

	public bool usePathOffsetChange = true;

	public bool isHaveBornEffect = true;

	[Tooltip("不勾选代表出生时朝右，勾选代表出生时朝左")]
	public bool isLeft = true;

	[Tooltip("战斗房初始化时生成在 Jump In Pos，所属小组触发时执行出生行为")]
	public bool battleRoomPreSpawn;

	public string[] buffList;

	public YooAssetReference scenePointPrefabAssetID;

	public bool shareBossInfoUI;

	public Pos[] patrolPoints;

	public Pos[] infoPoint;

	[Space(30f)]
	[Tooltip("不选择就是用默认的")]
	public AiDictionary[] aiConfig;

	[Tooltip("不选择就是用默认的")]
	public MonsterBornBehaviorDataClass[] monsterBornBehaviorDataClasses;

	public Pos jumpInPos;

	public bool bornInActive;

	public Vector3 pos => transform.position + pathOffset;

	public SpawnMonsterParams GetSpawnMonsterParams()
	{
		SpawnMonsterParams param = SpawnMonsterParams.SpawnMonsterParamsPool.Get();
		param.id = GetMonsterId(id);
		param.monsterPointId = id;
		if (RuntimeConfigs.data.enemySpawns.TryGetValue(id, out var value))
		{
			param.levelType = value.enemyLevelType;
			param.level = value.enemyLevelOffset;
		}
		param.pos = this.pos;
		param.scenePointPrefabAssetID = scenePointPrefabAssetID;
		param.spawnRotation = transform.rotation;
		param.hatredSize = new Vector3(hatredSizeX, hatredSizeY, hatredSizeZ);
		param.hatredOffset = new Vector3(hatredOffsetX, hatredOffsetY, hatredOffsetZ);
		param.useRayCastCheckBlock = useRayCastCheckBlock;
		param.useDirectMonsterPointRange = useBoxColliderRange;
		param.useEntityPositionForHatredRange = useEntityPositionForHatredRange;
		param.useEntityPositionForLoseBattleRange = useEntityPositionForLoseRange;
		param.loseBattleSize = new Vector3(loseBattleSizeX, loseBattleSizeY, loseBattleSizeZ);
		param.loseBattleOffset = new Vector3(loseBattleOffsetX, loseBattleOffsetY, loseBattleOffsetZ);
		param.loseBattleCanCheckBlock = loseBattleCanCheckBlock;
		param.buffList = buffList;
		param.isLeft = isLeft;
		param.groupUid = groupUid;
		param.groupAi = groupIndex;
		param.shareBossInfoUI = shareBossInfoUI;
		param.battleRoomPreSpawn = battleRoomPreSpawn;
		AiDictionary aiDictionary = Array.Find(aiConfig, (AiDictionary e) => e.id == param.id);
		if (aiDictionary != null)
		{
			param.aiIndex = aiDictionary.index;
		}
		else
		{
			param.aiIndex = 0;
		}
		MonsterBornBehaviorDataClass monsterBornBehaviorDataClass = Array.Find(monsterBornBehaviorDataClasses, (MonsterBornBehaviorDataClass e) => e.id == param.id);
		if (monsterBornBehaviorDataClass != null)
		{
			param.bornBehaviorName = monsterBornBehaviorDataClass.index;
		}
		else
		{
			param.bornBehaviorName = string.Empty;
		}
		param.jumpInbornPos = jumpInPos;
		param.bornInActive = bornInActive;
		param.isHaveBornEffect = isHaveBornEffect;
		if (patrolPoints != null)
		{
			Pos[] array = patrolPoints;
			foreach (Pos pos in array)
			{
				param.patrolPoints.Add(pos);
			}
		}
		if (infoPoint != null)
		{
			Pos[] array = infoPoint;
			foreach (Pos pos2 in array)
			{
				param.infoPos.Add(pos2.value);
				param.infoPosName.Add(pos2.posName);
			}
		}
		param.usePathOffsetChange = usePathOffsetChange;
		return param;
	}

	public int GetMonsterId(int id)
	{
		if (RuntimeConfigs.data.enemySpawns.TryGetValue(id, out var value))
		{
			int totalWeight = value.enemy.Sum((Maybe x) => x.weight);
			int value2 = value.enemy.Max((Maybe x) => x.weight / totalWeight) * totalWeight;
			return value.enemy.Find((Maybe x) => x.weight == value2)?.id ?? 20901;
		}
		return 21001;
	}
}
