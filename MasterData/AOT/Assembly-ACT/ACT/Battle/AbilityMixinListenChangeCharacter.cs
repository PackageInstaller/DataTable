using ACT.Battle.Configs;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinListenChangeCharacter : BaseAbilityMixin
{
	private ConfigMixinListenChangeCharacter m_Config;

	private float timeFlag;

	private bool canDoUp;

	private bool canDoDown;

	public AbilityMixinListenChangeCharacter(ConfigMixinListenChangeCharacter config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinListenChangeCharacter)config;
	}

	internal override void ResetForPool()
	{
		RemoveListener();
		m_Config = null;
		timeFlag = 0f;
		canDoUp = false;
		canDoDown = false;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		timeFlag = 0f;
		Singleton<GameManager>.instance.ecsManager.systemAbility.AddListener(typeof(EvtBattleChange), this);
	}

	internal override void OnRemove()
	{
		RemoveListener();
	}

	private void RemoveListener()
	{
		(Singleton<GameManager>.instance?.ecsManager?.systemAbility)?.RemoveListener(typeof(EvtBattleChange), this);
	}

	internal override void ListenEvt(BaseEvt evt)
	{
		if (!(evt is EvtBattleChange evtBattleChange) || (!(m_Config.cd < 1E-06f) && !(Time.time - timeFlag > m_Config.cd)))
		{
			return;
		}
		timeFlag = Time.time;
		canDoUp = (canDoDown = false);
		if (!m_Config.source.HasFlag(evtBattleChange.source))
		{
			return;
		}
		switch (m_Config.listenUp)
		{
		case ListenChangeCharacterType.none:
			canDoUp = false;
			break;
		case ListenChangeCharacterType.onlyListenSelf:
			if (evtBattleChange.next == owner)
			{
				canDoUp = true;
			}
			break;
		case ListenChangeCharacterType.onlyListenOther:
			if (evtBattleChange.next != owner)
			{
				canDoUp = true;
			}
			break;
		case ListenChangeCharacterType.onlyListenAnyBody:
			canDoUp = true;
			break;
		}
		switch (m_Config.listenDown)
		{
		case ListenChangeCharacterType.none:
			canDoDown = false;
			break;
		case ListenChangeCharacterType.onlyListenSelf:
			if (evtBattleChange.last == owner)
			{
				canDoDown = true;
			}
			break;
		case ListenChangeCharacterType.onlyListenOther:
			if (evtBattleChange.last != owner)
			{
				canDoDown = true;
			}
			break;
		case ListenChangeCharacterType.onlyListenAnyBody:
			canDoDown = true;
			break;
		}
		if (canDoUp)
		{
			DoActions(evtBattleChange.next, evt, m_Config.actionOnOwnerNext);
		}
		if (canDoDown)
		{
			DoActions(evtBattleChange.last, evt, m_Config.actionsOnOwnerPrev);
		}
	}

	internal override void OnAddStack(int add)
	{
		base.OnAddStack(add);
	}
}
