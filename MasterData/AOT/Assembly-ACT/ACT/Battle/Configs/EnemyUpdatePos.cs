using UnityEngine;

namespace ACT.Battle.Configs;

[SerializeField]
public struct EnemyUpdatePos
{
	[Tooltip("最小落位范围")]
	public float minHoldDis;

	[Tooltip("最大落位范围")]
	public float maxHoldDis;

	[Tooltip("最小更新范围")]
	public float minUpdateDis;

	[Tooltip("最大更新范围")]
	public float maxUpdateDis;
}
