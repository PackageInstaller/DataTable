using System;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI.ItemDetail.Styles;

[Serializable]
public class BloodBottleMaterialStyle : UniqStyleBase
{
	[Header("Middle")]
	public TMP_Text skillDes;

	public LocalizeStringEvent storyDes;

	[Header("Bottom")]
	public GameObject belongBottleRoot;

	public BImage belongBottleIcon;

	public LocalizeStringEvent belongBottleText;

	public bool extraWayActiveBelongBottleRoot { get; private set; } = true;

	public override void Reset()
	{
	}

	public override void Release()
	{
	}

	public void OtherWaySetBelongRootActive(Func<bool> extraParam)
	{
		extraWayActiveBelongBottleRoot = extraParam?.Invoke() ?? true;
	}
}
