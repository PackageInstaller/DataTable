using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;

namespace UnityEngine.InputSystem;

[InputControlLayout(stateType = typeof(MouseState), isGenericTypeOfDevice = true)]
public class Mouse : Pointer, IInputStateCallbackReceiver
{
	internal static Mouse s_PlatformMouseDevice;

	public DeltaControl scroll { get; protected set; }

	public ButtonControl leftButton { get; protected set; }

	public ButtonControl middleButton { get; protected set; }

	public ButtonControl rightButton { get; protected set; }

	public ButtonControl backButton { get; protected set; }

	public ButtonControl forwardButton { get; protected set; }

	public IntegerControl clickCount { get; protected set; }

	public new static Mouse current { get; private set; }

	public override void MakeCurrent()
	{
		base.MakeCurrent();
		current = this;
	}

	protected override void OnAdded()
	{
		base.OnAdded();
		if (base.native && s_PlatformMouseDevice == null)
		{
			s_PlatformMouseDevice = this;
		}
	}

	protected override void OnRemoved()
	{
		base.OnRemoved();
		if (current == this)
		{
			current = null;
		}
	}

	public void WarpCursorPosition(Vector2 position)
	{
		WarpMousePositionCommand command = WarpMousePositionCommand.Create(position);
		ExecuteCommand(ref command);
	}

	protected override void FinishSetup()
	{
		scroll = GetChildControl<DeltaControl>("scroll");
		leftButton = GetChildControl<ButtonControl>("leftButton");
		middleButton = GetChildControl<ButtonControl>("middleButton");
		rightButton = GetChildControl<ButtonControl>("rightButton");
		forwardButton = GetChildControl<ButtonControl>("forwardButton");
		backButton = GetChildControl<ButtonControl>("backButton");
		base.displayIndex = GetChildControl<IntegerControl>("displayIndex");
		clickCount = GetChildControl<IntegerControl>("clickCount");
		base.FinishSetup();
	}

	protected new void OnNextUpdate()
	{
		base.OnNextUpdate();
		InputState.Change(scroll, Vector2.zero);
	}

	protected new unsafe void OnStateEvent(InputEventPtr eventPtr)
	{
		scroll.AccumulateValueInEvent(base.currentStatePtr, eventPtr);
		base.OnStateEvent(eventPtr);
	}

	void IInputStateCallbackReceiver.OnNextUpdate()
	{
		OnNextUpdate();
	}

	void IInputStateCallbackReceiver.OnStateEvent(InputEventPtr eventPtr)
	{
		OnStateEvent(eventPtr);
	}
}
