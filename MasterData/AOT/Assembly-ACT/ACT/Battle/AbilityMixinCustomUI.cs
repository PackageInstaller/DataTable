using ACT.Battle.Configs;
using ACT.Event;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public class AbilityMixinCustomUI : BaseAbilityMixin
{
	private ConfigMixinCustomUI m_Config;

	public AbilityMixinCustomUI(ConfigMixinCustomUI config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void OnAdd()
	{
		CreateOperateBtnGroupEvt evt = Singleton<EventManager>.instance.GetEvt<CreateOperateBtnGroupEvt>();
		evt.characterEntity = ability.owner;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_CreateOperateBtnGroup, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		InitMotionCount(ability);
		owner.GetCompAbility().AddListener(typeof(EvtBattleChange), this);
	}

	internal override void OnRemove()
	{
		owner.GetCompAbility().RemoveListener(typeof(EvtBattleChange), this);
	}

	private void InitMotionCount(Ability ab)
	{
		CompMotion compMotion = ab.owner.GetCompMotion();
		ConfigCharacter config = ab.owner.GetConfig();
		compMotion.SetInt("dodgeInAirCount", config.dogeInAirCount);
		compMotion.dodgeCountChange.Add((int count) =>
		{
			compMotion.SetInt("dodgeInAirCount", count);
		});
		compMotion.airAttackCountChange.Add((int count) =>
		{
			compMotion.SetInt("airAttackA", count);
			SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
			EvtAirAttackCountChange evt = systemAbility.GetEvt<EvtAirAttackCountChange>(owner, ability);
			evt.count = count;
			evt.mainEntity = ab.owner;
			systemAbility.FireEvt(evt);
			systemAbility.ReleaseEvt(evt);
		});
		compMotion.SetInt("airAttackA", config.airAttackCount);
		compMotion.airAIndexChange.Add((int count) =>
		{
			compMotion.SetInt("AirAnum", count);
		});
		compMotion.SetInt("AirAnum", 0);
	}
}
