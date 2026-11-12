using System.Collections;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_SummonIceMaker : SkillSimpleBase
{
	private static readonly string combo_ActiveBattery = "ActiveBattery";

	private static readonly string evt_Active = "Active";

	private static readonly string combo_Turn_Left = "Turn_Left";

	private static readonly string combo_Turn_Right = "Turn_Right";

	private long WarningFX1;

	private long WarningFX2;

	private long WarningFX3;

	private readonly string tag1 = "Boss";

	private static TSVector2 nearestPos;

	private static TSVector2 otherPos1;

	private static TSVector2 otherPos2;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopEffect(WarningFX1);
		StopEffect(WarningFX2);
		StopEffect(WarningFX3);
		SetLogicTagToggleValue(_actor, Config.Skill_IceMaker_Finish, value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		string actionKey = ((CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 0) ? combo_Turn_Left : combo_Turn_Right);
		BeginAttack(1, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		TSVector2 entityPosition = GetEntityPosition(logicEntity);
		BeginLookAtByPos(entityPosition, 0.66, (FP)90 / (FP)0.66);
		yield return WaitTime(0.66);
		StopWaitLookAt();
		BeginAttack(2, combo_ActiveBattery, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.5);
		if (GetMonsterTagValue(_actor, 1) == tag1)
		{
			TSVector2 centerPos1 = new TSVector2(0, -7);
			TSVector2 centerPos2 = RotateTo(centerPos1, 120);
			TSVector2 centerPos3 = RotateTo(centerPos2, 120);
			Skill_SummonIceMaker skill_SummonIceMaker = this;
			Skill_SummonIceMaker skill_SummonIceMaker2 = this;
			TSVector2 position = centerPos1;
			FP rotation = GetRotation();
			skill_SummonIceMaker.WarningFX1 = skill_SummonIceMaker2.PlayEarlyWarningEffect("fx_warning_circular_2_5", 1f, default, position, rotation, 0.8f);
			Skill_SummonIceMaker skill_SummonIceMaker3 = this;
			Skill_SummonIceMaker skill_SummonIceMaker4 = this;
			position = centerPos2;
			rotation = GetRotation();
			skill_SummonIceMaker3.WarningFX2 = skill_SummonIceMaker4.PlayEarlyWarningEffect("fx_warning_circular_2_5", 1f, default, position, rotation, 0.8f);
			Skill_SummonIceMaker skill_SummonIceMaker5 = this;
			Skill_SummonIceMaker skill_SummonIceMaker6 = this;
			position = centerPos3;
			rotation = GetRotation();
			skill_SummonIceMaker5.WarningFX3 = skill_SummonIceMaker6.PlayEarlyWarningEffect("fx_warning_circular_2_5", 1f, default, position, rotation, 0.8f);
			yield return WaitTime(1);
			LogicEntity currentPlayer = GetCurrentPlayer();
			TSVector2 entityPosition2 = GetEntityPosition(currentPlayer);
			FP fP = Distance(entityPosition2, centerPos1);
			FP fP2 = Distance(entityPosition2, centerPos2);
			FP fP3 = Distance(entityPosition2, centerPos3);
			TSVector2 tSVector;
			TSVector2 tSVector2;
			TSVector2 tSVector3;
			if (fP <= fP2 && fP <= fP3)
			{
				tSVector = centerPos1;
				if (fP2 <= fP3)
				{
					tSVector2 = centerPos2;
					tSVector3 = centerPos3;
				}
				else
				{
					tSVector2 = centerPos3;
					tSVector3 = centerPos2;
				}
			}
			else if (fP2 <= fP && fP2 <= fP3)
			{
				tSVector = centerPos2;
				if (fP <= fP3)
				{
					tSVector2 = centerPos1;
					tSVector3 = centerPos3;
				}
				else
				{
					tSVector2 = centerPos3;
					tSVector3 = centerPos1;
				}
			}
			else
			{
				tSVector = centerPos3;
				if (fP <= fP2)
				{
					tSVector2 = centerPos1;
					tSVector3 = centerPos2;
				}
				else
				{
					tSVector2 = centerPos2;
					tSVector3 = centerPos1;
				}
			}
			SummonTeammate(5, tSVector, tSVector - new TSVector2(0, 0));
			SummonTeammate(7, tSVector2, tSVector2 - new TSVector2(0, 0));
			SummonTeammate(2, tSVector3, tSVector3 - new TSVector2(0, 0));
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = Config.evt_SummonIceMaker;
			_actor.DispatchEvent(adventureActorCustomEvent);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			TSVector2 centerPos3 = new TSVector2(0, -7);
			TSVector2 centerPos2 = RotateTo(centerPos3, 120);
			TSVector2 centerPos1 = RotateTo(centerPos2, 120);
			Skill_SummonIceMaker skill_SummonIceMaker7 = this;
			Skill_SummonIceMaker skill_SummonIceMaker8 = this;
			TSVector2 position = centerPos3;
			FP rotation = GetRotation();
			skill_SummonIceMaker7.WarningFX1 = skill_SummonIceMaker8.PlayEarlyWarningEffect("fx_warning_circular_2_5", 1f, default, position, rotation, 0.8f);
			Skill_SummonIceMaker skill_SummonIceMaker9 = this;
			Skill_SummonIceMaker skill_SummonIceMaker10 = this;
			position = centerPos2;
			rotation = GetRotation();
			skill_SummonIceMaker9.WarningFX2 = skill_SummonIceMaker10.PlayEarlyWarningEffect("fx_warning_circular_2_5", 1f, default, position, rotation, 0.8f);
			Skill_SummonIceMaker skill_SummonIceMaker11 = this;
			Skill_SummonIceMaker skill_SummonIceMaker12 = this;
			position = centerPos1;
			rotation = GetRotation();
			skill_SummonIceMaker11.WarningFX3 = skill_SummonIceMaker12.PlayEarlyWarningEffect("fx_warning_circular_2_5", 1f, default, position, rotation, 0.8f);
			yield return WaitTime(1);
			SummonTeammate(2, centerPos3, centerPos3 - new TSVector2(0, 0));
			SummonTeammate(5, centerPos2, centerPos2 - new TSVector2(0, 0));
			SummonTeammate(7, centerPos1, centerPos1 - new TSVector2(0, 0));
			AdventureActorCustomEvent adventureActorCustomEvent2 = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent2.sender = _actor;
			adventureActorCustomEvent2.actor = _actor;
			adventureActorCustomEvent2.eventHashCode = Config.evt_SummonIceMaker;
			_actor.DispatchEvent(adventureActorCustomEvent2);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}
}
