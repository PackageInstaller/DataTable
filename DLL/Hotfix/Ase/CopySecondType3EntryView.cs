using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine.UI;

namespace Ase;

public class CopySecondType3EntryView : UGuiView
{
	public Button backButton;

	public Button multiButton;

	public Button firePowerButton;

	public Button extremeButton;

	public TextMeshProUGUI timeLeft;

	private CopySecondType3EntryViewModel viewModel;

	public CopySecondType3EntryViewModel ViewModel
	{
		get
		{
			return viewModel;
		}
		set
		{
			if (viewModel == null)
			{
				OnInit(value);
			}
			else
			{
				RefreshData(value);
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
		viewModel = GetUserData<CopySecondType3EntryViewModel>(userData);
		BindingSet<CopySecondType3EntryView, CopySecondType3EntryViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(timeLeft).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopySecondType3EntryViewModel vm) => vm.TimeLeft);
		bindingSet.Bind(multiButton).For((Button v) => v.onClick).To((CopySecondType3EntryViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenMulti");
		bindingSet.Bind(firePowerButton).For((Button v) => v.onClick).To((CopySecondType3EntryViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenFirePower");
		bindingSet.Bind(extremeButton).For((Button v) => v.onClick).To((CopySecondType3EntryViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenExtreme");
		bindingSet.Bind(backButton).For((Button v) => v.onClick).To((CopySecondType3EntryViewModel vm) => vm.OptCommand)
			.CommandParameter("Close");
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopySecondType3EntryViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
