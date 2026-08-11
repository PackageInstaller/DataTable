using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class AchiItem : UGuiView
{
	[SerializeField]
	private Button selectBtn;

	[SerializeField]
	private Image achiIcon;

	[SerializeField]
	private GameObject select;

	[SerializeField]
	private Image achiNameIcon;

	[SerializeField]
	private TextMeshProUGUI achiNameTxt;

	[SerializeField]
	private TextMeshProUGUI achiIndexTxt;

	[SerializeField]
	private Button openAchiSelctViewBtn;

	[SerializeField]
	private Image achiIconBG;

	[SerializeField]
	private GameObject achiRarity1;

	[SerializeField]
	private GameObject achiRarity2;

	[SerializeField]
	private GameObject achiRarity3;

	[SerializeField]
	private GameObject achiRarity4;

	private AchiItemData viewModel;

	public AchiItemData ViewModel => viewModel;

	public void Init(AchiItemData viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<AchiItem, AchiItemData> bindingSet = this.CreateBindingSet(ViewModel);
		if (selectBtn != null)
		{
			bindingSet.Bind(selectBtn).For((Button v) => v.onClick).To((AchiItemData vm) => vm.OnClick);
		}
		if (achiIcon != null)
		{
			bindingSet.Bind(achiIcon).For((Image v) => v.sprite).ToExpression((AchiItemData vm) => vm.AchiIcon)
				.WithConversion("ItemIcon");
		}
		if (achiIconBG != null)
		{
			bindingSet.Bind(achiIconBG).For((Image v) => v.sprite).ToExpression((AchiItemData vm) => $"achievements_Iconbg_{vm.AchiRarity}")
				.WithConversion("ItemIcon");
		}
		if (select != null)
		{
			bindingSet.Bind(select.gameObject).For((GameObject v) => v.activeSelf).ToExpression((AchiItemData vm) => vm.IsSelected);
		}
		_ = achiNameIcon != null;
		if ((UnityEngine.Object)(object)achiNameTxt != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(achiNameTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((AchiItemData vm) => vm.AchiName);
		}
		if ((bool)(UnityEngine.Object)(object)achiIndexTxt)
		{
			bindingSet.Bind<TextMeshProUGUI>(achiIndexTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((AchiItemData vm) => vm.SelectAchiIndex);
		}
		if (openAchiSelctViewBtn != null)
		{
			bindingSet.Bind(openAchiSelctViewBtn).For((Button v) => v.onClick).To((AchiItemData vm) => vm.OnClick);
		}
		if (achiRarity1 != null)
		{
			bindingSet.Bind(achiRarity1).For((GameObject v) => v.activeSelf).ToExpression((AchiItemData vm) => vm.AchiRarity == 1);
		}
		if (achiRarity2 != null)
		{
			bindingSet.Bind(achiRarity2).For((GameObject v) => v.activeSelf).ToExpression((AchiItemData vm) => vm.AchiRarity == 2);
		}
		if (achiRarity3 != null)
		{
			bindingSet.Bind(achiRarity3).For((GameObject v) => v.activeSelf).ToExpression((AchiItemData vm) => vm.AchiRarity == 3);
		}
		if (achiRarity4 != null)
		{
			bindingSet.Bind(achiRarity4).For((GameObject v) => v.activeSelf).ToExpression((AchiItemData vm) => vm.AchiRarity == 4);
		}
		bindingSet.Build();
	}

	public void RefreshData(AchiItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
