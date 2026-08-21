using System;
using System.Collections.Generic;
using System.Reflection;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

public abstract class InputBindingComposite
{
	internal static TypeTable s_Composites;

	public abstract Type valueType { get; }

	public abstract int valueSizeInBytes { get; }

	public unsafe abstract void ReadValue(ref InputBindingCompositeContext context, void* buffer, int bufferSize);

	public abstract object ReadValueAsObject(ref InputBindingCompositeContext context);

	public virtual float EvaluateMagnitude(ref InputBindingCompositeContext context)
	{
		return -1f;
	}

	protected virtual void FinishSetup(ref InputBindingCompositeContext context)
	{
	}

	internal void CallFinishSetup(ref InputBindingCompositeContext context)
	{
		FinishSetup(ref context);
	}

	internal static Type GetValueType(string composite)
	{
		if (string.IsNullOrEmpty(composite))
		{
			throw new ArgumentNullException("composite");
		}
		Type type = s_Composites.LookupTypeRegistration(composite);
		if (type == null)
		{
			return null;
		}
		return TypeHelpers.GetGenericTypeArgumentFromHierarchy(type, typeof(InputBindingComposite<>), 0);
	}

	public static string GetExpectedControlLayoutName(string composite, string part)
	{
		if (string.IsNullOrEmpty(composite))
		{
			throw new ArgumentNullException("composite");
		}
		if (string.IsNullOrEmpty(part))
		{
			throw new ArgumentNullException("part");
		}
		Type type = s_Composites.LookupTypeRegistration(composite);
		if (type == null)
		{
			return null;
		}
		FieldInfo field = type.GetField(part, BindingFlags.IgnoreCase | BindingFlags.Instance | BindingFlags.Public);
		if (field == null)
		{
			return null;
		}
		return field.GetCustomAttribute<InputControlAttribute>(inherit: false)?.layout;
	}

	internal static IEnumerable<string> GetPartNames(string composite)
	{
		if (string.IsNullOrEmpty(composite))
		{
			throw new ArgumentNullException("composite");
		}
		Type type = s_Composites.LookupTypeRegistration(composite);
		if (type == null)
		{
			yield break;
		}
		FieldInfo[] fields = type.GetFields(BindingFlags.Instance | BindingFlags.Public);
		foreach (FieldInfo fieldInfo in fields)
		{
			if (fieldInfo.GetCustomAttribute<InputControlAttribute>() != null)
			{
				yield return fieldInfo.Name;
			}
		}
	}

	internal static string GetDisplayFormatString(string composite)
	{
		if (string.IsNullOrEmpty(composite))
		{
			throw new ArgumentNullException("composite");
		}
		Type type = s_Composites.LookupTypeRegistration(composite);
		if (type == null)
		{
			return null;
		}
		return type.GetCustomAttribute<DisplayStringFormatAttribute>()?.formatString;
	}
}
public abstract class InputBindingComposite<TValue> : InputBindingComposite where TValue : struct
{
	public override Type valueType => typeof(TValue);

	public override int valueSizeInBytes => UnsafeUtility.SizeOf<TValue>();

	public abstract TValue ReadValue(ref InputBindingCompositeContext context);

	public unsafe override void ReadValue(ref InputBindingCompositeContext context, void* buffer, int bufferSize)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		int num = UnsafeUtility.SizeOf<TValue>();
		if (bufferSize < num)
		{
			throw new ArgumentException($"Expected buffer of at least {UnsafeUtility.SizeOf<TValue>()} bytes but got buffer of only {bufferSize} bytes instead", "bufferSize");
		}
		TValue output = ReadValue(ref context);
		void* source = UnsafeUtility.AddressOf(ref output);
		UnsafeUtility.MemCpy(buffer, source, num);
	}

	public unsafe override object ReadValueAsObject(ref InputBindingCompositeContext context)
	{
		TValue output = default(TValue);
		void* buffer = UnsafeUtility.AddressOf(ref output);
		ReadValue(ref context, buffer, UnsafeUtility.SizeOf<TValue>());
		return output;
	}
}
