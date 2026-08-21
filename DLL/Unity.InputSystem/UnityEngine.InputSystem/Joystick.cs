using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

[InputControlLayout(stateType = typeof(JoystickState), isGenericTypeOfDevice = true)]
public class Joystick : InputDevice
{
	private static int s_JoystickCount;

	private static Joystick[] s_Joysticks;

	public ButtonControl trigger { get; protected set; }

	public StickControl stick { get; protected set; }

	public AxisControl twist { get; protected set; }

	public Vector2Control hatswitch { get; protected set; }

	public static Joystick current { get; private set; }

	public new static ReadOnlyArray<Joystick> all => new ReadOnlyArray<Joystick>(s_Joysticks, 0, s_JoystickCount);

	protected override void FinishSetup()
	{
		trigger = GetChildControl<ButtonControl>("{PrimaryTrigger}");
		stick = GetChildControl<StickControl>("{Primary2DMotion}");
		twist = TryGetChildControl<AxisControl>("{Twist}");
		hatswitch = TryGetChildControl<Vector2Control>("{Hatswitch}");
		base.FinishSetup();
	}

	public override void MakeCurrent()
	{
		base.MakeCurrent();
		current = this;
	}

	protected override void OnAdded()
	{
		ArrayHelpers.AppendWithCapacity(ref s_Joysticks, ref s_JoystickCount, this);
	}

	protected override void OnRemoved()
	{
		base.OnRemoved();
		if (current == this)
		{
			current = null;
		}
		int num = s_Joysticks.IndexOfReference(this, s_JoystickCount);
		if (num != -1)
		{
			s_Joysticks.EraseAtWithCapacity(ref s_JoystickCount, num);
		}
	}
}
