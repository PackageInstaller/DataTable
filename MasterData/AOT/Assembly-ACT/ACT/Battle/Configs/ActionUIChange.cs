using ACT.Event;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行UI", "Action", new string[] { "ui", "change", "hud", "text", "tip" })]
public class ActionUIChange : ConfigAction
{
	public enum IconType
	{
		None = -1,
		conmmonAttack,
		specialAttack,
		jump,
		switch1,
		switch2,
		switch3,
		shift
	}

	[Tooltip("如果true则更改，false则还原")]
	public bool changeIcon;

	[Tooltip("如果true则更改，false则还原")]
	public bool changeEffect;

	public IconType type;

	protected override AbilityAuth defaultAuth => AbilityAuth.ClientOwner;

	public override void Do(ActionMemory memory)
	{
		UIChangeEvt evt = Singleton<EventManager>.instance.GetEvt<UIChangeEvt>();
		evt.changeIcon = changeIcon;
		evt.changeEffect = changeEffect;
		evt.type = type;
		evt.owner = memory.owner;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_IconChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
