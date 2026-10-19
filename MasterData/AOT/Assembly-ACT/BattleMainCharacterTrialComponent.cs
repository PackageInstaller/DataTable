using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

public class BattleMainCharacterTrialComponent : MonoBehaviour, IBattleMainComponent
{
	public Button CharacterTrialTips;

	public Button Character;

	public void Initialize(MonoBattleMainBaseView view)
	{
	}

	public void OpenComponent()
	{
		CharacterTrialTips.SetBtnClick(OpenCharacterTrialTips);
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}

	public void UnInitialize()
	{
	}

	private void OpenCharacterTrialTips()
	{
		Raid data = CoreUtils.GetData(Model<RaidModel>.Interface.CurrentRaidId, RuntimeConfigs.data.raids);
		if (data != null && data.tryRole != null && data.tryRole.Length != 0)
		{
			EntityCharacterProbation data2 = CoreUtils.GetData(data.tryRole[0], RuntimeConfigs.data.entityCharacterProbations);
			if (data2.isShow != 0)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERTRIALTIPS, new CharacterTrialTipsViewData
				{
					characterId = data2.id
				});
			}
		}
	}
}
