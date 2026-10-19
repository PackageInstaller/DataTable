using System;
using Com.ForbiddenByte.OSA.Core;
using UnityEngine.UI;

namespace ACT.UI;

public class BookLevelHolder : BaseItemViewsHolder
{
	public BookLevelRewardItem levelRewardItem;

	private ContentSizeFitter ContentSizeFitter { get; set; }

	public override void CollectViews()
	{
		ContentSizeFitter = root.GetComponent<ContentSizeFitter>();
		levelRewardItem = root.GetComponent<BookLevelRewardItem>();
	}

	public void UpdateView(BookLevelModel model)
	{
		levelRewardItem.Init(model);
	}

	public override void MarkForRebuild()
	{
		base.MarkForRebuild();
		if ((bool)ContentSizeFitter)
		{
			ContentSizeFitter.enabled = true;
		}
	}

	public override void UnmarkForRebuild()
	{
		if ((bool)ContentSizeFitter)
		{
			ContentSizeFitter.enabled = false;
		}
		base.UnmarkForRebuild();
	}

	public void BindClickAction(Action<BookLevelHolder> action)
	{
		levelRewardItem.btn.OnClick.RemoveAllListeners();
		levelRewardItem.btn.OnClick.AddListener(() =>
		{
			action(this);
		});
	}

	public void BindSelectionAction(Action<BookLevelHolder> action)
	{
		levelRewardItem.select.OnClick.RemoveAllListeners();
		levelRewardItem.select.OnClick.AddListener(() =>
		{
			action(this);
		});
	}
}
