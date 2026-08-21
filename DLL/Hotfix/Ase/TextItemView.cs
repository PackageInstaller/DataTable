using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TextItemView : UGuiView
{
	public TextMeshProUGUI text1;

	public TextMeshProUGUI text2;

	public Image img;

	private TextItemViewModel viewModel;

	public void Init(TextItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<TextItemView, TextItemViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		if ((UnityEngine.Object)(object)text1 != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(text1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TextItemViewModel vm) => vm.Text1);
		}
		if ((UnityEngine.Object)(object)text2 != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(text2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TextItemViewModel vm) => vm.Text2);
		}
		if (img != null)
		{
			bindingSet.Bind(img).For((Image v) => v.color).To((TextItemViewModel vm) => vm.ColorType);
		}
		bindingSet.Build();
	}

	public void RefreshData(TextItemViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
