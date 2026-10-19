using ACT.Config;
using ACT.Core;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.UI;

namespace ACT.UI.CommonComponent;

public class CommonPriceComponent : ActButton
{
	public GameObject freeBackground;

	public GameObject cashBackground;

	public GameObject diamondBackground;

	public GameObject iconRoot;

	public BImage icon;

	public TMP_Text newPriceText;

	public TMP_Text oldPriceText;

	public RedDotItem redDot;

	private ImageAssetStation _station;

	public ImageAssetStation Station
	{
		get
		{
			return _station ?? (_station = GetComponentInParent<IBaseUIView>().Station);
		}
		set
		{
			_station = value;
		}
	}

	public void Init(int itemId, int newPrice, int oldPrice = -1)
	{
		if ((bool)freeBackground)
		{
			freeBackground.SetActive(value: false);
		}
		if ((bool)cashBackground)
		{
			cashBackground.SetActive(value: false);
		}
		if ((bool)diamondBackground)
		{
			diamondBackground.SetActive(value: true);
			targetGraphic = diamondBackground.GetComponent<Image>();
		}
		iconRoot.SetActive(value: true);
		ItemData data = CoreUtils.GetData(itemId, RuntimeConfigs.data.itemDatas);
		Station.LoadImage(165, data.iconAddress, icon);
		newPriceText.text = newPrice.FastToString();
		if (oldPrice > 0)
		{
			oldPriceText.text = oldPrice.FastToString();
			oldPriceText.fontStyle = FontStyles.Strikethrough;
			oldPriceText.gameObject.SetActive(value: true);
		}
		else
		{
			oldPriceText.gameObject.SetActive(value: false);
		}
	}

	public void Init(string newPrice, string oldPrice = null)
	{
		if ((bool)freeBackground)
		{
			freeBackground.SetActive(value: false);
		}
		if ((bool)cashBackground)
		{
			cashBackground.SetActive(value: true);
			targetGraphic = cashBackground.GetComponent<Image>();
		}
		if ((bool)diamondBackground)
		{
			diamondBackground.SetActive(value: false);
		}
		iconRoot.SetActive(value: false);
		newPriceText.text = newPrice;
		if (!string.IsNullOrEmpty(oldPrice))
		{
			oldPriceText.text = oldPrice;
			oldPriceText.fontStyle = FontStyles.Strikethrough;
			oldPriceText.gameObject.SetActive(value: true);
		}
		else
		{
			oldPriceText.gameObject.SetActive(value: false);
		}
	}

	public void Init()
	{
		if ((bool)freeBackground)
		{
			freeBackground.SetActive(value: true);
			targetGraphic = freeBackground.GetComponent<Image>();
		}
		if ((bool)cashBackground)
		{
			cashBackground.SetActive(value: false);
		}
		if ((bool)diamondBackground)
		{
			diamondBackground.SetActive(value: false);
		}
		iconRoot.SetActive(value: false);
		oldPriceText.gameObject.SetActive(value: false);
		newPriceText.text = LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.Free);
	}
}
