using System.ComponentModel;
using UnityEngine.InputSystem.Controls;

namespace UnityEngine.InputSystem.Interactions;

[DisplayName("Long Tap")]
public class SlowTapInteraction : IInputInteraction
{
	public float duration;

	public float pressPoint;

	private double m_SlowTapStartTime;

	private float durationOrDefault
	{
		get
		{
			if (!(duration > 0f))
			{
				return InputSystem.settings.defaultSlowTapTime;
			}
			return duration;
		}
	}

	private float pressPointOrDefault
	{
		get
		{
			if (!(pressPoint > 0f))
			{
				return ButtonControl.s_GlobalDefaultButtonPressPoint;
			}
			return pressPoint;
		}
	}

	public void Process(ref InputInteractionContext context)
	{
		if (context.isWaiting && context.ControlIsActuated(pressPointOrDefault))
		{
			m_SlowTapStartTime = context.time;
			context.Started();
		}
		else if (context.isStarted && !context.ControlIsActuated(pressPointOrDefault))
		{
			if (context.time - m_SlowTapStartTime >= (double)durationOrDefault)
			{
				context.Performed();
			}
			else
			{
				context.Canceled();
			}
		}
	}

	public void Reset()
	{
		m_SlowTapStartTime = 0.0;
	}
}
