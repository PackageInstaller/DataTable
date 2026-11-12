using System;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._14701;

public class SkillScript_MainControl : SkillAdvancedBase
{
	private string key_Base = "Skill_Mian_ZhaoHuan";

	private string evt_shoot = "ZhaoHuanYinXiang";

	private FP defaultShootOffset = 5;

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
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

	private void DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		string actionTag = key_Base;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = SkillFinish;
		System.Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_shoot))
		{
			TSVector2 item = (_actor.attackTarget ? _actor.attackTarget.tsTransform.Position : (_actor.tsTransform.Position + _actor.tsTransform.Forward * defaultShootOffset));
			FP fpParam = (_actor.attackTarget ? _actor.attackTarget.GetRadius() : ((FP)0));
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = summonEvt;
			adventureActorCustomEvent.fpParam = fpParam;
			adventureActorCustomEvent.tsVector2ParamList = new List<TSVector2>
			{
				_actor.tsTransform.Position,
				item
			};
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
