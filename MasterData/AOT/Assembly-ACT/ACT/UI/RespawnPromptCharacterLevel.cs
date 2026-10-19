using ACT.Battle;
using ACT.Core;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class RespawnPromptCharacterLevel : RespawnPromptCell
{
	[SerializeField]
	private TextMeshProUGUI _levelNum;

	protected override void UpdateContent()
	{
		base.UpdateContent();
		int characterLevel = CoreUtils.GetData(SystemUnlockManager.playerLevel, RuntimeConfigs.data.playerWorldLevelDatas).characterLevel;
		float charactersAverageLevel = MonoECS.instance.localPlayer.CurrentBattleTeam.GetCharactersAverageLevel();
		_levelNum.text = characterLevel.FastToString();
		UpdateSlider(charactersAverageLevel / (float)characterLevel);
	}
}
