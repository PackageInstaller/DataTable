using System;
using System.Threading;
using ACT.MissionSystem;
using ACT.Sound;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TaskTip_New : TaskTip_Base
{
	public ActButton tracingButton;

	public BImage missionTypeImage;

	public LocalizeStringEvent missionName;

	public LocalizeStringEvent missionContent;

	public AudioEventReference soundOnPlay;

	private MissionStateAdapter m_NewMission;

	private void Awake()
	{
		tracingButton?.SetBtnClick(OnTracingClick);
	}

	public async UniTask Play(MissionStateAdapter missionInfoAdapter)
	{
		if (gameObject == null)
		{
			return;
		}
		m_NewMission = missionInfoAdapter;
		CancellationToken token = gameObject.GetCancellationTokenOnDestroy();
		ImageAssetStation imageStation = GetImageStation();
		int missionType = missionInfoAdapter.GetMissionType();
		string missionName = missionInfoAdapter.GetMissionName();
		string missionTitle = missionInfoAdapter.GetMissionTitle();
		try
		{
			if (imageStation != null)
			{
				await imageStation.LoadImageAsync(200, missionType, missionTypeImage).AttachExternalCancellation(token);
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		if (Manager == null)
		{
			return;
		}
		this.missionName.OnUpdateString?.Invoke(missionName);
		missionContent.OnUpdateString?.Invoke(missionTitle);
		if (!soundOnPlay.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(soundOnPlay);
		}
		if (missionInfoAdapter.IsFirstMissionInGroup())
		{
			Manager.animationController.SetTrigger(TaskTip_Base.New);
			await UniTask.WaitUntil(() => Manager == null || !IsPlaying(), PlayerLoopTiming.Update, token);
		}
		else
		{
			Manager.animationController.SetTrigger(TaskTip_Base.UpdateParam);
			await UniTask.WaitUntil(() => Manager == null || !IsPlayingA(), PlayerLoopTiming.Update, token);
		}
	}

	private void OnTracingClick()
	{
		if (m_NewMission != null)
		{
			Singleton<MissionManager>.instance.RequestTracingMission(m_NewMission.Id);
		}
	}

	private bool IsPlaying()
	{
		AnimatorStateInfo currentAnimatorStateInfo = Manager.animationController.GetCurrentAnimatorStateInfo(0);
		if (currentAnimatorStateInfo.normalizedTime >= 1f)
		{
			return currentAnimatorStateInfo.IsName("Base.TaskNewShow");
		}
		return false;
	}

	private bool IsPlayingA()
	{
		AnimatorStateInfo currentAnimatorStateInfo = Manager.animationController.GetCurrentAnimatorStateInfo(0);
		if (currentAnimatorStateInfo.normalizedTime >= 1f)
		{
			return currentAnimatorStateInfo.IsName("Base.TaskUpdateShow");
		}
		return false;
	}
}
