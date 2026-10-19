namespace Google.Protobuf.Reflection;

internal sealed class ExtensionAccessor : IFieldAccessor
{
	private readonly Extension extension;

	private readonly ReflectionUtil.IExtensionReflectionHelper helper;

	public FieldDescriptor Descriptor { get; }

	internal ExtensionAccessor(FieldDescriptor descriptor)
	{
		Descriptor = descriptor;
		extension = descriptor.Extension;
		helper = ReflectionUtil.CreateExtensionHelper(extension);
	}

	public void Clear(IMessage message)
	{
		helper.ClearExtension(message);
	}

	public bool HasValue(IMessage message)
	{
		return helper.HasExtension(message);
	}

	public object GetValue(IMessage message)
	{
		return helper.GetExtension(message);
	}

	public void SetValue(IMessage message, object value)
	{
		helper.SetExtension(message, value);
	}
}
