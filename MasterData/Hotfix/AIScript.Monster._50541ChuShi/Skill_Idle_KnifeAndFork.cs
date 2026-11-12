using System.Collections;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class Skill_Idle_KnifeAndFork : SkillSimpleBase
{
	private string GroundFX;

	private string GroundFXJitter;

	private TSVector2 SelfPosition;

	private FP SelfRotation;

	private DeterministicShape AttackShape;

	private HitFeatureData AttackFeatureData;

	private long AttackFXID;

	private long JitterFXID;

	private long GroundFXID;

	private LogicEntity Master;

	private CoroutineNode AttackCor;

	private string SelfType;

	protected override void OnSkillEnable()
	{
		SetLogicTagToggleValue(_actor, "IsCallBack", value: false);
		SetSearchedImmunityDisable();
		SetCloseBlockEnable();
		ShowBlood(isShow: true);
		if (_actor.dataID == GetTeammateIdByIndex(1))
		{
			GroundFX = "Knife_Ground";
			GroundFXJitter = "Knife_Ground_Jitter";
			SelfType = "Fire";
		}
		else if (_actor.dataID == GetTeammateIdByIndex(2))
		{
			GroundFX = "Fork_Ground";
			GroundFXJitter = "Fork_Ground_Jitter";
			SelfType = "Fire";
		}
		else if (_actor.dataID == GetTeammateIdByIndex(4))
		{
			GroundFX = "Knife_Ground_Nofire";
			GroundFXJitter = "Knife_Ground_Jitter_Nofire";
			SelfType = "NoFire";
		}
		else if (_actor.dataID == GetTeammateIdByIndex(5))
		{
			GroundFX = "Fork_Ground_Nofire";
			GroundFXJitter = "Fork_Ground_Jitter_Nofire";
			SelfType = "NoFire";
		}
		SelfPosition = GetPosition();
		SelfRotation = GetRotation();
		TSVector2 selfPosition = SelfPosition;
		FP radius = 2;
		FP innerRadius = 0;
		FP selfRotation = SelfRotation;
		AttackShape = GetShapeData(DeterministicShape.ShapeType.Circle, selfPosition, default, default, radius, innerRadius, default, selfRotation);
		AttackFeatureData = GetHitFeatureData();
		if (GetTargetByTeammateIndex(0).Count > 0)
		{
			Master = GetTargetByTeammateIndex(0).get_Item(0);
		}
		else
		{
			Master = null;
		}
	}

	protected override void OnSkillDisable()
	{
		StopEffect(AttackFXID);
		StopEffect(JitterFXID);
	}

	protected override IEnumerator DoMainLogic()
	{
		Skill_Idle_KnifeAndFork skill_Idle_KnifeAndFork = this;
		Skill_Idle_KnifeAndFork skill_Idle_KnifeAndFork2 = this;
		string groundFX = GroundFX;
		TSVector2 selfPosition = SelfPosition;
		FP selfRotation = SelfRotation;
		skill_Idle_KnifeAndFork.GroundFXID = skill_Idle_KnifeAndFork2.PlayEffect(groundFX, 1f, default, selfPosition, selfRotation);
		if (GetLogicTagToggleValue(Master, "IsUltra") || GetLogicTagToggleValue(Master, "IsCallKnife"))
		{
			while (!GetLogicTagToggleValue(_actor, "IsCallBack"))
			{
				yield return null;
			}
			StopEffect(GroundFXID);
			Skill_Idle_KnifeAndFork skill_Idle_KnifeAndFork3 = this;
			Skill_Idle_KnifeAndFork skill_Idle_KnifeAndFork4 = this;
			string groundFXJitter = GroundFXJitter;
			selfPosition = GetPosition();
			selfRotation = GetRotation();
			skill_Idle_KnifeAndFork3.JitterFXID = skill_Idle_KnifeAndFork4.PlayEffect(groundFXJitter, 1f, default, selfPosition, selfRotation);
			yield return StartCor(FakeAttack());
			yield break;
		}
		yield return WaitTime(4);
		if (SelfType == "Fire")
		{
			StartCor(ref AttackCor, Attack());
		}
		while (!GetLogicTagToggleValue(Master, "IsUltra") && !GetLogicTagToggleValue(Master, "IsCallKnife"))
		{
			yield return null;
		}
		if (SelfType == "Fire")
		{
			StopCor(AttackCor);
			StopEffect(AttackFXID);
		}
		while (!GetLogicTagToggleValue(_actor, "IsCallBack"))
		{
			yield return null;
		}
		StopEffect(GroundFXID);
		Skill_Idle_KnifeAndFork skill_Idle_KnifeAndFork5 = this;
		Skill_Idle_KnifeAndFork skill_Idle_KnifeAndFork6 = this;
		string groundFXJitter2 = GroundFXJitter;
		selfPosition = GetPosition();
		selfRotation = GetRotation();
		skill_Idle_KnifeAndFork5.JitterFXID = skill_Idle_KnifeAndFork6.PlayEffect(groundFXJitter2, 1f, default, selfPosition, selfRotation);
		yield return StartCor(FakeAttack());
	}

	private IEnumerator Attack()
	{
		while (true)
		{
			Skill_Idle_KnifeAndFork skill_Idle_KnifeAndFork = this;
			Skill_Idle_KnifeAndFork skill_Idle_KnifeAndFork2 = this;
			TSVector2 selfPosition = SelfPosition;
			FP selfRotation = SelfRotation;
			skill_Idle_KnifeAndFork.AttackFXID = skill_Idle_KnifeAndFork2.PlayEffect("Attack", 1f, default, selfPosition, selfRotation);
			yield return WaitTime(2.5);
			PlayEffect("AttackWarningFX", 1f, 1, GetPosition(), default, 0.75f);
			yield return WaitTime(0.5);
			AreaHit_Simple(_actor, AttackShape, AttackFeatureData, 50541053, 0.5, HitBox.HurtAnimType.Small, "HittedFX");
			yield return WaitTime(4);
		}
	}

	private IEnumerator FakeAttack()
	{
		FP playbackSpeed = ((!GetLogicTagToggleValue(Master, "IsUltra")) ? ((FP)1.6) : ((FP)1));
		while (true)
		{
			AttackFXID = PlayEffect("Attack", position: SelfPosition, angle: SelfRotation, playbackSpeed: (float)playbackSpeed);
			yield return WaitTime(6.5);
		}
	}
}
