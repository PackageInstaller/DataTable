namespace Google.Protobuf.Reflection;

public interface IFieldAccessor
{
	FieldDescriptor Descriptor { get; }

	void Clear(IMessage message);

	object GetValue(IMessage message);

	bool HasValue(IMessage message);

	void SetValue(IMessage message, object value);
}
