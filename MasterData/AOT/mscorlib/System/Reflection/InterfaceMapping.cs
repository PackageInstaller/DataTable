namespace System.Reflection;

public struct InterfaceMapping
{
	public Type TargetType;

	public Type InterfaceType;

	public MethodInfo[] TargetMethods;

	public MethodInfo[] InterfaceMethods;
}
