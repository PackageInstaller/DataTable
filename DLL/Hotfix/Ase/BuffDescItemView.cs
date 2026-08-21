using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BuffDescItemView : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private TextMeshProUGUI desc;

	[SerializeField]
	private TextMeshProUGUI showTime;

	[SerializeField]
	private GameObject continuedShow;

	[SerializeField]
	private GameObject timeOver;

	[SerializeField]
	private TextMeshProUGUI buffName;

	[SerializeField]
	private TextMeshProUGUI BuffLayer;

	[SerializeField]
	private RectTransform BgRect;

	private BuffItemViewModel viewModel;

	public void Init(BuffItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<BuffDescItemView, BuffItemViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((BuffItemViewModel vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(showTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BuffItemViewModel vm) => $"{Mathf.Ceil(vm.MaxTime - vm.CurTime)}s");
		bindingSet.Bind(((Component)(object)showTime).gameObject).For((GameObject v) => v.activeSelf).ToExpression((BuffItemViewModel vm) => vm.MaxTime - vm.CurTime > 0f);
		bindingSet.Bind(timeOver).For((GameObject v) => v.activeSelf).ToExpression((BuffItemViewModel vm) => vm.NoActive ? true : ((vm.MaxTime < 0f) ? false : (vm.CurTime > vm.MaxTime)));
		bindingSet.Bind(continuedShow).For((GameObject v) => v.activeSelf).ToExpression((BuffItemViewModel vm) => vm.NoActive ? false : (vm.MaxTime < 0f));
		bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BuffItemViewModel vm) => vm.Desc);
		bindingSet.Bind<TextMeshProUGUI>(BuffLayer).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BuffItemViewModel vm) => vm.Layer);
		bindingSet.Bind(((Component)(object)BuffLayer).gameObject).For((GameObject v) => v.activeSelf).To((BuffItemViewModel vm) => vm.ShowLayer);
		bindingSet.Bind<TextMeshProUGUI>(buffName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BuffItemViewModel vm) => vm.BuffName);
		bindingSet.Build();
	}

	public override void RefreshData(object viewModel)
	{
		base.RefreshData(viewModel);
		this.viewModel = (BuffItemViewModel)viewModel;
		this.SetDataContext(viewModel);
	}

	public void SetDesText()
	{
		if (viewModel != null)
		{
			((TMP_Text)desc).text = viewModel.Desc;
		}
		((Component)(object)desc).GetComponent<ContentSizeFitter>().SetLayoutVertical();
		TMP_TextInfo textInfo = ((TMP_Text)desc).GetTextInfo(viewModel.Desc);
		if (textInfo != null)
		{
			Vector2 sizeDelta = ((Component)(object)desc).GetComponent<RectTransform>().sizeDelta;
			sizeDelta.x = BgRect.sizeDelta.x;
			sizeDelta.y = (float)textInfo.lineCount * 31.62f + 70f;
			BgRect.sizeDelta = sizeDelta;
		}
	}
}
