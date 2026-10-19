using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class InventoryItem : MonoBehaviour
{
	public BImage ImageQuality;

	public Image ImageQualityBg;

	public TextMeshProUGUI TextProbabilityDes;

	public Transform TfInventoryDesItem;

	public GameObject TfInventoryItemPrefab;

	public GameObject GoTitle;

	public GameObject GoRule;

	public List<Sprite> QualityBgSprites;

	private void Start()
	{
	}

	public void Init(Gacha gacha, int id, ImageAssetStation station, bool isfirst, bool islast)
	{
		GachaPoolNotice data = CoreUtils.GetData(id, RuntimeConfigs.data.gachaPoolNotices);
		if (data != null)
		{
			station.LoadImage(176, data.quality, ImageQuality);
			IList<object> list = new List<object>();
			float baseRate = data.baseRate10000;
			string item = baseRate.ToString("0.000");
			baseRate = data.finalRate10000;
			string item2 = baseRate.ToString("0.000");
			list.Add(item);
			list.Add(item2);
			GoTitle.SetActive(isfirst);
			GoRule.SetActive(islast);
			ImageQualityBg.sprite = QualityBgSprites[data.quality - 1];
			TextProbabilityDes.text = LocalizationUtility.GetLocalizeString("Common", 2218, list);
			if (TfInventoryDesItem.childCount > 0)
			{
				TfInventoryDesItem.DestroyChildren();
			}
			for (int i = 0; i < data.gachaItemUpList.Count; i++)
			{
				UIUtility.AddWidget<InventoryDesItem>(TfInventoryDesItem, TfInventoryItemPrefab).Init(itemQuantity: GetGachaItem(gacha, data.quality, data.gachaItemUpList[i].id)?.itemQuantity ?? 1, item: data.gachaItemUpList[i]);
			}
		}
	}

	private GachaItem GetGachaItem(Gacha gacha, int quality, int itemId)
	{
		for (int i = 0; i < gacha.poolList.Length; i++)
		{
			GachaPool data = CoreUtils.GetData(gacha.poolList[i], RuntimeConfigs.data.gachaPools);
			if (data == null || data.quality != quality)
			{
				continue;
			}
			for (int j = 0; j < data.gachaItemIDs.Length; j++)
			{
				GachaItem data2 = CoreUtils.GetData(data.gachaItemIDs[j], RuntimeConfigs.data.gachaItems);
				if (data2 != null && data2.itemId == itemId)
				{
					return data2;
				}
			}
		}
		return null;
	}
}
