using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11901;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private readonly Dictionary<int, string> dicKey = new Dictionary<int, string>
	{
		[1] = "Atk1",
		[2] = "Atk2",
		[3] = "Atk3"
	};

	private string evt_FanShoot = "119NrmAtk";

	private string bullut = "Bullet_11901_Atk_T2";

	private const int perkId_2 = 511902;

	private int buffId_2 = 11950211;

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

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
	}

	private void DoMainLogic()
	{
		int key = (int)(long)_actor.logicVariable.GetLogicTagValue("curNormalPhase");
		string actionTag = dicKey.get_Item(key);
		LogicEntity attackTarget = _actor.attackTarget;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, attackTarget, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnCustomEvent(string eventName)
	{
		if (eventName.Equals(evt_FanShoot) && GetPerkLv(511902, out var _) && _actor.buffComponent.CheckBuffByBuffID(buffId_2))
		{
			TSVector2 multiShootDirection = _actor.tsTransform.Forward;
			LogicEntity attackTarget = _actor.attackTarget;
			if (attackTarget != null)
			{
				multiShootDirection = (attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			}
			ILRuntimeAPI.FanMultipleShoot(_actor, bullut, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 3, 0, _actor.tsTransform.Position, 1.5, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 33, 0, 0.5);
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
