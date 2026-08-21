using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class LongTermCheckinView : ActivityViewBase
{
	[SerializeField]
	private LoopGridView loopGridView;

	[SerializeField]
	private TextMeshProUGUI alreadyCheckinDay;

	[SerializeField]
	private GameObject extraView;

	[SerializeField]
	private RectTransform extraItemRoot;

	[SerializeField]
	private Image extraBar;

	private float _barLength;

	[SerializeField]
	private LongTermCheckinItem extraItemTpl;

	private GameObjectPool _extraItemPool;

	private LongTermCheckinViewModel _viewModel;

	public override void Init(ActivityViewModelBase viewModel)
	{
		_barLength = extraBar.rectTransform.rect.width;
		_extraItemPool = new GameObjectPool(extraItemTpl.gameObject, extraItemRoot);
		_viewModel = (LongTermCheckinViewModel)viewModel;
		base.Init(viewModel);
		BindingSet<LongTermCheckinView, LongTermCheckinViewModel> bindingSet = this.CreateBindingSet((LongTermCheckinViewModel)viewModel);
		bindingSet.Bind<TextMeshProUGUI>(alreadyCheckinDay).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((LongTermCheckinViewModel vm) => vm.AlreadyCheckinDay);
		bindingSet.Bind(extraBar).For((Image v) => v.fillAmount).To((LongTermCheckinViewModel vm) => vm.ExtraProgress);
		bindingSet.Build();
		InitGridView();
		InitExtraView();
	}

	private void InitGridView()
	{
		loopGridView.InitGridView(_viewModel.ItemDataList.Count, OnGetItemByIndex);
	}

	private void InitExtraView()
	{
		_extraItemPool.RecycleAll();
		if (_viewModel.ExtraItemDataList == null)
		{
			extraView.SetActive(value: false);
			return;
		}
		foreach (LongTermCheckinItemData extraItemData in _viewModel.ExtraItemDataList)
		{
			LongTermCheckinItem component = _extraItemPool.Allocate(out var newCreate).GetComponent<LongTermCheckinItem>();
			if (newCreate)
			{
				component.Init(extraItemData);
			}
			else
			{
				component.SetDataContext(extraItemData);
			}
			component.transform.SetSiblingIndex(extraItemRoot.childCount - 1);
			float num = ((_viewModel.TotalDay > 0) ? ((float)extraItemData.Day / (float)_viewModel.TotalDay) : 0f);
			component.RectTransform.anchoredPosition = new Vector2(num * _barLength, component.RectTransform.anchoredPosition.y);
		}
	}

	private LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int dataIndex, int row, int column)
	{
		if (dataIndex < 0 || dataIndex >= _viewModel.ItemDataList.Count)
		{
			return null;
		}
		LongTermCheckinItemData longTermCheckinItemData = _viewModel.ItemDataList[dataIndex];
		if (longTermCheckinItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = loopGridView.NewListViewItem("LongTermCheckinItem");
		LongTermCheckinItem component = loopGridViewItem.GetComponent<LongTermCheckinItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(longTermCheckinItemData);
		}
		else
		{
			component.SetDataContext(longTermCheckinItemData);
		}
		return loopGridViewItem;
	}
}
