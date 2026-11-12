using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._14701;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private readonly Dictionary<int, string> dicKey = new Dictionary<int, string>
	{
		[1] = "Atk_1",
		[2] = "Atk_2",
		[3] = "Atk_3"
	};

	private string key_P1 = "Atk_3_P1";

	private string evt_shoot1 = "NrmAtk_Shoot1";

	private string evt_shoot2 = "NrmAtk_Shoot2";

	private string evt_shoot3 = "NrmAtk_Shoot3";

	private string evt_shoot4 = "NrmAtk_Shoot4";

	private string evt_shoot5 = "NrmAtk_Shoot5";

	private string evt_shoot6 = "NrmAtk_Shoot6";

	private string evt_shoot7 = "NrmAtk_Shoot7";

	private List<string> bullets = new List<string> { "Bullet_147_NrmAtk_Bessel_1", "Bullet_147_NrmAtk_Bessel_2", "Bullet_147_NrmAtk_Bessel_3", "Bullet_147_NrmAtk_Bessel_4", "Bullet_147_NrmAtk_Bessel_5", "Bullet_147_NrmAtk_Bessel_6", "Bullet_147_NrmAtk_Bessel_7" };

	private AnimationSlotConfigComponent.SlotType slotType = AnimationSlotConfigComponent.SlotType.Body;

	private int resetNormal = CommonHelper.StringToHash("ResetNormal");

	private const int perkId_1 = 514701;

	private const int perkId_2 = 514702;

	private int buff_2 = 14702011;

	private const int perkId_5 = 514705;

	private int buff_5 = 14705011;

	private int atkIndex;

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
		if (_actor.attackTarget == null)
		{
			comboAttack.InterruptAttack();
		}
	}

	private void DoMainLogic()
	{
		atkIndex = (int)(long)_actor.logicVariable.GetLogicTagValue("curNormalPhase");
		string text = dicKey.get_Item(atkIndex);
		if (GetPerkLv(514702, out var lv) && _actor.buffComponent.GetBuffNumByID(buff_2) > 0)
		{
			atkIndex = 3;
			text = dicKey.get_Item(3);
			_actor.buffComponent.RemoveBuffByBuffId(buff_2, 1);
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = resetNormal;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		if (atkIndex == 3)
		{
			if (GetPerkLv(514701, out lv) && _actor.logicVariable.GetLogicTagToggle("inLink"))
			{
				text = key_P1;
			}
			if (GetPerkLv(514705, out lv))
			{
				_actor.buffComponent.AddBuff(buff_5, _actor);
			}
		}
		string actionTag = text;
		LogicEntity attackTarget = _actor.attackTarget;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, attackTarget, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		int num = 0;
		if (evt.Equals(evt_shoot1))
		{
			num = 1;
		}
		else if (evt.Equals(evt_shoot2))
		{
			num = 2;
		}
		else if (evt.Equals(evt_shoot3))
		{
			num = 3;
		}
		else if (evt.Equals(evt_shoot4))
		{
			num = 4;
		}
		else if (evt.Equals(evt_shoot5))
		{
			num = 5;
		}
		else if (evt.Equals(evt_shoot6))
		{
			num = 6;
		}
		else if (evt.Equals(evt_shoot7))
		{
			num = 7;
		}
		if (num != 0)
		{
			TSVector2 position = _actor.tsTransform.Position;
			FP fP = _actor.dtCollider.HeightCenter;
			Transform slotNode = _actor.slotConfig.GetSlotNode(slotType);
			if (slotNode != null)
			{
				position.x = slotNode.position.x;
				position.y = slotNode.position.z;
				fP = slotNode.position.y - _actor.transform.position.y;
			}
			if (_actor.aimLockedTarget != null)
			{
				string bulletAlias = bullets.get_Item(num - 1);
				AdventureActor actor = _actor;
				TSVector2 position2 = position;
				FP positionY = fP;
				LogicEntity aimLockedTarget = _actor.aimLockedTarget;
				ILRuntimeAPI.Shoot(bulletAlias, actor, default, position2, positionY, default, aimLockedTarget, AimType.Target, BulletDirectionType.BulletToTarget);
			}
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
