using UnityEngine;

namespace Runtime.Battle.BreakChallenge;

public class BreakPointAnimatorEvent : MonoBehaviour
{
	private BreakPoint _runtimeBreakPoint;

	private void Awake()
	{
		_runtimeBreakPoint = GetComponentInParent<BreakPoint>();
	}

	public void AnimatorBreakEvent()
	{
		_runtimeBreakPoint.OnBreakByEvent();
	}
}
