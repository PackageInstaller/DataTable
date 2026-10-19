using System;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI.ItemDetail.Styles;

[Serializable]
public class GiftPackageStyle : UniqStyleBase
{
	[Header("Middle")]
	public LocalizeStringEvent giftPackageItemDes;

	public LocalizeStringEvent giftRewardDes;

	[Header("Buttom")]
	public GameObject openConditionRoot;

	public TextMeshProUGUI openCondition;
}
