using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;

namespace Google.Protobuf.Reflection;

internal sealed class DescriptorPool
{
	private readonly IDictionary<string, IDescriptor> descriptorsByName = new Dictionary<string, IDescriptor>();

	private readonly IDictionary<ObjectIntPair<IDescriptor>, FieldDescriptor> fieldsByNumber = new Dictionary<ObjectIntPair<IDescriptor>, FieldDescriptor>();

	private readonly IDictionary<ObjectIntPair<IDescriptor>, EnumValueDescriptor> enumValuesByNumber = new Dictionary<ObjectIntPair<IDescriptor>, EnumValueDescriptor>();

	private readonly HashSet<FileDescriptor> dependencies;

	private static readonly Regex ValidationRegex = new Regex("^[_A-Za-z][_A-Za-z0-9]*$", FrameworkPortability.CompiledRegexWhereAvailable);

	internal DescriptorPool(IEnumerable<FileDescriptor> dependencyFiles)
	{
		dependencies = new HashSet<FileDescriptor>();
		foreach (FileDescriptor dependencyFile in dependencyFiles)
		{
			dependencies.Add(dependencyFile);
			ImportPublicDependencies(dependencyFile);
		}
		foreach (FileDescriptor dependencyFile2 in dependencyFiles)
		{
			AddPackage(dependencyFile2.Package, dependencyFile2);
		}
	}

	private void ImportPublicDependencies(FileDescriptor file)
	{
		foreach (FileDescriptor publicDependency in file.PublicDependencies)
		{
			if (dependencies.Add(publicDependency))
			{
				ImportPublicDependencies(publicDependency);
			}
		}
	}

	internal T FindSymbol<T>(string fullName) where T : class
	{
		descriptorsByName.TryGetValue(fullName, out var value);
		if (value is T result)
		{
			return result;
		}
		foreach (FileDescriptor dependency in dependencies)
		{
			dependency.DescriptorPool.descriptorsByName.TryGetValue(fullName, out value);
			if (value is T result2)
			{
				return result2;
			}
		}
		return null;
	}

	internal void AddPackage(string fullName, FileDescriptor file)
	{
		int num = fullName.LastIndexOf('.');
		string text;
		if (num != -1)
		{
			AddPackage(fullName.Substring(0, num), file);
			text = fullName.Substring(num + 1);
		}
		else
		{
			text = fullName;
		}
		if (descriptorsByName.TryGetValue(fullName, out var value) && !(value is PackageDescriptor))
		{
			throw new DescriptorValidationException(file, "\"" + text + "\" is already defined (as something other than a package) in file \"" + value.File.Name + "\".");
		}
		descriptorsByName[fullName] = new PackageDescriptor(text, fullName, file);
	}

	internal void AddSymbol(IDescriptor descriptor)
	{
		ValidateSymbolName(descriptor);
		string fullName = descriptor.FullName;
		if (descriptorsByName.TryGetValue(fullName, out var value))
		{
			int num = fullName.LastIndexOf('.');
			string description;
			if (descriptor.File != value.File)
			{
				description = "\"" + fullName + "\" is already defined in file \"" + value.File.Name + "\".";
			}
			else
			{
				description = ((num != -1) ? ("\"" + fullName.Substring(num + 1) + "\" is already defined in \"" + fullName.Substring(0, num) + "\".") : ("\"" + fullName + "\" is already defined."));
			}
			throw new DescriptorValidationException(descriptor, description);
		}
		descriptorsByName[fullName] = descriptor;
	}

	private static void ValidateSymbolName(IDescriptor descriptor)
	{
		if (descriptor.Name == "")
		{
			throw new DescriptorValidationException(descriptor, "Missing name.");
		}
		if (!ValidationRegex.IsMatch(descriptor.Name))
		{
			throw new DescriptorValidationException(descriptor, "\"" + descriptor.Name + "\" is not a valid identifier.");
		}
	}

	internal FieldDescriptor FindFieldByNumber(MessageDescriptor messageDescriptor, int number)
	{
		fieldsByNumber.TryGetValue(new ObjectIntPair<IDescriptor>(messageDescriptor, number), out var value);
		return value;
	}

	internal void AddFieldByNumber(FieldDescriptor field)
	{
		ObjectIntPair<IDescriptor> key = new ObjectIntPair<IDescriptor>(field.Proto.HasExtendee ? field.ExtendeeType : field.ContainingType, field.FieldNumber);
		if (fieldsByNumber.TryGetValue(key, out var value))
		{
			throw new DescriptorValidationException(field, "Field number " + field.FieldNumber + "has already been used in \"" + field.ContainingType.FullName + "\" by field \"" + value.Name + "\".");
		}
		fieldsByNumber[key] = field;
	}

	internal void AddEnumValueByNumber(EnumValueDescriptor enumValue)
	{
		ObjectIntPair<IDescriptor> key = new ObjectIntPair<IDescriptor>(enumValue.EnumDescriptor, enumValue.Number);
		if (!enumValuesByNumber.ContainsKey(key))
		{
			enumValuesByNumber[key] = enumValue;
		}
	}

	internal IDescriptor LookupSymbol(string name, IDescriptor relativeTo)
	{
		IDescriptor descriptor;
		if (name.StartsWith("."))
		{
			descriptor = FindSymbol<IDescriptor>(name.Substring(1));
		}
		else
		{
			int num = name.IndexOf('.');
			string value = ((num == -1) ? name : name.Substring(0, num));
			StringBuilder stringBuilder = new StringBuilder(relativeTo.FullName);
			while (true)
			{
				int num2 = stringBuilder.ToString().LastIndexOf(".");
				if (num2 == -1)
				{
					descriptor = FindSymbol<IDescriptor>(name);
					break;
				}
				stringBuilder.Length = num2 + 1;
				stringBuilder.Append(value);
				descriptor = FindSymbol<IDescriptor>(stringBuilder.ToString());
				if (descriptor != null)
				{
					if (num != -1)
					{
						stringBuilder.Length = num2 + 1;
						stringBuilder.Append(name);
						descriptor = FindSymbol<IDescriptor>(stringBuilder.ToString());
					}
					break;
				}
				stringBuilder.Length = num2;
			}
		}
		if (descriptor == null)
		{
			throw new DescriptorValidationException(relativeTo, "\"" + name + "\" is not defined.");
		}
		return descriptor;
	}
}
