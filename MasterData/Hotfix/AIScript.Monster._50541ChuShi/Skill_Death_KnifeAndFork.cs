using System.Collections;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class Skill_Death_KnifeAndFork : SkillSimpleBase
{
	private string FinishFX;

	private string BreakFX;

	private TSVector2 SelfPosition;

	private FP SelfRotation;

	private DeterministicShape AttackShape;

	private HitFeatureData AttackFeatureData;

	protected override void OnSkillEnable()
	{
		if (_actor.dataID == GetTeammateIdByIndex(1))
		{
			FinishFX = "Knife_Finish";
			BreakFX = "Knife_Break";
		}
		else if (_actor.dataID == GetTeammateIdByIndex(2))
		{
			FinishFX = "Fork_Finish";
			BreakFX = "Fork_Break";
		}
		else if (_actor.dataID == GetTeammateIdByIndex(4))
		{
			FinishFX = "Knife_Finish";
			BreakFX = "Knife_Break_NoFire";
		}
		else if (_actor.dataID == GetTeammateIdByIndex(5))
		{
			FinishFX = "Fork_Finish";
			BreakFX = "Fork_Break_NoFire";
		}
		SelfPosition = GetPosition();
		SelfRotation = GetRotation();
		TSVector2 selfPosition = SelfPosition;
		FP radius = 1;
		FP innerRadius = 0;
		FP selfRotation = SelfRotation;
		AttackShape = GetShapeData(DeterministicShape.ShapeType.Circle, selfPosition, default, default, radius, innerRadius, default, selfRotation);
		AttackFeatureData = GetHitFeatureData();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetLogicTagToggleValue(_actor, "IsCallBack"))
		{
			Skill_Death_KnifeAndFork skill_Death_KnifeAndFork = this;
			string finishFX = FinishFX;
			TSVector2 selfPosition = SelfPosition;
			FP angle = 40;
			skill_Death_KnifeAndFork.PlayEffect(finishFX, 1f, default, selfPosition, angle);
			yield return WaitTime(0.5);
			AreaHit_Simple(_actor, AttackShape, AttackFeatureData, 50541052, 0.5, HitBox.HurtAnimType.Small, "HittedFX");
			DispatchCustomEvent("BossRush_KnifeAndFork_CallBack", isSelfEvent: false);
		}
		else
		{
			Skill_Death_KnifeAndFork skill_Death_KnifeAndFork2 = this;
			string breakFX = BreakFX;
			TSVector2 selfPosition = SelfPosition;
			FP angle = SelfRotation;
			skill_Death_KnifeAndFork2.PlayEffect(breakFX, 1f, default, selfPosition, angle);
		}
		yield return WaitTime(1);
	}
}
