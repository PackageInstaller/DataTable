namespace Sirenix.Utilities;

public class SirenixEditorConfigAttribute : GlobalConfigAttribute
{
	public SirenixEditorConfigAttribute()
		: base(SirenixAssetPaths.OdinEditorConfigsPath)
	{
	}
}
