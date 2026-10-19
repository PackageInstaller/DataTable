using ACT.Battle.Configs;
using UnityEngine;

namespace ACT.Battle;

public class EffectPart : AniPart
{
	public bool fresnel_color;

	public uint fresnel_color_x;

	public uint fresnel_color_y;

	public uint fresnel_color_z;

	public uint fresnel_color_w;

	private AnimationCurve fresnel_color_x_curve;

	private AnimationCurve fresnel_color_y_curve;

	private AnimationCurve fresnel_color_z_curve;

	private AnimationCurve fresnel_color_w_curve;

	public bool fresnel_range;

	public uint fresnel_range_index;

	private AnimationCurve fresnel_range_curve;

	public bool fresnel_smooth;

	public uint fresnel_smooth_index;

	private AnimationCurve fresnel_smooth_curve;

	public bool dither_threshold;

	public uint dither_threshold_index;

	private AnimationCurve dither_threshold_curve;

	public bool effect_outline;

	public uint effect_outline_index;

	private AnimationCurve effect_outline_curve;

	public bool effect_outline_color;

	public uint effect_outline_color_x;

	public uint effect_outline_color_y;

	public uint effect_outline_color_z;

	public uint effect_outline_color_w;

	private AnimationCurve effect_outline_color_x_curve;

	private AnimationCurve effect_outline_color_y_curve;

	private AnimationCurve effect_outline_color_z_curve;

	private AnimationCurve effect_outline_color_w_curve;

	public bool effect_outline_color_width;

	public uint effect_outline_color_width_index;

	private AnimationCurve effect_outline_color_width_curve;

	public bool effect_outline_width;

	public uint effect_outline_width_index;

	private AnimationCurve effect_outline_width_curve;

	public bool effect_emit_color;

	public uint effect_emit_color_x;

	public uint effect_emit_color_y;

	public uint effect_emit_color_z;

	public uint effect_emit_color_w;

	private AnimationCurve effect_emit_color_x_curve;

	private AnimationCurve effect_emit_color_y_curve;

	private AnimationCurve effect_emit_color_z_curve;

	private AnimationCurve effect_emit_color_w_curve;

	public override void Init(AniPartControl owner)
	{
		base.Init(owner);
		CurveLibrary curveLibrary = GameLoader.meta.curveLibrary;
		fresnel_color_x_curve = curveLibrary.GetCurve(fresnel_color_x);
		fresnel_color_y_curve = curveLibrary.GetCurve(fresnel_color_y);
		fresnel_color_z_curve = curveLibrary.GetCurve(fresnel_color_z);
		fresnel_color_w_curve = curveLibrary.GetCurve(fresnel_color_w);
		fresnel_range_curve = curveLibrary.GetCurve(fresnel_range_index);
		fresnel_smooth_curve = curveLibrary.GetCurve(fresnel_smooth_index);
		dither_threshold_curve = curveLibrary.GetCurve(dither_threshold_index);
		effect_outline_curve = curveLibrary.GetCurve(effect_outline_index);
		effect_outline_color_x_curve = curveLibrary.GetCurve(effect_outline_color_x);
		effect_outline_color_y_curve = curveLibrary.GetCurve(effect_outline_color_y);
		effect_outline_color_z_curve = curveLibrary.GetCurve(effect_outline_color_z);
		effect_outline_color_w_curve = curveLibrary.GetCurve(effect_outline_color_w);
		effect_outline_width_curve = curveLibrary.GetCurve(effect_outline_width_index);
		effect_emit_color_x_curve = curveLibrary.GetCurve(effect_emit_color_x);
		effect_emit_color_y_curve = curveLibrary.GetCurve(effect_emit_color_y);
		effect_emit_color_z_curve = curveLibrary.GetCurve(effect_emit_color_z);
		effect_emit_color_w_curve = curveLibrary.GetCurve(effect_emit_color_w);
	}

	protected override void SetMatParameters(MaterialPropertyBlock propertyBlock)
	{
		if (fresnel_color)
		{
			AniPart.SetHdrColor(propertyBlock, BattleConsts.SUB_EFFECT_FRESNEL_COLOR, new Color(EvaluateCurve(fresnel_color_x_curve), EvaluateCurve(fresnel_color_y_curve), EvaluateCurve(fresnel_color_z_curve), EvaluateCurve(fresnel_color_w_curve)));
		}
		if (fresnel_range)
		{
			propertyBlock.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_RANGE, EvaluateCurve(fresnel_range_curve));
		}
		if (fresnel_smooth)
		{
			propertyBlock.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_SMOOTH, EvaluateCurve(fresnel_smooth_curve));
		}
		if (dither_threshold)
		{
			propertyBlock.SetFloat(BattleConsts.SUB_EFFECT_SHADER_DITHER, EvaluateCurve(dither_threshold_curve));
		}
		if (effect_outline)
		{
			propertyBlock.SetFloat(BattleConsts.SUB_EFFECT_OUTLINE, EvaluateCurve(effect_outline_curve));
		}
		if (effect_outline_color)
		{
			AniPart.SetHdrColor(propertyBlock, BattleConsts.SUB_EFFECT_OUTLINE_COLOR, new Color(EvaluateCurve(effect_outline_color_x_curve), EvaluateCurve(effect_outline_color_y_curve), EvaluateCurve(effect_outline_color_z_curve), EvaluateCurve(effect_outline_color_w_curve)));
		}
		if (effect_outline_width)
		{
			propertyBlock.SetFloat(BattleConsts.SUB_EFFECT_OUTLINE_WIDTH, EvaluateCurve(effect_outline_width_curve));
		}
		if (effect_emit_color)
		{
			AniPart.SetHdrColor(propertyBlock, BattleConsts.SUB_EFFECT_EMIT_COLOR, new Color(EvaluateCurve(effect_emit_color_x_curve), EvaluateCurve(effect_emit_color_y_curve), EvaluateCurve(effect_emit_color_z_curve), EvaluateCurve(effect_emit_color_w_curve)));
		}
	}
}
