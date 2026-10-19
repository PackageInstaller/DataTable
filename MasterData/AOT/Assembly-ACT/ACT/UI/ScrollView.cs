using System;
using System.Collections.Generic;
using ACT.UI.CommonComponent.FancyScrollView.Core;
using ACT.UI.CommonComponent.FancyScrollView.Scroller;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.UI;

public class ScrollView : FancyScrollView<LevelNumData, Context>
{
	[SerializeField]
	private float selectTarDuration = 0.5f;

	[SerializeField]
	private Scroller scroller;

	[SerializeField]
	private GameObject cellPrefab;

	[SerializeField]
	private TextMeshProUGUI maxLevelText;

	[SerializeField]
	public UnityEvent<int> onComplete;

	[SerializeField]
	public UnityEvent onBeginDrag;

	[SerializeField]
	public UnityEvent onCellClick;

	private Action<int> onSelectionChanged;

	public int tarSelectedIndex => Context.SelectedIndex;

	protected override GameObject CellPrefab => cellPrefab;

	protected override void Initialize()
	{
		base.Initialize();
		Context.OnCellClicked = SelectCell;
		scroller.OnValueChanged(UpdatePosition);
		scroller.OnSelectionChanged(UpdateSelection);
		scroller.OnComplete(OnComplete);
		scroller.OnBeginDrag(OnBeginDrag);
	}

	private void UpdateSelection(int index)
	{
		if (Context.SelectedIndex != index)
		{
			Context.SelectedIndex = index;
			Refresh();
			onSelectionChanged?.Invoke(index);
		}
	}

	public void RefreshData()
	{
		Refresh();
	}

	public void UpdateData(IList<LevelNumData> items)
	{
		Context.TotalCount = items.Count;
		Context.ScrollDirection = scroller.ScrollDirection;
		UpdateContents(items);
		scroller.SetTotalCount(items.Count);
	}

	public void SetMinIndex(int index)
	{
		Context.MinIndex = index;
		scroller.SetMinIndex(index);
	}

	public void SetMaxLevel(int maxLevel)
	{
		Context.MaxLevel = maxLevel;
		if (maxLevelText != null)
		{
			maxLevelText.text = maxLevel.FastToString();
		}
	}

	public void SetContextMinIndex(int index)
	{
		Context.MinIndex = index;
	}

	public void SetScrollerMinIndex(int index)
	{
		scroller.SetMinIndex(index);
	}

	public void OnSelectionChanged(Action<int> callback)
	{
		onSelectionChanged = callback;
	}

	public void OnComplete()
	{
		onComplete?.Invoke(Context.SelectedIndex);
	}

	public void OnBeginDrag()
	{
		onBeginDrag?.Invoke();
	}

	public void SelectMax()
	{
		SelectCell(Context.TotalCount - 1);
	}

	public void SelectCell(int index)
	{
		SelectCell(index, selectTarDuration);
	}

	public void SelectCell(int index, float duration)
	{
		if (index >= 0 && index < ItemsSource.Count && index != Context.SelectedIndex)
		{
			UpdateSelection(index);
			scroller.ScrollTo(index, duration, Ease.OutCubic);
			onCellClick?.Invoke();
		}
	}

	public Cell GetSelectedCell()
	{
		return Context.CurrSelectedCell;
	}

	public void ResetData()
	{
		Context.SelectedIndex = -1;
		Context.TotalCount = -1;
		Context.MinIndex = -1;
		Context.CurrSelectedCell = null;
	}
}
