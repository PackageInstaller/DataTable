using System;
using System.Runtime.CompilerServices;

namespace AIScript.Monster.Soldier._18011;

public class MainSkill : SkillAdvancedBase
{
	private const string comboTag = "ComboSkill";

	private const string comboTag_Partner = "ComboSkill_1";

	private const HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.QiLiMoFa;

	private const string bulletTag_PartnerCombo = "MagicPartner";

	private static readonly int[] onceDamageIds_ComboBulletByPartnerLv;

	private LogicEntity _target;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_target = null;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_BORN", OnBulletBorn);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_target = null;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletBorn);
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	private void DoMainLogic()
	{
		_target = _actor.attackTarget;
		if (_target == null)
		{
			_target = ((SoldierActor)_actor).FindNearestConfrontTarget();
		}
		if (_target != null)
		{
			_actor.soldierAttackTarget = _target;
			_actor.LookAt(_target.tsTransform.Position, 0);
		}
		string actionTag = ((GetPartnerLv() >= 1) ? "ComboSkill_1" : "ComboSkill");
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnBulletBorn(IEvent evt)
	{
		if (_actor == null || !(evt is AdventureBulletBornEvent adventureBulletBornEvent) || adventureBulletBornEvent.owner == null || adventureBulletBornEvent.owner.Id != _actor.Id || !(adventureBulletBornEvent.sender is AdventureBulletBase adventureBulletBase))
		{
			return;
		}
		int num = GetPartnerLv();
		if (num >= 1 && string.Equals(adventureBulletBornEvent.tag, "MagicPartner"))
		{
			if (num > onceDamageIds_ComboBulletByPartnerLv.Length)
			{
				num = onceDamageIds_ComboBulletByPartnerLv.Length;
			}
			adventureBulletBase.AddAdditionalAttr(onceDamageIds_ComboBulletByPartnerLv[num - 1]);
		}
	}

	private int GetPartnerLv()
	{
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return 0;
		}
		return soldierLevelController.GetPartnerLv(HotfixEnum.ChessPartnerType.QiLiMoFa);
	}

	static MainSkill()
	{
		//IL_000c: Field data (rva=0x4d8) could not be found in any section!
		//IL_000c: Field data (rva=0x4d8) could not be found in any section!
		int[] array = new int[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._03B1DF8029337FC87ACB8A15B1938682BA63C860335ECE2ED677AF9F7C119094));
		onceDamageIds_ComboBulletByPartnerLv = array;
	}
}
