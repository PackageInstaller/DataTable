using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

[SerializeField]
public class ConfigCommonEnemyInfo : LuminSerializedScriptableObject
{
	public Dictionary<MonsterAttackType, Common> enemyInfoDict;

	[Header("每个职业都完全通用的信息")]
	public float loseAttackTokenTimeByHit = 2f;

	public float loseAttackTokenTimeByMove = 2f;

	[Obsolete]
	public Vector2 waitTimeRandomRange = new Vector2(0.3f, 1.5f);

	public float startRunDis = 3f;

	public float enemyStopMoveDisRange = 0.25f;

	public float enemyMinMoveDis = 1.5f;

	public Vector2 bossLoseBattleSize = new Vector2(50f, 50f);
}
