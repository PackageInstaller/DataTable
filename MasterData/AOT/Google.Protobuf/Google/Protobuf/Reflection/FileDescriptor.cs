using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Threading;
using Google.Protobuf.Collections;
using Google.Protobuf.WellKnownTypes;

namespace Google.Protobuf.Reflection;

public sealed class FileDescriptor : IDescriptor
{
	private readonly Lazy<Dictionary<IDescriptor, DescriptorDeclaration>> declarations;

	internal FileDescriptorProto Proto { get; }

	public Syntax Syntax { get; }

	public string Name => Proto.Name;

	public string Package => Proto.Package;

	public IList<MessageDescriptor> MessageTypes { get; }

	public IList<EnumDescriptor> EnumTypes { get; }

	public IList<ServiceDescriptor> Services { get; }

	public ExtensionCollection Extensions { get; }

	public IList<FileDescriptor> Dependencies { get; }

	public IList<FileDescriptor> PublicDependencies { get; }

	public ByteString SerializedData { get; }

	string IDescriptor.FullName => Name;

	FileDescriptor IDescriptor.File => this;

	internal DescriptorPool DescriptorPool { get; }

	public static FileDescriptor DescriptorProtoFileDescriptor => DescriptorReflection.Descriptor;

	[Obsolete("CustomOptions are obsolete. Use the GetOptions() method.")]
	public CustomOptions CustomOptions => new CustomOptions(Proto.Options?._extensions?.ValuesByNumber);

	static FileDescriptor()
	{
		ForceReflectionInitialization<Syntax>();
		ForceReflectionInitialization<NullValue>();
		ForceReflectionInitialization<Field.Types.Cardinality>();
		ForceReflectionInitialization<Field.Types.Kind>();
		ForceReflectionInitialization<Value.KindOneofCase>();
	}

	private FileDescriptor(ByteString descriptorData, FileDescriptorProto proto, IEnumerable<FileDescriptor> dependencies, DescriptorPool pool, bool allowUnknownDependencies, GeneratedClrTypeInfo generatedCodeInfo)
	{
		FileDescriptor fileDescriptor = this;
		SerializedData = descriptorData;
		DescriptorPool = pool;
		Proto = proto;
		Dependencies = new ReadOnlyCollection<FileDescriptor>(dependencies.ToList());
		PublicDependencies = DeterminePublicDependencies(this, proto, dependencies, allowUnknownDependencies);
		pool.AddPackage(Package, this);
		MessageTypes = DescriptorUtil.ConvertAndMakeReadOnly(proto.MessageType, (DescriptorProto message, int index) =>
		{
			FileDescriptor file = fileDescriptor;
			GeneratedClrTypeInfo generatedClrTypeInfo = generatedCodeInfo;
			return new MessageDescriptor(message, file, null, index, (generatedClrTypeInfo != null) ? generatedClrTypeInfo.NestedTypes[index] : null);
		});
		EnumTypes = DescriptorUtil.ConvertAndMakeReadOnly(proto.EnumType, (EnumDescriptorProto enumType, int index) =>
		{
			FileDescriptor file = fileDescriptor;
			GeneratedClrTypeInfo generatedClrTypeInfo = generatedCodeInfo;
			return new EnumDescriptor(enumType, file, null, index, (generatedClrTypeInfo != null) ? generatedClrTypeInfo.NestedEnums[index] : null);
		});
		Services = DescriptorUtil.ConvertAndMakeReadOnly(proto.Service, (ServiceDescriptorProto service, int index) => new ServiceDescriptor(service, fileDescriptor, index));
		Extensions = new ExtensionCollection(this, generatedCodeInfo?.Extensions);
		declarations = new Lazy<Dictionary<IDescriptor, DescriptorDeclaration>>(CreateDeclarationMap, LazyThreadSafetyMode.ExecutionAndPublication);
		if (!proto.HasSyntax || proto.Syntax == "proto2")
		{
			Syntax = Syntax.Proto2;
		}
		else if (proto.Syntax == "proto3")
		{
			Syntax = Syntax.Proto3;
		}
		else
		{
			Syntax = Syntax.Unknown;
		}
	}

	private Dictionary<IDescriptor, DescriptorDeclaration> CreateDeclarationMap()
	{
		Dictionary<IDescriptor, DescriptorDeclaration> dictionary = new Dictionary<IDescriptor, DescriptorDeclaration>();
		IEnumerable<SourceCodeInfo.Types.Location> enumerable = Proto.SourceCodeInfo?.Location;
		foreach (SourceCodeInfo.Types.Location item in enumerable ?? Enumerable.Empty<SourceCodeInfo.Types.Location>())
		{
			IDescriptor descriptor = FindDescriptorForPath(item.Path);
			if (descriptor != null)
			{
				dictionary[descriptor] = DescriptorDeclaration.FromProto(descriptor, item);
			}
		}
		return dictionary;
	}

	private IDescriptor FindDescriptorForPath(IList<int> path)
	{
		if (path.Count == 0 || (path.Count & 1) != 0)
		{
			return null;
		}
		IReadOnlyList<DescriptorBase> nestedDescriptorListForField = GetNestedDescriptorListForField(path[0]);
		DescriptorBase descriptorFromList = GetDescriptorFromList(nestedDescriptorListForField, path[1]);
		int num = 2;
		while (descriptorFromList != null && num < path.Count)
		{
			IReadOnlyList<DescriptorBase> nestedDescriptorListForField2 = descriptorFromList.GetNestedDescriptorListForField(path[num]);
			descriptorFromList = GetDescriptorFromList(nestedDescriptorListForField2, path[num + 1]);
			num += 2;
		}
		return descriptorFromList;
	}

	private DescriptorBase GetDescriptorFromList(IReadOnlyList<DescriptorBase> list, int index)
	{
		if (list == null)
		{
			return null;
		}
		if (index < 0 || index >= list.Count)
		{
			throw new InvalidProtocolBufferException("Invalid descriptor location path: index out of range");
		}
		return list[index];
	}

	private IReadOnlyList<DescriptorBase> GetNestedDescriptorListForField(int fieldNumber)
	{
		return fieldNumber switch
		{
			6 => (IReadOnlyList<DescriptorBase>)Services, 
			4 => (IReadOnlyList<DescriptorBase>)MessageTypes, 
			5 => (IReadOnlyList<DescriptorBase>)EnumTypes, 
			_ => null, 
		};
	}

	internal DescriptorDeclaration GetDeclaration(IDescriptor descriptor)
	{
		declarations.Value.TryGetValue(descriptor, out var value);
		return value;
	}

	internal string ComputeFullName(MessageDescriptor parent, string name)
	{
		if (parent != null)
		{
			return parent.FullName + "." + name;
		}
		if (Package.Length > 0)
		{
			return Package + "." + name;
		}
		return name;
	}

	private static IList<FileDescriptor> DeterminePublicDependencies(FileDescriptor @this, FileDescriptorProto proto, IEnumerable<FileDescriptor> dependencies, bool allowUnknownDependencies)
	{
		Dictionary<string, FileDescriptor> dictionary = dependencies.ToDictionary((FileDescriptor file) => file.Name);
		List<FileDescriptor> list = new List<FileDescriptor>();
		for (int num = 0; num < proto.PublicDependency.Count; num++)
		{
			int num2 = proto.PublicDependency[num];
			if (num2 < 0 || num2 >= proto.Dependency.Count)
			{
				throw new DescriptorValidationException(@this, "Invalid public dependency index.");
			}
			string text = proto.Dependency[num2];
			if (!dictionary.TryGetValue(text, out var value))
			{
				if (!allowUnknownDependencies)
				{
					throw new DescriptorValidationException(@this, "Invalid public dependency: " + text);
				}
			}
			else
			{
				list.Add(value);
			}
		}
		return new ReadOnlyCollection<FileDescriptor>(list);
	}

	public T FindTypeByName<T>(string name) where T : class, IDescriptor
	{
		if (name.IndexOf('.') != -1)
		{
			return null;
		}
		if (Package.Length > 0)
		{
			name = Package + "." + name;
		}
		T val = DescriptorPool.FindSymbol<T>(name);
		if (val != null && val.File == this)
		{
			return val;
		}
		return null;
	}

	private static FileDescriptor BuildFrom(ByteString descriptorData, FileDescriptorProto proto, FileDescriptor[] dependencies, bool allowUnknownDependencies, GeneratedClrTypeInfo generatedCodeInfo)
	{
		if (dependencies == null)
		{
			dependencies = new FileDescriptor[0];
		}
		DescriptorPool pool = new DescriptorPool(dependencies);
		FileDescriptor fileDescriptor = new FileDescriptor(descriptorData, proto, dependencies, pool, allowUnknownDependencies, generatedCodeInfo);
		if (dependencies.Length != proto.Dependency.Count)
		{
			throw new DescriptorValidationException(fileDescriptor, "Dependencies passed to FileDescriptor.BuildFrom() don't match those listed in the FileDescriptorProto.");
		}
		fileDescriptor.CrossLink();
		return fileDescriptor;
	}

	private void CrossLink()
	{
		foreach (MessageDescriptor messageType in MessageTypes)
		{
			messageType.CrossLink();
		}
		foreach (ServiceDescriptor service in Services)
		{
			service.CrossLink();
		}
		Extensions.CrossLink();
	}

	public static FileDescriptor FromGeneratedCode(byte[] descriptorData, FileDescriptor[] dependencies, GeneratedClrTypeInfo generatedCodeInfo)
	{
		ExtensionRegistry extensionRegistry = new ExtensionRegistry();
		extensionRegistry.AddRange(GetAllExtensions(dependencies, generatedCodeInfo));
		FileDescriptorProto fileDescriptorProto;
		try
		{
			fileDescriptorProto = FileDescriptorProto.Parser.WithExtensionRegistry(extensionRegistry).ParseFrom(descriptorData);
		}
		catch (InvalidProtocolBufferException innerException)
		{
			throw new ArgumentException("Failed to parse protocol buffer descriptor for generated code.", innerException);
		}
		try
		{
			return BuildFrom(ByteString.CopyFrom(descriptorData), fileDescriptorProto, dependencies, allowUnknownDependencies: true, generatedCodeInfo);
		}
		catch (DescriptorValidationException innerException2)
		{
			throw new ArgumentException("Invalid embedded descriptor for \"" + fileDescriptorProto.Name + "\".", innerException2);
		}
	}

	private static IEnumerable<Extension> GetAllExtensions(FileDescriptor[] dependencies, GeneratedClrTypeInfo generatedInfo)
	{
		return dependencies.SelectMany(GetAllDependedExtensions).Distinct(ExtensionRegistry.ExtensionComparer.Instance).Concat(GetAllGeneratedExtensions(generatedInfo));
	}

	private static IEnumerable<Extension> GetAllGeneratedExtensions(GeneratedClrTypeInfo generated)
	{
		return generated.Extensions.Concat(generated.NestedTypes.Where((GeneratedClrTypeInfo t) => t != null).SelectMany(GetAllGeneratedExtensions));
	}

	private static IEnumerable<Extension> GetAllDependedExtensions(FileDescriptor descriptor)
	{
		return (from s in descriptor.Extensions.UnorderedExtensions
			select s.Extension into e
			where e != null
			select e).Concat(descriptor.Dependencies.Concat(descriptor.PublicDependencies).SelectMany(GetAllDependedExtensions)).Concat(descriptor.MessageTypes.SelectMany(GetAllDependedExtensionsFromMessage));
	}

	private static IEnumerable<Extension> GetAllDependedExtensionsFromMessage(MessageDescriptor descriptor)
	{
		return (from s in descriptor.Extensions.UnorderedExtensions
			select s.Extension into e
			where e != null
			select e).Concat(descriptor.NestedTypes.SelectMany(GetAllDependedExtensionsFromMessage));
	}

	public static IReadOnlyList<FileDescriptor> BuildFromByteStrings(IEnumerable<ByteString> descriptorData, ExtensionRegistry registry)
	{
		ProtoPreconditions.CheckNotNull(descriptorData, "descriptorData");
		MessageParser<FileDescriptorProto> messageParser = FileDescriptorProto.Parser.WithExtensionRegistry(registry);
		List<FileDescriptor> list = new List<FileDescriptor>();
		Dictionary<string, FileDescriptor> dictionary = new Dictionary<string, FileDescriptor>();
		foreach (ByteString descriptorDatum in descriptorData)
		{
			FileDescriptorProto fileDescriptorProto = messageParser.ParseFrom(descriptorDatum);
			List<FileDescriptor> list2 = new List<FileDescriptor>();
			foreach (string item in fileDescriptorProto.Dependency)
			{
				if (!dictionary.TryGetValue(item, out var value))
				{
					throw new ArgumentException("Dependency missing: " + item);
				}
				list2.Add(value);
			}
			DescriptorPool pool = new DescriptorPool(list2);
			FileDescriptor fileDescriptor = new FileDescriptor(descriptorDatum, fileDescriptorProto, list2, pool, allowUnknownDependencies: false, null);
			fileDescriptor.CrossLink();
			list.Add(fileDescriptor);
			if (dictionary.ContainsKey(fileDescriptor.Name))
			{
				throw new ArgumentException("Duplicate descriptor name: " + fileDescriptor.Name);
			}
			dictionary.Add(fileDescriptor.Name, fileDescriptor);
		}
		return new ReadOnlyCollection<FileDescriptor>(list);
	}

	public static IReadOnlyList<FileDescriptor> BuildFromByteStrings(IEnumerable<ByteString> descriptorData)
	{
		return BuildFromByteStrings(descriptorData, null);
	}

	public override string ToString()
	{
		return "FileDescriptor for " + Name;
	}

	public FileOptions GetOptions()
	{
		return Proto.Options?.Clone();
	}

	[Obsolete("GetOption is obsolete. Use the GetOptions() method.")]
	public T GetOption<T>(Extension<FileOptions, T> extension)
	{
		T extension2 = Proto.Options.GetExtension(extension);
		if (!(extension2 is IDeepCloneable<T>))
		{
			return extension2;
		}
		return (extension2 as IDeepCloneable<T>).Clone();
	}

	[Obsolete("GetOption is obsolete. Use the GetOptions() method.")]
	public RepeatedField<T> GetOption<T>(RepeatedExtension<FileOptions, T> extension)
	{
		return Proto.Options.GetExtension(extension).Clone();
	}

	public static void ForceReflectionInitialization<T>()
	{
		ReflectionUtil.ForceInitialize<T>();
	}
}
