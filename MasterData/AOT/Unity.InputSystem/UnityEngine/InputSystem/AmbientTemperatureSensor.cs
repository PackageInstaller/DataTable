using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem;

[InputControlLayout(displayName = "Ambient Temperature")]
public class AmbientTemperatureSensor : Sensor
{
	[InputControl(displayName = "Ambient Temperature", noisy = true)]
	public AxisControl ambientTemperature { get; protected set; }

	public static AmbientTemperatureSensor current { get; private set; }

	public override void MakeCurrent()
	{
		base.MakeCurrent();
		current = this;
	}

	protected override void OnRemoved()
	{
		base.OnRemoved();
		if (current == this)
		{
			current = null;
		}
	}

	protected override void FinishSetup()
	{
		ambientTemperature = GetChildControl<AxisControl>("ambientTemperature");
		base.FinishSetup();
	}
}
