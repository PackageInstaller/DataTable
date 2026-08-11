using System.ComponentModel;
using UnityEngine.InputSystem.Controls;

namespace UnityEngine.InputSystem.Interactions;

[DisplayName("Tap")]
public class TapInteraction : IInputInteraction
{
	public float duration;

	public float pressPoint;

	private double m_TapStartTime;

	private float durationOrDefault
	{
		get
		{
			if (!((double)duration > 0.0))
			{
				return InputSystem.settings.defaultTapTime;
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

	private float releasePointOrDefault => pressPointOrDefault * ButtonControl.s_GlobalDefaultButtonReleaseThreshold;

	public void Process(ref InputInteractionContext context)
	{
		if (context.timerHasExpired)
		{
			context.Canceled();
		}
		else if (context.isWaiting && context.ControlIsActuated(pressPointOrDefault))
		{
			m_TapStartTime = context.time;
			context.Started();
			context.SetTimeout(durationOrDefault + 1E-05f);
		}
		else if (context.isStarted && !context.ControlIsActuated(releasePointOrDefault))
		{
			if (context.time - m_TapStartTime <= (double)durationOrDefault)
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
		m_TapStartTime = 0.0;
	}
}
