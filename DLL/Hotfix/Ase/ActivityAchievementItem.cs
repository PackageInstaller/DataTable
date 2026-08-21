using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityAchievementItem : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private Image rarityIcon;

	[SerializeField]
	private TextMeshProUGUI nameTxt;

	[SerializeField]
	private GameObject activeMask;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	protected Button btn;

	public string itemSizeType = "Large";

	private ActivityAchievementItemData viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<ActivityAchievementItemData>(userData);
		BindingSet<ActivityAchievementItem, ActivityAchievementItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((ActivityAchievementItemData vm) => vm.IsSelected);
		bindingSet.Bind(activeMask).For((GameObject v) => v.activeSelf).To((ActivityAchievementItemData vm) => vm.IsActive);
		bindingSet.Bind(rarityIcon).For((Image v) => v.sprite).ToExpression((ActivityAchievementItemData vm) => $"RarityBG_{itemSizeType}_{vm.Rarity}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((ActivityAchievementItemData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(nameTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityAchievementItemData vm) => vm.NameTxt);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((ActivityAchievementItemData vm) => vm.OnClick);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		if (userData is ActivityAchievementItemData dataContext)
		{
			viewModel = dataContext;
			this.SetDataContext(dataContext);
		}
	}
}
