using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinListenMotionChange : BaseAbilityMixin
{
	public ConfigMixinListenMotionChange config;

	public AbilityMixinListenMotionChange(ConfigMixinListenMotionChange configMixinListenMotionChange, Ability ab, byte index)
		: base(ab, index)
	{
		config = configMixinListenMotionChange;
	}

	internal override void RebindForPool(ConfigMixin configMixin, Ability ab, byte newIndex)
	{
		base.RebindForPool(configMixin, ab, newIndex);
		config = (ConfigMixinListenMotionChange)configMixin;
	}

	internal override void ResetForPool()
	{
		config = null;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility()?.AddListener(typeof(EvtMotionChange), this);
	}

	internal override void OnRemove()
	{
		owner.GetCompAbility()?.RemoveListener(typeof(EvtMotionChange), this);
	}

	internal override void OnSilentRemove()
	{
		owner.GetCompAbility()?.RemoveListener(typeof(EvtMotionChange), this);
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (!(evt is EvtMotionChange))
		{
			return;
		}
		EvtMotionChange evtMotionChange = (EvtMotionChange)evt;
		bool flag = false;
		if (config.from == null || config.from.Length == 0)
		{
			flag = true;
		}
		else
		{
			string[] array = config.from;
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i] == evtMotionChange.from)
				{
					flag = true;
				}
			}
		}
		bool flag2 = false;
		if (config.to == null || config.to.Length == 0)
		{
			flag2 = true;
		}
		else
		{
			string[] array = config.to;
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i] == evtMotionChange.to)
				{
					flag2 = true;
				}
			}
		}
		if ((flag & flag2) && config.actionList != null)
		{
			DoActions(owner, null, config.actionList);
		}
	}
}
