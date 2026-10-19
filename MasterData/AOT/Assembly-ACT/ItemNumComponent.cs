using ACT.Config;
using ACT.Core;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;

public class ItemNumComponent : MonoBehaviour
{
	public TextMeshProUGUI numText;

	public BImage icon;

	public Color numColor;

	public void Init(int id, int num)
	{
		if (!gameObject.activeSelf)
		{
			gameObject.SetActive(value: true);
		}
		ItemData data = CoreUtils.GetData(id, RuntimeConfigs.data.itemDatas);
		this.GetImageStation().LoadItemIcon(data.iconAddress, icon);
		numText.text = num.FastToString();
		numText.color = numColor;
	}
}
