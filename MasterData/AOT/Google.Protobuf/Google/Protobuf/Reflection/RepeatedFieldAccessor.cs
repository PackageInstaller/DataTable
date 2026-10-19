using System;
using System.Collections;
using System.Reflection;

namespace Google.Protobuf.Reflection;

internal sealed class RepeatedFieldAccessor : FieldAccessorBase
{
	internal RepeatedFieldAccessor(PropertyInfo property, FieldDescriptor descriptor)
		: base(property, descriptor)
	{
	}

	public override void Clear(IMessage message)
	{
		((IList)GetValue(message)).Clear();
	}

	public override bool HasValue(IMessage message)
	{
		throw new InvalidOperationException("HasValue is not implemented for repeated fields");
	}

	public override void SetValue(IMessage message, object value)
	{
		throw new InvalidOperationException("SetValue is not implemented for repeated fields");
	}
}
