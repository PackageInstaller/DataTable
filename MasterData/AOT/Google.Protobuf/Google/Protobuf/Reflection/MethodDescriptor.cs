namespace Google.Protobuf.Reflection;

public sealed class MethodDescriptor : DescriptorBase
{
	private readonly MethodDescriptorProto proto;

	private readonly ServiceDescriptor service;

	private MessageDescriptor inputType;

	private MessageDescriptor outputType;

	internal MethodDescriptorProto Proto => proto;

	public override string Name => proto.Name;

	internal MethodDescriptor(MethodDescriptorProto proto, FileDescriptor file, ServiceDescriptor parent, int index)
		: base(file, parent.FullName + "." + proto.Name, index)
	{
		this.proto = proto;
		service = parent;
		file.DescriptorPool.AddSymbol(this);
	}

	internal void CrossLink()
	{
		IDescriptor descriptor = File.DescriptorPool.LookupSymbol(Proto.InputType, this);
		if (!(descriptor is MessageDescriptor))
		{
			throw new DescriptorValidationException(this, "\"" + Proto.InputType + "\" is not a message type.");
		}
		inputType = (MessageDescriptor)descriptor;
		descriptor = File.DescriptorPool.LookupSymbol(Proto.OutputType, this);
		if (!(descriptor is MessageDescriptor))
		{
			throw new DescriptorValidationException(this, "\"" + Proto.OutputType + "\" is not a message type.");
		}
		outputType = (MessageDescriptor)descriptor;
	}
}
