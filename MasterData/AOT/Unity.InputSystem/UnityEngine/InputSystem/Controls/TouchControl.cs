using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Controls;

[InputControlLayout(stateType = typeof(TouchState))]
public class TouchControl : InputControl<TouchState>
{
	public TouchPressControl press { get; set; }

	public IntegerControl displayIndex { get; set; }

	public IntegerControl touchId { get; set; }

	public Vector2Control position { get; set; }

	public DeltaControl delta { get; set; }

	public AxisControl pressure { get; set; }

	public Vector2Control radius { get; set; }

	public TouchPhaseControl phase { get; set; }

	public ButtonControl indirectTouch { get; set; }

	public ButtonControl tap { get; set; }

	public IntegerControl tapCount { get; set; }

	public DoubleControl startTime { get; set; }

	public Vector2Control startPosition { get; set; }

	public bool isInProgress
	{
		get
		{
			TouchPhase touchPhase = phase.value;
			if ((uint)(touchPhase - 1) <= 1u || touchPhase == TouchPhase.Stationary)
			{
				return true;
			}
			return false;
		}
	}

	public TouchControl()
	{
		m_StateBlock.format = new FourCC('T', 'O', 'U', 'C');
	}

	protected override void FinishSetup()
	{
		press = GetChildControl<TouchPressControl>("press");
		displayIndex = GetChildControl<IntegerControl>("displayIndex");
		touchId = GetChildControl<IntegerControl>("touchId");
		position = GetChildControl<Vector2Control>("position");
		delta = GetChildControl<DeltaControl>("delta");
		pressure = GetChildControl<AxisControl>("pressure");
		radius = GetChildControl<Vector2Control>("radius");
		phase = GetChildControl<TouchPhaseControl>("phase");
		indirectTouch = GetChildControl<ButtonControl>("indirectTouch");
		tap = GetChildControl<ButtonControl>("tap");
		tapCount = GetChildControl<IntegerControl>("tapCount");
		startTime = GetChildControl<DoubleControl>("startTime");
		startPosition = GetChildControl<Vector2Control>("startPosition");
		base.FinishSetup();
	}

	public unsafe override TouchState ReadUnprocessedValueFromState(void* statePtr)
	{
		TouchState* ptr = (TouchState*)((byte*)statePtr + (int)m_StateBlock.byteOffset);
		return *ptr;
	}

	public unsafe override void WriteValueIntoState(TouchState value, void* statePtr)
	{
		TouchState* destination = (TouchState*)((byte*)statePtr + (int)m_StateBlock.byteOffset);
		UnsafeUtility.MemCpy(destination, UnsafeUtility.AddressOf(ref value), UnsafeUtility.SizeOf<TouchState>());
	}
}
