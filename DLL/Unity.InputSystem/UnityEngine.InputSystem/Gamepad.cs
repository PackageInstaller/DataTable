using System.ComponentModel;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Haptics;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

[InputControlLayout(stateType = typeof(GamepadState), isGenericTypeOfDevice = true)]
public class Gamepad : InputDevice, IDualMotorRumble, IHaptics
{
	private DualMotorRumble m_Rumble;

	private static int s_GamepadCount;

	private static Gamepad[] s_Gamepads;

	public ButtonControl buttonWest { get; protected set; }

	public ButtonControl buttonNorth { get; protected set; }

	public ButtonControl buttonSouth { get; protected set; }

	public ButtonControl buttonEast { get; protected set; }

	public ButtonControl leftStickButton { get; protected set; }

	public ButtonControl rightStickButton { get; protected set; }

	public ButtonControl startButton { get; protected set; }

	public ButtonControl selectButton { get; protected set; }

	public DpadControl dpad { get; protected set; }

	public ButtonControl leftShoulder { get; protected set; }

	public ButtonControl rightShoulder { get; protected set; }

	public StickControl leftStick { get; protected set; }

	public StickControl rightStick { get; protected set; }

	public ButtonControl leftTrigger { get; protected set; }

	public ButtonControl rightTrigger { get; protected set; }

	public ButtonControl aButton => buttonSouth;

	public ButtonControl bButton => buttonEast;

	public ButtonControl xButton => buttonWest;

	public ButtonControl yButton => buttonNorth;

	public ButtonControl triangleButton => buttonNorth;

	public ButtonControl squareButton => buttonWest;

	public ButtonControl circleButton => buttonEast;

	public ButtonControl crossButton => buttonSouth;

	public ButtonControl this[GamepadButton button] => button switch
	{
		GamepadButton.North => buttonNorth, 
		GamepadButton.South => buttonSouth, 
		GamepadButton.East => buttonEast, 
		GamepadButton.West => buttonWest, 
		GamepadButton.Start => startButton, 
		GamepadButton.Select => selectButton, 
		GamepadButton.LeftShoulder => leftShoulder, 
		GamepadButton.RightShoulder => rightShoulder, 
		GamepadButton.LeftTrigger => leftTrigger, 
		GamepadButton.RightTrigger => rightTrigger, 
		GamepadButton.LeftStick => leftStickButton, 
		GamepadButton.RightStick => rightStickButton, 
		GamepadButton.DpadUp => dpad.up, 
		GamepadButton.DpadDown => dpad.down, 
		GamepadButton.DpadLeft => dpad.left, 
		GamepadButton.DpadRight => dpad.right, 
		_ => throw new InvalidEnumArgumentException("button", (int)button, typeof(GamepadButton)), 
	};

	public static Gamepad current { get; private set; }

	public new static ReadOnlyArray<Gamepad> all => new ReadOnlyArray<Gamepad>(s_Gamepads, 0, s_GamepadCount);

	protected override void FinishSetup()
	{
		buttonWest = GetChildControl<ButtonControl>("buttonWest");
		buttonNorth = GetChildControl<ButtonControl>("buttonNorth");
		buttonSouth = GetChildControl<ButtonControl>("buttonSouth");
		buttonEast = GetChildControl<ButtonControl>("buttonEast");
		startButton = GetChildControl<ButtonControl>("start");
		selectButton = GetChildControl<ButtonControl>("select");
		leftStickButton = GetChildControl<ButtonControl>("leftStickPress");
		rightStickButton = GetChildControl<ButtonControl>("rightStickPress");
		dpad = GetChildControl<DpadControl>("dpad");
		leftShoulder = GetChildControl<ButtonControl>("leftShoulder");
		rightShoulder = GetChildControl<ButtonControl>("rightShoulder");
		leftStick = GetChildControl<StickControl>("leftStick");
		rightStick = GetChildControl<StickControl>("rightStick");
		leftTrigger = GetChildControl<ButtonControl>("leftTrigger");
		rightTrigger = GetChildControl<ButtonControl>("rightTrigger");
		base.FinishSetup();
	}

	public override void MakeCurrent()
	{
		base.MakeCurrent();
		current = this;
	}

	protected override void OnAdded()
	{
		ArrayHelpers.AppendWithCapacity(ref s_Gamepads, ref s_GamepadCount, this);
	}

	protected override void OnRemoved()
	{
		if (current == this)
		{
			current = null;
		}
		int num = s_Gamepads.IndexOfReference(this, s_GamepadCount);
		if (num != -1)
		{
			s_Gamepads.EraseAtWithCapacity(ref s_GamepadCount, num);
		}
	}

	public virtual void PauseHaptics()
	{
		m_Rumble.PauseHaptics(this);
	}

	public virtual void ResumeHaptics()
	{
		m_Rumble.ResumeHaptics(this);
	}

	public virtual void ResetHaptics()
	{
		m_Rumble.ResetHaptics(this);
	}

	public virtual void SetMotorSpeeds(float lowFrequency, float highFrequency)
	{
		m_Rumble.SetMotorSpeeds(this, lowFrequency, highFrequency);
	}
}
