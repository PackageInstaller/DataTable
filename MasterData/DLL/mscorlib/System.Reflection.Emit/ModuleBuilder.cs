namespace System.Reflection.Emit;

public class ModuleBuilder : Module
{
	public TypeBuilder DefineType(string name, TypeAttributes attr)
	{
		throw new PlatformNotSupportedException();
	}

	public TypeBuilder DefineType(string name, TypeAttributes attr, Type parent)
	{
		throw new PlatformNotSupportedException();
	}

	public TypeBuilder DefineType(string name, TypeAttributes attr, Type parent, Type[] interfaces)
	{
		throw new PlatformNotSupportedException();
	}
}
