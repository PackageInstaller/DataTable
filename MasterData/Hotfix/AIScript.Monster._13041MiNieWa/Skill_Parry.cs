using System.Collections;
using TrueSync;

namespace AIScript.Monster._13041MiNieWa;

public class Skill_Parry : SkillSimpleBase
{
	protected readonly int startKeyIndex1 = 1;

	protected readonly ComboInputBuffer.ActionKey[] startKey1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected readonly string AddBuff01 = "AddBuff01";

	protected readonly int buffId = 990031100;

	protected readonly string DelBuff01 = "DelBuff01";

	protected readonly string FreezeHP = "FreezeHP";

	protected readonly string RecoveryHP = "RecoveryHP";

	protected readonly string Charge02 = "Charge02";

	protected readonly FP waitTimeing = 10;

	protected readonly string fxName = "fx_m13041_base_skill4_block";

	protected readonly FP fxPosY = 0;

	protected readonly float fxSpeed = 1f;

	protected readonly float fxScale = 1f;

	protected readonly bool fxPlayerScale = true;

	protected readonly FP dashSpeed = 3;

	protected readonly FP dashDistance = 15;

	protected readonly FP dashCheckInterval = 0.2;

	protected readonly FP stopMinDistance = 3;

	protected readonly FP stopDistance = 100;

	protected readonly string TurnAround04 = "TurnAround04";

	protected readonly FP durationT = 99;

	protected readonly FP rotateSpeed = 540;

	protected readonly string StopTurn04 = "StopTurn04";

	protected readonly string Dodge01 = "Dodge01";

	protected readonly FP dodgeTime = 0.3;

	protected readonly FP dodgeDis = 1;

	private bool isTraceSuccess;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, startKey1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int keyIndex, string eventName)
	{
		if (eventName.Equals(TurnAround04))
		{
			BeginLookAtMonsterTarget(999, 60);
		}
		else if (eventName.Equals(StopTurn04))
		{
			StopWaitLookAt();
		}
		else if (eventName.Equals(Dodge01))
		{
			FP distanceWithTarget = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
			BeginDashActorForward(2, distanceWithTarget / dodgeTime, distanceWithTarget, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		}
	}
}
