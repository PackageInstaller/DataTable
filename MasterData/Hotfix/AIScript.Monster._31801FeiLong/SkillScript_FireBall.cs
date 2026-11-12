using System.Collections;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_FireBall : SkillScript_Base
{
	private int _loopTims;

	protected override IEnumerator DoMainLogic()
	{
		_loopTims = 0;
		BeginAttack(0, "FireBall");
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		AimAtTarget(GetCurrentPlayer(), Config.limitAngle_FireBall);
		yield return WaitCombo(ComboAttackType.isRecoveryBegin);
		CancelAim();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (comboIndex == 0 && string.Equals(eventName, "Fire"))
		{
			Shoot("", _actor.tsTransform.Position + _actor.tsTransform.Forward * Config.shootOffset_FireBall, Config.shootPositionY_FireBall, default, default, AimType.Position, BulletDirectionType.BulletToTarget, GetEntityPosition(GetCurrentPlayer()));
		}
	}

	protected override void OnComboLoop(int comboIndex)
	{
		base.OnComboLoop(comboIndex);
		if (comboIndex == 0)
		{
			_loopTims++;
			if (_loopTims >= 3)
			{
				CancelAttack();
			}
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_loopTims = 0;
	}
}
