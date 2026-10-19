using System;
using System.Collections.Generic;
using ACT.Core;
using ACT.Game;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class ElitePointComp : MonoBehaviour
{
	[SerializeField]
	private ActButton btn;

	[SerializeField]
	private PublicToggle unlockToggle;

	[SerializeField]
	private TextMeshProUGUI levelText;

	[SerializeField]
	private TextMeshProUGUI maxLevelText;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private BImage enabledIcon;

	[SerializeField]
	private RectTransform disabledRoot;

	[SerializeField]
	private RectTransform disabledIconRoot;

	[SerializeField]
	private BImage disabledIcon;

	[SerializeField]
	private RectTransform disabledIcon2Root;

	[SerializeField]
	private BImage disabledIcon2;

	[SerializeField]
	private Image iconColor;

	[SerializeField]
	private CanvasGroup _canvasGroup;

	[SerializeField]
	private List<GameObject> colorBgList;

	private int _elitePointId;

	private int _curLevel;

	private int _maxLevel;

	private int _colorIndex;

	private int _stage;

	private int _index;

	private ImageAssetStation m_ImageAssetStation;

	private GameObject m_levelUpPrefab;

	private ElitePointGroup.ElitePointGroupData m_ElitePointGroupData;

	public void SetData(int elitePointId, int curLevel, ElitePointGroup.ElitePointGroupData data, int colorIndex, Action<int> onSelectPoint)
	{
		_elitePointId = elitePointId;
		_curLevel = curLevel;
		_maxLevel = data.MaxLevel;
		_colorIndex = colorIndex;
		_stage = data.curStage;
		m_ElitePointGroupData = data;
		Color color = ColorParseUtility.HexToColor(RuntimeConfigs.data.elementConfigs[colorIndex].elementColour);
		iconColor.color = color;
		if (colorBgList != null && colorBgList.Count > 0)
		{
			for (int i = 0; i < colorBgList.Count; i++)
			{
				colorBgList[i].SetActive((i == colorIndex - 1) ? true : false);
				if (i == colorIndex - 1)
				{
					colorBgList[i].transform.GetChild(0).gameObject.SetActive(curLevel >= 1);
					m_levelUpPrefab = colorBgList[i].transform.GetChild(1).Find("levelup_glow").gameObject;
					SetGlowActive(data, curLevel);
					levelText.text = ((curLevel < 1) ? "" : curLevel.ToString());
				}
			}
		}
		btn.OnClick.RemoveAllListeners();
		btn.OnClick.AddListener(() =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/Property");
			onSelectPoint?.Invoke(_elitePointId);
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPELITELEVELUPNEW, new PopupEliteLevelUpNewViewData
			{
				elitePointId = _elitePointId,
				character = m_ElitePointGroupData.character,
				isTalentPoint = false
			});
		});
		unlockToggle.isOn = true;
		_canvasGroup.alpha = 1f;
	}

	private void SetGlowActive(ElitePointGroup.ElitePointGroupData data, int curLevel)
	{
		if (data != null)
		{
			int itemCount = G.localPlayer.Inventory.GetItemCount(data.character.GetGenericCharacterEliteItem());
			int characterEliteItem = data.character.GetCharacterEliteItem();
			int itemCount2 = G.localPlayer.Inventory.GetItemCount(characterEliteItem);
			int num = data.character.GetCostTokenNumPerLevel()[0];
			m_levelUpPrefab?.SetActive(num <= itemCount2 + itemCount && curLevel < 1);
		}
	}

	public void Init(int elitePointId, ElitePointGroup.ElitePointGroupData data, int index)
	{
		_index = index;
		unlockToggle.isOn = false;
		selected.SetActive(value: false);
		m_levelUpPrefab?.SetActive(value: false);
		_canvasGroup.alpha = 1f;
		int uIName = RuntimeConfigs.data.eliteTrainingPoints[elitePointId].UIName;
		data.m_ImageAssetStation.LoadImage(151, uIName, enabledIcon);
		data.m_ImageAssetStation.LoadImage(151, uIName, disabledIcon);
		int stage = index / 3;
		int activeLevel = ElitePointGroup.GetEliteTalentActiveLevel(stage);
		btn.OnClick.RemoveAllListeners();
		btn.OnClick.AddListener(() =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/Property_Gray");
			GameUtility.OpenToolTip(1791, "Common", new List<string> { activeLevel.ToString() });
		});
	}

	public void RefreshSelect(int pointId)
	{
		selected.SetActive(pointId == _elitePointId);
		SetGlowActive(m_ElitePointGroupData, _curLevel);
	}

	public int GetIndex()
	{
		return _index;
	}
}
