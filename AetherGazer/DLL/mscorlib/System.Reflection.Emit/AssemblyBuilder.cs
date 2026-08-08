namespace System.Reflection.Emit;

public class AssemblyBuilder : Assembly
{
	public static AssemblyBuilder DefineDynamicAssembly(AssemblyName name, AssemblyBuilderAccess access)
	{
		throw new PlatformNotSupportedException();
	}

	public ModuleBuilder DefineDynamicModule(string name)
	{
		throw new PlatformNotSupportedException();
	}
}
