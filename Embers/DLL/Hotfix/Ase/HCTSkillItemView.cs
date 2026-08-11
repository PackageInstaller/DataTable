using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HCTSkillItemView : UGuiView
{
	public HeroSkillTypeEnum skillTypeEnum;

	public Button btn;

	public GameObject select;

	public Image icon;

	public TextMeshProUGUI nameText;

	[SerializeField]
	private float skinIconScaleMul = 1.5f;

	[SerializeField]
	private float skinIconAlpha = -1f;

	public TextMeshProUGUI skillFuncText;

	public TextMeshProUGUI skillTypeText;

	public TextMeshProUGUI descText;

	public TextMeshProUGUI descNextText;

	public TextMeshProUGUI cooling1;

	public GameObject consumeRoot;

	public GameObject cdRoot;

	public TextMeshProUGUI consume1;

	public TextMeshProUGUI cooling2;

	public TextMeshProUGUI consume2;

	public GameObject consumeBar;

	public float height1;

	public float height2;

	private HCTSkillItemViewModel viewModel;

	private bool isSkinIcon;

	private Vector3 oriScale = Vector3.one;

	private float oriAlpha = 1f;

	private bool isOriSkillItem;

	public bool IsSkinIcon
	{
		get
		{
			return isSkinIcon;
		}
		set
		{
			isSkinIcon = value;
			if (!(icon == null))
			{
				float num = (value ? skinIconScaleMul : 1f);
				float a = ((!value) ? oriAlpha : ((skinIconAlpha >= 0f) ? skinIconAlpha : oriAlpha));
				icon.gameObject.transform.localScale = oriScale * num;
				Color color = icon.color;
				color.a = a;
				icon.color = color;
			}
		}
	}

	public bool IsOriSkillItem
	{
		get
		{
			return isOriSkillItem;
		}
		set
		{
			isOriSkillItem = value;
		}
	}

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<HCTSkillItemViewModel>(userData);
		BindingSet<HCTSkillItemView, HCTSkillItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((HCTSkillItemViewModel vm) => vm.Data.Icon)
				.WithConversion("ItemIcon");
			oriAlpha = icon.color.a;
			oriScale = icon.gameObject.transform.localScale;
		}
		bindingSet.Bind(this).For((HCTSkillItemView v) => v.IsSkinIcon).To((HCTSkillItemViewModel vm) => vm.Data.IsSkinIcon);
		if (select != null)
		{
			bindingSet.Bind(select).For((GameObject v) => v.activeSelf).To((HCTSkillItemViewModel vm) => vm.IsSelect);
		}
		if ((UnityEngine.Object)(object)nameText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(nameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HCTSkillItemViewModel vm) => vm.Data.Name);
		}
		if (consumeRoot != null)
		{
			bindingSet.Bind(consumeRoot).For((GameObject v) => v.activeSelf).ToExpression((HCTSkillItemViewModel vm) => !string.IsNullOrEmpty(vm.ConsumeText));
		}
		if ((UnityEngine.Object)(object)cooling1 != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(cooling1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HCTSkillItemViewModel vm) => vm.CoolingText);
			bindingSet.Bind<TextMeshProUGUI>(consume1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HCTSkillItemViewModel vm) => vm.ConsumeText);
			bindingSet.Bind(((Component)(object)cooling1).gameObject).For((GameObject v) => v.activeSelf).ToExpression((HCTSkillItemViewModel vm) => !vm.IsCoolingChange);
		}
		if ((UnityEngine.Object)(object)cooling2 != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(cooling2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HCTSkillItemViewModel vm) => vm.CoolingText);
			bindingSet.Bind(((Component)(object)cooling2).gameObject).For((GameObject v) => v.activeSelf).ToExpression((HCTSkillItemViewModel vm) => vm.IsCoolingChange);
		}
		if (cdRoot != null)
		{
			bindingSet.Bind(cdRoot).For((GameObject v) => v.activeSelf).ToExpression((HCTSkillItemViewModel vm) => vm.ShowCooling);
		}
		if ((UnityEngine.Object)(object)descText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(descText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HCTSkillItemViewModel vm) => vm.Desc);
		}
		if ((UnityEngine.Object)(object)skillFuncText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(skillFuncText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HCTSkillItemViewModel vm) => $"{vm.Data.SkillFunc}");
		}
		if ((UnityEngine.Object)(object)skillTypeText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(skillTypeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HCTSkillItemViewModel vm) => $"{vm.Data.SkillType}");
		}
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((HCTSkillItemViewModel vm) => vm.OnSkillClick);
		}
		bindingSet.Build();
		if ((UnityEngine.Object)(object)consume2 != null)
		{
			((Component)(object)consume2).gameObject.SetActive(value: false);
		}
	}

	public void SetSkinIconStyle(float scaleMul, float alpha)
	{
		skinIconScaleMul = scaleMul;
		skinIconAlpha = alpha;
		IsSkinIcon = isSkinIcon;
	}

	public bool HasConsumeBar()
	{
		bool flag = !string.IsNullOrEmpty(viewModel.ConsumeText) || viewModel.ShowCooling;
		((TMP_Text)descText).rectTransform.anchoredPosition = new Vector2(((TMP_Text)descText).rectTransform.anchoredPosition.x, flag ? height1 : height2);
		consumeBar?.SetActive(flag);
		return flag;
	}

	public void HasConsumeBar2()
	{
		bool active = !string.IsNullOrEmpty(viewModel.ConsumeText) || viewModel.ShowCooling;
		consumeBar?.SetActive(active);
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<HCTSkillItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
