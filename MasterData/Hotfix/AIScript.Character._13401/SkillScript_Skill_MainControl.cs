using System;
using AIScript.Utils;

namespace AIScript.Character._13401;

public class SkillScript_Skill_MainControl : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513407, out var _))
		{
			_actor.buffComponent.RemoveBuffByBuffId(13407011);
		}
		DefaultLookAt();
	}

	public void OnStart()
	{
		string text = "134_Main_Skill";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513401, out var _))
		{
			text = "134_Main_Skill_P01";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Add_Ammo_End"))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513401, out var perkLevel))
			{
				_actor.ammoInfo.SetOriginIntValue(HotfixEnum.AmmoType.Special1, 9, 1);
				_actor.ammoInfo.ChangeValue(HotfixEnum.AmmoType.Special1, HotfixEnum.ammoParameterType.SET_ABSOLUTE_VALUE, 9);
			}
			else
			{
				_actor.ammoInfo.SetOriginIntValue(HotfixEnum.AmmoType.Special1, 3, 1);
				_actor.ammoInfo.ChangeValue(HotfixEnum.AmmoType.Special1, HotfixEnum.ammoParameterType.SET_ABSOLUTE_VALUE, 3);
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513408, out perkLevel))
			{
				_actor.buffComponent?.AddBuff(13408011, _actor);
				_actor.buffComponent?.AddBuff(13408012, _actor);
			}
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513404, out var _))
		{
			((PlayerAdventureActor)_actor).SetLocalData("SpecialStrengthNormalAttack", bool.TrueString);
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2))
		{
			_actor.buffComponent.AddBuff(13496211, _actor);
		}
	}
}
