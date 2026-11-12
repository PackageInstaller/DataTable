using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai.LDScripts;

public class SkillBase : SkillSimpleBase
{
	protected LogicEntity target;

	protected readonly int flapIndex;

	protected readonly string flapKey = "Flap";

	protected readonly int dashIndex = 1;

	protected readonly string dashKey = "DashDMG";

	protected readonly int slightWeaknessIndex = 2;

	protected readonly string slightWeaknessKey = "SlightWeakness";

	protected readonly int dashSlideIndex = 3;

	protected readonly string dashSlideKey = "DashSide";

	protected readonly int dashSlide02Index = 4;

	protected readonly string dashSlide02Key = "DashSlide02";

	protected readonly int generalATKIndex = 5;

	protected readonly string generalATKKey = "GeneralATK";

	protected readonly string warningFx_Ground_fan90c16r = "fx_common_base_red_fan_90c_16r";

	protected readonly string warningFx_Ground_dash10 = "fx_common_base_Dash_YuJing_10_start";

	private readonly string atkAlertFx = "fx_common_base_charge_fire_actor";

	protected readonly int dashDMGIndex = 100;

	protected readonly int dashSlideNoDMGIndex = 101;

	protected LogicEntity GetTarget()
	{
		LogicEntity logicEntity = null;
		if (CheckTargetIsValid(GetAttackTarget(isUpToDate: true)))
		{
			return GetAttackTarget(isUpToDate: true);
		}
		return GetCurrentPlayer();
	}

	protected void FanDamage(TSVector2 pos, FP radius, FP innerRadius, FP angle, FP rotation, int skillType, int hitID, string hittedFx)
	{
		int num = skillType switch
		{
			0 => 4, 
			1 => 6, 
			_ => 4, 
		};
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, pos, default, default, radius, innerRadius, angle, rotation);
		HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, num);
		AreaHit_Simple(_actor, shapeData, hitFeatureData, hitID, 0.5, HitBox.HurtAnimType.Small, hittedFx);
	}

	protected void RectangleDamage(TSVector2 pos, FP width, FP length, FP rotation, int hitID, string hittedFx)
	{
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, pos, width, length, default, default, default, rotation);
		HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 4);
		AreaHit_Simple(_actor, shapeData, hitFeatureData, hitID, 0.5, HitBox.HurtAnimType.Small, hittedFx);
	}

	protected long ATKAlertFx()
	{
		return PlayEffect(atkAlertFx, 1f, 2, GetPosition(), default, 4f);
	}
}
