using UnityEngine;

namespace ACT.Battle.Configs;

[SerializeField]
public class Common
{
	[Tooltip("战斗房怪点不用这个")]
	public float enemyCommonFrontInBattleSizeX;

	[Tooltip("战斗房怪点不用这个")]
	public float enemyCommonBackInBattleSizeX;

	[Tooltip("战斗房怪点不用这个")]
	public float enemyCommonInBattleSizeY;

	[Tooltip("战斗房怪点不用这个")]
	public float enemyCommonLoseBattleSizeX;

	[Tooltip("战斗房怪点不用这个")]
	public float enemyCommonLoseBattleSizeY;

	[Tooltip("战斗房怪点不用这个")]
	public EnemyUpdatePos haveTokenUpdatePos;

	[Tooltip("战斗房怪点不用这个")]
	public EnemyUpdatePos dontHaveTokenUpdatePos;

	[Tooltip("战斗房怪点不用这个")]
	public FlyEnemyUpdatePos flyHaveTokenUpdatePos;

	[Tooltip("战斗房怪点不用这个")]
	public FlyEnemyUpdatePos flydontHaveTokenUpdatePos;
}
