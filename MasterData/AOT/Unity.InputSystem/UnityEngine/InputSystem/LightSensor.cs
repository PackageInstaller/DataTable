using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;

namespace UnityEngine.InputSystem;

[InputControlLayout(displayName = "Light")]
public class LightSensor : Sensor
{
	[InputControl(displayName = "Light Level", noisy = true)]
	public AxisControl lightLevel { get; protected set; }

	public static LightSensor current { get; private set; }

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
		lightLevel = GetChildControl<AxisControl>("lightLevel");
		base.FinishSetup();
	}
}
