using System;
using System.Collections.Generic;
using Cinemachine;
using Cysharp.Threading.Tasks;
using FMOD.Studio;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.Playables;

namespace Ase;

public class StoryViewModel : OptionBase
{
	private PlayableDirector director;

	private TimelineDataContainer _storyDataContainer;

	private bool pause;

	private BlackScreen outterBlackScreen;

	private BlackScreen endBlackScreen;

	private uint playingWorldId;

	private string assetPath = string.Empty;

	private List<int> audioBankGroups;

	private StoryEndType endType;

	private bool startStory;

	private SimpleCommand skipCommand;

	private new InteractionRequest dismissRequest;

	private float windowAlpha;

	private bool isFinish;

	public bool IsVaild
	{
		get
		{
			if ((UnityEngine.Object)(object)_storyDataContainer != null)
			{
				return (UnityEngine.Object)(object)director != null;
			}
			return false;
		}
	}

	public StoryEndType EndType => endType;

	public bool StoryEnding => endType != StoryEndType.None;

	public ICommand SkipCommand => skipCommand;

	public new IInteractionRequest DismissRequest => dismissRequest;

	public float WindowAlpha
	{
		get
		{
			return windowAlpha;
		}
		private set
		{
			Set(ref windowAlpha, value, "WindowAlpha");
		}
	}

	public bool IsFinish
	{
		get
		{
			return isFinish;
		}
		private set
		{
			Set(ref isFinish, value, "IsFinish");
		}
	}

	public async UniTask<bool> Init(uint worldId, int timelineId, bool pause, BlackScreen blackScreen, PlayableDirector pd = null)
	{
		playingWorldId = worldId;
		this.pause = pause;
		if ((UnityEngine.Object)(object)pd != null)
		{
			director = pd;
		}
		else
		{
			assetPath = AssetUtility.GetStoryAsset($"Art/Timeline/Prefabs/{timelineId}.prefab");
			GameObject gameObject = await GameEntry.Resource.LoadAssetAsync<GameObject>(assetPath);
			if (gameObject == null)
			{
				blackScreen?.Dispose();
				endType = StoryEndType.Exception;
				return false;
			}
			director = UnityEngine.Object.Instantiate(gameObject).GetComponent<PlayableDirector>();
		}
		outterBlackScreen = blackScreen;
		dismissRequest = new InteractionRequest(this);
		skipCommand = new SimpleCommand(SkipCommandClick);
		endType = StoryEndType.None;
		startStory = false;
		BindCamera();
		director.timeUpdateMode = DirectorUpdateMode.UnscaledGameTime;
		((Component)(object)director).gameObject.SetActive(value: false);
		director.time = 0.0;
		director.RebuildGraph();
		RegisterCallback();
		RequestStoryPoint(timelineId);
		return true;
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

	private void BindCamera()
	{
		if (!((UnityEngine.Object)(object)director != null))
		{
			return;
		}
		foreach (PlayableBinding output in director.playableAsset.outputs)
		{
			if (output.outputTargetType == typeof(CinemachineBrain))
			{
				director.SetGenericBinding(output.sourceObject, (UnityEngine.Object)GameEntry.Camera.MainCamera.GetComponent<CinemachineBrain>());
			}
		}
		PlayableDirector[] componentsInChildren = ((Component)(object)director).GetComponentsInChildren<PlayableDirector>(true);
		foreach (PlayableDirector val in componentsInChildren)
		{
			if (val.playableAsset == null)
			{
				continue;
			}
			foreach (PlayableBinding output2 in val.playableAsset.outputs)
			{
				if (output2.outputTargetType == typeof(CinemachineBrain))
				{
					val.SetGenericBinding(output2.sourceObject, (UnityEngine.Object)GameEntry.Camera.MainCamera.GetComponent<CinemachineBrain>());
				}
			}
		}
	}

	private void RegisterCallback()
	{
		_storyDataContainer = ((Component)(object)director).GetComponent<TimelineDataContainer>();
		_storyDataContainer.Init();
		RemoveCallback();
		_storyDataContainer.OnEndSrory += OnEndStory;
	}

	private void RemoveCallback()
	{
		_storyDataContainer.OnEndSrory -= OnEndStory;
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
		RemoveCallback();
		GameEntry.Resource.UnloadAsset(assetPath);
	}

	public void StartPlayBattleWrold()
	{
		if (!StoryEnding)
		{
			WindowAlpha = 1f;
			((Component)(object)director).gameObject.SetActive(value: true);
			director.initialTime = 0.009999999776482582;
			director.RebuildGraph();
			director.Play();
			startStory = true;
		}
	}

	public async UniTask StartPlayBefore(List<int> bankGroups)
	{
		audioBankGroups = bankGroups;
		await CloseOtherUI();
	}

	public async UniTask StartPlay()
	{
		if (StoryEnding)
		{
			return;
		}
		BlackScreen blackScreen;
		if (outterBlackScreen != null)
		{
			blackScreen = outterBlackScreen;
		}
		else
		{
			blackScreen = await BlackScreen.Show("TIMELINE");
			if (pause && playingWorldId != 0)
			{
				Singleton<GameSystem>.Instance?.GetWorldPauseMessenger().Publish(new WorldPauseMessenger(this, playingWorldId, pause: true, transition: true));
			}
			await UniTask.WaitForSeconds(1);
		}
		if (!StoryEnding)
		{
			WindowAlpha = 1f;
			((Component)(object)director).gameObject.SetActive(value: true);
			director.initialTime = 0.009999999776482582;
			director.RebuildGraph();
			director.Play();
			blackScreen.Dispose();
			await UniTask.WaitForSeconds(1);
			if (!StoryEnding)
			{
				startStory = true;
			}
		}
	}

	public async UniTask StopPlay(StoryEndType endtype)
	{
		if (!StoryEnding)
		{
			Pause();
			endType = endtype;
			endBlackScreen = await BlackScreen.Show("TIMELINE");
			await new WaitForSecondsRealtime(1f);
			RemoveCallback();
			if ((UnityEngine.Object)(object)director != null)
			{
				UnityEngine.Object.DestroyImmediate(((Component)(object)director).gameObject);
			}
			Close();
			OpenOtherUI();
			endBlackScreen.Dispose();
			await UniTask.WaitForSeconds(0.75f);
			if (pause && playingWorldId != 0)
			{
				Singleton<GameSystem>.Instance?.GetWorldPauseMessenger().Publish(new WorldPauseMessenger(this, playingWorldId, pause: false));
			}
			GameEntry.Resource.UnloadUnusedAssets(performGCCollect: false);
			await UniTask.WaitForSeconds(0.45f);
			startStory = false;
			isFinish = true;
			ClearStoryBGM();
		}
	}

	private void ClearStoryBGM()
	{
		try
		{
			Singleton<AudioSystem>.Instance.ClearStoryBGM();
		}
		catch (Exception)
		{
		}
	}

	public void ForceStop()
	{
		endType = StoryEndType.Exception;
		if ((UnityEngine.Object)(object)director != null)
		{
			UnityEngine.Object.DestroyImmediate(((Component)(object)director).gameObject);
		}
		Close();
		OpenOtherUI();
		startStory = false;
		isFinish = true;
		GameEntry.Resource.UnloadUnusedAssets(performGCCollect: false);
	}

	private void SkipCommandClick()
	{
		if (startStory)
		{
			StopPlay(StoryEndType.Skip);
		}
	}

	private void Pause()
	{
		if ((UnityEngine.Object)(object)director != null && !director.playableGraph.IsDone())
		{
			director.Pause();
		}
	}

	private void Resume()
	{
		if ((UnityEngine.Object)(object)director != null && !director.playableGraph.IsDone())
		{
			director.Resume();
		}
	}

	private void OnEndStory(object sender, EventArgs e)
	{
		StopPlay(StoryEndType.End);
	}

	private async UniTask CloseOtherUI()
	{
		ShowCameraStoryLayer();
		if (playingWorldId != 0)
		{
			Singleton<GameSystem>.Instance?.GetWorldChannel(playingWorldId)?.GetSystem<BattleSystem>()?.ControlView(isShow: false);
		}
		Singleton<AudioSystem>.Instance.PlayGlobalSnapshot(990001);
		SetUIGroupInteractable("POPUP", canClick: false);
		SetUIGroupInteractable("DEFAULT", canClick: false);
		await LoadBankGroups(audioBankGroups);
	}

	private void OpenOtherUI()
	{
		HideCameraStoryLayer();
		if (playingWorldId != 0)
		{
			Singleton<GameSystem>.Instance?.GetWorldChannel(playingWorldId)?.GetSystem<BattleSystem>()?.ControlView(isShow: true);
		}
		Singleton<AudioSystem>.Instance.StopGlobalSnapshot(990001, (STOP_MODE)0);
		SetUIGroupInteractable("POPUP", canClick: true);
		SetUIGroupInteractable("DEFAULT", canClick: true);
		UnloadBankGroups(audioBankGroups);
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

	public void ShowCameraStoryLayer()
	{
		if (!(GameEntry.Camera.MainCamera == null))
		{
			GameEntry.Camera.MainCamera.cullingMask &= ~(1 << LayerMask.NameToLayer("Battle"));
			GameEntry.Camera.MainCamera.cullingMask |= 1 << LayerMask.NameToLayer("Story");
		}
	}

	public void HideCameraStoryLayer()
	{
		if (!(GameEntry.Camera.MainCamera == null))
		{
			GameEntry.Camera.MainCamera.cullingMask |= 1 << LayerMask.NameToLayer("Battle");
			GameEntry.Camera.MainCamera.cullingMask &= ~(1 << LayerMask.NameToLayer("Story"));
		}
	}

	public override void Close()
	{
		dismissRequest.Raise();
	}
}
