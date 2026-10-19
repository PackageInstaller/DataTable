using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Define;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;

public class RogueSettlementItem : MonoBehaviour
{
	public GameObject GoItem;

	public BImage ImageQua;

	public BImage ImageItemIcon;

	public TextMeshProUGUI Name;

	public int Itemid;

	public List<Sprite> Qualitys = new List<Sprite>();

	private void Awake()
	{
	}

	private void OnDestroy()
	{
	}

	private void Start()
	{
	}

	private void Update()
	{
	}

	public void Init(int id, RogueItemType type, ImageAssetStation station = null)
	{
		Itemid = id;
		GoItem.SetActive(id != 0);
		RogueElement data = CoreUtils.GetData(id, RuntimeConfigs.data.rogueElements);
		switch (type)
		{
		case RogueItemType.Prop:
		{
			RogueItem data3 = CoreUtils.GetData(id, RuntimeConfigs.data.rogueItems);
			ImageQua.icon.sprite = Qualitys[data3.rarity - 1];
			break;
		}
		case RogueItemType.Bloodbottle:
		{
			RogueHealthPotion data2 = CoreUtils.GetData(id, RuntimeConfigs.data.rogueHealthPotions);
			ImageQua.icon.sprite = Qualitys[data2.rarity - 1];
			break;
		}
		case RogueItemType.AssistCharacter:
			CoreUtils.GetData(id, RuntimeConfigs.data.rogueAssistCharacters);
			break;
		}
		Name.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data.name);
		station.LoadImage(188, data.iconAddress, ImageItemIcon);
		ImageQua.icon.gameObject.SetActive(type == RogueItemType.Prop || type == RogueItemType.Bloodbottle);
	}
}
