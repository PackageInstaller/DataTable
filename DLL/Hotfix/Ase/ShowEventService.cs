using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public class ShowEventService
{
	private PopupEvent currentShowEvent;

	private Queue<PopupEvent> showQueues;

	public ShowEventService()
	{
		showQueues = new Queue<PopupEvent>();
		Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().AddShowGetBPListener(OnShowGetBPNotify);
	}

	public void AddTaskShowEvent(int taskId, Func<UniTask> showEvent)
	{
		if (showQueues.IndexOf((PopupEvent popupEvent) => popupEvent is TaskShowEvent taskShowEvent && taskShowEvent.TaskId == taskId) == -1)
		{
			showQueues.Enqueue(new TaskShowEvent(taskId, showEvent));
		}
	}

	public void AddBattlePropGetShowEvent(BattlePropGetViewModel battlePropGetViewModel, Func<UniTask> showEvent)
	{
		if (showQueues.IndexOf((PopupEvent popupEvent) => popupEvent is BattlePropGetShowEvent battlePropGetShowEvent && battlePropGetShowEvent.BattlePropGetViewModel == battlePropGetViewModel) == -1)
		{
			showQueues.Enqueue(new BattlePropGetShowEvent(battlePropGetViewModel, showEvent));
		}
	}

	public void AddKillRewardShowEvent(Func<UniTask> showEvent)
	{
		showQueues.Enqueue(new KillRewardShowEvent(showEvent));
	}

	public void Update()
	{
		if (currentShowEvent == null && showQueues != null && showQueues.Count > 0)
		{
			currentShowEvent = showQueues.Dequeue();
			currentShowEvent.Execute(delegate
			{
				currentShowEvent = null;
			});
		}
	}

	private void OnShowGetBPNotify(BattlePropGetViewModel battlePropGetViewModel)
	{
		AddBattlePropGetShowEvent(battlePropGetViewModel, async delegate
		{
			await (await GameEntry.UI.LoadWindow<BattlePropGetWindow>(AssetUtility.GetUIFormAsset("BattleProp/BattlePropGetWindow"), "POPUP", battlePropGetViewModel)).DoShow();
			await UniTask.WaitUntil(() => battlePropGetViewModel.IsCloseView);
		});
	}
}
