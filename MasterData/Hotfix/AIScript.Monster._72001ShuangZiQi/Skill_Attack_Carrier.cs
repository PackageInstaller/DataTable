using System.Collections;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Attack_Carrier : SkillSimpleBase
{
	private static readonly FP DashSpeed_P12 = 15;

	private static readonly FP DashSpeed_P3 = 30;

	private static readonly int HitDamageID = 72005021;

	private bool isRed;

	private int Phase;

	private AdventureActor summoner;

	private string Color;

	private string AttackFX_Start;

	private string AttackFX_Loop;

	private string HitFXName;

	private FP AttackDelayTime;

	private FP DashSpeed;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		summoner = logicComponent.SummonActor;
		isRed = GetLogicTagToggleValue(_actor, "Red");
		Phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		AttackDelayTime = GetLogicTagFpValue(_actor, "AttackDelayTime");
		ChessInitialize();
		if (Phase == 3)
		{
			DashSpeed = DashSpeed_P3;
		}
		else
		{
			DashSpeed = DashSpeed_P12;
		}
	}

	protected override void OnSkillDisable()
	{
		RemoveBuffFromTarget(_actor, 990020140);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(AttackDelayTime);
		BeginAttack(1, "Attack", flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect(AttackFX_Start);
		yield return BeginLookAt(GetCurrentPlayer(), 0.75, 360);
		Skill_Attack_Carrier skill_Attack_Carrier = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Attack_Carrier.PlayEarlyWarningEffect("fx_warning_dash", 0.75f, default, position, rotation);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayEffect(AttackFX_Loop);
		BeginDashActorForward(1, DashSpeed, 35, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false, 0.3);
		AddBuffToTarget(_actor, 990020140);
		SetCloseBlockEnable();
		StartCor(Damage());
		yield return WaitDashFinish();
		_actor.DestroySelf();
	}

	private void ChessInitialize()
	{
		if (isRed)
		{
			Color = "red";
		}
		else
		{
			Color = "green";
		}
		AttackFX_Start = "fx_m72005_base_Attack_Start_" + Color;
		AttackFX_Loop = "fx_m72005_loop_Attack_" + Color;
		HitFXName = "fx_common_hit_" + Color;
	}

	private IEnumerator Damage()
	{
		while (true)
		{
			Skill_Attack_Carrier skill_Attack_Carrier = this;
			TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0.5));
			FP width = 2;
			FP length = 3;
			FP rotation = GetRotation();
			DeterministicShape shapeData = skill_Attack_Carrier.GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
			Skill_Attack_Carrier skill_Attack_Carrier2 = this;
			FP knockBackForce = 15;
			FP knockBackDistance = 2;
			rotation = 0.3;
			FP hitStrenth = 4;
			HitFeatureData hitFeatureData = skill_Attack_Carrier2.GetHitFeatureData(HitBox.FeatureFlag.KnockBack | HitBox.FeatureFlag.Stiff, knockBackForce, knockBackDistance, UseAtttackForward: false, default, null, null, rotation, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth, UseHitBoxPosition: true);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, HitDamageID, 0, HitBox.HurtAnimType.Large, HitFXName);
			yield return null;
		}
	}
}
