using ACT.Battle.Configs;
using Fundamental;

namespace ACT.Battle;

public class AbilityMixinListenCustomEvt : BaseAbilityMixin
{
	private ConfigMixinListenCustomEvt m_Config;

	public AbilityMixinListenCustomEvt(ConfigMixinListenCustomEvt config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinListenCustomEvt)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		base.OnAdd();
		Singleton<GameManager>.instance.ecsManager.systemAbility.AddListener(typeof(EvtCustom), this);
	}

	internal override void OnRemove()
	{
		base.OnRemove();
		Singleton<GameManager>.instance.ecsManager.systemAbility.RemoveListener(typeof(EvtCustom), this);
	}

	internal override void OnSilentRemove()
	{
		base.OnSilentRemove();
		Singleton<GameManager>.instance.ecsManager.systemAbility.RemoveListener(typeof(EvtCustom), this);
	}

	internal override void ListenEvt(BaseEvt evt)
	{
		if (evt is EvtCustom evtCustom && evtCustom.eventId == m_Config.id)
		{
			DoActions(owner, evt, m_Config.actions);
		}
	}
}
