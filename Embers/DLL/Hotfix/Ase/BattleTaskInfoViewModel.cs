using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BattleTaskInfoViewModel : ViewModelBase
{
	private List<TaskTrackViewModel> trackTasks = new List<TaskTrackViewModel>();

	private InteractionRequest updateTrackingTaskRequest;

	public List<TaskTrackViewModel> TrackTasks => trackTasks;

	public InteractionRequest UpdateTrackingTaskRequest => updateTrackingTaskRequest;

	public BattleTaskInfoViewModel()
	{
		updateTrackingTaskRequest = new InteractionRequest(this);
		GetTrackTasks();
	}

	public void OnHeroPositionUpdate(Vector3 pos)
	{
		foreach (TaskTrackViewModel trackTask in trackTasks)
		{
			trackTask.UpdateItemPos(pos);
		}
	}

	private void GetTrackTasks()
	{
	}
}
