namespace System.Runtime.CompilerServices;

[AttributeUsage(AttributeTargets.Assembly, AllowMultiple = true, Inherited = false)]
public sealed class InternalsVisibleToAttribute : Attribute
{
	private string _assemblyName;

	private bool _allInternalsVisible = true;

	public string AssemblyName => _assemblyName;

	public bool AllInternalsVisible
	{
		set
		{
			_allInternalsVisible = value;
		}
	}

	public InternalsVisibleToAttribute(string assemblyName)
	{
		_assemblyName = assemblyName;
	}
}
