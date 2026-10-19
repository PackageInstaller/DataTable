using ACT.Config;
using ACT.Core;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;

public class MonthCardRewardItem : MonoBehaviour
{
	public BImage ItemIcon;

	public TextMeshProUGUI TextNum;

	private void Start()
	{
	}

	public void Init(int ItemId, int Num, ImageAssetStation station)
	{
		ItemData data = CoreUtils.GetData(ItemId, RuntimeConfigs.data.itemDatas);
		if (data != null)
		{
			station.LoadItemIcon(data.iconAddress, ItemIcon);
		}
		TextNum.SetText("x{0:0}", Num);
	}

	private void Update()
	{
	}
}
