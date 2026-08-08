using System;
using System.Reflection;
using System.Reflection.Emit;

namespace MessagePack.Internal;

internal class DynamicAssembly
{
	private readonly AssemblyBuilder assemblyBuilder;

	private readonly ModuleBuilder moduleBuilder;

	public DynamicAssembly(string moduleName)
	{
		AssemblyBuilderAccess access = AssemblyBuilderAccess.Run;
		assemblyBuilder = AssemblyBuilder.DefineDynamicAssembly(new AssemblyName(moduleName), access);
		moduleBuilder = assemblyBuilder.DefineDynamicModule(moduleName + ".dll");
	}

	public TypeBuilder DefineType(string name, TypeAttributes attr)
	{
		return moduleBuilder.DefineType(name, attr);
	}

	public TypeBuilder DefineType(string name, TypeAttributes attr, Type parent)
	{
		return moduleBuilder.DefineType(name, attr, parent);
	}

	public TypeBuilder DefineType(string name, TypeAttributes attr, Type parent, Type[] interfaces)
	{
		return moduleBuilder.DefineType(name, attr, parent, interfaces);
	}
}
