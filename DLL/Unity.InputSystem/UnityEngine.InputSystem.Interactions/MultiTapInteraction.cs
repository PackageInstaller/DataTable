using UnityEngine.InputSystem.Controls;

namespace UnityEngine.InputSystem.Interactions;

public class MultiTapInteraction : IInputInteraction<float>, IInputInteraction
{
	private enum TapPhase
	{
		None,
		WaitingForNextRelease,
		WaitingForNextPress
	}

	[Tooltip("The maximum time (in seconds) allowed to elapse between pressing and releasing a control for it to register as a tap.")]
	public float tapTime;

	[Tooltip("The maximum delay (in seconds) allowed between each tap. If this time is exceeded, the multi-tap is canceled.")]
	public float tapDelay;

	[Tooltip("How many taps need to be performed in succession. Two means double-tap, three means triple-tap, and so on.")]
	public int tapCount = 2;

	public float pressPoint;

	private TapPhase m_CurrentTapPhase;

	private int m_CurrentTapCount;

	private double m_CurrentTapStartTime;

	private double m_LastTapReleaseTime;

	private float tapTimeOrDefault
	{
		get
		{
			if (!((double)tapTime > 0.0))
			{
				return InputSystem.settings.defaultTapTime;
			}
			return tapTime;
		}
	}

	internal float tapDelayOrDefault
	{
		get
		{
			if (!((double)tapDelay > 0.0))
			{
				return InputSystem.settings.multiTapDelayTime;
			}
			return tapDelay;
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
			return;
		}
		switch (m_CurrentTapPhase)
		{
		case TapPhase.None:
			if (context.ControlIsActuated(pressPointOrDefault))
			{
				m_CurrentTapPhase = TapPhase.WaitingForNextRelease;
				m_CurrentTapStartTime = context.time;
				context.Started();
				float num = tapTimeOrDefault;
				float num2 = tapDelayOrDefault;
				context.SetTimeout(num);
				context.SetTotalTimeoutCompletionTime(num * (float)tapCount + (float)(tapCount - 1) * num2);
			}
			break;
		case TapPhase.WaitingForNextRelease:
			if (context.ControlIsActuated(releasePointOrDefault))
			{
				break;
			}
			if (context.time - m_CurrentTapStartTime <= (double)tapTimeOrDefault)
			{
				m_CurrentTapCount++;
				if (m_CurrentTapCount >= tapCount)
				{
					context.Performed();
					break;
				}
				m_CurrentTapPhase = TapPhase.WaitingForNextPress;
				m_LastTapReleaseTime = context.time;
				context.SetTimeout(tapDelayOrDefault);
			}
			else
			{
				context.Canceled();
			}
			break;
		case TapPhase.WaitingForNextPress:
			if (context.ControlIsActuated(pressPointOrDefault))
			{
				if (context.time - m_LastTapReleaseTime <= (double)tapDelayOrDefault)
				{
					m_CurrentTapPhase = TapPhase.WaitingForNextRelease;
					m_CurrentTapStartTime = context.time;
					context.SetTimeout(tapTimeOrDefault);
				}
				else
				{
					context.Canceled();
				}
			}
			break;
		}
	}

	public void Reset()
	{
		m_CurrentTapPhase = TapPhase.None;
		m_CurrentTapCount = 0;
		m_CurrentTapStartTime = 0.0;
		m_LastTapReleaseTime = 0.0;
	}
}
