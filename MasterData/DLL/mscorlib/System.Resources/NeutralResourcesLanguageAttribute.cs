namespace System.Resources;

[AttributeUsage(AttributeTargets.Assembly, AllowMultiple = false)]
public sealed class NeutralResourcesLanguageAttribute : Attribute
{
	public string CultureName { get; }

	public UltimateResourceFallbackLocation Location { get; }

	public NeutralResourcesLanguageAttribute(string cultureName)
	{
		if (cultureName == null)
		{
			throw new ArgumentNullException("cultureName");
		}
		CultureName = cultureName;
		Location = UltimateResourceFallbackLocation.MainAssembly;
	}
}
