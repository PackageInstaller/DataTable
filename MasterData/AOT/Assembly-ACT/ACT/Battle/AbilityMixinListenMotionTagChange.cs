using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinListenMotionTagChange : BaseAbilityMixin
{
	public ConfigMixinListenMotionTagChange config;

	public AbilityMixinListenMotionTagChange(ConfigMixinListenMotionTagChange configMixinListenMotionTagChange, Ability ab, byte index)
		: base(ab, index)
	{
		config = configMixinListenMotionTagChange;
	}

	internal override void RebindForPool(ConfigMixin configMixin, Ability ab, byte newIndex)
	{
		base.RebindForPool(configMixin, ab, newIndex);
		config = (ConfigMixinListenMotionTagChange)configMixin;
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
		if (evt is EvtMotionChange evtMotionChange && config != null && MatchTags(evtMotionChange.fromMotion, config.fromPrimaryTypeTag, config.fromTypeTag) && MatchTags(evtMotionChange.toMotion, config.toPrimaryTypeTag, config.toTypeTag) && config.actionList != null)
		{
			DoActions(owner, null, config.actionList);
		}
	}

	private static bool MatchTags(ConfigMotion motion, MotionPrimaryTypeTag primaryTypeTag, MotionTypeTag typeTag)
	{
		if (primaryTypeTag == MotionPrimaryTypeTag.None && typeTag == MotionTypeTag.None)
		{
			return true;
		}
		if (motion == null)
		{
			return false;
		}
		if (primaryTypeTag == MotionPrimaryTypeTag.None || motion.motionPrimaryTypeTag == primaryTypeTag)
		{
			if (typeTag != MotionTypeTag.None)
			{
				return motion.motionTypeTag == typeTag;
			}
			return true;
		}
		return false;
	}
}
