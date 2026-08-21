using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class LockTipsView : UGuiView
{
	public GameObject allRoot;

	public GameObject timeLockRoot;

	public TextMeshProUGUI timeLock;

	public GameObject propLockRoot;

	public TextMeshProUGUI count;

	public Image icon;

	private LockTipsData viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<LockTipsData>(userData);
		BindingSet<LockTipsView, LockTipsData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(allRoot).For((GameObject v) => v.activeSelf).ToExpression((LockTipsData vm) => vm.LockType != -1);
		bindingSet.Bind(propLockRoot).For((GameObject v) => v.activeSelf).ToExpression((LockTipsData vm) => vm.LockType == 2);
		bindingSet.Bind(timeLockRoot).For((GameObject v) => v.activeSelf).ToExpression((LockTipsData vm) => vm.LockType == 3);
		bindingSet.Bind<TextMeshProUGUI>(timeLock).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((LockTipsData vm) => $"{vm.Time}");
		bindingSet.Bind<TextMeshProUGUI>(count).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((LockTipsData vm) => $"{vm.Count}");
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((LockTipsData vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<LockTipsData>(userData);
		this.SetDataContext(viewModel);
	}
}
