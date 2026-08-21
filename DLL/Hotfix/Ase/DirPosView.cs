using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class DirPosView : UGuiView
{
	[SerializeField]
	private TaskUIPointDirView uIPointDirView;

	[SerializeField]
	private Transform dirUIParent;

	private DirPosViewModel viewModel;

	private List<TaskUIPointDirView> _taskUIPointDirViews;

	protected override void OnInit(object userData)
	{
		viewModel = (DirPosViewModel)userData;
		BindingSet<DirPosView, DirPosViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((DirPosView v) => v.UpdateDirUI).To((DirPosViewModel vm) => vm.UpdateDirUIPosRequest);
		bindingSet.Build();
	}

	private void UpdateDirUI(object sender, InteractionEventArgs e)
	{
		ShowTaskUIPos();
	}

	private void ShowTaskUIPos()
	{
		List<BattleTaskUIPosViewModel> battleTaskUIPosViewModels = viewModel.BattleTaskUIPosViewModels;
		if (battleTaskUIPosViewModels == null)
		{
			return;
		}
		if (_taskUIPointDirViews == null)
		{
			_taskUIPointDirViews = new List<TaskUIPointDirView>(battleTaskUIPosViewModels.Count);
		}
		int count = battleTaskUIPosViewModels.Count;
		int count2 = _taskUIPointDirViews.Count;
		if (count2 < count)
		{
			for (int i = count2 + 1; i <= count; i++)
			{
				TaskUIPointDirView component = Object.Instantiate(uIPointDirView.gameObject, dirUIParent).GetComponent<TaskUIPointDirView>();
				_taskUIPointDirViews.Add(component);
			}
		}
		else if (count2 > count)
		{
			for (int j = count; j < count2; j++)
			{
				_taskUIPointDirViews[j].gameObject.SetActive(value: false);
			}
		}
		for (int k = 0; k < count; k++)
		{
			_taskUIPointDirViews[k].gameObject.SetActive(value: true);
			if (!_taskUIPointDirViews[k].InitFinish)
			{
				_taskUIPointDirViews[k].Init(battleTaskUIPosViewModels[k]);
			}
			else
			{
				_taskUIPointDirViews[k].RefreshData(battleTaskUIPosViewModels[k]);
			}
		}
	}
}
