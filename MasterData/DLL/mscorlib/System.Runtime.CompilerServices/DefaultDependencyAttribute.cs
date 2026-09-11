namespace System.Runtime.CompilerServices;

[Serializable]
[AttributeUsage(AttributeTargets.Assembly)]
public sealed class DefaultDependencyAttribute : Attribute
{
	private LoadHint loadHint;

	public DefaultDependencyAttribute(LoadHint loadHintArgument)
	{
		loadHint = loadHintArgument;
	}
}
