using System.Collections.Generic;

namespace Google.Protobuf.Reflection;

public sealed class ServiceDescriptor : DescriptorBase
{
	private readonly ServiceDescriptorProto proto;

	private readonly IList<MethodDescriptor> methods;

	public override string Name => proto.Name;

	internal ServiceDescriptor(ServiceDescriptorProto proto, FileDescriptor file, int index)
		: base(file, file.ComputeFullName(null, proto.Name), index)
	{
		ServiceDescriptor parent = this;
		this.proto = proto;
		methods = DescriptorUtil.ConvertAndMakeReadOnly(proto.Method, (MethodDescriptorProto method, int i) => new MethodDescriptor(method, file, parent, i));
		file.DescriptorPool.AddSymbol(this);
	}

	internal override IReadOnlyList<DescriptorBase> GetNestedDescriptorListForField(int fieldNumber)
	{
		if (fieldNumber == 2)
		{
			return (IReadOnlyList<DescriptorBase>)methods;
		}
		return null;
	}

	internal void CrossLink()
	{
		foreach (MethodDescriptor method in methods)
		{
			method.CrossLink();
		}
	}
}
