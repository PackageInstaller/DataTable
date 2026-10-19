using ACT.Battle.Configs;
using UnityEngine;

namespace ACT.Battle;

public class ShaderACTNewDissolveCutPart : AniPart
{
	public uint dissolveThresholdIndex;

	public float dissolveThreshold;

	private AnimationCurve m_dissolveThresholdCurve;

	protected override void SetMatParameters(MaterialPropertyBlock propertyBlock)
	{
		if (m_dissolveThresholdCurve != null)
		{
			dissolveThreshold = EvaluateCurve(m_dissolveThresholdCurve);
			propertyBlock.SetFloat(BattleConsts.SHADER_ACT_NEW_DISSOLVE_CUT, dissolveThreshold);
		}
	}

	public override void Init(AniPartControl owner)
	{
		base.Init(owner);
		CurveLibrary curveLibrary = GameLoader.meta.curveLibrary;
		m_dissolveThresholdCurve = curveLibrary.GetCurve(dissolveThresholdIndex);
	}
}
