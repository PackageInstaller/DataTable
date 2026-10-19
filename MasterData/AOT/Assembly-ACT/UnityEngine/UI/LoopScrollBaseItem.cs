using System;
using ACT.UI;
using UnityEngine.Events;

namespace UnityEngine.UI;

[RequireComponent(typeof(LayoutElement))]
public abstract class LoopScrollBaseItem : BaseUIComponent, ILoopScrollDataSource
{
	[NonSerialized]
	[Header("在列表中的索引")]
	public int index;

	[Header("滚动列表显示回调")]
	public UnityEvent<LoopScrollBaseItem> onBaseShow;

	[Header("滚动列表加载回调")]
	public UnityEvent<LoopScrollBaseItem> onBaseLoad;

	[Header("滚动列表卸载回调")]
	public UnityEvent<LoopScrollBaseItem> onBaseUnLoad;

	public virtual void Init(object param)
	{
	}

	public virtual void ScrollCellIndex(int idx)
	{
		index = idx;
		onBaseShow.Invoke(this);
	}

	public virtual void OnLoad(int idx)
	{
		index = idx;
		onBaseLoad.Invoke(this);
	}

	public void OnShow()
	{
		Show();
	}

	public void OnHide()
	{
		Hide();
	}

	public virtual void OnUnLoad()
	{
		onBaseUnLoad?.Invoke(this);
		Hide();
	}

	public virtual void Hide()
	{
		CanvasGroup component = GetComponent<CanvasGroup>();
		if ((bool)component)
		{
			component.alpha = 0f;
			component.interactable = false;
			component.blocksRaycasts = false;
			LayoutElement component2 = GetComponent<LayoutElement>();
			if ((bool)component2)
			{
				component2.ignoreLayout = true;
			}
		}
		else
		{
			gameObject.SetActive(value: false);
		}
	}

	public virtual void Show()
	{
		CanvasGroup component = GetComponent<CanvasGroup>();
		if ((bool)component)
		{
			component.alpha = 1f;
			component.interactable = true;
			component.blocksRaycasts = true;
			LayoutElement component2 = GetComponent<LayoutElement>();
			if ((bool)component2)
			{
				component2.ignoreLayout = false;
			}
			gameObject.SetActive(value: true);
		}
		else
		{
			gameObject.SetActive(value: true);
		}
	}

	public virtual void PlayCustomAnimation(float delaySecond = 0f)
	{
	}

	public int GetIndex()
	{
		return index;
	}
}
