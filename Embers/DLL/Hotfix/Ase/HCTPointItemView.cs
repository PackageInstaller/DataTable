using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HCTPointItemView : UGuiView
{
	[SerializeField]
	private int order;

	[SerializeField]
	private HCSPointType pointType;

	[SerializeField]
	private float skinIconScaleMul = 1.5f;

	[SerializeField]
	private float skinIconAlpha = -1f;

	[SerializeField]
	private GameObject redPoint;

	public Button btn;

	public GameObject select;

	public Image icon;

	public StateEnumItem state;

	public TextMeshProUGUI progress;

	private RectTransform stateOpen;

	private HCTPointItemViewModel viewModel;

	private bool isSkinIcon;

	private Vector3 oriScale = Vector3.one;

	private float oriAlpha = 1f;

	public HCSPointType PointType => pointType;

	public int Order => order;

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
				icon.gameObject.transform.localScale = oriScale * num;
				Color color = icon.color;
				color.a = ((!value) ? oriAlpha : ((skinIconAlpha >= 0f) ? skinIconAlpha : oriAlpha));
				icon.color = color;
			}
		}
	}

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<HCTPointItemViewModel>(userData);
		BindingSet<HCTPointItemView, HCTPointItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (pointType == HCSPointType.Big)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((HCTPointItemViewModel vm) => vm.Icon)
				.WithConversion("ItemIcon");
			bindingSet.Bind(this).For((HCTPointItemView v) => v.IsSkinIcon).To((HCTPointItemViewModel vm) => vm.IsSkinIcon);
			if (icon != null)
			{
				oriAlpha = icon.color.a;
				oriScale = icon.gameObject.transform.localScale;
			}
		}
		bindingSet.Bind(select).For((GameObject v) => v.activeSelf).To((HCTPointItemViewModel vm) => vm.IsSelect);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((HCTPointItemViewModel vm) => vm.OnClick);
		if (viewModel.IsSelf)
		{
			bindingSet.Bind(state).For((StateEnumItem v) => v.CurState).To((HCTPointItemViewModel vm) => vm.PointState);
		}
		if ((UnityEngine.Object)(object)progress != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(progress).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HCTPointItemViewModel vm) => $"{vm.CurProgress}/{vm.TotalProgress}");
		}
		if (!viewModel.IsSelf)
		{
			bindingSet.Bind(redPoint).For((GameObject v) => v.activeSelf).To((HCTPointItemViewModel vm) => vm.IsSelf);
		}
		bindingSet.Build();
		if (pointType != HCSPointType.Small)
		{
			return;
		}
		for (int num = 0; num < state.stateConfigs.Count; num++)
		{
			if (state.stateConfigs[num].stateId == StateEnumConfig.Open)
			{
				stateOpen = state.stateConfigs[num].GetComponent<RectTransform>();
				break;
			}
		}
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<HCTPointItemViewModel>(userData);
		this.SetDataContext(userData);
	}

	public bool CheckVM(HCTPointItemViewModel vm)
	{
		return viewModel == vm;
	}

	public void PlayEffect(AutoDispose effect)
	{
		RectTransform component = effect.GetComponent<RectTransform>();
		if (pointType == HCSPointType.Big)
		{
			component.SetParent(RectTransform);
			component.anchoredPosition = Vector2.zero;
			effect.gameObject.SetActive(value: false);
			effect.gameObject.SetActive(value: true);
		}
		else
		{
			component.SetParent(stateOpen);
			component.anchoredPosition = Vector2.zero;
			component.SetSiblingIndex(0);
			effect.gameObject.SetActive(value: false);
			effect.gameObject.SetActive(value: true);
		}
	}
}
