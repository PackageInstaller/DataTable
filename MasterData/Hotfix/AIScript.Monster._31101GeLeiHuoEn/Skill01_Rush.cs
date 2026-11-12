using System.Collections;
using TrueSync;

namespace AIScript.Monster._31101GeLeiHuoEn;

public class Skill01_Rush : SkillSimpleBase
{
	private readonly string combo_key1 = "Rush";

	private readonly string combo_key2 = "RushAgain";

	private readonly string combo_key3 = "RushAttack";

	private CoroutineNode DistanceCor;

	private bool _isChecking = true;

	private FP SkillTimes01;

	private LogicEntity Targetenemy;

	protected override void OnSkillEnable()
	{
		SkillTimes01 = 0;
		_isChecking = true;
	}

	protected override void OnSkillDisable()
	{
		StopCor(DistanceCor);
		_isChecking = false;
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetBuffNum(_actor, 311010000) >= 1)
		{
			BeginAttack(1, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			_isChecking = true;
			BeginLookAt_NotWait(Targetenemy, 0.43, 720);
			yield return WaitTime(0.83);
			Dash();
			DistanceCor = StartCor(StartCheckLoop());
			yield return WaitDashFinish();
			StopCor(DistanceCor);
			_isChecking = false;
			if (SkillTimes01 == 0)
			{
				BeginAttack(2, combo_key2, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(0.4);
				GetEnemy();
				BeginLookAt_NotWait(Targetenemy, 0.1, 7200);
				yield return WaitTime(0.5);
				_isChecking = true;
				DistanceCor = StartCor(StartCheckLoop());
				Dash();
				yield return WaitDashFinish();
				StopCor(DistanceCor);
				_isChecking = false;
				if (SkillTimes01 == 0)
				{
					CancelAttack();
					yield return WaitCombo(ComboAttackType.isComboFinish);
				}
				else
				{
					BeginAttack(3, combo_key3, flushInputedKeys: true, forceInterruptAttack: true);
					yield return WaitCombo(ComboAttackType.isComboFinish);
				}
			}
			else
			{
				BeginAttack(3, combo_key3, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
		}
		else
		{
			BeginAttack(1, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			_isChecking = true;
			BeginLookAt_NotWait(Targetenemy, 0.43, 720);
			yield return WaitTime(0.83);
			Dash();
			yield return WaitDashFinish();
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	protected IEnumerator StartCheckLoop()
	{
		while (_isChecking)
		{
			yield return null;
			TSVector2 position = GetPosition();
			TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
			if (Distance(position, entityPosition) <= 1.6)
			{
				StopDash();
				_isChecking = false;
				SkillTimes01 = 1;
			}
		}
	}

	private void Dash()
	{
		BeginDashActorForward(1, 30, 12.8, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
