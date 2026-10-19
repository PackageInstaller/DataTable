using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.Game;
using ACT.UI;
using ACT.World;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinMixedRaidTrapTrigger : BaseAbilityMixin
{
	private readonly ConfigMixinMixedRaidTrapTrigger m_Config;

	private List<Collider> m_Colliders = new List<Collider>();

	private const string m_BoxName = "attackField";

	private Entity m_TriggerEntity;

	public AbilityMixinMixedRaidTrapTrigger(ConfigMixinMixedRaidTrapTrigger config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void OnAdd()
	{
		foreach (MonoTrigger monoTrigger in owner.GetMono().GetMixedPart("attackField").monoAttackPart.MonoTriggers)
		{
			monoTrigger.triggerEnter = (Action<Collider, ITrigger>)Delegate.Combine(monoTrigger.triggerEnter, new Action<Collider, ITrigger>(TriggerEnter));
			monoTrigger.triggerExit = (Action<Collider, ITrigger>)Delegate.Combine(monoTrigger.triggerExit, new Action<Collider, ITrigger>(TriggerExit));
			monoTrigger.triggerExitEvt = (Action)Delegate.Combine(monoTrigger.triggerExitEvt, new Action(TriggerExitEvt));
		}
	}

	internal override void OnRemove()
	{
		TriggerExitEvt();
	}

	internal override void OnSilentRemove()
	{
		OnRemove();
	}

	private void TriggerEnter(Collider collider, ITrigger trigger)
	{
		MonoEntity component = collider.gameObject.GetComponent<MonoEntity>();
		if (!(component != null) || !component.entity.IsCharacter() || MonoECS.instance.localPlayer.IndexOfTeamCharacter(component.entity) != MonoECS.instance.battleEntityIndex)
		{
			return;
		}
		if (m_Colliders.Count == 0)
		{
			m_TriggerEntity = component.entity;
			if (m_TriggerEntity.IsAlive() && MonoECS.instance.IsMainEntity(m_TriggerEntity))
			{
				G.service.ParkourRaidDead((bool r) =>
				{
					if (r)
					{
						if (m_Config.onTriggerEnter != null)
						{
							DoActions(m_TriggerEntity, null, m_Config.onTriggerEnter);
						}
					}
					else
					{
						Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_COMMONWORLDFAIL).Forget();
					}
				});
			}
		}
		if (m_TriggerEntity != component.entity)
		{
			m_TriggerEntity = component.entity;
			m_Colliders.Clear();
		}
		m_Colliders.Add(collider);
		OnEnterEvt(component.entity, trigger);
	}

	private void TriggerExit(Collider collider, ITrigger trigger)
	{
		MonoEntity component = collider.gameObject.GetComponent<MonoEntity>();
		if (!(component == null) && component.entity.IsCharacter() && m_Colliders.Contains(collider))
		{
			m_Colliders.Remove(collider);
			OnExitEvt(component.entity, trigger);
			if (m_Colliders.Count == 0)
			{
				m_TriggerEntity = default;
			}
		}
	}

	private void OnEnterEvt(Entity entity, ITrigger trigger)
	{
		TriggerStateChange evt = Singleton<EventManager>.instance.GetEvt<TriggerStateChange>();
		evt.enter = true;
		evt.trigger = trigger;
		evt.entity = entity;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TriggerStateChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void OnExitEvt(Entity entity, ITrigger trigger)
	{
		TriggerStateChange evt = Singleton<EventManager>.instance.GetEvt<TriggerStateChange>();
		evt.enter = false;
		evt.trigger = trigger;
		evt.entity = entity;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TriggerStateChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void TriggerExitEvt()
	{
		m_Colliders.Clear();
		m_TriggerEntity = default;
	}
}
