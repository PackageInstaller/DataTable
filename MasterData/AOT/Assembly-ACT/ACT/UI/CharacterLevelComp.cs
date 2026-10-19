using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class CharacterLevelComp : MonoBehaviour
{
	[SerializeReference]
	private TextMeshProUGUI levelText;

	[SerializeReference]
	private TextMeshProUGUI maxLevelText;

	[SerializeReference]
	private GameObject levelUp;

	[SerializeReference]
	private GameObject levelMax;

	public void Init(int characterId)
	{
		Character character = G.localPlayer.GetCharacter(characterId);
		levelText.text = character.Level.ToString();
		maxLevelText.text = CoreUtils.GetData(SystemUnlockManager.playerLevel, RuntimeConfigs.data.playerLevelDatas).characterLevel.FastToString();
		InitLevelUp(character);
	}

	private void InitLevelUp(Character character)
	{
		int level = character.Level;
		int characterLevel = CoreUtils.GetData(SystemUnlockManager.playerLevel, RuntimeConfigs.data.playerLevelDatas).characterLevel;
		levelUp.SetActive(level < characterLevel);
		levelMax.SetActive(level >= characterLevel);
	}
}
