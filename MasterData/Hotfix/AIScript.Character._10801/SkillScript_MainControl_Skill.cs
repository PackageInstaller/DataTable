using System;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._10801;

public class SkillScript_MainControl_Skill : SkillAdvancedBase
{
	private const string actionTag = "B1_Skill";

	private const string eventName_addSpecialAmmo = "AddBullet";

	private const int addCount_SpecialAmmo = 1;

	private const int skillId_SpecialNormalAttack = 10812000;

	private const int perkId_1 = 510801;

	private const string actionTag_1 = "B1P01_Skill";

	private const int perkId_3 = 510803;

	private const int parameterId_3 = 10803011;

	private const int addCount_SpecialAmmo_3 = 2;

	private PlayerSkillCd _playerSkillCd;

	private int _addSpecialAmmoTimes;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt();
		_playerSkillCd = _actor.GetLogicComponent<PlayerSkillCd>();
		_addSpecialAmmoTimes = 0;
	}

	public void OnStart()
	{
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510801, out var _))
		{
			Action<string> onCustomEvent = OnCustomEvent;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack("B1P01_Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		}
		else
		{
			Action<string> onCustomEvent = OnCustomEvent;
			Action onInterrupt = OnComboLoop;
			Action onComboFinish = OnFinish;
			Action onInterrupt2 = OnInterrupt;
			BeginAttack("B1_Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt2, onCustomEvent, null, fadeOutAnim: false, onInterrupt);
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (!string.Equals(eventName, "AddBullet"))
		{
			return;
		}
		(_actor as PlayerAdventureActor).enableReload = false;
		(_actor as PlayerAdventureActor).status = ActorStatus.Special;
		_addSpecialAmmoTimes++;
		if (_addSpecialAmmoTimes <= 1)
		{
			if (_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal) != 10812000)
			{
				_playerSkillCd.BindSkillIdToButton(ActionKey.Normal, 10812000);
				MonoSingleton<LuaManager>.Instance?.FireEvent("PlayerSwitchGun", 4);
				_actor.ammoInfo.ammoType = HotfixEnum.AmmoType.Special1;
				_actor.ammoInfo.bulletT = HotfixEnum.bulletType.FireShotgun;
				_actor.ammoInfo.ammoCount = 0;
			}
		}
		else
		{
			CommonUtils.ReduceSkillSection(_actor, _skill);
		}
		int num = 1;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510803, out var _) && TSRandom.Range(FP.Zero, 100) <= CommonUtils.GetScriptValue(_actor, 10803011))
		{
			num = 2;
		}
		_actor.ammoInfo.ammoCount += num;
		if (_actor.ammoInfo.ammoCount >= _actor.ammoInfo.ammoCountMax)
		{
			_actor.logicVariable.ToggleLogicTag("LockMainControlSkill", value: true);
		}
	}

	private void OnComboLoop()
	{
		if (_actor.ammoInfo.ammoCount >= _actor.ammoInfo.ammoCountMax || _playerSkillCd.GetSkillSection(_skill.skillId) <= 0)
		{
			comboAttack?.CancelAttack();
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
		comboAttack?.Clear();
		_addSpecialAmmoTimes = 0;
	}
}
