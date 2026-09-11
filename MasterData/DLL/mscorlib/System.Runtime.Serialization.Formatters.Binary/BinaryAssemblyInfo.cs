using System.Reflection;

namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class BinaryAssemblyInfo
{
	internal string assemblyString;

	private Assembly assembly;

	internal BinaryAssemblyInfo(string assemblyString)
	{
		this.assemblyString = assemblyString;
	}

	internal BinaryAssemblyInfo(string assemblyString, Assembly assembly)
	{
		this.assemblyString = assemblyString;
		this.assembly = assembly;
	}

	internal Assembly GetAssembly()
	{
		if (assembly == null)
		{
			assembly = FormatterServices.LoadAssemblyFromStringNoThrow(assemblyString);
			if (assembly == null)
			{
				throw new SerializationException(Environment.GetResourceString("Unable to find assembly '{0}'.", assemblyString));
			}
		}
		return assembly;
	}
}
