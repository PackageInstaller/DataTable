using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PropertyDetailWindow : UGuiWindow
{
	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private GameObject propItemTpl;

	[SerializeField]
	private RectTransform rootParent;

	[SerializeField]
	private RectTransform primeParent;

	[SerializeField]
	private RectTransform advancedParent;

	[SerializeField]
	private RectTransform passiveParent;

	[SerializeField]
	private LoopListView2 entryScrollView;

	[SerializeField]
	private Transform entryInfoShowPos;

	private CanvasGroup _canvasGroup;

	private List<PropertyItem> _primeItemList;

	private List<PropertyItem> _advancedItemList;

	private List<PropertyItem> _passiveItemList;

	private PropertyDetailViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<PropertyDetailViewModel>();
		_viewModel.SetEntryShowPos(entryInfoShowPos.position);
		BindingSet<PropertyDetailWindow, PropertyDetailViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((PropertyDetailWindow v) => v.OpenUguiWindow).To((PropertyDetailViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Build();
		_canvasGroup = base.transform.GetComponent<CanvasGroup>();
		_primeItemList = new List<PropertyItem>();
		_advancedItemList = new List<PropertyItem>();
		_passiveItemList = new List<PropertyItem>();
		backBtn.onClick.AddListener(delegate
		{
			Dismiss();
		});
		entryScrollView.InitListView((_viewModel.Entries != null) ? _viewModel.Entries.Count : 0, OnGetItemByIndex);
		RefreshProperty();
		RefreshEntryScrollView();
	}

	private void RefreshProperty()
	{
		if (_viewModel.PrimeProps != null)
		{
			for (int i = 0; i < _viewModel.PrimeProps.Count; i++)
			{
				if (_primeItemList.Count <= i)
				{
					PropertyItem component = Object.Instantiate(propItemTpl, primeParent).transform.GetComponent<PropertyItem>();
					component.Init(_viewModel.PrimeProps[i]);
					_primeItemList.Add(component);
				}
				else
				{
					_primeItemList[i].RefreshData(_viewModel.PrimeProps[i]);
				}
				_primeItemList[i].Visibility = true;
			}
			if (_primeItemList.Count > _viewModel.PrimeProps.Count)
			{
				for (int j = _viewModel.PrimeProps.Count; j < _primeItemList.Count; j++)
				{
					_primeItemList[j].Visibility = false;
				}
			}
			primeParent.gameObject.SetActive(value: true);
		}
		else
		{
			primeParent.gameObject.SetActive(value: false);
		}
		if (_viewModel.AdvanceProps != null)
		{
			for (int k = 0; k < _viewModel.AdvanceProps.Count; k++)
			{
				if (_advancedItemList.Count <= k)
				{
					PropertyItem component2 = Object.Instantiate(propItemTpl, advancedParent).transform.GetComponent<PropertyItem>();
					component2.Init(_viewModel.AdvanceProps[k]);
					_advancedItemList.Add(component2);
				}
				else
				{
					_advancedItemList[k].RefreshData(_viewModel.AdvanceProps[k]);
				}
				_advancedItemList[k].Visibility = true;
			}
			if (_advancedItemList.Count > _viewModel.AdvanceProps.Count)
			{
				for (int l = _viewModel.AdvanceProps.Count; l < _advancedItemList.Count; l++)
				{
					_advancedItemList[l].Visibility = false;
				}
			}
			advancedParent.gameObject.SetActive(value: true);
		}
		else
		{
			advancedParent.gameObject.SetActive(value: false);
		}
		if (_viewModel.Passive != null)
		{
			for (int m = 0; m < _viewModel.Passive.Count; m++)
			{
				if (_passiveItemList.Count <= m)
				{
					PropertyItem component3 = Object.Instantiate(propItemTpl, passiveParent).transform.GetComponent<PropertyItem>();
					component3.Init(_viewModel.Passive[m]);
					_passiveItemList.Add(component3);
				}
				else
				{
					_passiveItemList[m].RefreshData(_viewModel.Passive[m]);
				}
				_passiveItemList[m].Visibility = true;
			}
			if (_passiveItemList.Count > _viewModel.Passive.Count)
			{
				for (int n = _viewModel.Passive.Count; n < _passiveItemList.Count; n++)
				{
					_passiveItemList[n].Visibility = false;
				}
			}
			passiveParent.gameObject.SetActive(value: true);
		}
		else
		{
			passiveParent.gameObject.SetActive(value: false);
		}
	}

	private void RefreshEntryScrollView()
	{
		int itemCount = ((_viewModel.Entries != null) ? _viewModel.Entries.Count : 0);
		entryScrollView.SetListItemCount(itemCount);
		entryScrollView.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (_viewModel.Entries == null)
		{
			return null;
		}
		if (index < 0 || index >= _viewModel.Entries.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = entryScrollView.NewListViewItem("EntryLevelItem");
		EntryLevelItem component = loopListViewItem.GetComponent<EntryLevelItem>();
		EntryLevelItemData entryLevelItemData = _viewModel.Entries[index];
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(entryLevelItemData);
		}
		else
		{
			component.RefreshEntryLevelItemData(entryLevelItemData);
		}
		return loopListViewItem;
	}

	protected override void OnDestroy()
	{
		Clear();
		base.OnDestroy();
	}

	public void Show()
	{
		RefreshProperty();
		RefreshEntryScrollView();
		LayoutRebuilder.ForceRebuildLayoutImmediate(primeParent);
		LayoutRebuilder.ForceRebuildLayoutImmediate(advancedParent);
		LayoutRebuilder.ForceRebuildLayoutImmediate(passiveParent);
		LayoutRebuilder.ForceRebuildLayoutImmediate(rootParent);
		_canvasGroup.alpha = 1f;
		_canvasGroup.blocksRaycasts = true;
	}

	public void Clear()
	{
		for (int i = 0; i < _primeItemList.Count; i++)
		{
			Object.DestroyImmediate(_primeItemList[i]);
			_primeItemList[i] = null;
		}
		for (int j = 0; j < _advancedItemList.Count; j++)
		{
			Object.DestroyImmediate(_advancedItemList[j]);
			_advancedItemList[j] = null;
		}
		for (int k = 0; k < _passiveItemList.Count; k++)
		{
			Object.DestroyImmediate(_passiveItemList[k]);
			_passiveItemList[k] = null;
		}
	}
}
