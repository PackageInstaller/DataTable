using UnityEngine;

namespace Ase;

public class TeachGuideFrameFollowDesView : TeachGuideFrameBaseView
{
	[SerializeField]
	private RectTransform entityTragetUI;

	[SerializeField]
	private RectTransform followTextRect;

	protected override void FindTragetUI(ref RectTransform targetUI)
	{
		base.FindTragetUI(ref targetUI);
		if (_viewModel.TeachConfig.TeachingType == 3)
		{
			if (_viewModel.TeachConfig.FrameTarget == 2 || _viewModel.TeachConfig.FrameTarget == 3)
			{
				Vector3 frameEntityPos = _viewModel.GetFrameEntityPos(_viewModel.TeachConfig.FrameTarget);
				Vector2 vector = default(Vector2);
				RectTransformUtility.ScreenPointToLocalPointInRectangle((RectTransform)entityTragetUI.parent, (Vector2)frameEntityPos, UIUtilly.GetUICamera(), ref vector);
				entityTragetUI.localPosition = vector;
				targetUI = entityTragetUI;
			}
			else if (_viewModel.TeachConfig.FrameTarget == 1 && UIWindowHelper.UIControls.ContainsKey(_viewModel.TeachConfig.SelectUI))
			{
				targetUI = UIWindowHelper.UIControls[_viewModel.TeachConfig.SelectUI];
			}
		}
	}

	protected override void ShowFrame()
	{
		base.ShowFrame();
		entityTragetUI.localPosition = FrameImage.transform.localPosition;
		SetFollowTextPos(entityTragetUI);
	}

	private void SetFollowTextPos(RectTransform targetUIRect)
	{
		if (!(followTextRect == null))
		{
			followTextRect.position = targetUIRect.position;
			Vector2 vector = _viewModel.TeachConfig.FrameSize.ToVector2();
			if (_viewModel.TeachConfig.FrameTargetDir == 1)
			{
				followTextRect.anchoredPosition += new Vector2(0f, vector.y / 2f + followTextRect.rect.height / 2f);
			}
			else if (_viewModel.TeachConfig.FrameTargetDir == 2)
			{
				followTextRect.anchoredPosition += new Vector2(vector.x / 2f + followTextRect.rect.width / 2f, 0f);
			}
			else if (_viewModel.TeachConfig.FrameTargetDir == 3)
			{
				followTextRect.anchoredPosition -= new Vector2(0f, vector.y / 2f + followTextRect.rect.height / 2f);
			}
			else if (_viewModel.TeachConfig.FrameTargetDir == 4)
			{
				followTextRect.anchoredPosition -= new Vector2(vector.x / 2f + followTextRect.rect.width / 2f, 0f);
			}
			followTextRect.anchoredPosition += _viewModel.TeachConfig.FrameTargetOffset.ToVector2();
			Rect rect = followTextRect.rect;
			Vector2 size = rect.size;
			Vector2 vector2 = rect.center + (Vector2)followTextRect.position;
			float num = vector2.x - size.x / 2f;
			float num2 = vector2.x + size.x / 2f;
			if (num < 0f)
			{
				followTextRect.anchoredPosition += new Vector2(0f - num, 0f);
			}
			if (num2 > (float)Screen.width)
			{
				followTextRect.anchoredPosition += new Vector2(num2 - (float)Screen.width, 0f);
			}
		}
	}

	protected override void HideFrameUI()
	{
		base.HideFrameUI();
		followTextRect.position = VectorExtensions.ScreenOutPos;
	}
}
