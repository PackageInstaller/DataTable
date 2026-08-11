using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class StatusBuffItemView : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI nameText;

	[SerializeField]
	private TextMeshProUGUI timeText;

	[SerializeField]
	private Button toggleBtn;

	[SerializeField]
	private GameObject foldedRoot;

	[SerializeField]
	private GameObject expandedRoot;

	[SerializeField]
	private TextMeshProUGUI descText;

	[SerializeField]
	private float collapsedHeight = 80f;

	private StatusBuffItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<StatusBuffItemViewModel>(userData);
		BindingSet<StatusBuffItemView, StatusBuffItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((StatusBuffItemViewModel m) => m.Icon)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)nameText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(nameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((StatusBuffItemViewModel m) => m.BuffName);
		}
		if ((UnityEngine.Object)(object)timeText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(timeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((StatusBuffItemViewModel m) => (m.MaxTime < 0f) ? "--" : $"{Mathf.Ceil(Mathf.Max(0f, m.MaxTime - m.CurTime))}s");
		}
		if ((UnityEngine.Object)(object)descText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(descText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((StatusBuffItemViewModel m) => m.Desc);
			bindingSet.Bind(((Component)(object)descText).gameObject).For((GameObject v) => v.activeSelf).To((StatusBuffItemViewModel m) => m.IsExpand);
		}
		if (toggleBtn != null)
		{
			bindingSet.Bind(toggleBtn).For((Button v) => v.onClick).To((StatusBuffItemViewModel m) => m.OnClick);
		}
		if (foldedRoot != null)
		{
			bindingSet.Bind(foldedRoot).For((GameObject v) => v.activeSelf).ToExpression((StatusBuffItemViewModel m) => !m.IsExpand);
		}
		if (expandedRoot != null)
		{
			bindingSet.Bind(expandedRoot).For((GameObject v) => v.activeSelf).To((StatusBuffItemViewModel m) => m.IsExpand);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		if (userData is StatusBuffItemViewModel dataContext)
		{
			viewModel = dataContext;
			this.SetDataContext(dataContext);
		}
	}

	public void ApplyHeight()
	{
		RectTransform component = GetComponent<RectTransform>();
		if (component == null)
		{
			return;
		}
		float num = 0f;
		if ((UnityEngine.Object)(object)descText != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(((TMP_Text)descText).rectTransform);
			if (((Component)(object)descText).gameObject.activeSelf)
			{
				num = ((TMP_Text)descText).rectTransform.rect.height;
			}
		}
		float size = collapsedHeight + ((viewModel != null && viewModel.IsExpand) ? num : 0f);
		component.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, size);
	}
}
