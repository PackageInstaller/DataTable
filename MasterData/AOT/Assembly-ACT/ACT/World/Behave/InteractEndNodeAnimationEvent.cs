using ACT.World.StateObject;
using UnityEngine;

namespace ACT.World.Behave;

public class InteractEndNodeAnimationEvent : MonoBehaviour
{
	public InteractConnectNode interactConnectNode;

	public void OpeningFinishedEvent()
	{
		interactConnectNode.OnEndOpeningAnimationFinished();
	}
}
