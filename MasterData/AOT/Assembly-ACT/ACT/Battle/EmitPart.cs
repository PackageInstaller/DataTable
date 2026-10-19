using ACT.Battle.Configs;
using UnityEngine;

namespace ACT.Battle;

public class EmitPart : AniPart
{
	public uint index;

	private Gradient m_Gradient;

	public override void Init(AniPartControl owner)
	{
		base.Init(owner);
		CurveLibrary curveLibrary = GameLoader.meta.curveLibrary;
		m_Gradient = curveLibrary.GetGradient(index);
	}

	protected override void SetMatParameters(MaterialPropertyBlock propertyBlock)
	{
		AniPart.SetHdrColor(propertyBlock, BattleConsts.SUB_EFFECT_EMIT_COLOR, m_Gradient.Evaluate(curVal));
	}
}
