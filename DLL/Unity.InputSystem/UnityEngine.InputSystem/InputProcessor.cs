using System;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

public abstract class InputProcessor
{
	public enum CachingPolicy
	{
		CacheResult,
		EvaluateOnEveryRead
	}

	internal static TypeTable s_Processors;

	public virtual CachingPolicy cachingPolicy => CachingPolicy.CacheResult;

	public abstract object ProcessAsObject(object value, InputControl control);

	public unsafe abstract void Process(void* buffer, int bufferSize, InputControl control);

	internal static Type GetValueTypeFromType(Type processorType)
	{
		if (processorType == null)
		{
			throw new ArgumentNullException("processorType");
		}
		return TypeHelpers.GetGenericTypeArgumentFromHierarchy(processorType, typeof(InputProcessor<>), 0);
	}
}
public abstract class InputProcessor<TValue> : InputProcessor where TValue : struct
{
	public abstract TValue Process(TValue value, InputControl control);

	public override object ProcessAsObject(object value, InputControl control)
	{
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		if (!(value is TValue value2))
		{
			throw new ArgumentException($"Expecting value of type '{typeof(TValue).Name}' but got value '{value}' of type '{value.GetType().Name}'", "value");
		}
		return Process(value2, control);
	}

	public unsafe override void Process(void* buffer, int bufferSize, InputControl control)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		int num = UnsafeUtility.SizeOf<TValue>();
		if (bufferSize < num)
		{
			throw new ArgumentException($"Expected buffer of at least {num} bytes but got buffer with just {bufferSize} bytes", "bufferSize");
		}
		TValue output = default(TValue);
		void* destination = UnsafeUtility.AddressOf(ref output);
		UnsafeUtility.MemCpy(destination, buffer, num);
		output = Process(output, control);
		destination = UnsafeUtility.AddressOf(ref output);
		UnsafeUtility.MemCpy(buffer, destination, num);
	}
}
