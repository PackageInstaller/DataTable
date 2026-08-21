using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class Story : Singleton<Story>, ISingletonAwake, ISingletonUpdate, ISingletonLateUpdate
{
	private YarnSpinnerStory yarnSpinnerStory;

	private TimelineStory timelineStory;

	private StoryTipViewModel storyTipViewModel;

	private ISubscription<AccounetLoginNotifyMessager> accounetLoginNotifySubscription;

	public async UniTask<bool> PlayStory(uint worldId, int storyId, bool pause = true, BlackScreen blackScreen = null)
	{
		if (storyId == 0)
		{
			return false;
		}
		DRStory dataRow = GameEntry.DataTable.GetDataRow<DRStory>(storyId);
		if (dataRow == null)
		{
			return false;
		}
		List<int> bankGroups = dataRow.BankGroups;
		float playTime = Time.realtimeSinceStartup;
		if (storyTipViewModel != null)
		{
			storyTipViewModel.StopPopTip();
		}
		StoryEndType storyEndType = ((!dataRow.Is2DMode) ? (await timelineStory.Play(worldId, storyId, bankGroups, pause, blackScreen)) : (await yarnSpinnerStory.Play(worldId, dataRow, bankGroups, blackScreen)));
		if (storyTipViewModel != null)
		{
			storyTipViewModel.StopPopTip();
		}
		TDAHandler.Instance.LevelPlayStory(storyId, Time.realtimeSinceStartup - playTime, storyEndType == StoryEndType.Skip);
		if (storyEndType == StoryEndType.End || storyEndType == StoryEndType.Skip)
		{
			return true;
		}
		return false;
	}

	public async UniTask<bool> JumpToStory(uint worldId, int storyId, bool pause = true, BlackScreen blackScreen = null)
	{
		if (blackScreen == null)
		{
			blackScreen = await BlackScreen.Show("TIMELINE");
			await UniTask.WaitForSeconds(1);
		}
		await yarnSpinnerStory.WaitEnd();
		return await PlayStory(worldId, storyId, pause, blackScreen);
	}

	public void ExecuteEvent(List<TimelineEventTrigger> triggers)
	{
		if (triggers == null || triggers.Count == 0)
		{
			return;
		}
		foreach (TimelineEventTrigger trigger in triggers)
		{
			if ((bool)(Object)(object)trigger)
			{
				trigger.Execute();
			}
		}
	}

	private async UniTask LoadBankGroups(List<int> bankGroupIds)
	{
		if (bankGroupIds == null || bankGroupIds.Count == 0)
		{
			return;
		}
		DRBankGroup[] dataRows = GameEntry.DataTable.GetDataRows((DRBankGroup data) => bankGroupIds.Contains(data.Id));
		if (dataRows != null)
		{
			DRBankGroup[] array = dataRows;
			for (int num = 0; num < array.Length; num++)
			{
				await AudioHelper.LoadBanksByGroup(array[num]);
			}
		}
	}

	private void UnloadBankGroups(List<int> bankGroupIds)
	{
		if (bankGroupIds == null || bankGroupIds.Count == 0)
		{
			return;
		}
		DRBankGroup[] dataRows = GameEntry.DataTable.GetDataRows((DRBankGroup data) => bankGroupIds.Contains(data.Id));
		if (dataRows != null)
		{
			DRBankGroup[] array = dataRows;
			for (int num = 0; num < array.Length; num++)
			{
				AudioHelper.UnloadBankByGroup(array[num]);
			}
		}
	}

	public async UniTask InitPopupWindow()
	{
		storyTipViewModel = new StoryTipViewModel();
		await GameEntry.UI.OpenWindow<StoryTipWindow>("Story/StoryTips/StoryTipWindow", "DEFAULT", storyTipViewModel, delegate
		{
			storyTipViewModel = null;
		});
	}

	public async void PlayQueueTip(PopupTipType type, int queueId)
	{
		if (storyTipViewModel == null)
		{
			await InitPopupWindow();
		}
		storyTipViewModel.PlayQueueTip(type, queueId);
	}

	public async void PlayStoryQueueTip(int queueId)
	{
		if (storyTipViewModel == null)
		{
			await InitPopupWindow();
		}
		PlayQueueTip(PopupTipType.Story, queueId);
	}

	public async void PlayTaskQueueTip(int queueId)
	{
		if (storyTipViewModel == null)
		{
			await InitPopupWindow();
		}
		PlayQueueTip(PopupTipType.Task, queueId);
	}

	public void Awake()
	{
		timelineStory = new TimelineStory();
		yarnSpinnerStory = new YarnSpinnerStory();
		yarnSpinnerStory.Init();
		accounetLoginNotifySubscription = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<AccounetLoginNotifyMessager>(yarnSpinnerStory.UpdateState);
	}

	void ISingletonUpdate.Update()
	{
		OnUpdate();
	}

	public void LateUpdate()
	{
	}

	public void OnUpdate()
	{
		if (storyTipViewModel != null)
		{
			storyTipViewModel.PopupUpdate();
		}
		if (timelineStory != null)
		{
			timelineStory.Update();
		}
	}

	public void CloseNetworkNotify()
	{
		if (storyTipViewModel != null)
		{
			storyTipViewModel.StopPopTip();
			storyTipViewModel.Dispose();
			storyTipViewModel = null;
		}
		if (yarnSpinnerStory != null)
		{
			yarnSpinnerStory.CloseNetworkNotify();
		}
		if (timelineStory != null)
		{
			timelineStory.CloseNetworkNotify();
		}
	}

	public override void Dispose()
	{
		if (storyTipViewModel != null)
		{
			storyTipViewModel.StopPopTip();
			storyTipViewModel.Dispose();
			storyTipViewModel = null;
		}
		if (yarnSpinnerStory != null)
		{
			yarnSpinnerStory.Dispose();
			yarnSpinnerStory = null;
		}
		if (timelineStory != null)
		{
			timelineStory.Dispose();
			yarnSpinnerStory = null;
		}
		if (accounetLoginNotifySubscription != null)
		{
			accounetLoginNotifySubscription.Dispose();
			accounetLoginNotifySubscription = null;
		}
	}

	public void StoryQuit()
	{
		if (yarnSpinnerStory != null)
		{
			yarnSpinnerStory.StoryQuit();
		}
	}
}
