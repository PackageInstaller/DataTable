using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BPItemView : UGuiView
{
	[SerializeField]
	protected Button btn;

	[SerializeField]
	private TextMeshProUGUI num;

	[SerializeField]
	private GameObject numRoot;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image type;

	[SerializeField]
	private Image bg;

	[SerializeField]
	private GameObject selectRoot;

	[SerializeField]
	private GameObject lockRoot;

	[SerializeField]
	private TextMeshProUGUI countOrLevel;

	private BPItemViewModel viewModel;

	public string itemSizeType = "Middle";

	public static string[] ItemSizeEnum = new string[3] { "Small", "Middle", "Large" };

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<BPItemViewModel>(userData);
		BindingSet<BPItemView, BPItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((BPItemViewModel vm) => vm.Data.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(type).For((Image v) => v.sprite).ToExpression((BPItemViewModel vm) => $"attr_{vm.Data.Type.ToString()}")
			.WithConversion("ItemIcon");
		if (numRoot != null)
		{
			bindingSet.Bind(numRoot).For((GameObject v) => v.activeSelf).ToExpression((BPItemViewModel vm) => vm.Num > 0);
			bindingSet.Bind<TextMeshProUGUI>(num).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BPItemViewModel vm) => $"{vm.Num}");
		}
		bindingSet.Bind(bg).For((Image v) => v.sprite).ToExpression((BPItemViewModel vm) => $"RarityBG_{itemSizeType}_{vm.Data.Quality}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(countOrLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BPItemViewModel vm) => vm.Data.Count);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((BPItemViewModel vm) => vm.OnClick);
		bindingSet.Bind(lockRoot).For((GameObject v) => v.activeSelf).To((BPItemViewModel vm) => vm.Data.IsLock);
		bindingSet.Bind(selectRoot).For((GameObject v) => v.activeSelf).To((BPItemViewModel vm) => vm.IsSelect);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		viewModel = GetUserData<BPItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
