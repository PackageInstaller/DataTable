using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._10301;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string key = "B1_Skill";

	private string key_P4 = "B1_Skill_P4";

	private string evt_CastAreaEffect = "CastAreaEffect";

	private int perkId_4 = 1030104;

	private string areaEffect_4 = "AreaEffect_8010301_P22_Shadow";

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

	private TSVector2 lastPos;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		targetEntity = null;
		aimTarget.Cancel();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		aimTarget.Cancel();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			if (targetEntity != _actor.attackTarget)
			{
				targetEntity = _actor.attackTarget;
				aimTarget.Cancel();
				aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
			}
			lastPos = _actor.attackTarget.tsTransform.Position;
		}
		else
		{
			aimTarget.Cancel();
		}
	}

	private void DoMainLogic()
	{
		string actionTag = (GetPerk(perkId_4) ? key_P4 : key);
		Action<string> action = onCustomEvent;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_CastAreaEffect) && GetPerk(perkId_4))
		{
			TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : lastPos);
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_4, position);
		}
	}
}
