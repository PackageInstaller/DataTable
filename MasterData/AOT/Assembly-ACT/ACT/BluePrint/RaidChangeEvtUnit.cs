using ACT.Event;
using Fundamental;
using Unity.VisualScripting;
using UnityEngine;

namespace ACT.BluePrint;

[UnitCategory("ACT")]
public class RaidChangeEvtUnit : EventUnit<int>
{
	public ValueInput ChangeType;

	private const string m_HookName = "RaidChangeEvt";

	private GameObject m_Target;

	protected override bool register => true;

	protected override void Definition()
	{
		base.Definition();
		ChangeType = ValueInput("ChangeType", RaidChangeType.Exit);
	}

	public override void Instantiate(GraphReference instance)
	{
		base.Instantiate(instance);
		m_Target = instance.gameObject;
	}

	public override void StartListening(GraphStack stack)
	{
		base.StartListening(stack);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.Raid_Enter, OnRaidEnterEvt);
		Fundamental.Singleton<EventManager>.instance.AddEventListener(ClientEvent.Raid_Exit, OnRaidExitEvt);
	}

	public override void StopListening(GraphStack stack)
	{
		base.StopListening(stack);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Raid_Enter, OnRaidEnterEvt);
		Fundamental.Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Raid_Exit, OnRaidExitEvt);
	}

	public override EventHook GetHook(GraphReference reference)
	{
		return new EventHook("RaidChangeEvt", m_Target);
	}

	private void OnRaidEnterEvt(BaseEventContent e)
	{
		EventBus.Trigger(GetHook(null), 1);
	}

	private void OnRaidExitEvt(BaseEventContent e)
	{
		EventBus.Trigger(GetHook(null), 2);
	}

	protected override bool ShouldTrigger(Flow flow, int args)
	{
		return flow.GetValue<RaidChangeType>(ChangeType) == (RaidChangeType)args;
	}
}
