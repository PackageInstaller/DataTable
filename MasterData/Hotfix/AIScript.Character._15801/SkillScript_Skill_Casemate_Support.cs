using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class SkillScript_Skill_Casemate_Support : SkillScript_Summoned
{
	private int _totalShootTimes;

	private int _shootTimes;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_totalShootTimes = _summoner.logicVariable.GetLogicTagValue("RemainingSkillShootTimes").AsInt();
		_shootTimes = 0;
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboLoop = OnComboLoop;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("15801_Cannon_Attack_Support", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "158_Support_Shoot"))
		{
			Shoot();
		}
	}

	private void OnComboLoop()
	{
		if (_shootTimes >= _totalShootTimes)
		{
			comboAttack.CancelAttack();
		}
	}

	private void Shoot()
	{
		DefaultLookAt();
		TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_Support.shootPositionOffset_Skill.x + _actor.tsTransform.Forward * Config_Support.shootPositionOffset_Skill.z;
		FP y = Config_Support.shootPositionOffset_Skill.y;
		string bulletAlias = "Bullet_15801_Summon_Attack_Cannon_Support_Shoot";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515822, out var _))
		{
			bulletAlias = "Bullet_15801_Summon_Attack_Cannon_Support_Shoot_P22_Big";
		}
		ILRuntimeAPI.ShootByDirection(bulletAlias, _summoner, default, _actor.tsTransform.Forward, position, y);
		_shootTimes++;
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_summoner.logicVariable.SetLogicTagValue("RemainingSkillShootTimes", 0);
		_shootTimes = 0;
	}
}
