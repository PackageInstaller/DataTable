using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Scripting;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Utility")]
[Description("Send a graph event. If global is true, all graph owners in scene will receive this event. Use along with the 'Check Event' Condition")]
[Preserve]
public class SendEvent : ActionTask<GraphOwner>
{
	[RequiredField]
	public BBParameter<string> eventName;

	public BBParameter<float> delay;

	public bool sendGlobal;

	protected override string info => (sendGlobal ? "Global " : "") + "Send Event [" + eventName?.ToString() + "]" + ((delay.value > 0f) ? (" after " + delay?.ToString() + " sec.") : "");

	protected override void OnUpdate()
	{
		if (base.elapsedTime >= delay.value)
		{
			if (sendGlobal)
			{
				Graph.SendGlobalEvent(eventName.value, null, this);
			}
			else
			{
				base.agent.SendEvent(eventName.value, null, this);
			}
			EndAction();
		}
	}
}
[Category("✫ Utility")]
[Description("Send a graph event with T value. If global is true, all graph owners in scene will receive this event. Use along with the 'Check Event' Condition")]
public class SendEvent<T> : ActionTask<GraphOwner>
{
	[RequiredField]
	public BBParameter<string> eventName;

	public BBParameter<T> eventValue;

	public BBParameter<float> delay;

	public bool sendGlobal;

	protected override string info => string.Format("{0} Event [{1}] ({2}){3}", sendGlobal ? "Global " : "", eventName, eventValue, (delay.value > 0f) ? (" after " + delay?.ToString() + " sec.") : "");

	protected override void OnUpdate()
	{
		if (base.elapsedTime >= delay.value)
		{
			if (sendGlobal)
			{
				Graph.SendGlobalEvent(eventName.value, eventValue.value, this);
			}
			else
			{
				base.agent.SendEvent(eventName.value, eventValue.value, this);
			}
			EndAction();
		}
	}
}
