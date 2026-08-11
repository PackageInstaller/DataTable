using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;

namespace UnityEngine.InputSystem;

[InputControlLayout(stateType = typeof(PointerState), isGenericTypeOfDevice = true)]
public class Pointer : InputDevice, IInputStateCallbackReceiver
{
	public Vector2Control position { get; protected set; }

	public DeltaControl delta { get; protected set; }

	public Vector2Control radius { get; protected set; }

	public AxisControl pressure { get; protected set; }

	public ButtonControl press { get; protected set; }

	public IntegerControl displayIndex { get; protected set; }

	public static Pointer current { get; internal set; }

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
		position = GetChildControl<Vector2Control>("position");
		delta = GetChildControl<DeltaControl>("delta");
		radius = GetChildControl<Vector2Control>("radius");
		pressure = GetChildControl<AxisControl>("pressure");
		press = GetChildControl<ButtonControl>("press");
		displayIndex = GetChildControl<IntegerControl>("displayIndex");
		base.FinishSetup();
	}

	protected void OnNextUpdate()
	{
		InputState.Change(delta, Vector2.zero);
	}

	protected unsafe void OnStateEvent(InputEventPtr eventPtr)
	{
		delta.AccumulateValueInEvent(base.currentStatePtr, eventPtr);
		InputState.Change(this, eventPtr);
	}

	void IInputStateCallbackReceiver.OnNextUpdate()
	{
		OnNextUpdate();
	}

	void IInputStateCallbackReceiver.OnStateEvent(InputEventPtr eventPtr)
	{
		OnStateEvent(eventPtr);
	}

	bool IInputStateCallbackReceiver.GetStateOffsetForEvent(InputControl control, InputEventPtr eventPtr, ref uint offset)
	{
		return false;
	}
}
