using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class DodgeSuccessEffect : AniPart
{
	public uint scanLineIndex;

	public uint scanRangeIndex;

	public uint noiseOffsetScanIndex;

	public uint scanNoisePower;

	public uint dissolveEmmision1ColorId;

	public uint dissolveEmmision2ColorId;

	private AnimationCurve m_scanLineIndex;

	private AnimationCurve m_ScanRangeIndex;

	private AnimationCurve m_NoiseOffsetScanIndex;

	private AnimationCurve m_ScanNoisePower;

	private Color m_DissolveEmmision1Color;

	private Color m_DissolveEmmision2Color;

	public override void Init(AniPartControl owner)
	{
		base.Init(owner);
		CurveLibrary curveLibrary = GameLoader.meta.curveLibrary;
		m_scanLineIndex = curveLibrary.GetCurve(scanLineIndex);
		m_ScanRangeIndex = curveLibrary.GetCurve(scanRangeIndex);
		m_NoiseOffsetScanIndex = curveLibrary.GetCurve(noiseOffsetScanIndex);
		m_ScanNoisePower = curveLibrary.GetCurve(scanNoisePower);
		m_DissolveEmmision1Color = curveLibrary.GetColor(dissolveEmmision1ColorId);
		m_DissolveEmmision2Color = curveLibrary.GetColor(dissolveEmmision2ColorId);
	}

	public override void OnForwardPlayStart(Entity entity)
	{
		SetColorForAllTargets(BattleConsts.SHAER_EFFECT_DISSOLVEEMMISION1, m_DissolveEmmision1Color);
		SetColorForAllTargets(BattleConsts.SHAER_EFFECT_DISSOLVEEMMISION2, m_DissolveEmmision2Color);
	}

	public override void OnBackWardPlayStart(Entity entity)
	{
		SetColorForAllTargets(BattleConsts.SHAER_EFFECT_DISSOLVEEMMISION1, m_DissolveEmmision1Color);
		SetColorForAllTargets(BattleConsts.SHAER_EFFECT_DISSOLVEEMMISION2, m_DissolveEmmision2Color);
	}

	protected override void SetMatParameters(MaterialPropertyBlock propertyBlock)
	{
		propertyBlock.SetFloat(BattleConsts.SHADER_DISSOLVE_NEW_SCAN_LINE, EvaluateCurve(m_scanLineIndex));
		propertyBlock.SetFloat(BattleConsts.SHADER_EFFECT_SCANRANGE, EvaluateCurve(m_ScanRangeIndex));
		propertyBlock.SetFloat(BattleConsts.SHADER_EFFECT_NOISEOFFSETSCAN, EvaluateCurve(m_NoiseOffsetScanIndex));
		propertyBlock.SetFloat(BattleConsts.SHADER_EFFECT_SCANNOISEPOWER, EvaluateCurve(m_ScanNoisePower));
	}
}
