using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroGiftItem : UGuiView
{
	[SerializeField]
	private KnapsackItemNew prop;

	[SerializeField]
	private GameObject handleFrame;

	[SerializeField]
	private Button btnAdd;

	[SerializeField]
	private Button btnDec;

	[SerializeField]
	private Button btnMax;

	[SerializeField]
	private TextMeshProUGUI useCount;

	private HeroGiftItemData _viewModel;

	protected override void OnInit(object userData)
	{
		_viewModel = GetUserData<HeroGiftItemData>(userData);
		BindingSet<HeroGiftItem, HeroGiftItemData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(handleFrame).For((GameObject v) => v.activeSelf).ToExpression((HeroGiftItemData vm) => vm.UseCount > 0);
		bindingSet.Bind<TextMeshProUGUI>(useCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroGiftItemData vm) => vm.UseCount);
		bindingSet.Bind(btnAdd).For((Button v) => v.onClick).To((HeroGiftItemData vm) => vm.OnAddBtnClick);
		bindingSet.Bind(btnDec).For((Button v) => v.onClick).To((HeroGiftItemData vm) => vm.OnDecBtnClick);
		bindingSet.Bind(btnMax).For((Button v) => v.onClick).To((HeroGiftItemData vm) => vm.OnMaxBtnClick);
		bindingSet.Build();
		prop.Init(new KnapsackItemViewModel(_viewModel, _viewModel.PropData));
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		_viewModel = GetUserData<HeroGiftItemData>(userData);
		this.SetDataContext(userData);
		prop.RefreshData(new KnapsackItemViewModel(_viewModel, _viewModel.PropData));
	}
}
