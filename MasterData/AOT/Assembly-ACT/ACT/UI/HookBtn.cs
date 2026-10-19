using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public class HookBtn : OperateBtn
{
	public new bool IsActive { get; private set; }

	public override void Init(OperateBtnData operateBtnData, CustomUITransform transform, ImageAssetStation imageStation)
	{
		base.Init(operateBtnData, transform, imageStation);
	}

	public void ChangeHookBtnSate(bool isActive)
	{
		IsActive = isActive;
		interactable = IsActive;
		SetDisableState(!IsActive);
	}

	protected override void SetDisableState(bool isDisable)
	{
		base.SetDisableState(isDisable);
		mainImage.icon.color = new Color(mainImage.icon.color.r, mainImage.icon.color.g, mainImage.icon.color.b, isDisable ? 0.4f : 1f);
		blackBoard.color = new Color(blackBoard.color.r, blackBoard.color.g, blackBoard.color.b, isDisable ? 0.4f : 1f);
	}

	public void SetGuideEffectActive(bool active)
	{
		guideeff?.SetActive(active);
	}
}
