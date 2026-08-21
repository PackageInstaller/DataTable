using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroSkillItem : UGuiView
{
	[SerializeField]
	private Image normalSkillIcon;

	[SerializeField]
	private Image selectSkillIcon;

	[SerializeField]
	private TextMeshProUGUI normalSkillName;

	[SerializeField]
	private TextMeshProUGUI selectSkillName;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject selectObj;

	[SerializeField]
	private GameObject normalObj;

	private HeroSkillItemData viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<HeroSkillItemData>(userData);
		BindingSet<HeroSkillItem, HeroSkillItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((HeroSkillItemData vm) => vm.OnClick);
		bindingSet.Bind(normalSkillIcon).For((Image v) => v.sprite).ToExpression((HeroSkillItemData vm) => vm.SkillIconPath)
			.WithConversion("ItemIcon");
		bindingSet.Bind(selectSkillIcon).For((Image v) => v.sprite).ToExpression((HeroSkillItemData vm) => vm.SkillIconPath)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(normalSkillName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkillItemData vm) => vm.SkillName);
		bindingSet.Bind<TextMeshProUGUI>(selectSkillName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSkillItemData vm) => vm.SkillName);
		bindingSet.Bind(selectObj).For((GameObject v) => v.activeSelf).To((HeroSkillItemData vm) => vm.IsSelected);
		bindingSet.Bind(normalObj).For((GameObject v) => v.activeSelf).ToExpression((HeroSkillItemData vm) => !vm.IsSelected);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		if (userData is HeroSkillItemData dataContext)
		{
			viewModel = dataContext;
			this.SetDataContext(dataContext);
		}
	}
}
