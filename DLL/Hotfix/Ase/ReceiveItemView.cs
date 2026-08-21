using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class ReceiveItemView : KnapsackItemNew
{
	[SerializeField]
	private GameObject isGot;

	[SerializeField]
	private GameObject isUp;

	[SerializeField]
	private GameObject isTeam;

	[SerializeField]
	private GameObject isLock;

	[SerializeField]
	private TextMeshProUGUI countRange;

	private ReceiveItemViewModel viewModel;

	public void Init(ReceiveItemViewModel data)
	{
		viewModel = data;
		Init((KnapsackItemViewModel)data);
		BindingSet<ReceiveItemView, ReceiveItemViewModel> bindingSet = this.CreateBindingSet(data);
		if (isGot != null)
		{
			bindingSet.Bind(isGot).For((GameObject v) => v.activeSelf).To((ReceiveItemViewModel vm) => vm.IsGot);
		}
		if (isUp != null)
		{
			bindingSet.Bind(isUp).For((GameObject v) => v.activeSelf).To((ReceiveItemViewModel vm) => vm.IsUp);
		}
		if (isTeam != null)
		{
			bindingSet.Bind(isTeam).For((GameObject v) => v.activeSelf).To((ReceiveItemViewModel vm) => vm.IsTeam);
		}
		if (isLock != null)
		{
			bindingSet.Bind(isLock).For((GameObject v) => v.activeSelf).To((ReceiveItemViewModel vm) => vm.IsLock);
		}
		if ((UnityEngine.Object)(object)countRange != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(countRange).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ReceiveItemViewModel vm) => vm.CountRange);
		}
		bindingSet.Build();
	}

	public void RefreshData(ReceiveItemViewModel data)
	{
		viewModel = data;
		base.RefreshData(data);
		this.SetDataContext(data);
	}
}
