using ACT.Battle;
using ACT.Core;

namespace ACT.UI;

public class RespawnPromptSkillLevel : RespawnPromptCell
{
	protected override void UpdateContent()
	{
		base.UpdateContent();
		int skillLevel = CoreUtils.GetData(SystemUnlockManager.playerLevel, RuntimeConfigs.data.playerWorldLevelDatas).skillLevel;
		float averageUsedSkillPoint = MonoECS.instance.localPlayer.CurrentBattleTeam.GetAverageUsedSkillPoint();
		UpdateSlider(averageUsedSkillPoint / (float)skillLevel);
	}
}
