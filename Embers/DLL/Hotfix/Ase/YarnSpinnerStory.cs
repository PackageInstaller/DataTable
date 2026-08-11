using System;
using System.Collections.Generic;
using System.Globalization;
using Cysharp.Threading.Tasks;
using FMOD.Studio;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class YarnSpinnerStory
{
	private bool isStoryPlaying;

	public string textLanguageCode = CultureInfo.CurrentCulture.Name;

	private YarnSpinnerStoryWindow storyWindow;

	private YarnSpinnerStoryViewModel storyViewModel;

	public async void Init()
	{
		storyViewModel = new YarnSpinnerStoryViewModel();
		storyWindow = await GameEntry.UI.LoadWindow<YarnSpinnerStoryWindow>(AssetUtility.GetUIFormAsset("Story/YarnSpinnerStoryWindow"), "TIMELINE", storyViewModel);
		UpdateState(null);
	}

	public void UpdateState(AccounetLoginNotifyMessager messager)
	{
		storyWindow.UpdateState(GameEntry.Setting.GetBool("剧情自动"), GameEntry.Setting.GetBool("剧情倍速"));
	}

	public async UniTask<StoryEndType> Play(uint worldId, DRStory storyConfig, List<int> bankGroups, BlackScreen blackScreen = null)
	{
		if (isStoryPlaying)
		{
			return StoryEndType.Exception;
		}
		isStoryPlaying = true;
		if (worldId != 0)
		{
			Singleton<GameSystem>.Instance?.GetWorldPauseMessenger().Publish(new WorldPauseMessenger(this, worldId, pause: true, transition: true));
			Singleton<GameSystem>.Instance?.GetWorldChannel(worldId)?.GetSystem<BattleSystem>()?.ControlView(isShow: false);
			SetUIGroupInteractable("POPUP", canClick: false);
			SetUIGroupInteractable("DEFAULT", canClick: false);
		}
		Singleton<AudioSystem>.Instance.PlayGlobalSnapshot(990001);
		await LoadBankGroups(bankGroups);
		if (blackScreen == null)
		{
			blackScreen = await BlackScreen.Show("TIMELINE");
			await UniTask.WaitForSeconds(1);
		}
		string assetPath = AssetUtility.GetStoryAsset($"Art/Story/StoryAssets/{storyConfig.Id}.asset");
		StoryAssets storyAssets = await GameEntry.Resource.LoadAssetAsync<StoryAssets>(assetPath, "Story");
		if ((UnityEngine.Object)(object)storyAssets == null)
		{
			return StoryEndType.Exception;
		}
		RequestStoryPoint(storyConfig.Id);
		await storyWindow.DoShow(ignoreAnimation: true);
		await storyWindow.Play(storyConfig, storyAssets, textLanguageCode);
		blackScreen.Dispose();
		await UniTask.WaitForSeconds(1);
		await storyWindow.WaitOnStoryEnd();
		storyWindow.ResetState();
		blackScreen = await BlackScreen.Show("TIMELINE");
		await UniTask.WaitForSeconds(1);
		await storyWindow.Stop();
		if (worldId != 0)
		{
			Singleton<GameSystem>.Instance?.GetWorldPauseMessenger().Publish(new WorldPauseMessenger(this, worldId, pause: false));
			Singleton<GameSystem>.Instance?.GetWorldChannel(worldId)?.GetSystem<BattleSystem>()?.ControlView(isShow: true);
			SetUIGroupInteractable("POPUP", canClick: true);
			SetUIGroupInteractable("DEFAULT", canClick: true);
		}
		Singleton<AudioSystem>.Instance.StopGlobalSnapshot(990001, (STOP_MODE)0);
		blackScreen.Dispose();
		GameEntry.Resource.UnloadUnusedAssets(performGCCollect: false);
		GameEntry.Resource.UnloadAsset(assetPath, "Story");
		await UniTask.WaitForSeconds(1.2f);
		UnloadBankGroups(bankGroups);
		isStoryPlaying = false;
		return StoryEndType.End;
	}

	public async UniTask WaitEnd()
	{
		await UniTask.WaitUntil(() => !isStoryPlaying);
	}

	private void SetUIGroupInteractable(string groupName, bool canClick)
	{
		WindowContainer uIGroup = GameEntry.UI.GetUIGroup(groupName);
		if (uIGroup != null)
		{
			uIGroup.CanvasGroup.interactable = canClick;
			uIGroup.CanvasGroup.blocksRaycasts = canClick;
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

	public void CloseNetworkNotify()
	{
		if (storyWindow != null)
		{
			storyWindow.OnCloseNetwork();
		}
		isStoryPlaying = false;
	}

	public void Dispose()
	{
		if (storyWindow != null)
		{
			storyWindow.OnCloseNetwork();
		}
		isStoryPlaying = false;
	}

	private async void RequestStoryPoint(int id)
	{
		UpdateHandbookRequest request = UpdateHandbookRequest.Create();
		request.Id = id;
		UpdateHandbookResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<UpdateHandbookResponse>(request);
			Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "播放剧情", "播放剧情错误");
		}
		catch (Exception)
		{
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
	}

	public void StoryQuit()
	{
		if (storyWindow != null)
		{
			storyWindow.StoryQuit();
		}
	}
}
