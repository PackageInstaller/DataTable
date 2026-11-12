using System;

namespace AIScript.Character._10801;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private const string actionTag = "Attack_1";

	private const string bulletTag_NormalAttack = "108Bullet";

	private const string eventName_FinishShoot = "ShootEnd";

	private const int perkId_6 = 510806;

	private const int additionalAttrId_6 = 10850601;

	protected bool _isSpecial;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_isSpecial = false;
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_BORN", OnBulletBorn);
	}

	public void OnStart()
	{
		string text = GetActionTag();
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(text, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected virtual string GetActionTag()
	{
		return "Attack_1";
	}

	private void OnBulletBorn(IEvent evt)
	{
		AdventureBulletBornEvent adventureBulletBornEvent = evt as AdventureBulletBornEvent;
		if (adventureBulletBornEvent.owner != null && adventureBulletBornEvent.owner.Id == _actor.Id && string.Equals(adventureBulletBornEvent.tag, "108Bullet"))
		{
			AdventureBullet adventureBullet = adventureBulletBornEvent.sender as AdventureBullet;
			if (adventureBullet != null && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510806, out var _) && _actor.logicVariable.GetLogicTagToggle("TriggerPerk_6"))
			{
				adventureBullet.AddAdditionalAttr(10850601);
			}
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "ShootEnd"))
		{
			OnShootFinish();
			KasimiraNormalAttackFinishEvent kasimiraNormalAttackFinishEvent = KasimiraNormalAttackFinishEvent.Generate();
			kasimiraNormalAttackFinishEvent.sender = _actor;
			kasimiraNormalAttackFinishEvent.isSpecial = _isSpecial;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(kasimiraNormalAttackFinishEvent);
		}
	}

	protected virtual void OnShootFinish()
	{
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
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletBorn);
		_isSpecial = false;
	}
}
