using UnityEngine;

public class TriggerInteractiveOperate : TriggerConditionBase
{
	public string operateIDN;

	[HideInInspector]
	public int uid;

	public override void DisableTrigger()
	{
		base.DisableTrigger();
		Singleton<InteractiveManager>.Instance.removeTiggerOpListener(this);
	}

	public override void ToActive()
	{
		base.ToActive();
		Singleton<InteractiveManager>.Instance.addopTiggerOpListener(this);
	}

	public override void OnTrigger()
	{
		if (CanTrigger())
		{
			base.OnTrigger();
		}
	}

	public void triggerOp(string opId)
	{
		if (operateIDN == opId)
		{
			OnTrigger();
		}
	}
}
