using System.Collections;
using TrueSync;

namespace AIScript.Monster.Trigger;

public class AttackFromBanShenShu : SkillSimpleBase
{
	private static readonly string StartFX = "Actor/Monster/10501BanShenShu/FX/fx_m10501_loop_skill2_atk";

	private static readonly string WarnFX = "Actor/Monster/10501BanShenShu/FX/fx_m10501_loop_skill2_atk_warn";

	private static readonly string AttackFX = "Actor/Monster/10501BanShenShu/FX/fx_m10501_base_Skill2_atk";

	private static readonly string HittedFX = "FX/ActorCommon/fx_common_hit_dark_chop";

	private TSVector2 PlayPosition;

	protected override IEnumerator DoMainLogic()
	{
		PlayPosition = GetEntityPositionObsoleted(GetCurrentPlayer());
		AttackFromBanShenShu attackFromBanShenShu = this;
		TSVector2 playPosition = PlayPosition;
		FP radius = 1.5;
		FP innerRadius = 0;
		FP rotation = 0;
		DeterministicShape AttackShape = attackFromBanShenShu.GetShapeData(DeterministicShape.ShapeType.Circle, playPosition, default, default, radius, innerRadius, default, rotation);
		HitFeatureData AttackFeatureData = GetHitFeatureData();
		AttackFromBanShenShu attackFromBanShenShu2 = this;
		string startFX = StartFX;
		TSVector2 playPosition2 = PlayPosition;
		long StartFXID = attackFromBanShenShu2.PlayEffect(startFX, 1f, default, playPosition2);
		yield return WaitTime(1);
		AttackFromBanShenShu attackFromBanShenShu3 = this;
		string warnFX = WarnFX;
		playPosition2 = PlayPosition;
		long WarnFXID = attackFromBanShenShu3.PlayEffect(warnFX, 1f, default, playPosition2);
		yield return WaitTime(1);
		AttackFromBanShenShu attackFromBanShenShu4 = this;
		string attackFX = AttackFX;
		playPosition2 = PlayPosition;
		attackFromBanShenShu4.PlayEffect(attackFX, 1f, default, playPosition2);
		AreaHit_Simple(_actor, AttackShape, AttackFeatureData, 1002001, 0.5, HitBox.HurtAnimType.Small, HittedFX);
		StopEffect(StartFXID);
		StopEffect(WarnFXID);
		yield return WaitTime(2);
	}
}
