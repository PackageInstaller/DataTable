using ACT.Config;
using ACT.Core;
using ACT.Game;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class MonoPopAdventureView : BaseUIView
{
	public bool isAdventure;

	[Header("世界等级")]
	public GameObject worldLevelPanel;

	public TextMeshProUGUI worldLevel;

	[Header("冒险等级")]
	public GameObject adventureLevelPanel;

	public TextMeshProUGUI adventureLevel;

	public TextMeshProUGUI currentExp;

	public TextMeshProUGUI maxExp;

	public TextMeshProUGUI addExp;

	public TouchUIMask expBar;

	private int m_SystemId;

	protected override void Init()
	{
		if (isAdventure)
		{
			int num = (int)uiViewData;
			adventureLevelPanel.SetActive(value: true);
			worldLevelPanel.SetActive(value: false);
			int playerLevel = SystemUnlockManager.playerLevel;
			PlayerLevelData playerLevelData = RuntimeConfigs.data.playerLevelDatas[playerLevel];
			long num2 = G.detailUserInfo.Attributes[93];
			adventureLevel.SetText("{0:0}", playerLevel);
			currentExp.text = num2.ToString();
			maxExp.SetText("{0:0}", playerLevelData.xpEachLv);
			expBar.value = (float)num2 / (float)playerLevelData.xpEachLv;
			addExp.SetText("{0:0}", num);
		}
		else
		{
			adventureLevelPanel.SetActive(value: false);
			worldLevelPanel.SetActive(value: true);
			worldLevel.SetText("{0:0}", SystemUnlockManager.worldLevel);
		}
	}

	public void AddExp(int exp)
	{
		addExp.SetText("{0:0}", exp);
	}
}
