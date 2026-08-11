using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Text;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

public static class InputControlExtensions
{
	[Flags]
	public enum Enumerate
	{
		IgnoreControlsInDefaultState = 1,
		IgnoreControlsInCurrentState = 2,
		IncludeSyntheticControls = 4,
		IncludeNoisyControls = 8,
		IncludeNonLeafControls = 0x10
	}

	public struct InputEventControlCollection : IEnumerable<InputControl>, IEnumerable
	{
		internal InputDevice m_Device;

		internal InputEventPtr m_EventPtr;

		internal Enumerate m_Flags;

		internal float m_MagnitudeThreshold;

		public InputEventPtr eventPtr => m_EventPtr;

		public InputEventControlEnumerator GetEnumerator()
		{
			return new InputEventControlEnumerator(m_EventPtr, m_Device, m_Flags, m_MagnitudeThreshold);
		}

		IEnumerator<InputControl> IEnumerable<InputControl>.GetEnumerator()
		{
			return GetEnumerator();
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return GetEnumerator();
		}
	}

	public struct InputEventControlEnumerator : IEnumerator<InputControl>, IEnumerator, IDisposable
	{
		private Enumerate m_Flags;

		private readonly InputDevice m_Device;

		private readonly uint[] m_StateOffsetToControlIndex;

		private readonly int m_StateOffsetToControlIndexLength;

		private readonly InputControl[] m_AllControls;

		private unsafe byte* m_DefaultState;

		private unsafe byte* m_CurrentState;

		private unsafe byte* m_NoiseMask;

		private InputEventPtr m_EventPtr;

		private InputControl m_CurrentControl;

		private int m_CurrentIndexInStateOffsetToControlIndexMap;

		private uint m_CurrentControlStateBitOffset;

		private unsafe byte* m_EventState;

		private uint m_CurrentBitOffset;

		private uint m_EndBitOffset;

		private float m_MagnitudeThreshold;

		public InputControl Current => m_CurrentControl;

		object IEnumerator.Current => Current;

		internal unsafe InputEventControlEnumerator(InputEventPtr eventPtr, InputDevice device, Enumerate flags, float magnitudeThreshold = 0f)
		{
			m_Device = device;
			m_StateOffsetToControlIndex = device.m_StateOffsetToControlMap;
			m_StateOffsetToControlIndexLength = m_StateOffsetToControlIndex.LengthSafe();
			m_AllControls = device.m_ChildrenForEachControl;
			m_EventPtr = eventPtr;
			m_Flags = flags;
			m_CurrentControl = null;
			m_CurrentIndexInStateOffsetToControlIndexMap = 0;
			m_CurrentControlStateBitOffset = 0u;
			m_EventState = default(byte*);
			m_CurrentBitOffset = 0u;
			m_EndBitOffset = 0u;
			m_MagnitudeThreshold = magnitudeThreshold;
			if ((flags & Enumerate.IncludeNoisyControls) == 0)
			{
				m_NoiseMask = (byte*)device.noiseMaskPtr + device.m_StateBlock.byteOffset;
			}
			else
			{
				m_NoiseMask = default(byte*);
			}
			if ((flags & Enumerate.IgnoreControlsInDefaultState) != 0)
			{
				m_DefaultState = (byte*)device.defaultStatePtr + device.m_StateBlock.byteOffset;
			}
			else
			{
				m_DefaultState = default(byte*);
			}
			if ((flags & Enumerate.IgnoreControlsInCurrentState) != 0)
			{
				m_CurrentState = (byte*)device.currentStatePtr + device.m_StateBlock.byteOffset;
			}
			else
			{
				m_CurrentState = default(byte*);
			}
			Reset();
		}

		private unsafe bool CheckDefault(uint numBits)
		{
			return MemoryHelpers.MemCmpBitRegion(m_EventState, m_DefaultState, m_CurrentBitOffset, numBits, m_NoiseMask);
		}

		private unsafe bool CheckCurrent(uint numBits)
		{
			return MemoryHelpers.MemCmpBitRegion(m_EventState, m_CurrentState, m_CurrentBitOffset, numBits, m_NoiseMask);
		}

		public unsafe bool MoveNext()
		{
			if (!m_EventPtr.valid)
			{
				throw new ObjectDisposedException("Enumerator has already been disposed");
			}
			if (m_CurrentControl != null && (m_Flags & Enumerate.IncludeNonLeafControls) != 0)
			{
				InputControl parent = m_CurrentControl.parent;
				if (parent != m_Device)
				{
					m_CurrentControl = parent;
					return true;
				}
			}
			bool flag = m_DefaultState != null;
			bool flag2 = m_CurrentState != null;
			while (true)
			{
				m_CurrentControl = null;
				if (flag2 | flag)
				{
					if ((m_CurrentBitOffset & 7) != 0)
					{
						uint num = (m_CurrentBitOffset + 8) & 7;
						if ((flag2 && CheckCurrent(num)) || (flag && CheckDefault(num)))
						{
							m_CurrentBitOffset += num;
						}
					}
					while (m_CurrentBitOffset < m_EndBitOffset)
					{
						uint num2 = m_CurrentBitOffset >> 3;
						byte b = m_EventState[num2];
						int num3 = ((m_NoiseMask != null) ? m_NoiseMask[num2] : byte.MaxValue);
						if (flag2 && (m_CurrentState[num2] & num3) == (b & num3))
						{
							m_CurrentBitOffset += 8u;
							continue;
						}
						if (!flag || (m_DefaultState[num2] & num3) != (b & num3))
						{
							break;
						}
						m_CurrentBitOffset += 8u;
					}
				}
				if (m_CurrentBitOffset >= m_EndBitOffset || m_CurrentIndexInStateOffsetToControlIndexMap >= m_StateOffsetToControlIndexLength)
				{
					return false;
				}
				for (; m_CurrentIndexInStateOffsetToControlIndexMap < m_StateOffsetToControlIndexLength; m_CurrentIndexInStateOffsetToControlIndexMap++)
				{
					InputDevice.DecodeStateOffsetToControlMapEntry(m_StateOffsetToControlIndex[m_CurrentIndexInStateOffsetToControlIndexMap], out var controlIndex, out var stateOffset, out var stateSize);
					if (stateOffset < m_CurrentControlStateBitOffset || m_CurrentBitOffset >= stateOffset + stateSize - m_CurrentControlStateBitOffset)
					{
						continue;
					}
					if (stateOffset - m_CurrentControlStateBitOffset >= m_CurrentBitOffset + 8)
					{
						m_CurrentBitOffset = stateOffset - m_CurrentControlStateBitOffset;
						break;
					}
					if (stateOffset + stateSize - m_CurrentControlStateBitOffset > m_EndBitOffset)
					{
						continue;
					}
					if ((stateOffset & 7) == 0 && (stateSize & 7) == 0)
					{
						m_CurrentControl = m_AllControls[controlIndex];
					}
					else
					{
						if ((flag2 && MemoryHelpers.MemCmpBitRegion(m_EventState, m_CurrentState, stateOffset - m_CurrentControlStateBitOffset, stateSize, m_NoiseMask)) || (flag && MemoryHelpers.MemCmpBitRegion(m_EventState, m_DefaultState, stateOffset - m_CurrentControlStateBitOffset, stateSize, m_NoiseMask)))
						{
							continue;
						}
						m_CurrentControl = m_AllControls[controlIndex];
					}
					if ((m_Flags & Enumerate.IncludeNoisyControls) == 0 && m_CurrentControl.noisy)
					{
						m_CurrentControl = null;
						continue;
					}
					if ((m_Flags & Enumerate.IncludeSyntheticControls) == 0 && (m_CurrentControl.m_ControlFlags & (InputControl.ControlFlags.IsSynthetic | InputControl.ControlFlags.UsesStateFromOtherControl)) != 0)
					{
						m_CurrentControl = null;
						continue;
					}
					m_CurrentIndexInStateOffsetToControlIndexMap++;
					break;
				}
				if (m_CurrentControl != null)
				{
					if (m_MagnitudeThreshold == 0f)
					{
						break;
					}
					byte* statePtr = m_EventState - (m_CurrentControlStateBitOffset >> 3) - m_Device.m_StateBlock.byteOffset;
					float num4 = m_CurrentControl.EvaluateMagnitude(statePtr);
					if (!(num4 >= 0f) || !(num4 < m_MagnitudeThreshold))
					{
						break;
					}
				}
			}
			return true;
		}

		public unsafe void Reset()
		{
			if (!m_EventPtr.valid)
			{
				throw new ObjectDisposedException("Enumerator has already been disposed");
			}
			FourCC type = m_EventPtr.type;
			FourCC stateFormat;
			if (type == 1398030676)
			{
				StateEvent* ptr = StateEvent.FromUnchecked(m_EventPtr);
				m_EventState = (byte*)ptr->state;
				m_EndBitOffset = ptr->stateSizeInBytes * 8;
				m_CurrentBitOffset = 0u;
				stateFormat = ptr->stateFormat;
			}
			else
			{
				if (!(type == 1145852993))
				{
					throw new NotSupportedException($"Cannot iterate over controls in event of type '{type}'");
				}
				DeltaStateEvent* ptr2 = DeltaStateEvent.FromUnchecked(m_EventPtr);
				m_EventState = (byte*)ptr2->deltaState - ptr2->stateOffset;
				m_CurrentBitOffset = ptr2->stateOffset * 8;
				m_EndBitOffset = m_CurrentBitOffset + ptr2->deltaStateSizeInBytes * 8;
				stateFormat = ptr2->stateFormat;
			}
			m_CurrentIndexInStateOffsetToControlIndexMap = 0;
			m_CurrentControlStateBitOffset = 0u;
			m_CurrentControl = null;
			if (!(stateFormat != m_Device.m_StateBlock.format))
			{
				return;
			}
			uint offset = 0u;
			if (m_Device.hasStateCallbacks && ((IInputStateCallbackReceiver)m_Device).GetStateOffsetForEvent(null, m_EventPtr, ref offset))
			{
				m_CurrentControlStateBitOffset = offset * 8;
				if (m_CurrentState != null)
				{
					m_CurrentState += offset;
				}
				if (m_DefaultState != null)
				{
					m_DefaultState += offset;
				}
				if (m_NoiseMask != null)
				{
					m_NoiseMask += offset;
				}
			}
			else if (!(m_Device is Touchscreen) || !m_EventPtr.IsA<StateEvent>() || !(StateEvent.FromUnchecked(m_EventPtr)->stateFormat == TouchState.Format))
			{
				throw new InvalidOperationException($"{type} event with state format {stateFormat} cannot be used with device '{m_Device}'");
			}
		}

		public void Dispose()
		{
			m_EventPtr = default(InputEventPtr);
		}
	}

	public struct ControlBuilder
	{
		public InputControl control { get; internal set; }

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder At(InputDevice device, int index)
		{
			device.m_ChildrenForEachControl[index] = control;
			control.m_Device = device;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder WithParent(InputControl parent)
		{
			control.m_Parent = parent;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder WithName(string name)
		{
			control.m_Name = new InternedString(name);
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder WithDisplayName(string displayName)
		{
			control.m_DisplayNameFromLayout = new InternedString(displayName);
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder WithShortDisplayName(string shortDisplayName)
		{
			control.m_ShortDisplayNameFromLayout = new InternedString(shortDisplayName);
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder WithLayout(InternedString layout)
		{
			control.m_Layout = layout;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder WithUsages(int startIndex, int count)
		{
			control.m_UsageStartIndex = startIndex;
			control.m_UsageCount = count;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder WithAliases(int startIndex, int count)
		{
			control.m_AliasStartIndex = startIndex;
			control.m_AliasCount = count;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder WithChildren(int startIndex, int count)
		{
			control.m_ChildStartIndex = startIndex;
			control.m_ChildCount = count;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder WithStateBlock(InputStateBlock stateBlock)
		{
			control.m_StateBlock = stateBlock;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder WithDefaultState(PrimitiveValue value)
		{
			control.m_DefaultState = value;
			control.m_Device.hasControlsWithDefaultState = true;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder WithMinAndMax(PrimitiveValue min, PrimitiveValue max)
		{
			control.m_MinValue = min;
			control.m_MaxValue = max;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder WithProcessor<TProcessor, TValue>(TProcessor processor) where TProcessor : InputProcessor<TValue> where TValue : struct
		{
			((InputControl<TValue>)control).m_ProcessorStack.Append(processor);
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder IsNoisy(bool value)
		{
			control.noisy = value;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder IsSynthetic(bool value)
		{
			control.synthetic = value;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder DontReset(bool value)
		{
			control.dontReset = value;
			if (value)
			{
				control.m_Device.hasDontResetControls = true;
			}
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public ControlBuilder IsButton(bool value)
		{
			control.isButton = value;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public void Finish()
		{
			control.isSetupFinished = true;
		}
	}

	public struct DeviceBuilder
	{
		public InputDevice device { get; internal set; }

		[MethodImpl((MethodImplOptions)256)]
		public DeviceBuilder WithName(string name)
		{
			device.m_Name = new InternedString(name);
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public DeviceBuilder WithDisplayName(string displayName)
		{
			device.m_DisplayNameFromLayout = new InternedString(displayName);
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public DeviceBuilder WithShortDisplayName(string shortDisplayName)
		{
			device.m_ShortDisplayNameFromLayout = new InternedString(shortDisplayName);
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public DeviceBuilder WithLayout(InternedString layout)
		{
			device.m_Layout = layout;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public DeviceBuilder WithChildren(int startIndex, int count)
		{
			device.m_ChildStartIndex = startIndex;
			device.m_ChildCount = count;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public DeviceBuilder WithStateBlock(InputStateBlock stateBlock)
		{
			device.m_StateBlock = stateBlock;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public DeviceBuilder IsNoisy(bool value)
		{
			device.noisy = value;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public DeviceBuilder WithControlUsage(int controlIndex, InternedString usage, InputControl control)
		{
			device.m_UsagesForEachControl[controlIndex] = usage;
			device.m_UsageToControl[controlIndex] = control;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public DeviceBuilder WithControlAlias(int controlIndex, InternedString alias)
		{
			device.m_AliasesForEachControl[controlIndex] = alias;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public DeviceBuilder WithStateOffsetToControlIndexMap(uint[] map)
		{
			device.m_StateOffsetToControlMap = map;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public unsafe DeviceBuilder WithControlTree(byte[] controlTreeNodes, ushort[] controlTreeIndicies)
		{
			int num = UnsafeUtility.SizeOf<InputDevice.ControlBitRangeNode>();
			int num2 = controlTreeNodes.Length / num;
			device.m_ControlTreeNodes = new InputDevice.ControlBitRangeNode[num2];
			fixed (byte* ptr = controlTreeNodes)
			{
				for (int i = 0; i < num2; i++)
				{
					device.m_ControlTreeNodes[i] = *(InputDevice.ControlBitRangeNode*)(ptr + i * num);
				}
			}
			device.m_ControlTreeIndices = controlTreeIndicies;
			return this;
		}

		[MethodImpl((MethodImplOptions)256)]
		public void Finish()
		{
			device.isSetupFinished = true;
		}
	}

	public static TControl FindInParentChain<TControl>(this InputControl control) where TControl : InputControl
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		for (InputControl inputControl = control; inputControl != null; inputControl = inputControl.parent)
		{
			if (inputControl is TControl result)
			{
				return result;
			}
		}
		return null;
	}

	public static bool IsPressed(this InputControl control, float buttonPressPoint = 0f)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (Mathf.Approximately(0f, buttonPressPoint))
		{
			buttonPressPoint = ((!(control is ButtonControl buttonControl)) ? ButtonControl.s_GlobalDefaultButtonPressPoint : buttonControl.pressPointOrDefault);
		}
		return control.IsActuated(buttonPressPoint);
	}

	public static bool IsActuated(this InputControl control, float threshold = 0f)
	{
		if (control.CheckStateIsAtDefault())
		{
			return false;
		}
		float magnitude = control.magnitude;
		if (magnitude < 0f)
		{
			if (Mathf.Approximately(threshold, 0f))
			{
				return true;
			}
			return false;
		}
		if (Mathf.Approximately(threshold, 0f))
		{
			return magnitude > 0f;
		}
		return magnitude >= threshold;
	}

	public unsafe static object ReadValueAsObject(this InputControl control)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		return control.ReadValueFromStateAsObject(control.currentStatePtr);
	}

	public unsafe static void ReadValueIntoBuffer(this InputControl control, void* buffer, int bufferSize)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		control.ReadValueFromStateIntoBuffer(control.currentStatePtr, buffer, bufferSize);
	}

	public unsafe static object ReadDefaultValueAsObject(this InputControl control)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		return control.ReadValueFromStateAsObject(control.defaultStatePtr);
	}

	public static TValue ReadValueFromEvent<TValue>(this InputControl<TValue> control, InputEventPtr inputEvent) where TValue : struct
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (!control.ReadValueFromEvent(inputEvent, out var value))
		{
			return default(TValue);
		}
		return value;
	}

	public unsafe static bool ReadValueFromEvent<TValue>(this InputControl<TValue> control, InputEventPtr inputEvent, out TValue value) where TValue : struct
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		void* statePtrFromStateEvent = control.GetStatePtrFromStateEvent(inputEvent);
		if (statePtrFromStateEvent == null)
		{
			value = control.ReadDefaultValue();
			return false;
		}
		value = control.ReadValueFromState(statePtrFromStateEvent);
		return true;
	}

	public unsafe static object ReadValueFromEventAsObject(this InputControl control, InputEventPtr inputEvent)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		void* statePtrFromStateEvent = control.GetStatePtrFromStateEvent(inputEvent);
		if (statePtrFromStateEvent == null)
		{
			return control.ReadDefaultValueAsObject();
		}
		return control.ReadValueFromStateAsObject(statePtrFromStateEvent);
	}

	public static TValue ReadUnprocessedValueFromEvent<TValue>(this InputControl<TValue> control, InputEventPtr eventPtr) where TValue : struct
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		TValue value = default(TValue);
		control.ReadUnprocessedValueFromEvent(eventPtr, out value);
		return value;
	}

	public unsafe static bool ReadUnprocessedValueFromEvent<TValue>(this InputControl<TValue> control, InputEventPtr inputEvent, out TValue value) where TValue : struct
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		void* statePtrFromStateEvent = control.GetStatePtrFromStateEvent(inputEvent);
		if (statePtrFromStateEvent == null)
		{
			value = control.ReadDefaultValue();
			return false;
		}
		value = control.ReadUnprocessedValueFromState(statePtrFromStateEvent);
		return true;
	}

	public unsafe static void WriteValueFromObjectIntoEvent(this InputControl control, InputEventPtr eventPtr, object value)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		void* statePtrFromStateEvent = control.GetStatePtrFromStateEvent(eventPtr);
		if (statePtrFromStateEvent != null)
		{
			control.WriteValueFromObjectIntoState(value, statePtrFromStateEvent);
		}
	}

	public unsafe static void WriteValueIntoState(this InputControl control, void* statePtr)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (statePtr == null)
		{
			throw new ArgumentNullException("statePtr");
		}
		int valueSizeInBytes = control.valueSizeInBytes;
		void* ptr = UnsafeUtility.Malloc(valueSizeInBytes, 8, Allocator.Temp);
		try
		{
			control.ReadValueFromStateIntoBuffer(control.currentStatePtr, ptr, valueSizeInBytes);
			control.WriteValueFromBufferIntoState(ptr, valueSizeInBytes, statePtr);
		}
		finally
		{
			UnsafeUtility.Free(ptr, Allocator.Temp);
		}
	}

	public unsafe static void WriteValueIntoState<TValue>(this InputControl control, TValue value, void* statePtr) where TValue : struct
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (!(control is InputControl<TValue> inputControl))
		{
			throw new ArgumentException("Expecting control of type '" + typeof(TValue).Name + "' but got '" + control.GetType().Name + "'");
		}
		inputControl.WriteValueIntoState(value, statePtr);
	}

	public unsafe static void WriteValueIntoState<TValue>(this InputControl<TValue> control, TValue value, void* statePtr) where TValue : struct
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (statePtr == null)
		{
			throw new ArgumentNullException("statePtr");
		}
		void* bufferPtr = UnsafeUtility.AddressOf(ref value);
		int bufferSize = UnsafeUtility.SizeOf<TValue>();
		control.WriteValueFromBufferIntoState(bufferPtr, bufferSize, statePtr);
	}

	public unsafe static void WriteValueIntoState<TValue>(this InputControl<TValue> control, void* statePtr) where TValue : struct
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		control.WriteValueIntoState(control.ReadValue(), statePtr);
	}

	public unsafe static void WriteValueIntoState<TValue, TState>(this InputControl<TValue> control, TValue value, ref TState state) where TValue : struct where TState : struct, IInputStateTypeInfo
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		int num = UnsafeUtility.SizeOf<TState>();
		if (control.stateOffsetRelativeToDeviceRoot + control.m_StateBlock.alignedSizeInBytes >= num)
		{
			throw new ArgumentException($"Control {control.path} with offset {control.stateOffsetRelativeToDeviceRoot} and size of {control.m_StateBlock.sizeInBits} bits is out of bounds for state of type {typeof(TState).Name} with size {num}", "state");
		}
		byte* statePtr = (byte*)UnsafeUtility.AddressOf(ref state);
		control.WriteValueIntoState(value, statePtr);
	}

	public static void WriteValueIntoEvent<TValue>(this InputControl control, TValue value, InputEventPtr eventPtr) where TValue : struct
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (!eventPtr.valid)
		{
			throw new ArgumentNullException("eventPtr");
		}
		if (!(control is InputControl<TValue> control2))
		{
			throw new ArgumentException("Expecting control of type '" + typeof(TValue).Name + "' but got '" + control.GetType().Name + "'");
		}
		control2.WriteValueIntoEvent(value, eventPtr);
	}

	public unsafe static void WriteValueIntoEvent<TValue>(this InputControl<TValue> control, TValue value, InputEventPtr eventPtr) where TValue : struct
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (!eventPtr.valid)
		{
			throw new ArgumentNullException("eventPtr");
		}
		void* statePtrFromStateEvent = control.GetStatePtrFromStateEvent(eventPtr);
		if (statePtrFromStateEvent != null)
		{
			control.WriteValueIntoState(value, statePtrFromStateEvent);
		}
	}

	public unsafe static void CopyState(this InputDevice device, void* buffer, int bufferSizeInBytes)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		if (bufferSizeInBytes <= 0)
		{
			throw new ArgumentException("bufferSizeInBytes must be positive", "bufferSizeInBytes");
		}
		InputStateBlock stateBlock = device.m_StateBlock;
		long size = Math.Min(bufferSizeInBytes, stateBlock.alignedSizeInBytes);
		UnsafeUtility.MemCpy(buffer, (byte*)device.currentStatePtr + stateBlock.byteOffset, size);
	}

	public unsafe static void CopyState<TState>(this InputDevice device, out TState state) where TState : struct, IInputStateTypeInfo
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		state = default(TState);
		if (device.stateBlock.format != state.format)
		{
			throw new ArgumentException($"Struct '{typeof(TState).Name}' has state format '{state.format}' which doesn't match device '{device}' with state format '{device.stateBlock.format}'", "TState");
		}
		int bufferSizeInBytes = UnsafeUtility.SizeOf<TState>();
		void* buffer = UnsafeUtility.AddressOf(ref state);
		device.CopyState(buffer, bufferSizeInBytes);
	}

	public unsafe static bool CheckStateIsAtDefault(this InputControl control)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		return control.CheckStateIsAtDefault(control.currentStatePtr, null);
	}

	public unsafe static bool CheckStateIsAtDefault(this InputControl control, void* statePtr, void* maskPtr = null)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (statePtr == null)
		{
			throw new ArgumentNullException("statePtr");
		}
		return control.CompareState(statePtr, control.defaultStatePtr, maskPtr);
	}

	public unsafe static bool CheckStateIsAtDefaultIgnoringNoise(this InputControl control)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		return control.CheckStateIsAtDefaultIgnoringNoise(control.currentStatePtr);
	}

	public unsafe static bool CheckStateIsAtDefaultIgnoringNoise(this InputControl control, void* statePtr)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (statePtr == null)
		{
			throw new ArgumentNullException("statePtr");
		}
		return control.CheckStateIsAtDefault(statePtr, InputStateBuffers.s_NoiseMaskBuffer);
	}

	public unsafe static bool CompareStateIgnoringNoise(this InputControl control, void* statePtr)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (statePtr == null)
		{
			throw new ArgumentNullException("statePtr");
		}
		return control.CompareState(control.currentStatePtr, statePtr, control.noiseMaskPtr);
	}

	public unsafe static bool CompareState(this InputControl control, void* firstStatePtr, void* secondStatePtr, void* maskPtr = null)
	{
		byte* ptr = (byte*)firstStatePtr + (int)control.m_StateBlock.byteOffset;
		byte* ptr2 = (byte*)secondStatePtr + (int)control.m_StateBlock.byteOffset;
		byte* ptr3 = ((maskPtr != null) ? ((byte*)maskPtr + (int)control.m_StateBlock.byteOffset) : null);
		if (control.m_StateBlock.sizeInBits == 1)
		{
			if (ptr3 != null && MemoryHelpers.ReadSingleBit(ptr3, control.m_StateBlock.bitOffset))
			{
				return true;
			}
			return MemoryHelpers.ReadSingleBit(ptr2, control.m_StateBlock.bitOffset) == MemoryHelpers.ReadSingleBit(ptr, control.m_StateBlock.bitOffset);
		}
		return MemoryHelpers.MemCmpBitRegion(ptr, ptr2, control.m_StateBlock.bitOffset, control.m_StateBlock.sizeInBits, ptr3);
	}

	public unsafe static bool CompareState(this InputControl control, void* statePtr, void* maskPtr = null)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (statePtr == null)
		{
			throw new ArgumentNullException("statePtr");
		}
		return control.CompareState(control.currentStatePtr, statePtr, maskPtr);
	}

	public unsafe static bool HasValueChangeInState(this InputControl control, void* statePtr)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (statePtr == null)
		{
			throw new ArgumentNullException("statePtr");
		}
		return control.CompareValue(control.currentStatePtr, statePtr);
	}

	public unsafe static bool HasValueChangeInEvent(this InputControl control, InputEventPtr eventPtr)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (!eventPtr.valid)
		{
			throw new ArgumentNullException("eventPtr");
		}
		void* statePtrFromStateEvent = control.GetStatePtrFromStateEvent(eventPtr);
		if (statePtrFromStateEvent == null)
		{
			return false;
		}
		return control.CompareValue(control.currentStatePtr, statePtrFromStateEvent);
	}

	public unsafe static void* GetStatePtrFromStateEvent(this InputControl control, InputEventPtr eventPtr)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (!eventPtr.valid)
		{
			throw new ArgumentNullException("eventPtr");
		}
		return control.GetStatePtrFromStateEventUnchecked(eventPtr, eventPtr.type);
	}

	internal unsafe static void* GetStatePtrFromStateEventUnchecked(this InputControl control, InputEventPtr eventPtr, FourCC eventType)
	{
		FourCC stateFormat;
		uint num;
		void* ptr;
		uint offset;
		if (eventType == 1398030676)
		{
			StateEvent* intPtr = StateEvent.FromUnchecked(eventPtr);
			offset = 0u;
			stateFormat = intPtr->stateFormat;
			num = intPtr->stateSizeInBytes;
			ptr = intPtr->state;
		}
		else
		{
			if (!(eventType == 1145852993))
			{
				throw new ArgumentException($"Event must be a StateEvent or DeltaStateEvent but is a {eventType} instead", "eventPtr");
			}
			DeltaStateEvent* intPtr2 = DeltaStateEvent.FromUnchecked(eventPtr);
			offset = intPtr2->stateOffset;
			stateFormat = intPtr2->stateFormat;
			num = intPtr2->deltaStateSizeInBytes;
			ptr = intPtr2->deltaState;
		}
		InputDevice device = control.device;
		if (stateFormat != device.m_StateBlock.format && (!device.hasStateCallbacks || !((IInputStateCallbackReceiver)device).GetStateOffsetForEvent(control, eventPtr, ref offset)))
		{
			return null;
		}
		offset += device.m_StateBlock.byteOffset;
		ref InputStateBlock stateBlock = ref control.m_StateBlock;
		long num2 = (int)stateBlock.effectiveByteOffset - offset;
		if (num2 < 0 || num2 + stateBlock.alignedSizeInBytes > num)
		{
			return null;
		}
		return (byte*)ptr - (int)offset;
	}

	public unsafe static bool ResetToDefaultStateInEvent(this InputControl control, InputEventPtr eventPtr)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (!eventPtr.valid)
		{
			throw new ArgumentNullException("eventPtr");
		}
		FourCC type = eventPtr.type;
		if (type != 1398030676 && type != 1145852993)
		{
			throw new ArgumentException("Given event is not a StateEvent or a DeltaStateEvent", "eventPtr");
		}
		byte* statePtrFromStateEvent = (byte*)control.GetStatePtrFromStateEvent(eventPtr);
		if (statePtrFromStateEvent == null)
		{
			return false;
		}
		byte* defaultStatePtr = (byte*)control.defaultStatePtr;
		ref InputStateBlock stateBlock = ref control.m_StateBlock;
		uint byteOffset = stateBlock.byteOffset;
		MemoryHelpers.MemCpyBitRegion(statePtrFromStateEvent + byteOffset, defaultStatePtr + byteOffset, stateBlock.bitOffset, stateBlock.sizeInBits);
		return true;
	}

	public static void QueueValueChange<TValue>(this InputControl<TValue> control, TValue value, double time = -1.0) where TValue : struct
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		InputEventPtr eventPtr;
		using (StateEvent.From(control.device, out eventPtr))
		{
			if (time >= 0.0)
			{
				eventPtr.time = time;
			}
			control.WriteValueIntoEvent(value, eventPtr);
			InputSystem.QueueEvent(eventPtr);
		}
	}

	public unsafe static void AccumulateValueInEvent(this InputControl<float> control, void* currentStatePtr, InputEventPtr newState)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (control.ReadUnprocessedValueFromEvent(newState, out var value))
		{
			float num = control.ReadUnprocessedValueFromState(currentStatePtr);
			control.WriteValueIntoEvent(num + value, newState);
		}
	}

	internal unsafe static void AccumulateValueInEvent(this InputControl<Vector2> control, void* currentStatePtr, InputEventPtr newState)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (control.ReadUnprocessedValueFromEvent(newState, out var value))
		{
			Vector2 vector = control.ReadUnprocessedValueFromState(currentStatePtr);
			control.WriteValueIntoEvent(vector + value, newState);
		}
	}

	public static void FindControlsRecursive<TControl>(this InputControl parent, IList<TControl> controls, Func<TControl, bool> predicate) where TControl : InputControl
	{
		if (parent == null)
		{
			throw new ArgumentNullException("parent");
		}
		if (controls == null)
		{
			throw new ArgumentNullException("controls");
		}
		if (predicate == null)
		{
			throw new ArgumentNullException("predicate");
		}
		if (parent is TControl val && predicate(val))
		{
			controls.Add(val);
		}
		int count = parent.children.Count;
		for (int i = 0; i < count; i++)
		{
			parent.children[i].FindControlsRecursive(controls, predicate);
		}
	}

	internal static string BuildPath(this InputControl control, string deviceLayout, StringBuilder builder = null)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (string.IsNullOrEmpty(deviceLayout))
		{
			throw new ArgumentNullException("deviceLayout");
		}
		if (builder == null)
		{
			builder = new StringBuilder();
		}
		InputDevice device = control.device;
		builder.Append('<');
		builder.Append(deviceLayout.Escape("\\>", "\\>"));
		builder.Append('>');
		ReadOnlyArray<InternedString> usages = device.usages;
		for (int i = 0; i < usages.Count; i++)
		{
			builder.Append('{');
			builder.Append(usages[i].ToString().Escape("\\}", "\\}"));
			builder.Append('}');
		}
		builder.Append('/');
		string text = device.path.Replace("\\", "\\\\");
		string text2 = control.path.Replace("\\", "\\\\");
		builder.Append(text2, text.Length + 1, text2.Length - text.Length - 1);
		return builder.ToString();
	}

	public static InputEventControlCollection EnumerateControls(this InputEventPtr eventPtr, Enumerate flags, InputDevice device = null, float magnitudeThreshold = 0f)
	{
		if (!eventPtr.valid)
		{
			throw new ArgumentNullException("eventPtr", "Given event pointer must not be null");
		}
		FourCC type = eventPtr.type;
		if (type != 1398030676 && type != 1145852993)
		{
			throw new ArgumentException($"Event must be a StateEvent or DeltaStateEvent but is a {type} instead", "eventPtr");
		}
		if (device == null)
		{
			int deviceId = eventPtr.deviceId;
			device = InputSystem.GetDeviceById(deviceId);
			if (device == null)
			{
				throw new ArgumentException($"Cannot find device with ID {deviceId} referenced by event", "eventPtr");
			}
		}
		return new InputEventControlCollection
		{
			m_Device = device,
			m_EventPtr = eventPtr,
			m_Flags = flags,
			m_MagnitudeThreshold = magnitudeThreshold
		};
	}

	public static InputEventControlCollection EnumerateChangedControls(this InputEventPtr eventPtr, InputDevice device = null, float magnitudeThreshold = 0f)
	{
		return eventPtr.EnumerateControls(Enumerate.IgnoreControlsInCurrentState, device, magnitudeThreshold);
	}

	public static bool HasButtonPress(this InputEventPtr eventPtr, float magnitude = -1f, bool buttonControlsOnly = true)
	{
		return eventPtr.GetFirstButtonPressOrNull(magnitude, buttonControlsOnly) != null;
	}

	public static InputControl GetFirstButtonPressOrNull(this InputEventPtr eventPtr, float magnitude = -1f, bool buttonControlsOnly = true)
	{
		if (eventPtr.type != 1398030676 && eventPtr.type != 1145852993)
		{
			return null;
		}
		if (magnitude < 0f)
		{
			magnitude = InputSystem.settings.defaultButtonPressPoint;
		}
		foreach (InputControl item in eventPtr.EnumerateControls(Enumerate.IgnoreControlsInDefaultState, null, magnitude))
		{
			if (!buttonControlsOnly || item.isButton)
			{
				return item;
			}
		}
		return null;
	}

	public static IEnumerable<InputControl> GetAllButtonPresses(this InputEventPtr eventPtr, float magnitude = -1f, bool buttonControlsOnly = true)
	{
		if (eventPtr.type != 1398030676 && eventPtr.type != 1145852993)
		{
			yield break;
		}
		if (magnitude < 0f)
		{
			magnitude = InputSystem.settings.defaultButtonPressPoint;
		}
		foreach (InputControl item in eventPtr.EnumerateControls(Enumerate.IgnoreControlsInDefaultState, null, magnitude))
		{
			if (!buttonControlsOnly || item.isButton)
			{
				yield return item;
			}
		}
	}

	public static ControlBuilder Setup(this InputControl control)
	{
		if (control == null)
		{
			throw new ArgumentNullException("control");
		}
		if (control.isSetupFinished)
		{
			throw new InvalidOperationException($"The setup of {control} cannot be modified; control is already in use");
		}
		return new ControlBuilder
		{
			control = control
		};
	}

	public static DeviceBuilder Setup(this InputDevice device, int controlCount, int usageCount, int aliasCount)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		if (device.isSetupFinished)
		{
			throw new InvalidOperationException($"The setup of {device} cannot be modified; control is already in use");
		}
		if (controlCount < 1)
		{
			throw new ArgumentOutOfRangeException("controlCount");
		}
		if (usageCount < 0)
		{
			throw new ArgumentOutOfRangeException("usageCount");
		}
		if (aliasCount < 0)
		{
			throw new ArgumentOutOfRangeException("aliasCount");
		}
		device.m_Device = device;
		device.m_ChildrenForEachControl = new InputControl[controlCount];
		if (usageCount > 0)
		{
			device.m_UsagesForEachControl = new InternedString[usageCount];
			device.m_UsageToControl = new InputControl[usageCount];
		}
		if (aliasCount > 0)
		{
			device.m_AliasesForEachControl = new InternedString[aliasCount];
		}
		return new DeviceBuilder
		{
			device = device
		};
	}
}
