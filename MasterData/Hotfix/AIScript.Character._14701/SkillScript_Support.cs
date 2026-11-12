using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._14701;

public class SkillScript_Support : SkillAdvancedBase
{
	private string key_1 = "Skill_Sup_HengSao";

	private string key_1_P21 = "Skill_Sup_HengSao_P21";

	private string key_1_P26 = "Skill_Sup_HengSao_P26";

	private string key_1_P21P26 = "Skill_Sup_HengSao_P21P26";

	private string key_2 = "Skill_Sup_TanQin";

	private string key_2_P24 = "Skill_Sup_TanQin_P24";

	private string evt_shoot = "147SkillSupTanQun";

	private string bullet = "Bullet_147_Sup_YinBo";

	private AnimationSlotConfigComponent.SlotType slotType = AnimationSlotConfigComponent.SlotType.Body;

	private FP searchRange = 10;

	private const int perkId_21 = 514721;

	private const int perkId_23 = 514723;

	private string bullet_23 = "Bullet_147_Sup_YinBo_P23";

	private const int perkId_24 = 514724;

	private const int perkId_26 = 514726;

	private const int perkId_28 = 514728;

	private int buff_28 = 14728011;

	private const int perkId_29 = 514729;

	private CoroutineNode corMain;

	private Dictionary<long, int> shootCache = new Dictionary<long, int>();

	private List<LogicEntity> list = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		shootCache.Clear();
		list.Clear();
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		bool interrupt = false;
		bool perkLv = GetPerkLv(514721, out var lv);
		bool perk24 = GetPerkLv(514724, out lv);
		bool perkLv2 = GetPerkLv(514726, out lv);
		string actionTag = key_1;
		if (perkLv & perkLv2)
		{
			actionTag = key_1_P21P26;
		}
		else
		{
			if (perkLv)
			{
				actionTag = key_1_P21;
			}
			if (perkLv2)
			{
				actionTag = key_1_P26;
			}
		}
		RequestComboAttack req = BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, () =>
		{
			interrupt = true;
		}, null, null, fadeOutAnim: true, null, recoveryBeginCheckCdStart: false);
		while (!req.isRecoveryBegin | interrupt)
		{
			yield return null;
		}
		actionTag = (perk24 ? key_2_P24 : key_2);
		SkillScript_Support skillScript_Support = this;
		string actionTag2 = actionTag;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = SkillFinish;
		System.Action onInterrupt = SkillInterrupt;
		skillScript_Support.BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action, null, fadeOutAnim: true);
	}

	private void onCustomEvent(string evt)
	{
		if (!evt.Equals(evt_shoot))
		{
			return;
		}
		LogicEntity logicEntity = null;
		if (GetPerkLv(514729, out var _))
		{
			logicEntity = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		}
		if (logicEntity == null)
		{
			List<long> list = new List<long>();
			foreach (KeyValuePair<long, int> item in shootCache)
			{
				LogicEntity logicEntity2 = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(item.Key);
				if (logicEntity2 != null && logicEntity2 is AdventureActor adventureActor)
				{
					if (adventureActor.isSneak || adventureActor.isPenetrate || !adventureActor.actorHealthInfo.isAlive)
					{
						list.Add(item.Key);
					}
				}
				else
				{
					list.Add(item.Key);
				}
			}
			for (int i = 0; i < list.Count; i++)
			{
				shootCache.Remove(list.get_Item(i));
			}
			CommonUtils.SearchNearTargetsByCircle(_actor, _actor.tsTransform.Position, searchRange, isConfront: true, includeSelf: false, this.list);
			if (this.list.Count > 0)
			{
				for (int j = 0; j < this.list.Count; j++)
				{
					if (!shootCache.TryGetValue(this.list.get_Item(j).Id, out var _))
					{
						shootCache.Add(this.list.get_Item(j).Id, 1);
						logicEntity = this.list.get_Item(j);
						break;
					}
				}
				if (logicEntity == null)
				{
					this.list.Sort((LogicEntity x, LogicEntity y) =>
					{
						int num = shootCache.get_Item(x.Id);
						int num2 = shootCache.get_Item(y.Id);
						return num - num2;
					});
					logicEntity = this.list.get_Item(0);
					shootCache.get_Item(logicEntity.Id)++;
				}
			}
		}
		if (logicEntity != null)
		{
			Shoot(logicEntity);
		}
	}

	private void Shoot(LogicEntity target)
	{
		if (GetPerkLv(514728, out var lv))
		{
			_actor.buffComponent.AddBuff(buff_28, _actor);
		}
		TSVector2 position = _actor.tsTransform.Position;
		FP positionY = _actor.dtCollider.HeightCenter;
		Transform slotNode = _actor.slotConfig.GetSlotNode(slotType);
		if (slotNode != null)
		{
			position.x = slotNode.position.x;
			position.y = slotNode.position.z;
			positionY = slotNode.position.y;
		}
		string bulletAlias = (GetPerkLv(514723, out lv) ? bullet_23 : bullet);
		bool perkLv = GetPerkLv(514729, out lv);
		if (ILRuntimeAPI.Shoot(bulletAlias, _actor, default, position, positionY, default, target, AimType.Target, BulletDirectionType.BulletToTarget) is AdventureFbxFollowBullet adventureFbxFollowBullet)
		{
			adventureFbxFollowBullet.EnableMainCtrTargetFirst = perkLv;
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
