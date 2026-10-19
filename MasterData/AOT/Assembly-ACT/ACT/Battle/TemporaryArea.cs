using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Event;
using ACT.World;
using ACT.World.Asset;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class TemporaryArea : MonoBehaviour
{
	private sealed class PendingTriggerEnter
	{
		public ITrigger Trigger;

		public Collider Collider;

		public CompBehave CompBehave;
	}

	private Dictionary<ITrigger, List<Collider>> m_DicTriggerColliders = new Dictionary<ITrigger, List<Collider>>();

	private readonly List<PendingTriggerEnter> m_PendingTriggerEnters = new List<PendingTriggerEnter>();

	private readonly List<CompBehave> m_PendingCompBehaves = new List<CompBehave>();

	private bool m_PendingWaitMainEntity;

	private bool m_PendingWaitSceneComplete;

	private Action _onLogicEnter;

	private Action _onLogicExit;

	public void Init(MixedBox[] boxColliderParametersArray, Action onEnter, Action onExit)
	{
		foreach (MixedBox mixedBox in boxColliderParametersArray)
		{
			GameObject gameObject = new GameObject("Area:" + mixedBox.name);
			gameObject.transform.SetParent(transform);
			BoxCollider boxCollider = gameObject.gameObject.AddComponent<BoxCollider>();
			boxCollider.isTrigger = true;
			mixedBox.CopyTo(boxCollider, gameObject.transform);
			MonoTrigger monoTrigger = gameObject.gameObject.AddComponent<MonoTrigger>();
			monoTrigger.triggerEnter = (Action<Collider, ITrigger>)Delegate.Combine(monoTrigger.triggerEnter, new Action<Collider, ITrigger>(TriggerEnter));
			monoTrigger.triggerExit = (Action<Collider, ITrigger>)Delegate.Combine(monoTrigger.triggerExit, new Action<Collider, ITrigger>(TriggerExit));
		}
		_onLogicEnter = (Action)Delegate.Combine(_onLogicEnter, onEnter);
		_onLogicExit = (Action)Delegate.Combine(_onLogicExit, onExit);
	}

	public void Init(ExitField[] boxColliderParametersArray, Action onEnter, Action onExit)
	{
		foreach (ExitField exitField in boxColliderParametersArray)
		{
			GameObject gameObject = new GameObject("Area:" + exitField.Name);
			gameObject.transform.SetParent(transform);
			BoxCollider boxCollider = gameObject.gameObject.AddComponent<BoxCollider>();
			boxCollider.isTrigger = true;
			exitField.CopyTo(boxCollider, gameObject.transform);
			MonoTrigger monoTrigger = gameObject.gameObject.AddComponent<MonoTrigger>();
			monoTrigger.triggerEnter = (Action<Collider, ITrigger>)Delegate.Combine(monoTrigger.triggerEnter, new Action<Collider, ITrigger>(TriggerEnter));
			monoTrigger.triggerExit = (Action<Collider, ITrigger>)Delegate.Combine(monoTrigger.triggerExit, new Action<Collider, ITrigger>(TriggerExit));
		}
		_onLogicEnter = (Action)Delegate.Combine(_onLogicEnter, onEnter);
		_onLogicExit = (Action)Delegate.Combine(_onLogicExit, onExit);
	}

	private bool IsSceneLoading()
	{
		return MonoECS.instance.IsLoadSubScene;
	}

	private void TriggerEnter(Collider collider, ITrigger trigger)
	{
		MonoEntity monoEntity = collider?.gameObject.GetComponent<MonoEntity>();
		if (monoEntity == null || !monoEntity.entity.IsValid || !monoEntity.entity.TryGetCompTrigger(out CompTrigger component) || !monoEntity.entity.TryGetCompBehave(out CompBehave component2) || !monoEntity.entity.IsCharacter() || MonoECS.instance == null || MonoECS.instance.PlayerControlType == MonoECS.ControlType.OreCar)
		{
			return;
		}
		uint triggerEntityId = component.UintTransform();
		bool flag = m_DicTriggerColliders.Count == 0;
		RemoveSameTriggerEntity(trigger, triggerEntityId);
		bool flag2 = IsSceneLoading();
		if ((!monoEntity.entity.IsLogicAvailable() || !IsCurrentMainEntity(monoEntity.entity)) | flag2)
		{
			m_PendingTriggerEnters.Add(new PendingTriggerEnter
			{
				Trigger = trigger,
				Collider = collider,
				CompBehave = component2
			});
			AddPendingLogicAvailable(component2);
			AddPendingMainEntityChanged();
			if (flag2)
			{
				AddPendingSceneComplete();
			}
			TryCompletePendingTriggerEnters();
		}
		else
		{
			AddLogicalCollider(trigger, collider);
			if (flag)
			{
				_onLogicEnter?.Invoke();
			}
		}
	}

	private void TriggerExit(Collider collider, ITrigger trigger)
	{
		RemovePendingTriggerEnter(trigger, collider);
		if (RemoveLogicalCollider(trigger, collider) && m_DicTriggerColliders.Count == 0 && m_PendingTriggerEnters.Count == 0)
		{
			_onLogicExit?.Invoke();
		}
	}

	private void AddLogicalCollider(ITrigger trigger, Collider collider)
	{
		if (!m_DicTriggerColliders.TryGetValue(trigger, out var value))
		{
			value = new List<Collider>();
			m_DicTriggerColliders.Add(trigger, value);
		}
		value.Add(collider);
	}

	private bool RemoveLogicalCollider(ITrigger trigger, Collider collider)
	{
		if (!m_DicTriggerColliders.TryGetValue(trigger, out var value))
		{
			return false;
		}
		bool flag = value.Remove(collider);
		if (!flag)
		{
			MonoEntity monoEntity = collider?.gameObject.GetComponent<MonoEntity>();
			if (monoEntity != null && monoEntity.entity.TryGetCompTrigger(out CompTrigger component))
			{
				uint num = component.UintTransform();
				for (int num2 = value.Count - 1; num2 >= 0; num2--)
				{
					MonoEntity monoEntity2 = value[num2]?.gameObject.GetComponent<MonoEntity>();
					if (monoEntity2 != null && monoEntity2.entity.TryGetCompTrigger(out CompTrigger component2) && component2.UintTransform() == num)
					{
						value.RemoveAt(num2);
						flag = true;
						break;
					}
				}
			}
		}
		if (value.Count == 0)
		{
			m_DicTriggerColliders.Remove(trigger);
		}
		return flag;
	}

	private bool IsCurrentMainEntity(Entity entity)
	{
		if (MonoECS.instance != null && MonoECS.instance.mainEntity.IsValid)
		{
			return MonoECS.instance.mainEntity == entity;
		}
		return false;
	}

	private void AddPendingMainEntityChanged()
	{
		if (!m_PendingWaitMainEntity)
		{
			m_PendingWaitMainEntity = true;
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.RuntimeBattleTeam_MainCharacterChanged, OnPendingMainEntityChanged);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, OnPendingMainEntityChanged);
		}
	}

	private void AddPendingSceneComplete()
	{
		if (!m_PendingWaitSceneComplete)
		{
			m_PendingWaitSceneComplete = true;
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.Scene_Change_Complete, OnPendingSceneComplete);
		}
	}

	private void OnPendingSceneComplete(BaseEventContent obj)
	{
		if (m_PendingWaitSceneComplete)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Scene_Change_Complete, OnPendingSceneComplete);
			m_PendingWaitSceneComplete = false;
			TryCompletePendingTriggerEnters();
		}
	}

	private void RemovePendingMainEntityChangedIfUnused()
	{
		if (m_PendingTriggerEnters.Count <= 0 && m_PendingWaitMainEntity)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RuntimeBattleTeam_MainCharacterChanged, OnPendingMainEntityChanged);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, OnPendingMainEntityChanged);
			m_PendingWaitMainEntity = false;
		}
	}

	private void OnPendingMainEntityChanged(BaseEventContent obj)
	{
		TryCompletePendingTriggerEnters();
	}

	private void TryCompletePendingTriggerEnters()
	{
		if (m_PendingWaitSceneComplete || MonoECS.instance == null || !MonoECS.instance.mainEntity.IsValid)
		{
			return;
		}
		Entity mainEntity = MonoECS.instance.mainEntity;
		bool flag = m_DicTriggerColliders.Count == 0;
		bool flag2 = false;
		for (int num = m_PendingTriggerEnters.Count - 1; num >= 0; num--)
		{
			PendingTriggerEnter pendingTriggerEnter = m_PendingTriggerEnters[num];
			MonoEntity monoEntity = pendingTriggerEnter.Collider?.gameObject.GetComponent<MonoEntity>();
			if (!(monoEntity == null) && monoEntity.entity.IsValid && !(monoEntity.entity != mainEntity) && monoEntity.entity.IsLogicAvailable() && monoEntity.entity.TryGetCompBehave(out CompBehave component) && component == pendingTriggerEnter.CompBehave)
			{
				m_PendingTriggerEnters.RemoveAt(num);
				AddLogicalCollider(pendingTriggerEnter.Trigger, pendingTriggerEnter.Collider);
				RemovePendingLogicAvailableIfUnused(pendingTriggerEnter.CompBehave);
				flag2 = true;
			}
		}
		RemovePendingMainEntityChangedIfUnused();
		RemovePendingSceneCompleteIfUnused();
		if (flag2 & flag)
		{
			_onLogicEnter?.Invoke();
		}
	}

	private void AddPendingLogicAvailable(CompBehave compBehave)
	{
		if (!m_PendingCompBehaves.Contains(compBehave))
		{
			m_PendingCompBehaves.Add(compBehave);
			compBehave.OnLogicAvailable += OnPendingLogicAvailable;
		}
	}

	private void OnPendingLogicAvailable(Entity entity)
	{
		if (entity.IsValid && entity.TryGetCompBehave(out CompBehave _))
		{
			TryCompletePendingTriggerEnters();
		}
	}

	private void RemoveSameTriggerEntity(ITrigger trigger, uint triggerEntityId)
	{
		if (m_DicTriggerColliders.TryGetValue(trigger, out var value))
		{
			for (int num = value.Count - 1; num >= 0; num--)
			{
				MonoEntity monoEntity = value[num]?.gameObject.GetComponent<MonoEntity>();
				if (!(monoEntity == null) && monoEntity.entity.TryGetCompTrigger(out CompTrigger component) && component.UintTransform() == triggerEntityId)
				{
					value.RemoveAt(num);
				}
			}
			if (value.Count == 0)
			{
				m_DicTriggerColliders.Remove(trigger);
			}
		}
		for (int num2 = m_PendingTriggerEnters.Count - 1; num2 >= 0; num2--)
		{
			PendingTriggerEnter pendingTriggerEnter = m_PendingTriggerEnters[num2];
			MonoEntity monoEntity2 = pendingTriggerEnter.Collider?.gameObject.GetComponent<MonoEntity>();
			if (pendingTriggerEnter.Trigger == trigger && !(monoEntity2 == null) && monoEntity2.entity.TryGetCompTrigger(out CompTrigger component2) && component2.UintTransform() == triggerEntityId)
			{
				m_PendingTriggerEnters.RemoveAt(num2);
				RemovePendingLogicAvailableIfUnused(pendingTriggerEnter.CompBehave);
			}
		}
		RemovePendingMainEntityChangedIfUnused();
		RemovePendingSceneCompleteIfUnused();
	}

	private void RemovePendingTriggerEnter(ITrigger trigger, Collider collider)
	{
		for (int num = m_PendingTriggerEnters.Count - 1; num >= 0; num--)
		{
			PendingTriggerEnter pendingTriggerEnter = m_PendingTriggerEnters[num];
			if (pendingTriggerEnter.Trigger == trigger && !(pendingTriggerEnter.Collider != collider))
			{
				m_PendingTriggerEnters.RemoveAt(num);
				RemovePendingLogicAvailableIfUnused(pendingTriggerEnter.CompBehave);
			}
		}
		RemovePendingMainEntityChangedIfUnused();
		RemovePendingSceneCompleteIfUnused();
	}

	private void RemovePendingSceneCompleteIfUnused()
	{
		if (m_PendingTriggerEnters.Count <= 0 && m_PendingWaitSceneComplete)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Scene_Change_Complete, OnPendingSceneComplete);
			m_PendingWaitSceneComplete = false;
		}
	}

	private void RemovePendingLogicAvailableIfUnused(CompBehave compBehave)
	{
		if (!m_PendingTriggerEnters.Exists((PendingTriggerEnter pending) => pending.CompBehave == compBehave))
		{
			compBehave.OnLogicAvailable -= OnPendingLogicAvailable;
			m_PendingCompBehaves.Remove(compBehave);
		}
	}

	private void OnDestroy()
	{
		if (m_PendingWaitSceneComplete)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Scene_Change_Complete, OnPendingSceneComplete);
		}
		if (m_PendingWaitMainEntity)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RuntimeBattleTeam_MainCharacterChanged, OnPendingMainEntityChanged);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, OnPendingMainEntityChanged);
		}
		foreach (CompBehave pendingCompBehafe in m_PendingCompBehaves)
		{
			pendingCompBehafe.OnLogicAvailable -= OnPendingLogicAvailable;
		}
		m_PendingTriggerEnters.Clear();
		m_PendingCompBehaves.Clear();
		m_DicTriggerColliders.Clear();
	}
}
