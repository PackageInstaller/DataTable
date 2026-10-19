using ACT.Battle.Configs;
using UnityEngine;

namespace ACT.Config;

public class BattleMetaRes : ScriptableObject
{
	public ConfigGroundLightDiePara configGroundLightDiePara;

	public ConfigGlobalSpeed hitGlobalSpeed;

	public float ditherTime = 0.5f;

	public float hitEffectTime = 0.1f;

	public float getHitTime = 0.1f;

	public ConfigCommonEnemyInfo enemyInfo;

	public ConfigHitEffectComparisonTable hitEffectComparisonTable;

	[Tooltip("破盾时的通用处理")]
	public ConfigBreakPostureActions breakPostureActions;

	public float coyoteTime = 0.1f;

	public float lastConflictTriggerTimer = 0.2f;

	public float dissolveTime = 0.5f;

	public float roleGetHitTime = 0.1f;

	public float roleGetHitLightTime = 0.1f;

	public float roleDummyDuration = 0.3f;

	public float roleDummyRadius;

	public float roleDummyHeight;

	public float roleAttackCompensation;
}
