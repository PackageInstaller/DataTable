using System.Threading;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TaskTip_Success : TaskTip_Base
{
	public BImage missionTypeImage;

	public LocalizeStringEvent missionName;

	public LocalizeStringEvent missionContent;

	public async UniTask Play(MissionStateAdapter missionInfoAdapter)
	{
		CancellationToken cancellationTokenOnDestroy = gameObject.GetCancellationTokenOnDestroy();
		ImageAssetStation imageStation = GetImageStation();
		int missionType = missionInfoAdapter.GetMissionType();
		string arg = missionInfoAdapter.GetMissionName();
		string missionTitle = missionInfoAdapter.GetMissionTitle();
		imageStation?.LoadImage(200, missionType, missionTypeImage);
		missionName.OnUpdateString?.Invoke(arg);
		missionContent.OnUpdateString?.Invoke(missionTitle);
		Manager.animationController.SetTrigger(TaskTip_Base.Complete);
		await UniTask.WaitUntil(() => !IsPlaying(), PlayerLoopTiming.Update, cancellationTokenOnDestroy);
	}

	private bool IsPlaying()
	{
		AnimatorStateInfo currentAnimatorStateInfo = Manager.animationController.GetCurrentAnimatorStateInfo(0);
		if (currentAnimatorStateInfo.normalizedTime >= 1f)
		{
			return currentAnimatorStateInfo.IsName("Base.TaskCompleteShow");
		}
		return false;
	}
}
