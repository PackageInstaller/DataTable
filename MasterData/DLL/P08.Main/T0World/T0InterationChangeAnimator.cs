using System;

namespace T0World;

[Serializable]
public class T0InterationChangeAnimator : T0InterationFunctionDataBase
{
	public string animatorControllerPath;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		behaviour.GetComponent<T0ChangeAnimatorController>().ChangeAnimatorController(animatorControllerPath);
		base.IsFinish = true;
	}
}
