using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SkillComboView : UGuiView
{
	[SerializeField]
	private Image skillIcon;

	[SerializeField]
	private Image chargeFill;

	[SerializeField]
	private GameObject chargeFillFull;

	[SerializeField]
	private GameObject selected;

	[SerializeField]
	private GameObject finished;

	[SerializeField]
	private GameObject fail;

	[SerializeField]
	private GameObject chargetStart;

	[SerializeField]
	private GameObject chargeFinish;

	[SerializeField]
	private TextMeshProUGUI skillDes1;

	[SerializeField]
	private TextMeshProUGUI skillDes2;

	private SkillComboViewModel _viewModel;

	public void Init(SkillComboViewModel skillComboViewModel)
	{
		_viewModel = skillComboViewModel;
		if (_viewModel != null)
		{
			BindingSet<SkillComboView, SkillComboViewModel> bindingSet = this.CreateBindingSet(_viewModel);
			bindingSet.Bind(skillIcon).For((Image v) => v.sprite).ToExpression((SkillComboViewModel vm) => vm.SkillIcon)
				.WithConversion("ItemIcon");
			bindingSet.Bind(chargeFill).For((Image v) => v.fillAmount).To((SkillComboViewModel vm) => vm.ChargeFillAmount);
			bindingSet.Bind(selected).For((GameObject v) => v.activeSelf).To((SkillComboViewModel vm) => vm.SelectSkill);
			bindingSet.Bind(finished).For((GameObject v) => v.activeSelf).To((SkillComboViewModel vm) => vm.FinishSkill);
			bindingSet.Bind(fail).For((GameObject v) => v.activeSelf).To((SkillComboViewModel vm) => vm.FailSkill);
			bindingSet.Bind<TextMeshProUGUI>(skillDes1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SkillComboViewModel vm) => vm.SkillDes);
			bindingSet.Bind<TextMeshProUGUI>(skillDes2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SkillComboViewModel vm) => vm.SkillDes2);
			bindingSet.Bind(chargetStart).For((GameObject v) => v.activeSelf).To((SkillComboViewModel vm) => vm.ChargeStart);
			bindingSet.Bind(chargeFinish).For((GameObject v) => v.activeSelf).ToExpression((SkillComboViewModel vm) => vm.ChargeFillAmount >= 1f);
			bindingSet.Bind(chargeFillFull).For((GameObject v) => v.activeSelf).ToExpression((SkillComboViewModel vm) => vm.ChargeFillAmount >= 1f);
			bindingSet.Bind(chargeFill.gameObject).For((GameObject v) => v.activeSelf).ToExpression((SkillComboViewModel vm) => vm.ChargeFillAmount < 1f);
			bindingSet.Build();
		}
	}
}
