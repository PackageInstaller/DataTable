using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Fundamental;
using UnityEngine.Events;

namespace ACT.Battle;

public class AbilityMixinBreakItems : BaseAbilityMixin
{
	private ConfigMixinBreakItems m_Config;

	private List<Entity> m_AllItems;

	private float startTimeStamp;

	private bool m_IsOver = true;

	public AbilityMixinBreakItems(Ability ab, byte index, ConfigMixinBreakItems config)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void OnAdd()
	{
		m_AllItems = ListPool<Entity>.Get();
		m_IsOver = true;
		ActionCreatFlexibleEntity[] items = m_Config.items;
		foreach (ActionCreatFlexibleEntity obj in items)
		{
			obj.onCreate = (UnityAction<Entity>)Delegate.Combine(obj.onCreate, new UnityAction<Entity>(OnCreateItem));
		}
		Singleton<GameManager>.instance.ecsManager.systemAbility.AddListener(typeof(EvtAbilityBreakBullet), this);
	}

	internal override void TriggerAbility()
	{
		startTimeStamp = owner.GetCompTime().lifeTime;
		m_IsOver = false;
		Entity entity = caster;
		Entity entity2 = owner;
		FindTargetResult target = FindTargetResult.EntityOnly(owner);
		Ability ability = base.ability;
		ConfigAction[] items = m_Config.items;
		SystemAbility.DoActions(entity, entity2, target, null, ability, items);
	}

	internal override void FixedUpdate()
	{
		if (!m_IsOver && !(owner.GetCompTime().lifeTime - startTimeStamp <= m_Config.time))
		{
			m_IsOver = true;
			ReleaseBullets();
			SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(owner), null, ability, m_Config.onTimeOut);
			SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(owner), null, ability, m_Config.onFailed);
		}
	}

	internal override void ListenEvt(BaseEvt evt)
	{
		if (evt is EvtAbilityBreakBullet evtAbilityBreakBullet && !m_IsOver && m_AllItems.Count > 0)
		{
			m_AllItems.Remove(evtAbilityBreakBullet.bullet);
			if (m_AllItems.Count == 0)
			{
				m_IsOver = true;
				ReleaseBullets();
				SystemAbility.DoActions(caster, owner, FindTargetResult.EntityOnly(owner), null, ability, m_Config.onSuccess);
			}
		}
	}

	internal override void OnRemove()
	{
		ReleaseBullets();
		Singleton<GameManager>.instance.ecsManager.systemAbility.RemoveListener(typeof(EvtAbilityBreakBullet), this);
		ListPool<Entity>.Release(m_AllItems);
	}

	private void ReleaseBullets()
	{
		foreach (Entity allItem in m_AllItems)
		{
			allItem.KillEntity();
		}
		m_AllItems.Clear();
	}

	private void OnCreateItem(Entity entity)
	{
		m_AllItems.Add(entity);
		entity.GetCompAbility().onDie += (Action<Entity>)((Entity l) =>
		{
			EvtAbilityBreakBullet evt = Singleton<GameManager>.instance.ecsManager.systemAbility.GetEvt<EvtAbilityBreakBullet>(owner, ability);
			evt.bullet = l;
			Singleton<GameManager>.instance.ecsManager.systemAbility.FireEvt(evt);
			Singleton<GameManager>.instance.ecsManager.systemAbility.ReleaseEvt(evt);
		});
	}
}
