namespace System.Runtime.CompilerServices;

[Serializable]
[AttributeUsage(AttributeTargets.Assembly, AllowMultiple = true)]
public sealed class DependencyAttribute : Attribute
{
	private string dependentAssembly;

	private LoadHint loadHint;

	public DependencyAttribute(string dependentAssemblyArgument, LoadHint loadHintArgument)
	{
		dependentAssembly = dependentAssemblyArgument;
		loadHint = loadHintArgument;
	}
}
