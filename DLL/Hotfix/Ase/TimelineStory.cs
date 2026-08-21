using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class TimelineStory
{
	private StoryShowEvent currentShowEvent;

	private Queue<StoryShowEvent> showStoryQue;

	public bool IsTimelinePlaying => currentShowEvent != null;

	public Queue<StoryShowEvent> ShowStoryQue => showStoryQue;

	public void Update()
	{
		if (currentShowEvent == null && showStoryQue != null && showStoryQue.Count > 0)
		{
			currentShowEvent = showStoryQue.Dequeue();
			currentShowEvent.Execute(delegate
			{
				currentShowEvent.Dispose();
				currentShowEvent = null;
			});
		}
	}

	public async UniTask<StoryEndType> Play(uint worldId, int timelineId, List<int> bankGroups, bool pause = true, BlackScreen blackScreen = null)
	{
		if (timelineId == 0)
		{
			return StoryEndType.Exception;
		}
		if (showStoryQue == null)
		{
			showStoryQue = new Queue<StoryShowEvent>();
		}
		AsyncResult<StoryEndResult> callback = new AsyncResult<StoryEndResult>(cancelable: true);
		StoryShowEvent showEvent = new StoryShowEvent(timelineId);
		showEvent.SetFunc(async delegate
		{
			await StartShowStoryTask(worldId, timelineId, callback, pause, blackScreen, showEvent, bankGroups);
		});
		if (showStoryQue.Count > 0)
		{
			showStoryQue.Enqueue(showEvent);
			return (await callback).endType;
		}
		currentShowEvent = showEvent;
		currentShowEvent?.Execute(delegate
		{
			currentShowEvent?.Dispose();
			currentShowEvent = null;
		});
		return (await callback).endType;
	}

	private async UniTask StartShowStoryTask(uint worldId, int timelineId, AsyncResult<StoryEndResult> result, bool pause, BlackScreen blackScreen, StoryShowEvent showEvent, List<int> bankGroups)
	{
		StoryViewModel timelineViewModel = new StoryViewModel();
		showEvent.SetViewModel(timelineViewModel);
		if (await timelineViewModel.Init(worldId, timelineId, pause, blackScreen))
		{
			await timelineViewModel.StartPlayBefore(bankGroups);
			await (await GameEntry.UI.LoadWindow<StoryWindow>(AssetUtility.GetUIFormAsset("Story/StoryWindow"), "TIMELINE", timelineViewModel)).DoShow(ignoreAnimation: true);
			await timelineViewModel.StartPlay();
			await UniTask.WaitUntil(() => timelineViewModel.IsFinish);
		}
		result.SetResult(new StoryEndResult
		{
			endType = timelineViewModel.EndType
		});
	}

	public void CloseNetworkNotify()
	{
		if (currentShowEvent != null)
		{
			currentShowEvent.ViewModel?.ForceStop();
			currentShowEvent.Dispose();
			currentShowEvent = null;
			showStoryQue.Clear();
		}
	}

	public void Dispose()
	{
		if (currentShowEvent != null)
		{
			currentShowEvent.ViewModel?.ForceStop();
			currentShowEvent.Dispose();
			currentShowEvent = null;
			showStoryQue.Clear();
		}
	}
}
