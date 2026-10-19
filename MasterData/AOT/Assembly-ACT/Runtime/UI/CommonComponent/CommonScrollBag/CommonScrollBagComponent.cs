using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.Linq;
using ACT;
using ACT.UI;
using ACT.UI.DataProxy;
using Fundamental;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.UI;

namespace Runtime.UI.CommonComponent.CommonScrollBag;

public class CommonScrollBagComponent : BaseUIComponent
{
	public enum SelectModeType
	{
		Single,
		SingleRepeat,
		MultipleUnique,
		MultipleRepeat
	}

	private static ObjectPool<ObservableCollection<ItemUnifierProxy>> m_ObservableCollectionPool = new ObjectPool<ObservableCollection<ItemUnifierProxy>>((ObservableCollection<ItemUnifierProxy> x) =>
	{
		x.Clear();
	}, null);

	private IEnumerable<ItemUnifierProxy> m_ItemSource;

	private ItemUIComponentBase.InitType m_ItemShowType = ItemUIComponentBase.InitType.BagItem;

	private ItemUIComponentBase.ItemCountShowType m_CountShowType = ItemUIComponentBase.ItemCountShowType.Both;

	private ObservableCollection<ItemUnifierProxy> m_SelectedModels = new ObservableCollection<ItemUnifierProxy>();

	private bool m_IsDirty;

	private bool m_ForbiddenSelectedChangeCallBack;

	private int m_DefaultScrollIndex = -1;

	private bool m_KeepScrollOffsetWhenJumpToIndex = true;

	private List<NotifyCollectionChangedEventArgs> m_TempSelectedModels;

	[Header("循环滚动窗口(LoopScrollRect)")]
	[SerializeField]
	private LoopScrollRect m_LoopScrollRect;

	[Header("动画配置")]
	public float delay;

	public IEnumerable<ItemUnifierProxy> ItemSource
	{
		get
		{
			return m_ItemSource;
		}
		set
		{
			m_ItemSource = value;
			m_IsDirty = true;
			if (value == null)
			{
				ResetToEmptyList();
			}
		}
	}

	public ItemUIComponentBase.InitType ItemShowType
	{
		get
		{
			return m_ItemShowType;
		}
		set
		{
			if (m_ItemShowType != value)
			{
				m_ItemShowType = value;
				m_IsDirty = true;
			}
		}
	}

	public bool ResetPositionAfterUpdate { get; set; }

	public ItemUIComponentBase.ItemCountShowType CountShowType
	{
		get
		{
			return m_CountShowType;
		}
		set
		{
			if (m_CountShowType != value)
			{
				m_CountShowType = value;
				m_IsDirty = true;
			}
		}
	}

	public ObservableCollection<ItemUnifierProxy> SelectedModels => m_SelectedModels;

	public SelectModeType SelectMode { get; set; }

	public Action<int> BeforeInstantiate { get; set; }

	public Action<ItemUIComponentBase> OnItemLoad { get; set; }

	public Action<ItemUIComponentBase> OnItemUnLoad { get; set; }

	public Action<ItemUIComponentBase> OnItemShow { get; set; }

	public Action<ItemUIComponentBase> OnItemSelect { get; set; }

	public Action<ItemUIComponentBase> OnItemUnSelect { get; set; }

	public string AnimName { get; set; } = "ItemShow";

	public Action OnUpdateEnd { get; set; }

	public void BindTemplate(GameObject template)
	{
		if (template == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("试图设置一个空的模板？");
			}
			return;
		}
		ActToggleGroup actToggleGroup = m_LoopScrollRect.content.GetComponent<ActToggleGroup>();
		if (!actToggleGroup)
		{
			actToggleGroup = m_LoopScrollRect.content.AddComponent<ActToggleGroup>();
		}
		ItemUIComponentBase componentInChildren = template.GetComponentInChildren<ItemUIComponentBase>();
		if ((bool)componentInChildren && !componentInChildren.Group)
		{
			componentInChildren.Group = actToggleGroup;
		}
		m_LoopScrollRect.item = template;
	}

	public void AddSelectedModelWithoutNotify(ItemUnifierProxy toAdd)
	{
		m_ForbiddenSelectedChangeCallBack = true;
		if (SelectMode == SelectModeType.MultipleRepeat)
		{
			m_SelectedModels.Add(toAdd);
		}
		else if (SelectMode == SelectModeType.SingleRepeat)
		{
			if (m_SelectedModels.Count > 0 && m_SelectedModels[0] != toAdd)
			{
				m_SelectedModels.Clear();
			}
			m_SelectedModels.Add(toAdd);
		}
		else if (!m_SelectedModels.Contains(toAdd))
		{
			m_SelectedModels.Add(toAdd);
		}
		m_ForbiddenSelectedChangeCallBack = false;
	}

	public void RemoveSelectedModelWithoutNotify(ItemUnifierProxy toRemove)
	{
		m_ForbiddenSelectedChangeCallBack = true;
		m_SelectedModels.Remove(toRemove);
		m_ForbiddenSelectedChangeCallBack = false;
	}

	public void ClearSelectedModelWithoutNotify()
	{
		m_ForbiddenSelectedChangeCallBack = true;
		m_SelectedModels.Clear();
		m_ForbiddenSelectedChangeCallBack = false;
	}

	public int GetSelectedCount(ItemUnifierProxy item)
	{
		int num = 0;
		foreach (ItemUnifierProxy selectedModel in m_SelectedModels)
		{
			if (selectedModel == item)
			{
				num++;
			}
		}
		return num;
	}

	public void ScrollToIndex(int index, bool keepOffset = true)
	{
		m_DefaultScrollIndex = index;
		m_KeepScrollOffsetWhenJumpToIndex = keepOffset;
		SetDirty();
	}

	public ItemUIComponentBase GetItem(int id)
	{
		return m_LoopScrollRect.GetItem(id) as ItemUIComponentBase;
	}

	public void RefreshDatas()
	{
		m_LoopScrollRect.RefreshCells();
	}

	public bool TryRefreshVisibleCellsInPlace()
	{
		if (!isActiveAndEnabled || m_ItemSource == null || m_TempSelectedModels == null)
		{
			return false;
		}
		if (m_LoopScrollRect.totalCount != m_ItemSource.Count())
		{
			return false;
		}
		m_LoopScrollRect.RefreshCells();
		m_IsDirty = false;
		foreach (NotifyCollectionChangedEventArgs tempSelectedModel in m_TempSelectedModels)
		{
			OnSelectedModelChanged(this, tempSelectedModel);
		}
		m_TempSelectedModels.Clear();
		OnUpdateEnd?.Invoke();
		return true;
	}

	public void ClearBag()
	{
		m_LoopScrollRect.ClearCells();
		SelectedModels?.Clear();
	}

	public void SetDirty()
	{
		m_IsDirty = true;
	}

	public void ForceUpdatePerformance()
	{
		UpdatePerformance();
		m_IsDirty = false;
		foreach (NotifyCollectionChangedEventArgs tempSelectedModel in m_TempSelectedModels)
		{
			OnSelectedModelChanged(this, tempSelectedModel);
		}
		m_TempSelectedModels.Clear();
		OnUpdateEnd?.Invoke();
	}

	private void ResetToEmptyList()
	{
		if (!(m_LoopScrollRect == null))
		{
			m_LoopScrollRect.StopMovement();
			m_LoopScrollRect.ClearCells();
		}
	}

	private void OnValidate()
	{
		if (m_LoopScrollRect == null)
		{
			m_LoopScrollRect = GetComponentInChildren<LoopScrollRect>();
		}
	}

	private void Awake()
	{
		m_TempSelectedModels = Fundamental.ListPool<NotifyCollectionChangedEventArgs>.Get();
		m_SelectedModels = m_ObservableCollectionPool.Get();
		m_SelectedModels.CollectionChanged += OnSelectedModelChanged;
		m_LoopScrollRect.OnItemShow.RemoveAllListeners();
		m_LoopScrollRect.OnItemShow.AddListener(SetItemContent);
		m_LoopScrollRect.OnItemLoad.RemoveAllListeners();
		m_LoopScrollRect.OnItemLoad.AddListener(OnItemLoadCallback);
		m_LoopScrollRect.OnItemUnload.RemoveAllListeners();
		m_LoopScrollRect.OnItemUnload.AddListener(OnItemUnLoadCallback);
		m_LoopScrollRect.BeforeItemGet.RemoveAllListeners();
		m_LoopScrollRect.BeforeItemGet.AddListener(OnTemplateApply);
	}

	protected override void OnUnityDestroy()
	{
		m_SelectedModels.CollectionChanged -= OnSelectedModelChanged;
		m_SelectedModels.Clear();
		m_LoopScrollRect.OnItemShow.RemoveListener(SetItemContent);
		m_LoopScrollRect.BeforeItemGet.RemoveListener(OnTemplateApply);
		m_LoopScrollRect.OnItemLoad.RemoveListener(OnItemLoadCallback);
		m_LoopScrollRect.OnItemUnload.RemoveListener(OnItemUnLoadCallback);
		m_ObservableCollectionPool.Release(m_SelectedModels);
		m_SelectedModels = null;
		Fundamental.ListPool<NotifyCollectionChangedEventArgs>.Release(m_TempSelectedModels);
	}

	private void OnSelectedModelChanged(object obj, NotifyCollectionChangedEventArgs args)
	{
		if (m_IsDirty)
		{
			m_TempSelectedModels.Add(args);
			return;
		}
		if (args.Action == NotifyCollectionChangedAction.Add)
		{
			foreach (ItemUnifierProxy newItem in args.NewItems)
			{
				if (newItem != null && newItem.Context is ItemUIComponentBase chosen)
				{
					if (m_ForbiddenSelectedChangeCallBack)
					{
						break;
					}
					OnItemChosen(chosen);
				}
			}
			return;
		}
		if (args.Action != NotifyCollectionChangedAction.Remove)
		{
			return;
		}
		foreach (ItemUnifierProxy oldItem in args.OldItems)
		{
			if (oldItem != null && oldItem.Context is ItemUIComponentBase chosen2)
			{
				if (m_ForbiddenSelectedChangeCallBack)
				{
					break;
				}
				OnInvertSelect(chosen2);
			}
		}
	}

	private void UpdatePerformance()
	{
		try
		{
			if (!gameObject)
			{
				return;
			}
			BindTemplate(m_LoopScrollRect.item);
			int num = m_ItemSource?.Count() ?? 0;
			m_LoopScrollRect.totalCount = num;
			if (m_SelectedModels == null || m_SelectedModels.Count == 0 || ResetPositionAfterUpdate || num == 0)
			{
				m_LoopScrollRect.RefillCells();
			}
			else
			{
				int startItem = m_LoopScrollRect.ItemIndexStart;
				if (m_DefaultScrollIndex >= 0)
				{
					startItem = Math.Clamp(m_DefaultScrollIndex, 0, m_LoopScrollRect.totalCount - 1);
				}
				float contentOffset = 0f;
				if (m_KeepScrollOffsetWhenJumpToIndex)
				{
					contentOffset = ((m_LoopScrollRect.Direction == LoopScrollRectBase.LoopScrollRectDirection.Horizontal) ? m_LoopScrollRect.content.anchoredPosition.x : m_LoopScrollRect.content.anchoredPosition.y);
				}
				m_LoopScrollRect.RefillCells(startItem, fillViewRect: false, contentOffset);
			}
			m_DefaultScrollIndex = -1;
			m_KeepScrollOffsetWhenJumpToIndex = true;
		}
		catch (Exception value)
		{
			m_DefaultScrollIndex = -1;
			m_KeepScrollOffsetWhenJumpToIndex = true;
			Console.WriteLine(value);
		}
	}

	private void Update()
	{
		if (!m_IsDirty)
		{
			return;
		}
		UpdatePerformance();
		m_IsDirty = false;
		foreach (NotifyCollectionChangedEventArgs tempSelectedModel in m_TempSelectedModels)
		{
			OnSelectedModelChanged(this, tempSelectedModel);
		}
		m_TempSelectedModels.Clear();
		OnUpdateEnd?.Invoke();
	}

	private void SetItemContent(ILoopScrollDataSource item)
	{
		if (!(item is ItemUIComponentBase { ItemUnifier: var itemUnifier } itemUIComponentBase))
		{
			return;
		}
		if (itemUnifier != null && itemUnifier.Context is ItemUIComponentBase)
		{
			itemUIComponentBase.ItemUnifier.Context = null;
			itemUIComponentBase.TransiteItemUnifier = null;
		}
		itemUIComponentBase.Station = Station;
		itemUIComponentBase.gameObject.SetActive(value: true);
		if (m_ItemSource == null)
		{
			itemUIComponentBase.SetData((ItemUnifierProxy)null, long.MinValue, ItemShowType, CountShowType, false);
			itemUIComponentBase.UpdatePerformance();
			return;
		}
		ItemUnifierProxy itemUnifierProxy = null;
		if (m_ItemSource is IList<ItemUnifierProxy> list)
		{
			int index = itemUIComponentBase.Index;
			if (index >= 0 && index < list.Count)
			{
				itemUnifierProxy = list[index];
			}
		}
		else
		{
			int num = 0;
			foreach (ItemUnifierProxy item2 in m_ItemSource)
			{
				if (itemUIComponentBase.Index == num++)
				{
					itemUnifierProxy = item2;
					break;
				}
			}
		}
		itemUIComponentBase.SetData(itemUnifierProxy, long.MinValue, ItemShowType, CountShowType);
		if (itemUnifierProxy != null)
		{
			itemUnifierProxy.Context = itemUIComponentBase;
		}
		itemUIComponentBase.RedPointPath = string.Empty;
		itemUIComponentBase.OnItemClick = OnItemChosen;
		itemUIComponentBase.OnInvertSelect = OnInvertSelect;
		itemUIComponentBase.UpdatePerformance();
		itemUIComponentBase.IsDisabled = false;
		itemUIComponentBase.IsChosen = false;
		itemUIComponentBase.IsHighLight = false;
		if (m_SelectedModels.Contains(itemUnifierProxy))
		{
			if (SelectMode == SelectModeType.Single || SelectMode == SelectModeType.SingleRepeat)
			{
				itemUIComponentBase.IsHighLight = true;
			}
			else
			{
				itemUIComponentBase.IsChosen = true;
			}
		}
		OnItemShow?.Invoke(itemUIComponentBase);
		if (!m_IsDirty || Mathf.Approximately(0f, delay))
		{
			return;
		}
		int num2 = itemUIComponentBase.Index / m_LoopScrollRect.contentConstraintCount - m_LoopScrollRect.StartLine;
		int num3 = itemUIComponentBase.Index % m_LoopScrollRect.contentConstraintCount;
		if (num2 >= 0)
		{
			if (itemUIComponentBase.TransiteItemUnifier != null)
			{
				itemUIComponentBase.PlayAnimation((float)(num3 + num2) * delay, itemUIComponentBase.AnimationName);
			}
			else
			{
				itemUIComponentBase.PlayAnimation((float)(num3 + num2) * delay, AnimName);
			}
		}
	}

	private void OnItemChosen(ItemUIComponentBase chosen)
	{
		if (chosen.IsDisabled)
		{
			try
			{
				OnItemSelect?.Invoke(chosen);
				return;
			}
			catch (Exception exception)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception);
				}
				return;
			}
		}
		switch (SelectMode)
		{
		case SelectModeType.Single:
		{
			Func<bool> canChosen2 = chosen.CanChosen;
			if (canChosen2 != null && !canChosen2())
			{
				break;
			}
			if (!m_SelectedModels.Contains(chosen.ItemUnifier))
			{
				m_ForbiddenSelectedChangeCallBack = true;
				m_SelectedModels.Add(chosen.ItemUnifier);
				while (m_SelectedModels.Count > 1)
				{
					ItemUnifierProxy item = m_SelectedModels.First();
					m_SelectedModels.Remove(item);
				}
				m_ForbiddenSelectedChangeCallBack = false;
			}
			try
			{
				OnItemSelect?.Invoke(chosen);
				chosen.IsHighLight = true;
				break;
			}
			catch (Exception exception3)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception3);
				}
				break;
			}
		}
		case SelectModeType.SingleRepeat:
		{
			Func<bool> canChosen3 = chosen.CanChosen;
			if (canChosen3 != null && !canChosen3())
			{
				break;
			}
			m_ForbiddenSelectedChangeCallBack = true;
			if (m_SelectedModels.Count > 0 && m_SelectedModels[0] != chosen.ItemUnifier)
			{
				m_SelectedModels.Clear();
			}
			m_SelectedModels.Add(chosen.ItemUnifier);
			m_ForbiddenSelectedChangeCallBack = false;
			try
			{
				OnItemSelect?.Invoke(chosen);
				chosen.IsHighLight = true;
				break;
			}
			catch (Exception exception4)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception4);
				}
				break;
			}
		}
		case SelectModeType.MultipleUnique:
		{
			Func<bool> canChosen4 = chosen.CanChosen;
			if (canChosen4 != null && !canChosen4())
			{
				break;
			}
			chosen.IsChosen = true;
			if (!m_SelectedModels.Contains(chosen.ItemUnifier))
			{
				m_ForbiddenSelectedChangeCallBack = true;
				m_SelectedModels.Add(chosen.ItemUnifier);
				m_ForbiddenSelectedChangeCallBack = false;
			}
			try
			{
				OnItemSelect?.Invoke(chosen);
				break;
			}
			catch (Exception exception5)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception5);
				}
				break;
			}
		}
		case SelectModeType.MultipleRepeat:
		{
			Func<bool> canChosen = chosen.CanChosen;
			if (canChosen != null && !canChosen())
			{
				break;
			}
			chosen.IsChosen = true;
			m_ForbiddenSelectedChangeCallBack = true;
			m_SelectedModels.Add(chosen.ItemUnifier);
			m_ForbiddenSelectedChangeCallBack = false;
			try
			{
				OnItemSelect?.Invoke(chosen);
				break;
			}
			catch (Exception exception2)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception2);
				}
				break;
			}
		}
		}
	}

	private void OnInvertSelect(ItemUIComponentBase chosen)
	{
		if (!chosen.IsChosen)
		{
			return;
		}
		m_ForbiddenSelectedChangeCallBack = true;
		m_SelectedModels.Remove(chosen.ItemUnifier);
		m_ForbiddenSelectedChangeCallBack = false;
		if (!m_SelectedModels.Contains(chosen.ItemUnifier))
		{
			chosen.IsChosen = false;
		}
		try
		{
			OnItemUnSelect?.Invoke(chosen);
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
	}

	private void OnTemplateApply(int index)
	{
		BeforeInstantiate?.Invoke(index);
	}

	private void OnItemLoadCallback(ILoopScrollDataSource item)
	{
		OnItemLoad?.Invoke((ItemUIComponentBase)item);
	}

	private void OnItemUnLoadCallback(ILoopScrollDataSource item)
	{
		OnItemUnLoad?.Invoke((ItemUIComponentBase)item);
	}
}
