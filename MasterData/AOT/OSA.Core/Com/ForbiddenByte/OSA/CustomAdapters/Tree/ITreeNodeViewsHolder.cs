using System;

namespace Com.ForbiddenByte.OSA.CustomAdapters.Tree;

public interface ITreeNodeViewsHolder
{
	int ItemIndex { get; }

	void UpdateViews(ITreeNodeModel model);

	void SetOnToggleFoldoutListener(Action<ITreeNodeViewsHolder> onFoldOutToggled);
}
