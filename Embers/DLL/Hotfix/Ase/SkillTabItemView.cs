#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SkillTabItemView : UGuiView
{
	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject selRoot;

	[SerializeField]
	private GameObject norRoot;

	[SerializeField]
	private GameObject useRoot;

	[SerializeField]
	private TextMeshProUGUI name1;

	[SerializeField]
	private TextMeshProUGUI name2;

	[SerializeField]
	private Image attrImg1;

	[SerializeField]
	private TextMeshProUGUI skillName;

	[SerializeField]
	private TextMeshProUGUI skillResume;

	[SerializeField]
	private TextMeshProUGUI skillTag;

	[SerializeField]
	private TextMeshProUGUI skillDesc;

	[SerializeField]
	private List<Color> nameColor;

	private bool isInit;

	private SkillTabItemViewModel viewModel;

	public bool IsInit => isInit;

	public void Init(SkillTabItemViewModel viewModel)
	{
		if (nameColor == null || nameColor.Count < 2)
		{
			Log.Error("战斗技能描述界面 名字颜色配置异常！");
		}
		this.viewModel = viewModel;
		BindingSet<SkillTabItemView, SkillTabItemViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((SkillTabItemViewModel vm) => vm.OnSelect);
		}
		if (selRoot != null)
		{
			bindingSet.Bind(selRoot).For((GameObject v) => v.activeSelf).To((SkillTabItemViewModel vm) => vm.IsSelect);
		}
		if (norRoot != null)
		{
			bindingSet.Bind(norRoot).For((GameObject v) => v.activeSelf).ToExpression((SkillTabItemViewModel vm) => !vm.IsSelect);
		}
		if (useRoot != null)
		{
			bindingSet.Bind(useRoot).For((GameObject v) => v.activeSelf).To((SkillTabItemViewModel vm) => vm.IsSelf);
		}
		if ((UnityEngine.Object)(object)name1 != null && (UnityEngine.Object)(object)name2 != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(name1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((SkillTabItemViewModel vm) => vm.HeroData.Name);
			bindingSet.Bind<TextMeshProUGUI>(name1).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).ToExpression((SkillTabItemViewModel vm) => vm.IsSelf ? nameColor[0] : nameColor[1]);
			bindingSet.Bind<TextMeshProUGUI>(name2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((SkillTabItemViewModel vm) => vm.HeroData.Name);
			bindingSet.Bind<TextMeshProUGUI>(name2).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).ToExpression((SkillTabItemViewModel vm) => vm.IsSelf ? nameColor[0] : nameColor[1]);
		}
		if (attrImg1 != null)
		{
			bindingSet.Bind(attrImg1).For((Image v) => v.sprite).ToExpression((SkillTabItemViewModel vm) => $"hero_attr_{(int)vm.HeroData.Attribute}")
				.WithConversion("ItemIcon");
			bindingSet.Bind<TextMeshProUGUI>(skillName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((SkillTabItemViewModel vm) => vm.Data.Name);
			bindingSet.Bind<TextMeshProUGUI>(skillResume).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((SkillTabItemViewModel vm) => vm.Data.StaminaCost);
			bindingSet.Bind<TextMeshProUGUI>(skillTag).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((SkillTabItemViewModel vm) => vm.Data.SkillTag);
			bindingSet.Bind<TextMeshProUGUI>(skillDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((SkillTabItemViewModel vm) => vm.Data.Desc);
		}
		bindingSet.Build();
		isInit = true;
	}

	public void RefreshData(SkillTabItemViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
