namespace Sirenix.Utilities;

public class SirenixGlobalConfigAttribute : GlobalConfigAttribute
{
	public SirenixGlobalConfigAttribute()
		: base(SirenixAssetPaths.OdinResourcesConfigsPath)
	{
	}
}
