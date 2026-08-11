using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class MonsterCopyView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI taskDes;

	[SerializeField]
	private TextMeshProUGUI killCountText;

	private MonsterCopyViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<MonsterCopyViewModel>(userData);
		BindingSet<MonsterCopyView, MonsterCopyViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(taskDes).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MonsterCopyViewModel vm) => vm.TaskContent);
		bindingSet.Bind<TextMeshProUGUI>(killCountText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MonsterCopyViewModel vm) => vm.KillCount);
		bindingSet.Build();
		base.transform.parent = _viewModel.Root;
	}
}
