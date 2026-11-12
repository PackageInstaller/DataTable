using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._15601;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string key = "Skill";

	private string evt_Summon = "CallPenguinDoll";

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

	private TSVector2 lastPos;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		DoMainLogic();
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

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private void DoMainLogic()
	{
		string actionTag = key;
		Action<string> action = onCustomEvent;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action, null, fadeOutAnim: true);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_Summon))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = summonEvt;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		else if (evt.Equals("ThrowDoll"))
		{
			ILRuntimeAPI.Shoot("Bullet_PenguinSummon", _actor, 1, _actor.tsTransform.Position, 1, lastPos, null, AimType.Position);
		}
	}
}
