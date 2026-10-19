using ACT.Config;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;

namespace ACT;

public class AttributeTab : MonoBehaviour
{
	private ImageAssetStation _imageStation;

	[SerializeField]
	private BImage Icon;

	[SerializeField]
	private TextMeshProUGUI AttributeName;

	[SerializeField]
	private TextMeshProUGUI AttributeNum;

	private void Start()
	{
	}

	public void UpdateTabView(PropertyData propertyData, float value)
	{
		_imageStation = ImageManager.instance.GetAssetStation();
		_imageStation.LoadImage(146, propertyData.icon, Icon);
		AttributeName.SetText(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, propertyData.descLocal));
		string text = value.FastToString(propertyData.judge ? 1 : 0, propertyData.judge);
		if (text.Equals("0.0%"))
		{
			text = "0%";
		}
		AttributeNum.SetText(text);
	}
}
