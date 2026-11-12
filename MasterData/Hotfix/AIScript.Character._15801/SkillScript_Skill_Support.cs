using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class SkillScript_Skill_Support : SkillAdvancedBase
{
	private int _totalShootTimes;

	private int _shootTimes;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_totalShootTimes = 4;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515825, out var _))
		{
			_totalShootTimes += 2;
		}
		_shootTimes = 0;
	}

	public void OnStart()
	{
		_actor.logicVariable.SetLogicTagTSVector2Value("SummoneCasematePosition", _actor.tsTransform.Position);
		_actor.logicVariable.SetLogicTagTSVector2Value("SummoneCasemateDirection", _actor.tsTransform.Forward);
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboLoop = OnComboLoop;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("158_Support_Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
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
		ILRuntimeAPI.ShootByDirection(bulletAlias, _actor, default, _actor.tsTransform.Forward, position, y);
		_shootTimes++;
		_actor.logicVariable.SetLogicTagTSVector2Value("SummoneCasematePosition", _actor.tsTransform.Position);
		_actor.logicVariable.SetLogicTagTSVector2Value("SummoneCasemateDirection", _actor.tsTransform.Forward);
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
		if (_shootTimes < _totalShootTimes)
		{
			_actor.logicVariable.SetLogicTagValue("RemainingSkillShootTimes", _totalShootTimes - _shootTimes);
		}
		else
		{
			_actor.logicVariable.SetLogicTagValue("RemainingSkillShootTimes", 0);
		}
		_shootTimes = 0;
	}
}
