using System;
using ACT.Core;
using Com.ForbiddenByte.OSA.Core;

namespace ACT.UI;

public class ChapterItemVH : BaseItemViewsHolder
{
	private SystemGuideChapterItem ChapterItem;

	private ActButton btn;

	private bool isDisabled;

	public override void CollectViews()
	{
		base.CollectViews();
		ChapterItem = root.GetComponent<SystemGuideChapterItem>();
		btn = root.GetComponent<ActButton>();
	}

	public void UpdateViews(ChapterViewBaseModel model)
	{
		isDisabled = model.IsDisabled;
		if (isDisabled)
		{
			ChapterItem.SetDisabled(disabled: true);
			return;
		}
		ChapterItem.SetDisabled(disabled: false);
		SetSelect(model.IsSelect);
		ChapterItem.SetLocalizationTxt(RuntimeConfigs.data.chapterIndexs[model.ChapterIndex].name);
	}

	public void SetSelect(bool select)
	{
		ChapterItem.SetActive(select);
	}

	public void BindClickAction(Action<ChapterItemVH> action)
	{
		if (btn == null || isDisabled)
		{
			btn.OnClick.RemoveAllListeners();
			return;
		}
		btn.OnClick.RemoveAllListeners();
		btn.OnClick.AddListener(() =>
		{
			action(this);
		});
	}
}
