using UnityEngine;
using UnityEngine.UI;

namespace Com.ForbiddenByte.OSA.Core;

public abstract class AbstractViewsHolder
{
	public RectTransform root;

	public virtual int ItemIndex { get; set; }

	public void Init(RectTransform rootPrefab, RectTransform parent, int itemIndex, bool activateRootGameObject = true, bool callCollectViews = true)
	{
		Init(rootPrefab.gameObject, parent, itemIndex, activateRootGameObject, callCollectViews);
	}

	public void Init(GameObject rootPrefabGO, RectTransform parent, int itemIndex, bool activateRootGameObject = true, bool callCollectViews = true, bool worldPositionStays = false)
	{
		GameObject gameObject = Object.Instantiate(rootPrefabGO, parent, worldPositionStays);
		root = gameObject.transform as RectTransform;
		OnRootCreated(itemIndex, activateRootGameObject, callCollectViews);
	}

	public void InitWithExistingRoot(RectTransform existingRoot, RectTransform parent, int itemIndex, bool activateRootGameObject = true, bool callCollectViews = true)
	{
		if (existingRoot.parent != parent)
		{
			existingRoot.SetParent(parent, worldPositionStays: false);
		}
		root = existingRoot;
		OnRootCreated(itemIndex, activateRootGameObject, callCollectViews);
	}

	public virtual void CollectViews()
	{
	}

	public virtual void MarkForRebuild()
	{
		if ((bool)root)
		{
			LayoutRebuilder.MarkLayoutForRebuild(root);
		}
	}

	public virtual void UnmarkForRebuild()
	{
	}

	public virtual void ShiftIndex(int shift, int modulo)
	{
		ItemIndex = ShiftIntWithOverflowCheck(ItemIndex, shift, modulo);
	}

	public virtual void OnBeforeRecycleOrDisable(int newItemIndex)
	{
	}

	public virtual void OnBeforeDestroy()
	{
	}

	protected virtual void OnRootCreated(int itemIndex, bool activateRootGameObject = true, bool callCollectViews = true)
	{
		if (activateRootGameObject)
		{
			root.gameObject.SetActive(value: true);
		}
		ItemIndex = itemIndex;
		if (callCollectViews)
		{
			CollectViews();
		}
	}

	protected int ShiftIntWithOverflowCheck(int value, int shift, int modulo)
	{
		return (int)(((long)value + (long)shift + modulo) % modulo);
	}
}
