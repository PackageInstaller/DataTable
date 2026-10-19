using System;
using ACT.ViewControl;
using UnityEngine.Localization.Components;

namespace ACT.UI.ItemDetail.Styles;

[Serializable]
public class ItemStyle : UniqStyleBase
{
	public LocalizeStringEvent itemFunctionDescription;

	public LocalizeStringEvent itemDescription;

	public OperateBtnPrompt operateBtnPrompt;

	public ViewControlLayer jumpLayer;

	public override void Reset()
	{
		base.Reset();
	}

	public override void Release()
	{
		base.Release();
	}
}
