using ACT.Battle;
using UnityEngine;

namespace ACT.DebugGUI;

public class TimeScaleMonitor : SingleMonitor
{
	private DebugGUISlider systemTimeSlider;

	private DebugGUISlider timeSlider;

	private DebugGUIButton resetButton;

	protected override bool OnInit()
	{
		systemTimeSlider = new DebugGUISlider("System Time Scale:", 1f, 0.0001f, 2f);
		timeSlider = new DebugGUISlider("Time Scale:", 1f, 0.0001f, 2f);
		resetButton = new DebugGUIButton("重置所有TimeScale为1", () =>
		{
			systemTimeSlider.value = 1f;
			GameManager.timeSystem.DebugChangeSpeed(systemTimeSlider.value);
			timeSlider.value = 1f;
			Time.timeScale = timeSlider.value;
		});
		sigwnd.AddGUI(resetButton);
		sigwnd.AddGUI(systemTimeSlider);
		sigwnd.AddGUI(timeSlider);
		return true;
	}

	public override void OnUpdate()
	{
		SystemTime timeSystem = GameManager.timeSystem;
		if (!Mathf.Approximately(GameManager.timeSystem.debugSpeed, systemTimeSlider.value))
		{
			timeSystem.DebugChangeSpeed(systemTimeSlider.value);
		}
		if (!Mathf.Approximately(Time.timeScale, timeSlider.value))
		{
			Time.timeScale = timeSlider.value;
		}
	}
}
