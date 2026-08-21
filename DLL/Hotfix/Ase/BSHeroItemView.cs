using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BSHeroItemView : UGuiView
{
	[SerializeField]
	private new Text name;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private Button btnDetail;

	[SerializeField]
	private GameObject line;

	[SerializeField]
	private LoopListView2 StatisticList;

	[SerializeField]
	private List<Color> nameColor;

	private BSHeroItemViewModel viewModel;

	public void Init(BSHeroItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<BSHeroItemView, BSHeroItemViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(name).For((Text v) => v.text).To((BSHeroItemViewModel vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BSHeroItemViewModel vm) => $"Lv.{vm.Hero.Level}");
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((BSHeroItemViewModel vm) => HeroDefinition.GetHeroIconPath(HeroDefinition.HeroIconType.Upgrade, vm.Hero))
			.WithConversion("ItemIcon");
		bindingSet.Bind(btnDetail).For((Button v) => v.onClick).To((BSHeroItemViewModel vm) => vm.OnSelect);
		bindingSet.Bind(line).For((GameObject v) => v.activeSelf).To((BSHeroItemViewModel vm) => vm.ShowLine);
		bindingSet.Bind(name).For((Text v) => v.color).ToExpression((BSHeroItemViewModel vm) => vm.IsSelf ? nameColor[1] : nameColor[0]);
		bindingSet.Build();
		StatisticList.InitListView(viewModel.BSItemVMs.Count, OnGetStatisticItemByIndex);
	}

	public void RefreshData(BSHeroItemViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}

	private LoopListViewItem2 OnGetStatisticItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.BSItemVMs.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("BSItemView");
		if (loopListViewItem != null)
		{
			BSItemView component = loopListViewItem.GetComponent<BSItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.BSItemVMs[index]);
			}
			else
			{
				component.RefreshData(viewModel.BSItemVMs[index]);
			}
		}
		return loopListViewItem;
	}
}
