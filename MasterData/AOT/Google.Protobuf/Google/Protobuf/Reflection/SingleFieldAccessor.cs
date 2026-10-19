using System;
using System.Reflection;

namespace Google.Protobuf.Reflection;

internal sealed class SingleFieldAccessor : FieldAccessorBase
{
	private readonly Action<IMessage, object> setValueDelegate;

	private readonly Action<IMessage> clearDelegate;

	private readonly Func<IMessage, bool> hasDelegate;

	internal SingleFieldAccessor(PropertyInfo property, FieldDescriptor descriptor)
		: base(property, descriptor)
	{
		SingleFieldAccessor singleFieldAccessor = this;
		if (!property.CanWrite)
		{
			throw new ArgumentException("Not all required properties/methods available");
		}
		setValueDelegate = ReflectionUtil.CreateActionIMessageObject(property.GetSetMethod());
		if (descriptor.FieldType == FieldType.Message)
		{
			hasDelegate = (IMessage message) => singleFieldAccessor.GetValue(message) != null;
			clearDelegate = (IMessage message) =>
			{
				singleFieldAccessor.SetValue(message, null);
			};
		}
		else if (descriptor.RealContainingOneof != null)
		{
			OneofAccessor oneofAccessor = descriptor.RealContainingOneof.Accessor;
			hasDelegate = (IMessage message) => oneofAccessor.GetCaseFieldDescriptor(message) == descriptor;
			clearDelegate = (IMessage message) =>
			{
				if (oneofAccessor.GetCaseFieldDescriptor(message) == descriptor)
				{
					oneofAccessor.Clear(message);
				}
			};
		}
		else if (descriptor.File.Syntax == Syntax.Proto2 || descriptor.Proto.Proto3Optional)
		{
			MethodInfo getMethod = property.DeclaringType.GetRuntimeProperty("Has" + property.Name).GetMethod;
			if (getMethod == null)
			{
				throw new ArgumentException("Not all required properties/methods are available");
			}
			hasDelegate = ReflectionUtil.CreateFuncIMessageBool(getMethod);
			MethodInfo runtimeMethod = property.DeclaringType.GetRuntimeMethod("Clear" + property.Name, ReflectionUtil.EmptyTypes);
			if (runtimeMethod == null)
			{
				throw new ArgumentException("Not all required properties/methods are available");
			}
			clearDelegate = ReflectionUtil.CreateActionIMessage(runtimeMethod);
		}
		else
		{
			hasDelegate = (IMessage message) =>
			{
				throw new InvalidOperationException("Presence is not implemented for this field");
			};
			Type propertyType = property.PropertyType;
			object defaultValue = ((propertyType == typeof(string)) ? "" : ((propertyType == typeof(ByteString)) ? ByteString.Empty : Activator.CreateInstance(propertyType)));
			clearDelegate = (IMessage message) =>
			{
				singleFieldAccessor.SetValue(message, defaultValue);
			};
		}
	}

	public override void Clear(IMessage message)
	{
		clearDelegate(message);
	}

	public override bool HasValue(IMessage message)
	{
		return hasDelegate(message);
	}

	public override void SetValue(IMessage message, object value)
	{
		setValueDelegate(message, value);
	}
}
