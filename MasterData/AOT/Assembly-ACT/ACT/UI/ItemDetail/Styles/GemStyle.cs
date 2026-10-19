using System;
using Runtime.UI.CommonComponent;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI.ItemDetail.Styles;

[Serializable]
public class GemStyle : UniqStyleBase
{
	[Header("Middle")]
	public EquipBuffDetail gemBuffDetail;

	public LocalizeStringEvent gemDescription;

	[Header("Bottom")]
	public CommonCharacterEquipComponent characterEquipComponent;

	public override void Reset()
	{
		base.Reset();
	}

	public override void Release()
	{
		base.Release();
	}
}
