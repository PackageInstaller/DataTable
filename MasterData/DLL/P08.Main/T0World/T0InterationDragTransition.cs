using System;

namespace T0World;

[Serializable]
public class T0InterationDragTransition : T0InterationDragBase
{
	public string exitDragAnimName;

	public string beginDragAnimName;

	private string executeAnimName;

	private T0WorldInteractionBehavior runBehaviour;

	public override bool isNeedSDK => true;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		base.StartEvent(behaviour);
		executeAnimName = string.Empty;
		runBehaviour = behaviour;
		PlayDragAnim(exitDragAnimName);
	}

	private void PlayDragAnim(string animName)
	{
		if (runBehaviour != null && executeAnimName != animName)
		{
			runBehaviour.PlayTimeline(animName, out var _, out var _);
			executeAnimName = animName;
		}
	}

	public override void OnDragValueChange(float progress)
	{
		PlayDragAnim(beginDragAnimName);
		base.OnDragValueChange(progress);
	}

	public override void OnDragValueAddChange(float addProgress)
	{
		PlayDragAnim(beginDragAnimName);
		base.OnDragValueAddChange(addProgress);
	}

	public override void OnDragEnd()
	{
		PlayDragAnim(exitDragAnimName);
	}

	public override void SendSDK(T0WorldInteractionBehavior behaviour)
	{
		string select_param = "{" + exitDragAnimName + "," + beginDragAnimName + "}";
		T0SDKData t0SDKData = new T0SDKData();
		t0SDKData.select_param = select_param;
		T0SDKSystem.SendSDKData(behaviour, t0SDKData);
	}
}
