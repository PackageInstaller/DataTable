using System;
using UnityEngine;

[DisallowMultipleComponent]
public class QWNPCMoveComponent : MonoBehaviour
{
	public Action animatorMoveDelgate;

	private void OnAnimatorMove()
	{
		animatorMoveDelgate?.Invoke();
	}
}
