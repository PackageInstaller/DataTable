using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13001;

public class SkillScript_Support_Skill : SkillAdvancedBase
{
	private bool _canAim;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513029, out var perkLevel))
		{
			_actor.buffComponent.RemoveBuffByBuffId(13029012);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513031, out perkLevel) && SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
		{
			long num = ILRuntimeAPI.PlayDrop(_actor, "Item_130_B2P24_Letter", playerAdventureActor.tsTransform.Position);
			if (num > 0)
			{
				DropEntity dropEntity = ILRuntimeAPI.GetDropEntity(num);
				if (dropEntity != null)
				{
					dropEntity.buffId = 13031011;
				}
			}
		}
		_canAim = true;
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
		DefaultLookAt();
	}

	public void OnStart()
	{
		string comboTag = GetComboTag();
		Action<string> onCustomEvent = OnCustomEvent;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent);
	}

	private string GetComboTag()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513021, out var perkLevel))
		{
			int perkLevel2;
			switch (GetWeActorCount())
			{
			case 2:
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 513023, out perkLevel2))
				{
					if (!CommonUtils.HavePersonalPerk(_actor.dataID, 513030, out perkLevel2))
					{
						return "B2P21P23_Skill_2";
					}
					return "B2p30P21P23_Skill_2";
				}
				if (!CommonUtils.HavePersonalPerk(_actor.dataID, 513030, out perkLevel2))
				{
					return "B2P21_Skill_2";
				}
				return "B2P30P21_Skill_2";
			case 3:
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 513023, out perkLevel2))
				{
					if (!CommonUtils.HavePersonalPerk(_actor.dataID, 513030, out perkLevel2))
					{
						return "B2P21P23_Skill_3";
					}
					return "B2p30P21P23_Skill_3";
				}
				if (!CommonUtils.HavePersonalPerk(_actor.dataID, 513030, out perkLevel2))
				{
					return "B2P21_Skill_3";
				}
				return "B2P30P21_Skill_3";
			}
		}
		else
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513023, out perkLevel))
			{
				if (GetWeActorCount() >= 3)
				{
					if (!CommonUtils.HavePersonalPerk(_actor.dataID, 513030, out perkLevel))
					{
						return "B2P23_Skill_3";
					}
					return "B2P30p23_Skill_3";
				}
				if (!CommonUtils.HavePersonalPerk(_actor.dataID, 513030, out perkLevel))
				{
					return "B2P23_Skill";
				}
				return "B2P30P23_Skill";
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513030, out perkLevel))
			{
				return "B2P30_Skill";
			}
		}
		return "B2_Skill";
	}

	private int GetWeActorCount()
	{
		int num = 0;
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.WE)
			{
				num++;
			}
		}
		return num;
	}

	public void OnUpdate()
	{
		if (_canAim)
		{
			DefaultLookAt();
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "StartIceRain"))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = this;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventName = "StartIceRain";
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513024, out var _) && string.Equals(eventName, "B2P24_Shoot") && _actor.attackTarget != null)
		{
			ILRuntimeAPI.SearchByRangeAndPosition(_actor, _actor.attackTarget.tsTransform.Position, Config_Support.searchRadius_P24, OnSearchTargetFinish_24, isConfront: true);
		}
	}

	private void OnSearchTargetFinish_24(List<LogicEntity> targets)
	{
		if (targets == null || targets.Count <= 0)
		{
			return;
		}
		TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_Support.shootOffset_P24.x + _actor.tsTransform.Forward * Config_Support.shootOffset_P24.z;
		LogicEntity logicEntity = (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor)?.attackTarget;
		if (logicEntity != null && targets.Remove(logicEntity))
		{
			targets.Insert(0, logicEntity);
		}
		int num = 3;
		List<string> list = (CommonUtils.HavePersonalPerk(_actor.dataID, 513023, out var _) ? Config_Support.bulletKeyList_P23_P24 : Config_Support.bulletKeyList_P24);
		int num2 = 0;
		int count = TSMath.Clamp(targets.Count, 0, num).AsInt();
		while (num > 0)
		{
			for (int i = 0; i < targets.Count; i++)
			{
				if (num <= 0)
				{
					break;
				}
				LogicEntity logicEntity2 = targets.get_Item(i);
				num2 = ((num2 < list.Count) ? num2 : 0);
				ILRuntimeAPI.Shoot(list.get_Item(num2), _actor, default, position, Config_Support.shootOffset_P24.y, logicEntity2.tsTransform.Position, logicEntity2, AimType.Target, BulletDirectionType.BulletToTarget)?.AddAdditionalAttr(13024011, count);
				num2++;
				num--;
			}
		}
	}

	private void OnRecoveryBegin()
	{
		_canAim = false;
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
	}
}
