using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityPackView : ActivityViewBase
{
	[SerializeField]
	private TextMeshProUGUI packName;

	[SerializeField]
	private TextMeshProUGUI packDesc;

	[SerializeField]
	private Button btnRuleOpen;

	[SerializeField]
	private Button btnRuleClose;

	[SerializeField]
	private GameObject rulePanel;

	[SerializeField]
	private List<ActivityPackItem> items = new List<ActivityPackItem>();

	[SerializeField]
	private GameObject canBuy;

	[SerializeField]
	private GameObject bought;

	[SerializeField]
	private Button btnBuy;

	[SerializeField]
	private TextMeshProUGUI nowPriceText;

	[SerializeField]
	private TextMeshProUGUI oriPriceText;

	private ActivityPackViewModel _viewModel;

	public override void Init(ActivityViewModelBase viewModel)
	{
		_viewModel = (ActivityPackViewModel)viewModel;
		base.Init(viewModel);
		BindingSet<ActivityPackView, ActivityPackViewModel> bindingSet = this.CreateBindingSet((ActivityPackViewModel)viewModel);
		if ((UnityEngine.Object)(object)packName != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(packName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityPackViewModel vm) => vm.PackName);
		}
		if ((UnityEngine.Object)(object)packDesc != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(packDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityPackViewModel vm) => vm.PackDesc);
		}
		if (canBuy != null)
		{
			bindingSet.Bind(canBuy).For((GameObject v) => v.activeSelf).ToExpression((ActivityPackViewModel vm) => !vm.PackBought);
		}
		if (bought != null)
		{
			bindingSet.Bind(bought).For((GameObject v) => v.activeSelf).To((ActivityPackViewModel vm) => vm.PackBought);
		}
		if (btnBuy != null)
		{
			bindingSet.Bind(btnBuy).For((Button v) => v.onClick).To((ActivityPackViewModel vm) => vm.BuyPackCmd);
		}
		if ((UnityEngine.Object)(object)nowPriceText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(nowPriceText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityPackViewModel vm) => vm.NowPriceText);
		}
		if ((UnityEngine.Object)(object)oriPriceText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(oriPriceText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityPackViewModel vm) => vm.OriPriceText);
		}
		bindingSet.Build();
		if (btnRuleOpen != null && rulePanel != null)
		{
			btnRuleOpen.onClick.AddListener(delegate
			{
				rulePanel.SetActive(value: true);
			});
		}
		if (btnRuleClose != null && rulePanel != null)
		{
			btnRuleClose.onClick.AddListener(delegate
			{
				rulePanel.SetActive(value: false);
			});
		}
		InitPackItems();
	}

	private void InitPackItems()
	{
		if (items == null)
		{
			return;
		}
		items.RemoveAll((ActivityPackItem p) => p == null);
		for (int num = 0; num < items.Count; num++)
		{
			if (num >= _viewModel.ItemDataList.Count)
			{
				items[num].gameObject.SetActive(value: false);
			}
			else
			{
				items[num].Init(_viewModel.ItemDataList[num]);
			}
		}
	}
}
