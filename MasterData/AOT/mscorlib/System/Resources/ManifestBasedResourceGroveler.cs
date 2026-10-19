using System.Globalization;
using System.Reflection;

namespace System.Resources;

internal class ManifestBasedResourceGroveler : IResourceGroveler
{
	private ResourceManager.ResourceManagerMediator _mediator;

	public ManifestBasedResourceGroveler(ResourceManager.ResourceManagerMediator mediator)
	{
		_mediator = mediator;
	}

	internal static CultureInfo GetNeutralResourcesLanguage(Assembly a, ref UltimateResourceFallbackLocation fallbackLocation)
	{
		string cultureName = null;
		short fallbackLocation2 = 0;
		if (GetNeutralResourcesLanguageAttribute(a, ref cultureName, ref fallbackLocation2))
		{
			if (fallbackLocation2 < 0 || fallbackLocation2 > 1)
			{
				throw new ArgumentException(Environment.GetResourceString("The NeutralResourcesLanguageAttribute specifies an invalid or unrecognized ultimate resource fallback location: \"{0}\".", fallbackLocation2));
			}
			fallbackLocation = (UltimateResourceFallbackLocation)fallbackLocation2;
			try
			{
				return CultureInfo.GetCultureInfo(cultureName);
			}
			catch (ArgumentException innerException)
			{
				if (a == typeof(object).Assembly)
				{
					return CultureInfo.InvariantCulture;
				}
				throw new ArgumentException(Environment.GetResourceString("The NeutralResourcesLanguageAttribute on the assembly \"{0}\" specifies an invalid culture name: \"{1}\".", a.ToString(), cultureName), innerException);
			}
		}
		fallbackLocation = UltimateResourceFallbackLocation.MainAssembly;
		return CultureInfo.InvariantCulture;
	}

	private static bool GetNeutralResourcesLanguageAttribute(Assembly assembly, ref string cultureName, ref short fallbackLocation)
	{
		NeutralResourcesLanguageAttribute customAttribute = assembly.GetCustomAttribute<NeutralResourcesLanguageAttribute>();
		if (customAttribute == null)
		{
			return false;
		}
		cultureName = customAttribute.CultureName;
		fallbackLocation = (short)customAttribute.Location;
		return true;
	}
}
