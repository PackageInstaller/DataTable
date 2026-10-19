using System;
using System.Collections.Generic;
using ACT.World.Asset;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("生成怪物", "Mixin", new string[] { "spawn", "monster" })]
public class ConfigMixinSpawnMonster : ConfigMixin
{
	public class MonsterPointPara
	{
		public int id;

		public ConfigFunction<Vector3> position;

		[HideInInspector]
		public bool useWorldLevel = true;

		[HideInInspector]
		public int level;

		[HideInInspector]
		public Vector3 pathOffset = Vector3.zero;

		public float hatredSizeX;

		public float hatredSizeY;

		public float hatredSizeZ;

		public float hatredOffsetX;

		public float hatredOffsetY;

		public float hatredOffsetZ;

		public bool useRayCastCheckBlock;

		public float loseBattleSizeX;

		public float loseBattleSizeY;

		public float loseBattleSizeZ;

		public float loseBattleOffsetX;

		public float loseBattleOffsetY;

		public float loseBattleOffsetZ;

		public bool loseBattleCanCheckBlock;

		[Tooltip("颜色")]
		public Color loseBattleColor = Color.green;

		public bool usePathOffsetChange = true;

		public bool isHaveBornEffect = true;

		public string[] buffList;

		[Tooltip("不勾选代表出生时朝右，勾选代表出生时朝左")]
		public bool isLeft = true;

		public int groupUid = -1;

		public int groupIndex = -1;

		public List<AiDictionary> aiConfig;

		public List<MonsterBornBehaviorDataClass> monsterBornBehaviorDataClasses;

		public ConfigFunction<Vector3>[] patrolPoints;

		public string[] infoPosName;

		public ConfigFunction<Vector3>[] infoPos;

		public ActionCreatGeneralEntity.SpawnLevelType levelType;

		public int levelOffset;

		public ActionCreatGeneralEntity.LifeSpan lifeSpan;

		public bool bornInActive;
	}

	[Serializable]
	public enum LimitType
	{
		Limit,
		MaxValue,
		TypeMaxLimit
	}

	public ConfigFunction<float> maxValue;

	public LimitType limitType;

	public AbilityEntityType abilityEntityType;

	public ConfigFunction<float> lifeTime = new ConstFloat();

	public ABProperty[] overrideProperty = new ABProperty[0];

	public List<MonsterPointPara> monsterParams;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinSpawnMonster(this, ab, index);
	}
}
