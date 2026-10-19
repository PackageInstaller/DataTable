using System;
using System.Collections.Generic;

namespace Google.Protobuf.Reflection;

public sealed class EnumDescriptor : DescriptorBase
{
	private readonly EnumDescriptorProto proto;

	private readonly MessageDescriptor containingType;

	private readonly IList<EnumValueDescriptor> values;

	private readonly Type clrType;

	public override string Name => proto.Name;

	public Type ClrType => clrType;

	public IList<EnumValueDescriptor> Values => values;

	internal EnumDescriptor(EnumDescriptorProto proto, FileDescriptor file, MessageDescriptor parent, int index, Type clrType)
		: base(file, file.ComputeFullName(parent, proto.Name), index)
	{
		EnumDescriptor parent2 = this;
		this.proto = proto;
		this.clrType = clrType;
		containingType = parent;
		if (proto.Value.Count == 0)
		{
			throw new DescriptorValidationException(this, "Enums must contain at least one value.");
		}
		values = DescriptorUtil.ConvertAndMakeReadOnly(proto.Value, (EnumValueDescriptorProto value, int i) => new EnumValueDescriptor(value, file, parent2, i));
		File.DescriptorPool.AddSymbol(this);
	}

	internal override IReadOnlyList<DescriptorBase> GetNestedDescriptorListForField(int fieldNumber)
	{
		if (fieldNumber == 2)
		{
			return (IReadOnlyList<DescriptorBase>)Values;
		}
		return null;
	}

	public EnumValueDescriptor FindValueByName(string name)
	{
		return File.DescriptorPool.FindSymbol<EnumValueDescriptor>(FullName + "." + name);
	}
}
