using System;
using System.Reflection;

namespace Google.Protobuf.Reflection;

public sealed class OneofAccessor
{
	private readonly Func<IMessage, int> caseDelegate;

	private readonly Action<IMessage> clearDelegate;

	public OneofDescriptor Descriptor { get; }

	private OneofAccessor(OneofDescriptor descriptor, Func<IMessage, int> caseDelegate, Action<IMessage> clearDelegate)
	{
		Descriptor = descriptor;
		this.caseDelegate = caseDelegate;
		this.clearDelegate = clearDelegate;
	}

	internal static OneofAccessor ForRegularOneof(OneofDescriptor descriptor, PropertyInfo caseProperty, MethodInfo clearMethod)
	{
		return new OneofAccessor(descriptor, ReflectionUtil.CreateFuncIMessageInt32(caseProperty.GetGetMethod()), ReflectionUtil.CreateActionIMessage(clearMethod));
	}

	internal static OneofAccessor ForSyntheticOneof(OneofDescriptor descriptor)
	{
		return new OneofAccessor(descriptor, (IMessage message) => descriptor.Fields[0].Accessor.HasValue(message) ? descriptor.Fields[0].FieldNumber : 0, (IMessage message) =>
		{
			descriptor.Fields[0].Accessor.Clear(message);
		});
	}

	public void Clear(IMessage message)
	{
		clearDelegate(message);
	}

	public FieldDescriptor GetCaseFieldDescriptor(IMessage message)
	{
		int num = caseDelegate(message);
		if (num <= 0)
		{
			return null;
		}
		return Descriptor.ContainingType.FindFieldByNumber(num);
	}
}
