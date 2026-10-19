using UnityEngine;

namespace ACT.Config;

[SerializeField]
public class RaidPerformanceConfig : LuminSerializedScriptableObject
{
	public YooAssetReference OpeningPrefrmanceTimeline;

	public AnimationCurve OpeningTimeScale;

	public YooAssetReference SettlementPreformanceTimeline;

	public AnimationCurve SettlementTimeScale;
}
