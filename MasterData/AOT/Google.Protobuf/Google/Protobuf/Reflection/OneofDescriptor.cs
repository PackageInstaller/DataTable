using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Reflection;

namespace Google.Protobuf.Reflection;

public sealed class OneofDescriptor : DescriptorBase
{
	private readonly OneofDescriptorProto proto;

	private MessageDescriptor containingType;

	private IList<FieldDescriptor> fields;

	private readonly OneofAccessor accessor;

	public override string Name => proto.Name;

	public MessageDescriptor ContainingType => containingType;

	public IList<FieldDescriptor> Fields => fields;

	public bool IsSynthetic { get; }

	public OneofAccessor Accessor => accessor;

	internal OneofDescriptor(OneofDescriptorProto proto, FileDescriptor file, MessageDescriptor parent, int index, string clrName)
		: base(file, file.ComputeFullName(parent, proto.Name), index)
	{
		this.proto = proto;
		containingType = parent;
		file.DescriptorPool.AddSymbol(this);
		IsSynthetic = parent.Proto.Field.FirstOrDefault((FieldDescriptorProto fieldProto) => fieldProto.HasOneofIndex && fieldProto.OneofIndex == index)?.Proto3Optional ?? false;
		accessor = CreateAccessor(clrName);
	}

	internal void CrossLink()
	{
		List<FieldDescriptor> list = new List<FieldDescriptor>();
		foreach (FieldDescriptor item in ContainingType.Fields.InDeclarationOrder())
		{
			if (item.ContainingOneof == this)
			{
				list.Add(item);
			}
		}
		fields = new ReadOnlyCollection<FieldDescriptor>(list);
	}

	private OneofAccessor CreateAccessor(string clrName)
	{
		if (clrName == null)
		{
			return null;
		}
		if (IsSynthetic)
		{
			return OneofAccessor.ForSyntheticOneof(this);
		}
		PropertyInfo property = containingType.ClrType.GetProperty(clrName + "Case");
		if (property == null)
		{
			throw new DescriptorValidationException(this, $"Property {clrName}Case not found in {containingType.ClrType}");
		}
		if (!property.CanRead)
		{
			throw new ArgumentException($"Cannot read from property {clrName}Case in {containingType.ClrType}");
		}
		MethodInfo method = containingType.ClrType.GetMethod("Clear" + clrName);
		if (method == null)
		{
			throw new DescriptorValidationException(this, $"Method Clear{clrName} not found in {containingType.ClrType}");
		}
		return OneofAccessor.ForRegularOneof(this, property, method);
	}
}
