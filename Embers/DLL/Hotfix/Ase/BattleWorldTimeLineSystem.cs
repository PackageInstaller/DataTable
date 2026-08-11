#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using Ase.ECS;
using Cinemachine;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Ase;

public class BattleWorldTimeLineSystem : BaseSystem
{
	private PlayableDirector director;

	private DRBattleTimeline timelineData;

	private BattleTimelineConfig battleTimelineConfig;

	private BattleTimelineCastingViewModel _castingViewModel;

	private BattleTimelineCastingWindow _castingWindow;

	private CinemachineVirtualCamera camera;

	protected override bool IsLogicSystem => false;

	public override async UniTask<bool> OnEnter(object data = null)
	{
		int timelineId = 0;
		if (data is LockstepBattleWorldData { LockStepWorldType: LockStepWorldType.Reconnect })
		{
			return true;
		}
		if (data is BattleWorldData battleWorldData)
		{
			DRMonsterAttr dataRow = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(battleWorldData.BossId);
			if (dataRow != null)
			{
				timelineId = dataRow.MonsterType;
			}
		}
		await PrepareTimeine(timelineId);
		return true;
	}

	public override void OnAwake(object data = null)
	{
		MonsterEntity monsterEntity = world.GetSystem<BattleSystem>().GetMonsterEntity();
		if (monsterEntity != null)
		{
			InjectTimelineActor(monsterEntity.GetComponent<EntityViewComponent>().Transform.gameObject);
		}
	}

	public async UniTask PlayTimeline(int timelineId, GameObject actor)
	{
		_ = 1;
		try
		{
			if (await PrepareTimeine(timelineId))
			{
				InjectTimelineActor(actor);
				await Show();
			}
		}
		catch (Exception ex)
		{
			Log.Error("战斗演出播放失败" + ex);
		}
	}

	private async UniTask<bool> PrepareTimeine(int timelineId)
	{
		timelineData = GameEntry.DataTable.GetDataRow<DRBattleTimeline>(timelineId);
		if (timelineData != null)
		{
			string timeLineAsset = AssetUtility.GetTimeLineAsset(timelineData.Path);
			if (!GameEntry.Resource.CheckLocationValid(timeLineAsset))
			{
				Log.Error("timeline路径不对 " + timeLineAsset);
				return true;
			}
			if (timelineData.ShowForms == 0 || timelineData.ShowForms == 1)
			{
				director = UnityEngine.Object.Instantiate(await GameEntry.Resource.LoadAssetAsync<GameObject>(timeLineAsset)).GetComponent<PlayableDirector>();
				director.timeUpdateMode = DirectorUpdateMode.UnscaledGameTime;
				((Component)(object)director).gameObject.SetActive(value: false);
				director.time = 0.0;
				director.RebuildGraph();
				battleTimelineConfig = ((Component)(object)director).GetComponent<BattleTimelineConfig>();
			}
			else
			{
				_castingViewModel = new BattleTimelineCastingViewModel();
				_castingWindow = await GameEntry.UI.LoadWindow<BattleTimelineCastingWindow>(timeLineAsset, "DEFAULT", _castingViewModel);
			}
		}
		return true;
	}

	private async void InjectTimelineActor(GameObject actor)
	{
		if (timelineData == null)
		{
			return;
		}
		if ((bool)(UnityEngine.Object)(object)director)
		{
			if (!battleTimelineConfig)
			{
				return;
			}
			PlayableAsset playableAsset = director.playableAsset;
			TimelineAsset val = (TimelineAsset)(object)((playableAsset is TimelineAsset) ? playableAsset : null);
			if (val != null)
			{
				if (battleTimelineConfig.groupOnly)
				{
					FixByGroup(val, actor);
				}
				else
				{
					FixByTrack(val, actor);
				}
			}
			((Component)(object)director).gameObject.SetActive(value: true);
		}
		else if ((bool)_castingWindow)
		{
			camera = GetSystem<VirtualCameraSystem>().CreateTimelineCameraByOtherCamera();
			camera.m_Priority++;
			camera.Follow = actor.transform;
			CinemachineFramingTransposerAp cinemachineComponent = camera.GetCinemachineComponent<CinemachineFramingTransposerAp>();
			if (timelineData.Offset.Count == 3)
			{
				cinemachineComponent.m_TrackedObjectOffset = new Vector3(timelineData.Offset[0], timelineData.Offset[1], timelineData.Offset[2]);
			}
		}
	}

	private void FixByGroup(TimelineAsset timeline, GameObject actor)
	{
		foreach (TrackAsset rootTrack in timeline.GetRootTracks())
		{
			GroupTrack val = (GroupTrack)(object)((rootTrack is GroupTrack) ? rootTrack : null);
			if (val == null || !battleTimelineConfig.ContainsGroup(((UnityEngine.Object)(object)rootTrack).name))
			{
				continue;
			}
			foreach (TrackAsset childTrack in ((TrackAsset)val).GetChildTracks())
			{
				DoRealFix(childTrack, actor);
			}
		}
	}

	private void FixByTrack(TimelineAsset timeline, GameObject actor)
	{
		foreach (TrackAsset outputTrack in timeline.GetOutputTracks())
		{
			if (battleTimelineConfig.ContainsTrack(((UnityEngine.Object)(object)outputTrack).name))
			{
				DoRealFix(outputTrack, actor);
			}
		}
	}

	private void DoRealFix(TrackAsset track, GameObject actor)
	{
		if (((object)track).GetType() == typeof(AnimationTrack))
		{
			director.SetGenericBinding((UnityEngine.Object)(object)track, (UnityEngine.Object)(object)actor.GetComponent<AnimatorComponent>().Animator);
		}
		else
		{
			if (!(((object)track).GetType() == typeof(CinemachineTrack)))
			{
				return;
			}
			foreach (TimelineClip clip in track.GetClips())
			{
				CinemachineShot cinemachineShot = clip.asset as CinemachineShot;
				if (cinemachineShot != null)
				{
					CinemachineVirtualCameraBase cinemachineVirtualCameraBase = cinemachineShot.VirtualCamera.Resolve(director.playableGraph.GetResolver());
					if (string.IsNullOrEmpty(timelineData.Paramter) || timelineData.Paramter == "Follow")
					{
						cinemachineVirtualCameraBase.Follow = actor.transform;
					}
					else if (timelineData.Paramter == "LookAt")
					{
						cinemachineVirtualCameraBase.LookAt = actor.transform;
					}
				}
			}
		}
	}

	public override async UniTask OnStartBefore(object data = null)
	{
		await Show();
	}

	private async UniTask Show()
	{
		if (timelineData != null)
		{
			if ((bool)(UnityEngine.Object)(object)director)
			{
				((Component)(object)director).gameObject.SetActive(value: true);
				director.initialTime = ((timelineData.StartTime != 0f) ? timelineData.StartTime : 0.01f);
				director.RebuildGraph();
				director.Play();
				await UniTask.WaitForSeconds(timelineData.Duration);
			}
			else if ((bool)_castingWindow)
			{
				await _castingWindow.Show();
				await UniTask.WaitForSeconds(timelineData.Duration);
			}
			if (timelineData == null || !timelineData.EndBlack)
			{
				await OnCloseWindowOrTimeline(endBlack: false);
				return;
			}
			BlackScreen blackScreen = await BlackScreen.Show("TIMELINE");
			await UniTask.WaitForSeconds(1);
			OnCloseWindowOrTimeline(endBlack: true);
			blackScreen.Dispose();
		}
	}

	private async UniTask OnCloseWindowOrTimeline(bool endBlack)
	{
		if ((bool)(UnityEngine.Object)(object)director)
		{
			UnityEngine.Object.Destroy(((Component)(object)director).gameObject);
			director = null;
		}
		else if ((bool)_castingWindow)
		{
			_castingWindow.CloseUI();
			_castingViewModel?.Close();
			_castingWindow = null;
		}
		if ((bool)camera)
		{
			if (!endBlack)
			{
				camera.enabled = false;
				await UniTask.WaitForSeconds(world?.CameraConfig?.battleDefaultBlendTime ?? 1.5f);
			}
			UnityEngine.Object.Destroy(camera.gameObject);
			camera = null;
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		OnCloseWindowOrTimeline(endBlack: true);
		timelineData = null;
		battleTimelineConfig = null;
		director = null;
		_castingWindow = null;
		_castingViewModel = null;
	}
}
