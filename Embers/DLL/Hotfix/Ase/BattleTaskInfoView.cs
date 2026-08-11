using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BattleTaskInfoView : UGuiView
{
	[SerializeField]
	private Transform trackRoot;

	[SerializeField]
	private GameObject trackPrefab;

	private BattleTaskInfoViewModel viewModel;

	public void Init(BattleTaskInfoViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<BattleTaskInfoView, BattleTaskInfoViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(this).For((BattleTaskInfoView v) => v.UpdateTrackTasks).To((BattleTaskInfoViewModel vm) => vm.UpdateTrackingTaskRequest);
		bindingSet.Build();
		UpdateTrackTasks();
	}

	private void UpdateTrackTasks(object sender = null, InteractionEventArgs e = null)
	{
		int childCount = trackRoot.childCount;
		List<TaskTrackViewModel> trackTasks = viewModel.TrackTasks;
		for (int i = 0; i < childCount; i++)
		{
			if (i < trackTasks.Count)
			{
				trackRoot.GetChild(i).GetComponent<TaskTrackView>().RefreshData(trackTasks[i]);
			}
		}
		for (int j = childCount; j < trackTasks.Count; j++)
		{
			if (trackTasks[j].IsShow)
			{
				Object.Instantiate(trackPrefab, trackRoot).GetComponent<TaskTrackView>().Init(trackTasks[j]);
			}
		}
	}

	public void RefreshData(BattleTaskInfoViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
