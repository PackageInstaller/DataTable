namespace System.Reflection;

internal struct MonoEventInfo
{
	public Type declaring_type;

	public Type reflected_type;

	public string name;

	public MethodInfo add_method;

	public MethodInfo remove_method;

	public MethodInfo raise_method;

	public EventAttributes attrs;

	public MethodInfo[] other_methods;
}
