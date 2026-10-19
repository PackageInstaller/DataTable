using ACT.UI;

namespace ACT;

public interface ISettingResolver
{
	void Init(string id, SettingCellBindings.DependsOn[] bindingDependsOnSettings);

	string GetSettingsId();
}
