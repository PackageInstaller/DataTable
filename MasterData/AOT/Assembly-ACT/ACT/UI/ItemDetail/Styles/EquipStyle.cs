using System;
using System.Collections.Generic;
using Runtime.UI.CommonComponent;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI.ItemDetail.Styles;

[Serializable]
public class EquipStyle : UniqStyleBase
{
	[Header("Top")]
	public GemHoleItems gemHoles;

	[Header("Middle")]
	public PropertyStyle mainPropertyStyle;

	public PropertyStyle randomPropertyStyle1;

	public PropertyStyle randomPropertyStyle2;

	public EquipBuffDetail equipBuffDetail;

	public LocalizeStringEvent equipDescription;

	[Header("Bottom")]
	public CommonCharacterEquipComponent characterEquipComponent;

	private new Stack<ItemSource> _itemSourcePool;

	public override void Reset()
	{
		base.Reset();
		gemHoles.gameObject.SetActive(value: true);
	}

	public override void Release()
	{
		base.Release();
	}
}
