using System.Linq;
using ACT.Core;
using ACT.Game.Data;
using ACT.UI;
using ACT.Utility;
using Fundamental;

namespace ACT.Config.Condition;

public class CheckAnyCharacterUpgradeTalentSkill : GuideStepCondition
{
	public override bool CheckCondition()
	{
		IBaseUIController topActivePanel = Singleton<NewUIManager>.instance.GetTopActivePanel();
		if (topActivePanel == null || topActivePanel.UIType != UI_TYPE.UI_CHARACTER)
		{
			return false;
		}
		CharacterView characterView = topActivePanel.GetUIView() as CharacterView;
		if (characterView == null)
		{
			return false;
		}
		Character currentSelectCharacter = characterView.CurrentSelectCharacter;
		if (currentSelectCharacter == null)
		{
			return false;
		}
		if (currentSelectCharacter.Level >= 10)
		{
			return CanUpgradeTalentSkill(currentSelectCharacter);
		}
		return false;
	}

	private bool CanUpgradeTalentSkill(Character character)
	{
		int num = CoreUtils.GetData(character.Id, RuntimeConfigs.data.entityCharacterDatas).skillGroupIds.Where((int x) =>
		{
			SkillGroupData data2 = CoreUtils.GetData(x, RuntimeConfigs.data.skillGroupDatas);
			if (data2 == null || data2.skillType != 12)
			{
				return false;
			}
			return CoreUtils.GetData(TableRule.GetSkillGroupLevelId(x, 1), RuntimeConfigs.data.skillGroupLevelDatas).requireCharacterLevel == 10;
		}).FirstOrDefault();
		if (character.SkillGroupLevels.ContainsKey(num))
		{
			return false;
		}
		SkillGroupLevelData data = CoreUtils.GetData(TableRule.GetSkillGroupLevelId(num, 1), RuntimeConfigs.data.skillGroupLevelDatas);
		if (data == null)
		{
			return false;
		}
		return GameUtility.ItemsIsEnough(data.cost);
	}
}
