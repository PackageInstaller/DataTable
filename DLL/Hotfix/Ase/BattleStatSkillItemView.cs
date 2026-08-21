using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleStatSkillItemView : UGuiView
{
	public string color;

	public TextMeshProUGUI skillName;

	public Image skillIcon;

	[SerializeField]
	private float skinIconScaleMul = 1.5f;

	[SerializeField]
	private float skinIconAlpha = -1f;

	public TextMeshProUGUI damage;

	public TextMeshProUGUI tenacity;

	public TextMeshProUGUI cureSelf;

	public TextMeshProUGUI cureOther;

	public TextMeshProUGUI injureCount;

	public TextMeshProUGUI injureValue;

	public TextMeshProUGUI falldown;

	public TextMeshProUGUI cureAll;

	public TextMeshProUGUI release;

	public TextMeshProUGUI hitCount;

	public TextMeshProUGUI criticalCount;

	public Button btn;

	public GameObject canSelect;

	public GameObject selectState;

	public GameObject normalState;

	private BattleStatSkillItemViewModel viewModel;

	private bool isSkinIcon;

	private Vector3 oriScale = Vector3.one;

	private float oriAlpha = 1f;

	public bool IsSkinIcon
	{
		get
		{
			return isSkinIcon;
		}
		set
		{
			isSkinIcon = value;
			if (!(skillIcon == null))
			{
				float num = (value ? skinIconScaleMul : 1f);
				skillIcon.gameObject.transform.localScale = oriScale * num;
				Color color = skillIcon.color;
				color.a = ((!value) ? oriAlpha : ((skinIconAlpha >= 0f) ? skinIconAlpha : oriAlpha));
				skillIcon.color = color;
			}
		}
	}

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<BattleStatSkillItemViewModel>(userData);
		BindingSet<BattleStatSkillItemView, BattleStatSkillItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if ((UnityEngine.Object)(object)damage != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(damage).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleStatSkillItemViewModel vm) => $"{vm.Data.Damage}");
		}
		if ((UnityEngine.Object)(object)tenacity != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(tenacity).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleStatSkillItemViewModel vm) => $"{vm.Data.Tenacity}");
		}
		if ((UnityEngine.Object)(object)cureSelf != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(cureSelf).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleStatSkillItemViewModel vm) => $"{vm.Data.CureSelf}");
		}
		if ((UnityEngine.Object)(object)cureOther != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(cureOther).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleStatSkillItemViewModel vm) => $"{vm.Data.CureOther}");
		}
		if ((UnityEngine.Object)(object)injureCount != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(injureCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleStatSkillItemViewModel vm) => $"{vm.Data.InjureCount}");
		}
		if ((UnityEngine.Object)(object)injureValue != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(injureValue).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleStatSkillItemViewModel vm) => $"{vm.Data.InjureValue}");
		}
		if ((UnityEngine.Object)(object)falldown != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(falldown).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleStatSkillItemViewModel vm) => $"{vm.Data.FallCount}");
		}
		if ((UnityEngine.Object)(object)cureAll != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(cureAll).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleStatSkillItemViewModel vm) => $"{vm.Data.Cure}");
		}
		if ((UnityEngine.Object)(object)release != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(release).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleStatSkillItemViewModel vm) => $"{vm.Data.Release}");
		}
		if ((UnityEngine.Object)(object)hitCount != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(hitCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleStatSkillItemViewModel vm) => $"{vm.Data.HitCount}");
		}
		if ((UnityEngine.Object)(object)criticalCount != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(criticalCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleStatSkillItemViewModel vm) => $"{vm.Data.Critical}");
		}
		if ((UnityEngine.Object)(object)skillName != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(skillName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattleStatSkillItemViewModel vm) => vm.Data.Highlight ? $"<color=#{color}>{vm.Data.SkillName}*</color>" : vm.Data.SkillName);
		}
		if (skillIcon != null)
		{
			bindingSet.Bind(skillIcon).For((Image v) => v.sprite).To((BattleStatSkillItemViewModel vm) => vm.Data.SkillIcon)
				.WithConversion("ItemIcon");
			oriAlpha = skillIcon.color.a;
			oriScale = skillIcon.gameObject.transform.localScale;
		}
		bindingSet.Bind(this).For((BattleStatSkillItemView v) => v.IsSkinIcon).To((BattleStatSkillItemViewModel vm) => vm.Data.IsSkinIcon);
		if (canSelect != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((BattleStatSkillItemViewModel vm) => vm.OnSelect);
			bindingSet.Bind(canSelect).For((GameObject v) => v.activeSelf).ToExpression((BattleStatSkillItemViewModel vm) => vm.CanSelect && vm.Data.HasChild);
			bindingSet.Bind(selectState).For((GameObject v) => v.activeSelf).ToExpression((BattleStatSkillItemViewModel vm) => vm.IsSelect);
			bindingSet.Bind(normalState).For((GameObject v) => v.activeSelf).ToExpression((BattleStatSkillItemViewModel vm) => !vm.IsSelect);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<BattleStatSkillItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
