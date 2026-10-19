using System;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class PlayerLevelGroup : MonoBehaviour
{
	[SerializeField]
	private BImage _img_Head;

	[SerializeField]
	private TextMeshProUGUI _playerName;

	[SerializeField]
	private TextMeshProUGUI _playerLevel;

	[SerializeField]
	private Slider _slider;

	[SerializeField]
	private TextMeshProUGUI _curExp;

	[SerializeField]
	private TextMeshProUGUI _xiegang;

	[SerializeField]
	private TextMeshProUGUI _maxExp;

	[SerializeField]
	private GameObject _expRoot;

	[SerializeField]
	private GameObject _maxExpRoot;

	public void Refresh()
	{
		_playerLevel.SetText("{0:0}", SystemUnlockManager.playerLevel);
		BriefUserInfo brief = G.detailUserInfo.Brief;
		if (brief == null)
		{
			_playerName.text = "本地游戏";
			_ = LuminApplication.LogEnabled;
			return;
		}
		_playerName.text = brief.Nickname;
		long num = G.detailUserInfo.Attributes[93];
		_curExp.SetText("{0:0}", num);
		try
		{
			this.GetImageStation().LoadSprite(GameLoader.meta.dramaAsideAtalasNameAssetID, RuntimeConfigs.data.MtyAvatars[G.localPlayer.Profile.EscInfo.CurAvatarId].iconID, _img_Head);
		}
		catch (Exception)
		{
			this.GetImageStation().LoadSprite(GameLoader.meta.dramaAsideAtalasNameAssetID, RuntimeConfigs.data.MtyAvatars[10001].iconID, _img_Head);
		}
		PlayerLevelData playerLevelData = RuntimeConfigs.data.playerLevelDatas[Mathf.Max(SystemUnlockManager.playerLevel, 1)];
		_maxExp.SetText("{0:0}", playerLevelData.xpEachLv);
		ColorUtility.TryParseHtmlString((num >= playerLevelData.xpEachLv) ? Model<WorldLevelModel>.Interface.GetTextColorString(WorldLevelColorEnum.BrightChartreuse) : Model<WorldLevelModel>.Interface.GetTextColorString(WorldLevelColorEnum.White), out var color);
		_curExp.color = color;
		float num2 = Mathf.Clamp01(1f * (float)num / (float)playerLevelData.xpEachLv);
		if (num2 > 0f && num2 < 1f)
		{
			num2 = Mathf.Clamp(num2, 0.01f, 0.99f);
		}
		_slider.value = num2;
		_expRoot.SetActive(SystemUnlockManager.playerLevel < RuntimeConfigs.data.game.playerMaxLevel);
		_maxExpRoot.SetActive(SystemUnlockManager.playerLevel >= RuntimeConfigs.data.game.playerMaxLevel);
	}
}
