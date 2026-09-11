namespace System.Reflection;

internal struct MonoPropertyInfo
{
	public Type parent;

	public Type declaring_type;

	public string name;

	public MethodInfo get_method;

	public MethodInfo set_method;

	public PropertyAttributes attrs;
}
