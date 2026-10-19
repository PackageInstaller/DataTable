using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Core;
using Bamboo.Collections;
using Bamboo.ECS;

namespace ACT.Battle.ECS.System;

public class SystemRogue : EntitySystem
{
	private readonly Dictionary<int, Dictionary<string, float>> m_TriggerParameters = new Dictionary<int, Dictionary<string, float>>();

	private readonly Dictionary<string, float> m_RogueParameter = new Dictionary<string, float>();

	private Dictionary<int, int> m_TriggerSuitCount = new Dictionary<int, int>();

	public List<RuntimeRogueCard> cards;

	public override Filter MajorFilter => null;

	public event Action<int, IEnumerator<int>, bool> OnCardChangeEvent;

	public event Action SetParamCallback;

	protected override void OnCreate()
	{
	}

	public int GetTriggerSuitCount(int triggerId)
	{
		if (RuntimeConfigs.data.rogueTriggerCards.TryGetValue(triggerId, out var value))
		{
			return m_TriggerSuitCount.GetValueOrDefault(value.suit, 0);
		}
		return 0;
	}

	public bool TryGetTriggerParameter(int trigger, string name, out float value)
	{
		value = 0f;
		if (m_TriggerParameters.TryGetValue(trigger, out var value2) && value2.TryGetValue(name, out var value3))
		{
			value = value3;
			return true;
		}
		return false;
	}

	private void ClearTriggerParameter(int triggerId)
	{
		if (m_TriggerParameters.TryGetValue(triggerId, out var value))
		{
			value.Clear();
		}
	}

	private void SetTriggerParameter(int trigger, string name, float value)
	{
		if (!m_TriggerParameters.TryGetValue(trigger, out var _))
		{
			m_TriggerParameters.Add(trigger, new Dictionary<string, float>());
		}
		m_TriggerParameters[trigger][name] = value;
	}

	public void SetTriggerParameter(int trigger, string name, float value, Entity er, Ability ab)
	{
		SetTriggerParameter(trigger, name, value);
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtRogueTriggerParameterChange evt = abilitySystem.GetEvt<EvtRogueTriggerParameterChange>(er, ab);
		evt.mainEntity = er;
		evt.triggerId = trigger;
		evt.parameterName = name;
		evt.parameterValue = value;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
	}

	private void SetRogueParameter(string name, float value)
	{
		m_RogueParameter[name] = value;
		SetParamCallback?.Invoke();
	}

	public void SetRogueParameter(string name, float value, Entity er, Ability ab)
	{
		SetRogueParameter(name, value);
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtRogueParameterChange evt = abilitySystem.GetEvt<EvtRogueParameterChange>(er, ab);
		evt.mainEntity = er;
		evt.parameterName = name;
		evt.parameterValue = value;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
	}

	public bool TryGetRogueParameter(string name, out float value)
	{
		value = 0f;
		if (m_RogueParameter.TryGetValue(name, out var value2))
		{
			value = value2;
			return true;
		}
		return false;
	}

	public void RemoveRogueParameter(string name)
	{
		m_RogueParameter.Remove(name);
	}

	public void RemoveRogueTriggerParameter(int triggerId)
	{
		m_TriggerParameters.Remove(triggerId);
	}

	public void AddCard(int trigger, List<int> effect)
	{
		RuntimeRogueCard runtimeRogueCard = RuntimeRogueCard.Pool.Get();
		runtimeRogueCard.Init(trigger, effect);
		cards.Add(runtimeRogueCard);
		int suit = RuntimeConfigs.data.rogueTriggerCards[trigger].suit;
		m_TriggerSuitCount[suit] = m_TriggerSuitCount.GetValueOrDefault(trigger, 0) + 1;
		OnCardChangeEvent?.Invoke(trigger, effect.GetEnumerator(), arg3: true);
	}

	public void RemoveCard(int trigger, List<int> effect)
	{
		for (int num = cards.Count - 1; num >= 0; num--)
		{
			if (cards[num].trigger == trigger && cards[num].effects.SequenceEqual(effect))
			{
				RemoveCard(num);
				break;
			}
		}
	}

	private void RemoveCard(int i)
	{
		RuntimeRogueCard runtimeRogueCard = cards[i];
		int trigger = runtimeRogueCard.trigger;
		BSet<int> effects = runtimeRogueCard.effects;
		cards.RemoveAt(i);
		m_TriggerSuitCount[trigger] = m_TriggerSuitCount.GetValueOrDefault(trigger, 0) - 1;
		OnCardChangeEvent?.Invoke(trigger, effects.GetEnumerator(), arg3: false);
		RuntimeRogueCard.Pool.Release(runtimeRogueCard);
	}
}
