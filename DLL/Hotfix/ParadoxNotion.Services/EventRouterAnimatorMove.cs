using UnityEngine;

namespace ParadoxNotion.Services;

public class EventRouterAnimatorMove : MonoBehaviour
{
	public event EventRouter.EventDelegate onAnimatorMove;

	private void OnAnimatorMove()
	{
		if (onAnimatorMove != null)
		{
			onAnimatorMove(new EventData(base.gameObject, this));
		}
	}
}
