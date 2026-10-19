using System;
using System.Reflection;

namespace Google.Protobuf.Reflection;

internal abstract class FieldAccessorBase : IFieldAccessor
{
	private readonly Func<IMessage, object> getValueDelegate;

	private readonly FieldDescriptor descriptor;

	public FieldDescriptor Descriptor => descriptor;

	internal FieldAccessorBase(PropertyInfo property, FieldDescriptor descriptor)
	{
		this.descriptor = descriptor;
		getValueDelegate = ReflectionUtil.CreateFuncIMessageObject(property.GetGetMethod());
	}

	public object GetValue(IMessage message)
	{
		return getValueDelegate(message);
	}

	public abstract bool HasValue(IMessage message);

	public abstract void Clear(IMessage message);

	public abstract void SetValue(IMessage message, object value);
}
