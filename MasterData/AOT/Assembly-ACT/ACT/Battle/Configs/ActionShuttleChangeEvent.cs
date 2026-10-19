using ACT.Event;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行穿梭事件", "Action", new string[] { "shuttle", "change", "event", "trigger", "signal" })]
public class ActionShuttleChangeEvent : ConfigAction
{
	public ConfigFunction<float> count;

	public ConfigFunction<float> maxCount;

	public ConfigFunction<float> breakLimit;

	public override void Do(ActionMemory memory)
	{
		UIShuttleUpdateEvent evt = Singleton<EventManager>.instance.GetEvt<UIShuttleUpdateEvent>();
		evt.count = (int)count.Return(memory);
		evt.maxCount = (int)maxCount.Return(memory);
		evt.breakLimit = breakLimit.Return(memory) != 0f;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_ShuttleUpdate, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
