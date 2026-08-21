using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyItem3View : UGuiView
{
	public Button btn;

	public TextMeshProUGUI index1;

	public TextMeshProUGUI index2;

	public GameObject lockRoot;

	public GameObject recommendRoot;

	public GameObject redRoot;

	public GameObject selectRoot;

	private CopyItemViewModel viewModel;

	private int index;

	public int Index
	{
		get
		{
			return index;
		}
		set
		{
			index = value;
			string text = "";
			if (index == 1)
			{
				text = "I";
			}
			else if (index == 2)
			{
				text = "II";
			}
			else if (index == 3)
			{
				text = "III";
			}
			else if (index == 4)
			{
				text = "IV";
			}
			else if (index == 5)
			{
				text = "V";
			}
			else if (index == 6)
			{
				text = "VI";
			}
			((TMP_Text)index1).text = text;
			((TMP_Text)index2).text = text;
		}
	}

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<CopyItemViewModel>(userData);
		BindingSet<CopyItem3View, CopyItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((CopyItemViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenType3Detail");
		bindingSet.Bind(redRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyItemViewModel vm) => vm.Data.HasNew && !vm.Data.IsLock);
		bindingSet.Bind(lockRoot).For((GameObject v) => v.activeSelf).To((CopyItemViewModel vm) => vm.Data.IsLock);
		if (recommendRoot != null)
		{
			bindingSet.Bind(recommendRoot).For((GameObject v) => v.activeSelf).To((CopyItemViewModel vm) => vm.IsRecommend);
		}
		bindingSet.Bind(selectRoot).For((GameObject v) => v.activeSelf).To((CopyItemViewModel vm) => vm.IsSelect);
		bindingSet.Bind(this).For((CopyItem3View v) => v.Index).To((CopyItemViewModel vm) => vm.Data.CopyRank);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
