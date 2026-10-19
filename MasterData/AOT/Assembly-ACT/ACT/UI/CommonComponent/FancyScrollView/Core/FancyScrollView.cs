using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI.CommonComponent.FancyScrollView.Core;

public abstract class FancyScrollView<TItemData, TContext> : MonoBehaviour where TContext : class, new()
{
	[SerializeField]
	[Range(0.01f, 1f)]
	protected float cellInterval = 0.2f;

	[SerializeField]
	[Range(0f, 1f)]
	protected float scrollOffset = 0.5f;

	[SerializeField]
	protected bool loop;

	[SerializeField]
	protected Transform cellContainer;

	private readonly IList<FancyCell<TItemData, TContext>> pool = new List<FancyCell<TItemData, TContext>>();

	protected bool initialized;

	protected float currentPosition;

	protected abstract GameObject CellPrefab { get; }

	protected IList<TItemData> ItemsSource { get; set; } = new List<TItemData>();

	protected TContext Context { get; } = new TContext();

	protected virtual void Initialize()
	{
	}

	protected virtual void UpdateContents(IList<TItemData> itemsSource)
	{
		ItemsSource = itemsSource;
		Refresh();
	}

	protected virtual void Relayout()
	{
		UpdatePosition(currentPosition, forceRefresh: false);
	}

	protected virtual void Refresh()
	{
		UpdatePosition(currentPosition, forceRefresh: true);
	}

	protected virtual void UpdatePosition(float position)
	{
		UpdatePosition(position, forceRefresh: false);
	}

	private void UpdatePosition(float position, bool forceRefresh)
	{
		if (!initialized)
		{
			Initialize();
			initialized = true;
		}
		currentPosition = position;
		float num = position - scrollOffset / cellInterval;
		int firstIndex = Mathf.CeilToInt(num);
		float num2 = (Mathf.Ceil(num) - num) * cellInterval;
		if (num2 + (float)pool.Count * cellInterval < 1f)
		{
			ResizePool(num2);
		}
		UpdateCells(num2, firstIndex, forceRefresh);
	}

	private void ResizePool(float firstPosition)
	{
		int num = Mathf.CeilToInt((1f - firstPosition) / cellInterval) - pool.Count;
		for (int i = 0; i < num; i++)
		{
			FancyCell<TItemData, TContext> component = Object.Instantiate(CellPrefab, cellContainer).GetComponent<FancyCell<TItemData, TContext>>();
			if (component == null)
			{
				throw new MissingComponentException($"FancyCell<{typeof(TItemData).FullName}, {typeof(TContext).FullName}> component not found in {CellPrefab.name}.");
			}
			component.SetContext(Context);
			component.Initialize();
			component.SetVisible(visible: false);
			pool.Add(component);
		}
	}

	private void UpdateCells(float firstPosition, int firstIndex, bool forceRefresh)
	{
		for (int i = 0; i < pool.Count; i++)
		{
			int num = firstIndex + i;
			float num2 = firstPosition + (float)i * cellInterval;
			FancyCell<TItemData, TContext> fancyCell = pool[CircularIndex(num, pool.Count)];
			if (loop)
			{
				num = CircularIndex(num, ItemsSource.Count);
			}
			if (num < 0 || num >= ItemsSource.Count || num2 > 1f)
			{
				fancyCell.SetVisible(visible: false);
				continue;
			}
			if (forceRefresh || fancyCell.Index != num || !fancyCell.IsVisible)
			{
				fancyCell.Index = num;
				fancyCell.SetVisible(visible: true);
				fancyCell.UpdateContent(ItemsSource[num]);
			}
			fancyCell.UpdatePosition(num2);
		}
	}

	private int CircularIndex(int i, int size)
	{
		if (size >= 1)
		{
			if (i >= 0)
			{
				return i % size;
			}
			return size - 1 + (i + 1) % size;
		}
		return 0;
	}
}
public abstract class FancyScrollView<TItemData> : FancyScrollView<TItemData, NullContext>
{
}
