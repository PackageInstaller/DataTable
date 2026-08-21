using TMPro;
using UnityEngine;

namespace Ase;

public class TeachGuideFrameFixedDesView : TeachGuideFrameBaseView
{
	public Animator FrameAnimator;

	public TextMeshProUGUI FrameDes1;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
	}

	protected override void ShowFrame()
	{
		base.ShowFrame();
		FrameAnimator.Play("Effect_Battle_Tips_Enter");
		if (_viewModel.TeachConfig.FinishCondition == 2)
		{
			BgEmptyBtn.interactable = true;
			CustomUIMask.raycastTarget = false;
			((TMP_Text)FrameDes1).text = "点击【屏幕任意处】进行下一步";
		}
		else if (_viewModel.TeachConfig.FinishCondition == 1)
		{
			((TMP_Text)FrameDes1).text = "点击【框选区域】进行下一步";
		}
		((Component)(object)FrameDes1).gameObject.SetActive(_viewModel.TeachConfig.TeachingType != 1 || _viewModel.TeachConfig.Pause);
	}

	protected override void FindTragetUI(ref RectTransform targetUI)
	{
		if (UIWindowHelper.UIControls.ContainsKey(_viewModel.TeachConfig.SelectUI))
		{
			targetUI = UIWindowHelper.UIControls[_viewModel.TeachConfig.SelectUI];
		}
	}

	protected override void HideFrameUI()
	{
		base.HideFrameUI();
		FrameAnimator.Play("Effect_Battle_Tips_Exit");
	}
}
