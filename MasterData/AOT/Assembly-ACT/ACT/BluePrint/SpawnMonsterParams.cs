using System;
using System.Collections.Generic;
using ACT.Battle;
using Fundamental;
using Unity.VisualScripting;
using UnityEngine;

namespace ACT.BluePrint;

[Serializable]
[Inspectable]
public class SpawnMonsterParams : ICloneable
{
	public static ObjectPool<SpawnMonsterParams> SpawnMonsterParamsPool = new ObjectPool<SpawnMonsterParams>((SpawnMonsterParams x) =>
	{
		x.patrolPoints = Fundamental.ListPool<Vector3>.Get();
		x.infoPosName = Fundamental.ListPool<string>.Get();
		x.infoPos = Fundamental.ListPool<Vector3>.Get();
	}, (SpawnMonsterParams x) =>
	{
		Fundamental.ListPool<Vector3>.Release(x.patrolPoints);
		Fundamental.ListPool<string>.Release(x.infoPosName);
		Fundamental.ListPool<Vector3>.Release(x.infoPos);
		x.Reset();
	});

	[Inspectable]
	public int id;

	[Inspectable]
	public int monsterPointId;

	[Inspectable]
	public int levelType;

	[Inspectable]
	public int level;

	[Inspectable]
	public bool levelOverride;

	[Inspectable]
	public Vector3 pos;

	[Inspectable]
	public YooAssetReference scenePointPrefabAssetID;

	[Inspectable]
	public Quaternion spawnRotation = Quaternion.identity;

	[Inspectable]
	public Vector3 hatredSize;

	[Inspectable]
	public Vector3 hatredOffset;

	[Inspectable]
	public bool useRayCastCheckBlock;

	[Inspectable]
	public bool useDirectMonsterPointRange;

	[Inspectable]
	public bool useEntityPositionForHatredRange;

	[Inspectable]
	public bool useEntityPositionForLoseBattleRange;

	[Inspectable]
	public Vector3 loseBattleSize;

	[Inspectable]
	public Vector3 loseBattleOffset;

	[Inspectable]
	public bool loseBattleCanCheckBlock;

	[Inspectable]
	public bool isHaveBornEffect;

	[Inspectable]
	public string[] buffList;

	[Inspectable]
	public bool isLeft;

	[Inspectable]
	public bool useOwnerDirection;

	[Inspectable]
	public int groupAi = -1;

	[Inspectable]
	public int groupUid = -1;

	[Inspectable]
	public int aiIndex = -1;

	[Inspectable]
	public List<Vector3> patrolPoints;

	[Inspectable]
	public List<string> infoPosName;

	[Inspectable]
	public List<Vector3> infoPos;

	[Inspectable]
	public Alliance alliance = Alliance.Enemy;

	[Inspectable]
	public bool usePathOffsetChange;

	[Inspectable]
	public Vector3 pathOffset;

	[Inspectable]
	public bool bornInActive;

	[Inspectable]
	public bool shareBossInfoUI;

	[Inspectable]
	public bool battleRoomPreSpawn;

	[Inspectable]
	public string bornBehaviorName;

	[Inspectable]
	public Vector3 jumpInbornPos;

	[Inspectable]
	public bool needDither;

	public object Clone()
	{
		SpawnMonsterParams spawnMonsterParams = SpawnMonsterParamsPool.Get();
		spawnMonsterParams.id = id;
		spawnMonsterParams.monsterPointId = monsterPointId;
		spawnMonsterParams.levelType = levelType;
		spawnMonsterParams.level = level;
		spawnMonsterParams.levelOverride = levelOverride;
		spawnMonsterParams.pos = pos;
		spawnMonsterParams.scenePointPrefabAssetID = scenePointPrefabAssetID;
		spawnMonsterParams.spawnRotation = spawnRotation;
		spawnMonsterParams.hatredSize = hatredSize;
		spawnMonsterParams.hatredOffset = hatredOffset;
		spawnMonsterParams.useRayCastCheckBlock = useRayCastCheckBlock;
		spawnMonsterParams.useDirectMonsterPointRange = useDirectMonsterPointRange;
		spawnMonsterParams.useEntityPositionForHatredRange = useEntityPositionForHatredRange;
		spawnMonsterParams.useEntityPositionForLoseBattleRange = useEntityPositionForLoseBattleRange;
		spawnMonsterParams.loseBattleSize = loseBattleSize;
		spawnMonsterParams.loseBattleOffset = loseBattleOffset;
		spawnMonsterParams.loseBattleCanCheckBlock = loseBattleCanCheckBlock;
		spawnMonsterParams.isHaveBornEffect = isHaveBornEffect;
		spawnMonsterParams.buffList = buffList;
		spawnMonsterParams.isLeft = isLeft;
		spawnMonsterParams.useOwnerDirection = useOwnerDirection;
		spawnMonsterParams.groupAi = groupAi;
		spawnMonsterParams.groupUid = groupUid;
		spawnMonsterParams.aiIndex = aiIndex;
		spawnMonsterParams.alliance = alliance;
		spawnMonsterParams.usePathOffsetChange = usePathOffsetChange;
		spawnMonsterParams.pathOffset = pathOffset;
		spawnMonsterParams.bornInActive = bornInActive;
		spawnMonsterParams.shareBossInfoUI = shareBossInfoUI;
		spawnMonsterParams.battleRoomPreSpawn = battleRoomPreSpawn;
		if (patrolPoints != null)
		{
			foreach (Vector3 patrolPoint in patrolPoints)
			{
				spawnMonsterParams.patrolPoints.Add(patrolPoint);
			}
		}
		if (infoPos != null)
		{
			foreach (Vector3 infoPo in infoPos)
			{
				spawnMonsterParams.infoPos.Add(infoPo);
			}
		}
		if (infoPosName != null)
		{
			foreach (string item in infoPosName)
			{
				spawnMonsterParams.infoPosName.Add(item);
			}
		}
		spawnMonsterParams.bornBehaviorName = bornBehaviorName;
		spawnMonsterParams.jumpInbornPos = jumpInbornPos;
		spawnMonsterParams.needDither = needDither;
		return spawnMonsterParams;
	}

	public void Reset()
	{
		id = 0;
		monsterPointId = 0;
		levelType = 0;
		level = 0;
		levelOverride = false;
		pos = Vector3.zero;
		scenePointPrefabAssetID = null;
		spawnRotation = Quaternion.identity;
		hatredSize = default;
		hatredOffset = default;
		useRayCastCheckBlock = false;
		useDirectMonsterPointRange = false;
		useEntityPositionForHatredRange = false;
		useEntityPositionForLoseBattleRange = true;
		loseBattleSize = default;
		loseBattleOffset = default;
		loseBattleCanCheckBlock = false;
		isHaveBornEffect = false;
		buffList = null;
		isLeft = false;
		useOwnerDirection = false;
		groupAi = -1;
		groupUid = -1;
		aiIndex = -1;
		alliance = Alliance.Enemy;
		infoPosName = null;
		infoPos = null;
		bornInActive = false;
		shareBossInfoUI = false;
		battleRoomPreSpawn = false;
		bornBehaviorName = "";
		jumpInbornPos = Vector3.zero;
		needDither = false;
	}
}
