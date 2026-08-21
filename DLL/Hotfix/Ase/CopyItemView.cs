using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyItemView : UGuiView
{
	public Button btn;

	public TextMeshProUGUI rankName;

	public TextMeshProUGUI advLevel;

	public Image icon;

	public Image qualityImg;

	public GameObject redRoot;

	public GameObject normalRoot;

	public GameObject highDifficultyRoot;

	public GameObject lockRoot;

	public GameObject selectRoot;

	public CopyLockTextItem lockDesc;

	private CopyItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<CopyItemViewModel>(userData);
		BindingSet<CopyItemView, CopyItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((CopyItemViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenDetail");
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((CopyItemViewModel vm) => vm.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(qualityImg).For((Image v) => v.sprite).ToExpression((CopyItemViewModel vm) => $"copy_rarity_{vm.Quality}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(normalRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyItemViewModel vm) => !vm.Data.IsLock);
		bindingSet.Bind(lockRoot).For((GameObject v) => v.activeSelf).To((CopyItemViewModel vm) => vm.Data.IsLock);
		bindingSet.Bind(selectRoot).For((GameObject v) => v.activeSelf).To((CopyItemViewModel vm) => vm.IsSelect);
		bindingSet.Bind(redRoot).For((GameObject v) => v.activeSelf).To((CopyItemViewModel vm) => vm.Data.HasNew);
		bindingSet.Bind(lockDesc).For((CopyLockTextItem v) => v.CopyData).To((CopyItemViewModel vm) => vm.Data);
		bindingSet.Bind<TextMeshProUGUI>(advLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyItemViewModel vm) => vm.Data.MatchTeamLevel);
		bindingSet.Bind(highDifficultyRoot).For((GameObject v) => v.activeSelf).To((CopyItemViewModel vm) => vm.Data.IsHighDifficulty);
		bindingSet.Bind<TextMeshProUGUI>(rankName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyItemViewModel vm) => vm.Data.CopyRankName);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
