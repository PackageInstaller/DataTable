using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RandomBuffItemDisplayView : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI nameText;

	[SerializeField]
	private Button toggleBtn;

	[SerializeField]
	private GameObject foldedRoot;

	[SerializeField]
	private GameObject expandedRoot;

	[SerializeField]
	private GameObject maxLvShow;

	[SerializeField]
	private TextMeshProUGUI descText;

	[SerializeField]
	private float collapsedHeight = 80f;

	private RandomBuffDisplayItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = userData as RandomBuffDisplayItemViewModel;
		BindingSet<RandomBuffItemDisplayView, RandomBuffDisplayItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((RandomBuffDisplayItemViewModel m) => m.BuffIcon)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)nameText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(nameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RandomBuffDisplayItemViewModel m) => m.BuffName);
		}
		if ((UnityEngine.Object)(object)descText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(descText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RandomBuffDisplayItemViewModel m) => m.BuffDes);
			bindingSet.Bind(((Component)(object)descText).gameObject).For((GameObject v) => v.activeSelf).To((RandomBuffDisplayItemViewModel m) => m.IsExpand);
		}
		if (toggleBtn != null)
		{
			bindingSet.Bind(toggleBtn).For((Button v) => v.onClick).To((RandomBuffDisplayItemViewModel m) => m.OnClick);
		}
		if (foldedRoot != null)
		{
			bindingSet.Bind(foldedRoot).For((GameObject v) => v.activeSelf).ToExpression((RandomBuffDisplayItemViewModel m) => !m.IsExpand);
		}
		if (expandedRoot != null)
		{
			bindingSet.Bind(expandedRoot).For((GameObject v) => v.activeSelf).To((RandomBuffDisplayItemViewModel m) => m.IsExpand);
		}
		bindingSet.Bind(maxLvShow).For((GameObject v) => v.activeSelf).To((RandomBuffDisplayItemViewModel m) => m.CurMaxLv);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		if (userData is RandomBuffDisplayItemViewModel dataContext)
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
