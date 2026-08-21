using System;
using UnityEngine;

public class InputCheck : MonoBehaviour
{
	private Vector2 TouchFirst = Vector2.zero;

	private Vector2 TouchFinal = Vector2.zero;

	private Action<string> _action;

	[SerializeField]
	private static float slidingDistance = 100f;

	private void OnGUI()
	{
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Invalid comparison between Unknown and I4
		if ((int)Event.current.type == 0)
		{
			TouchFirst = Event.current.mousePosition;
		}
		if ((int)Event.current.type == 1)
		{
			TouchFinal = Event.current.mousePosition;
			Check();
		}
	}

	public void AddAction(Action<string> action)
	{
		_action = action;
	}

	private void Check()
	{
		float x = (TouchFinal - TouchFirst).x;
		if (x > 0f && Math.Abs(x) >= slidingDistance)
		{
			_action("Left");
		}
		if (x < 0f && Math.Abs(x) >= slidingDistance)
		{
			_action("Right");
		}
	}
}
