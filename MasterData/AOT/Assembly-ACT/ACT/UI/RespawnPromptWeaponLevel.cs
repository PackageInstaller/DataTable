using ACT.Core;

namespace ACT.UI;

public class RespawnPromptWeaponLevel : RespawnPromptCell
{
	protected override void UpdateContent()
	{
		base.UpdateContent();
		_ = CoreUtils.GetData(SystemUnlockManager.playerLevel, RuntimeConfigs.data.playerWorldLevelDatas).weaponLevel;
	}
}
