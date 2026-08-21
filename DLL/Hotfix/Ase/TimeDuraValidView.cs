using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class TimeDuraValidView : UGuiView
{
	public TextMeshProUGUI text1NoValid;

	public TextMeshProUGUI text2Valid;

	protected override void OnInit(object userData)
	{
		if (userData != null)
		{
			TimeDuraValidData userData2 = GetUserData<TimeDuraValidData>(userData);
			BindingSet<TimeDuraValidView, TimeDuraValidData> bindingSet = this.CreateBindingSet(userData2);
			bindingSet.Bind(((Component)(object)text2Valid).gameObject).For((GameObject v) => v.activeSelf).ToExpression((TimeDuraValidData vm) => vm.IsTimeValid);
			bindingSet.Bind(((Component)(object)text1NoValid).gameObject).For((GameObject v) => v.activeSelf).ToExpression((TimeDuraValidData vm) => !vm.IsTimeValid);
			bindingSet.Bind<TextMeshProUGUI>(text1NoValid).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TimeDuraValidData vm) => vm.TimeConfig);
			bindingSet.Bind<TextMeshProUGUI>(text2Valid).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TimeDuraValidData vm) => vm.TimeConfig);
			bindingSet.Build();
		}
	}

	public override void RefreshData(object userData)
	{
		if (userData != null)
		{
			base.RefreshData(userData);
			this.SetDataContext(userData);
		}
	}
}
