using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MoneyItem : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI moneyText;

	[SerializeField]
	private TextMeshProUGUI propText;

	[SerializeField]
	private Button iconBtn;

	[SerializeField]
	private Button addBtn;

	private MoneyItemData viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<MoneyItemData>(userData);
		BindingSet<MoneyItem, MoneyItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((MoneyItemData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(((Component)(object)moneyText).gameObject).For((GameObject v) => v.activeSelf).ToExpression((MoneyItemData vm) => !vm.MoneyEmpty);
		bindingSet.Bind<TextMeshProUGUI>(moneyText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((MoneyItemData vm) => vm.ShowMaxCount ? $"{(vm.MoneyEmpty ? 0 : vm.Money.Count)}/{(vm.MoneyEmpty ? 0 : vm.Money.MaxCount)}" : $"{(vm.MoneyEmpty ? 0 : vm.Money.Count)}");
		bindingSet.Bind(((Component)(object)propText).gameObject).For((GameObject v) => v.activeSelf).ToExpression((MoneyItemData vm) => !vm.PropDataEmpty);
		bindingSet.Bind<TextMeshProUGUI>(propText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((MoneyItemData vm) => vm.ShowMaxCount ? $"{(vm.PropDataEmpty ? 0 : vm.PropData.Amount)}/{(vm.PropDataEmpty ? 0 : vm.PropData.MaxCount)}" : $"{(vm.PropDataEmpty ? 0 : vm.PropData.Amount)}");
		bindingSet.Bind(iconBtn).For((Button v) => v.enabled).To((MoneyItemData vm) => vm.IconBtnEnable);
		if (addBtn != null)
		{
			bindingSet.Bind(addBtn.gameObject).For((GameObject v) => v.activeSelf).To((MoneyItemData vm) => vm.GetBtnEnable);
			bindingSet.Bind(addBtn).For((Button v) => v.onClick).To((MoneyItemData vm) => vm.OnGetBtnClick);
		}
		bindingSet.Build();
		iconBtn.onClick.AddListener(OnIconBtnClick);
	}

	private void OnIconBtnClick()
	{
		viewModel.OnIconBtnClick(iconBtn.transform.position);
	}

	public void RefreshData(MoneyItemData data)
	{
		viewModel = data;
		this.SetDataContext(data);
	}
}
