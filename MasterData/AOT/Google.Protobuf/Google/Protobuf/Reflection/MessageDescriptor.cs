using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using Google.Protobuf.Collections;

namespace Google.Protobuf.Reflection;

public sealed class MessageDescriptor : DescriptorBase
{
	public sealed class FieldCollection
	{
		private readonly MessageDescriptor messageDescriptor;

		public FieldDescriptor this[int number] => messageDescriptor.FindFieldByNumber(number) ?? throw new KeyNotFoundException("No such field number");

		internal FieldCollection(MessageDescriptor messageDescriptor)
		{
			this.messageDescriptor = messageDescriptor;
		}

		public IList<FieldDescriptor> InDeclarationOrder()
		{
			return messageDescriptor.fieldsInDeclarationOrder;
		}

		public IList<FieldDescriptor> InFieldNumberOrder()
		{
			return messageDescriptor.fieldsInNumberOrder;
		}

		internal IDictionary<string, FieldDescriptor> ByJsonName()
		{
			return messageDescriptor.jsonFieldMap;
		}
	}

	private static readonly HashSet<string> WellKnownTypeNames = new HashSet<string> { "google/protobuf/any.proto", "google/protobuf/api.proto", "google/protobuf/duration.proto", "google/protobuf/empty.proto", "google/protobuf/wrappers.proto", "google/protobuf/timestamp.proto", "google/protobuf/field_mask.proto", "google/protobuf/source_context.proto", "google/protobuf/struct.proto", "google/protobuf/type.proto" };

	private readonly IList<FieldDescriptor> fieldsInDeclarationOrder;

	private readonly IList<FieldDescriptor> fieldsInNumberOrder;

	private readonly IDictionary<string, FieldDescriptor> jsonFieldMap;

	private Func<IMessage, bool> extensionSetIsInitialized;

	public override string Name => Proto.Name;

	internal DescriptorProto Proto { get; }

	public Type ClrType { get; }

	public MessageParser Parser { get; }

	internal bool IsWellKnownType
	{
		get
		{
			if (File.Package == "google.protobuf")
			{
				return WellKnownTypeNames.Contains(File.Name);
			}
			return false;
		}
	}

	internal bool IsWrapperType
	{
		get
		{
			if (File.Package == "google.protobuf")
			{
				return File.Name == "google/protobuf/wrappers.proto";
			}
			return false;
		}
	}

	public MessageDescriptor ContainingType { get; }

	public FieldCollection Fields { get; }

	public ExtensionCollection Extensions { get; }

	public IList<MessageDescriptor> NestedTypes { get; }

	public IList<EnumDescriptor> EnumTypes { get; }

	public IList<OneofDescriptor> Oneofs { get; }

	public int RealOneofCount { get; }

	[Obsolete("CustomOptions are obsolete. Use the GetOptions() method.")]
	public CustomOptions CustomOptions => new CustomOptions(Proto.Options?._extensions?.ValuesByNumber);

	internal MessageDescriptor(DescriptorProto proto, FileDescriptor file, MessageDescriptor parent, int typeIndex, GeneratedClrTypeInfo generatedCodeInfo)
		: base(file, file.ComputeFullName(parent, proto.Name), typeIndex)
	{
		MessageDescriptor messageDescriptor = this;
		Proto = proto;
		Parser = generatedCodeInfo?.Parser;
		ClrType = generatedCodeInfo?.ClrType;
		ContainingType = parent;
		Oneofs = DescriptorUtil.ConvertAndMakeReadOnly(proto.OneofDecl, (OneofDescriptorProto oneof, int index) =>
		{
			FileDescriptor file2 = file;
			MessageDescriptor parent2 = messageDescriptor;
			GeneratedClrTypeInfo generatedClrTypeInfo = generatedCodeInfo;
			return new OneofDescriptor(oneof, file2, parent2, index, (generatedClrTypeInfo != null) ? generatedClrTypeInfo.OneofNames[index] : null);
		});
		int num = 0;
		foreach (OneofDescriptor oneof in Oneofs)
		{
			if (oneof.IsSynthetic)
			{
				num++;
			}
			else if (num != 0)
			{
				throw new ArgumentException("All synthetic oneofs should come after real oneofs");
			}
		}
		RealOneofCount = Oneofs.Count - num;
		NestedTypes = DescriptorUtil.ConvertAndMakeReadOnly(proto.NestedType, (DescriptorProto type, int index) =>
		{
			FileDescriptor file2 = file;
			MessageDescriptor parent2 = messageDescriptor;
			GeneratedClrTypeInfo generatedClrTypeInfo = generatedCodeInfo;
			return new MessageDescriptor(type, file2, parent2, index, (generatedClrTypeInfo != null) ? generatedClrTypeInfo.NestedTypes[index] : null);
		});
		EnumTypes = DescriptorUtil.ConvertAndMakeReadOnly(proto.EnumType, (EnumDescriptorProto type, int index) =>
		{
			FileDescriptor file2 = file;
			MessageDescriptor parent2 = messageDescriptor;
			GeneratedClrTypeInfo generatedClrTypeInfo = generatedCodeInfo;
			return new EnumDescriptor(type, file2, parent2, index, (generatedClrTypeInfo != null) ? generatedClrTypeInfo.NestedEnums[index] : null);
		});
		Extensions = new ExtensionCollection(this, generatedCodeInfo?.Extensions);
		fieldsInDeclarationOrder = DescriptorUtil.ConvertAndMakeReadOnly(proto.Field, (FieldDescriptorProto field, int index) =>
		{
			FileDescriptor file2 = file;
			MessageDescriptor parent2 = messageDescriptor;
			GeneratedClrTypeInfo generatedClrTypeInfo = generatedCodeInfo;
			return new FieldDescriptor(field, file2, parent2, index, (generatedClrTypeInfo != null) ? generatedClrTypeInfo.PropertyNames[index] : null, null);
		});
		fieldsInNumberOrder = new ReadOnlyCollection<FieldDescriptor>(fieldsInDeclarationOrder.OrderBy((FieldDescriptor field) => field.FieldNumber).ToArray());
		jsonFieldMap = CreateJsonFieldMap(fieldsInNumberOrder);
		file.DescriptorPool.AddSymbol(this);
		Fields = new FieldCollection(this);
	}

	private static ReadOnlyDictionary<string, FieldDescriptor> CreateJsonFieldMap(IList<FieldDescriptor> fields)
	{
		Dictionary<string, FieldDescriptor> dictionary = new Dictionary<string, FieldDescriptor>();
		foreach (FieldDescriptor field in fields)
		{
			dictionary[field.Name] = field;
			dictionary[field.JsonName] = field;
		}
		return new ReadOnlyDictionary<string, FieldDescriptor>(dictionary);
	}

	internal override IReadOnlyList<DescriptorBase> GetNestedDescriptorListForField(int fieldNumber)
	{
		return fieldNumber switch
		{
			2 => (IReadOnlyList<DescriptorBase>)fieldsInDeclarationOrder, 
			3 => (IReadOnlyList<DescriptorBase>)NestedTypes, 
			4 => (IReadOnlyList<DescriptorBase>)EnumTypes, 
			_ => null, 
		};
	}

	internal bool IsExtensionsInitialized(IMessage message)
	{
		if (Proto.ExtensionRange.Count == 0)
		{
			return true;
		}
		if (extensionSetIsInitialized == null)
		{
			extensionSetIsInitialized = ReflectionUtil.CreateIsInitializedCaller(ClrType);
		}
		return extensionSetIsInitialized(message);
	}

	public FieldDescriptor FindFieldByName(string name)
	{
		return File.DescriptorPool.FindSymbol<FieldDescriptor>(FullName + "." + name);
	}

	public FieldDescriptor FindFieldByNumber(int number)
	{
		return File.DescriptorPool.FindFieldByNumber(this, number);
	}

	public T FindDescriptor<T>(string name) where T : class, IDescriptor
	{
		return File.DescriptorPool.FindSymbol<T>(FullName + "." + name);
	}

	public MessageOptions GetOptions()
	{
		return Proto.Options?.Clone();
	}

	[Obsolete("GetOption is obsolete. Use the GetOptions() method.")]
	public T GetOption<T>(Extension<MessageOptions, T> extension)
	{
		T extension2 = Proto.Options.GetExtension(extension);
		if (!(extension2 is IDeepCloneable<T>))
		{
			return extension2;
		}
		return (extension2 as IDeepCloneable<T>).Clone();
	}

	[Obsolete("GetOption is obsolete. Use the GetOptions() method.")]
	public RepeatedField<T> GetOption<T>(RepeatedExtension<MessageOptions, T> extension)
	{
		return Proto.Options.GetExtension(extension).Clone();
	}

	internal void CrossLink()
	{
		foreach (MessageDescriptor nestedType in NestedTypes)
		{
			nestedType.CrossLink();
		}
		foreach (FieldDescriptor item in fieldsInDeclarationOrder)
		{
			item.CrossLink();
		}
		foreach (OneofDescriptor oneof in Oneofs)
		{
			oneof.CrossLink();
		}
		Extensions.CrossLink();
	}
}
