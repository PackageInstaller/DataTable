using System;
using System.Runtime.InteropServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.LowLevel;

[StructLayout(LayoutKind.Explicit, Pack = 1, Size = 25)]
public struct StateEvent : IInputEventTypeInfo
{
	public const int Type = 1398030676;

	internal const int kStateDataSizeToSubtract = 1;

	[FieldOffset(0)]
	public InputEvent baseEvent;

	[FieldOffset(20)]
	public FourCC stateFormat;

	[FieldOffset(24)]
	internal unsafe fixed byte stateData[1];

	public uint stateSizeInBytes => baseEvent.sizeInBytes - 24;

	public unsafe void* state
	{
		get
		{
			fixed (byte* result = stateData)
			{
				return result;
			}
		}
	}

	public FourCC typeStatic => 1398030676;

	public unsafe InputEventPtr ToEventPtr()
	{
		fixed (StateEvent* eventPtr = &this)
		{
			return new InputEventPtr((InputEvent*)eventPtr);
		}
	}

	public unsafe TState GetState<TState>() where TState : struct, IInputStateTypeInfo
	{
		TState output = default;
		if (stateFormat != output.format)
		{
			throw new InvalidOperationException($"Expected state format '{output.format}' but got '{stateFormat}' instead");
		}
		UnsafeUtility.MemCpy(UnsafeUtility.AddressOf(ref output), state, Math.Min(stateSizeInBytes, UnsafeUtility.SizeOf<TState>()));
		return output;
	}

	public unsafe static TState GetState<TState>(InputEventPtr ptr) where TState : struct, IInputStateTypeInfo
	{
		return From(ptr)->GetState<TState>();
	}

	public static int GetEventSizeWithPayload<TState>() where TState : struct
	{
		return UnsafeUtility.SizeOf<TState>() + 20 + 4;
	}

	public unsafe static StateEvent* From(InputEventPtr ptr)
	{
		if (!ptr.valid)
		{
			throw new ArgumentNullException("ptr");
		}
		if (!ptr.IsA<StateEvent>())
		{
			throw new InvalidCastException($"Cannot cast event with type '{ptr.type}' into StateEvent");
		}
		return FromUnchecked(ptr);
	}

	internal unsafe static StateEvent* FromUnchecked(InputEventPtr ptr)
	{
		return (StateEvent*)ptr.data;
	}

	public static NativeArray<byte> From(InputDevice device, out InputEventPtr eventPtr, Allocator allocator = Allocator.Temp)
	{
		return From(device, out eventPtr, allocator, useDefaultState: false);
	}

	public static NativeArray<byte> FromDefaultStateFor(InputDevice device, out InputEventPtr eventPtr, Allocator allocator = Allocator.Temp)
	{
		return From(device, out eventPtr, allocator, useDefaultState: true);
	}

	private unsafe static NativeArray<byte> From(InputDevice device, out InputEventPtr eventPtr, Allocator allocator, bool useDefaultState)
	{
		if (device == null)
		{
			throw new ArgumentNullException("device");
		}
		if (!device.added)
		{
			throw new ArgumentException($"Device '{device}' has not been added to system", "device");
		}
		FourCC format = device.m_StateBlock.format;
		uint alignedSizeInBytes = device.m_StateBlock.alignedSizeInBytes;
		uint byteOffset = device.m_StateBlock.byteOffset;
		byte* source = (byte*)(useDefaultState ? device.defaultStatePtr : device.currentStatePtr) + (int)byteOffset;
		uint num = 24 + alignedSizeInBytes;
		NativeArray<byte> nativeArray = new NativeArray<byte>((int)num.AlignToMultipleOf(4u), allocator);
		StateEvent* unsafePtr = (StateEvent*)nativeArray.GetUnsafePtr();
		unsafePtr->baseEvent = new InputEvent(1398030676, (int)num, device.deviceId, InputRuntime.s_Instance.currentTime);
		unsafePtr->stateFormat = format;
		UnsafeUtility.MemCpy(unsafePtr->state, source, alignedSizeInBytes);
		eventPtr = unsafePtr->ToEventPtr();
		return nativeArray;
	}
}
