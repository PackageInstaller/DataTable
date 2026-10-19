using System;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine.Localization.Components;

namespace ACT.UI.ItemDetail.Styles;

[Serializable]
public struct PropertyStyle
{
	public BImage icon;

	public LocalizeStringEvent propertyName;

	public TMP_Text number;
}
