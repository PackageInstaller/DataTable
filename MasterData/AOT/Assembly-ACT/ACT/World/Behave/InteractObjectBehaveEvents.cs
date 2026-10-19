using ACT.World.StateObject;
using UnityEngine;

namespace ACT.World.Behave;

[AddComponentMenu("ACT/StateObjectBehave/InteractObjectBehaveEvents")]
public class InteractObjectBehaveEvents : MonoBehaviour
{
	[Tooltip("调用CompleteTransition的对象")]
	public StateObjectBase interactObject;

	public void CompleteTransition(int targetStateId)
	{
		interactObject.CompleteTransition(targetStateId);
	}

	public void CompleteTransitionClear()
	{
		interactObject.CompleteTransitionClear();
	}
}
