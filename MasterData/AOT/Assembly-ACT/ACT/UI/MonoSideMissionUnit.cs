using ACT.Battle;
using ACT.MissionSystem;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class MonoSideMissionUnit : MonoBehaviour
{
	[Header("任务成功")]
	public LocalizeStringEvent missionCompleteName;

	public GameObject missionCompleteState;

	[Header("任务开启")]
	public LocalizeStringEvent missionOpenName;

	public GameObject missionOpenState;

	[Header("动画")]
	public Animation animation;

	public BetterAnimation betterAnimation;

	public AnimatorSoundList soundList;

	[Header("任务打开")]
	public string openAnimationName = "Show";

	public int openSoundIndex;

	[Header("任务完成")]
	public string completeAnimationName = "Show";

	public int completeSoundIndex = 1;

	public void Pause()
	{
		foreach (AnimationState item in animation)
		{
			item.speed = 0f;
		}
	}

	public void Resume()
	{
		foreach (AnimationState item in animation)
		{
			item.speed = 1f;
		}
	}

	public async UniTask PlayAnimation(int missionId, bool isOpen)
	{
		missionOpenState.SetActive(isOpen);
		missionCompleteState.SetActive(!isOpen);
		MissionData missionData = Singleton<MissionManager>.instance.GetMissionData(missionId);
		if (isOpen)
		{
			missionOpenName.StringReference.TableReference = "shortcommon";
			missionOpenName.StringReference.TableEntryReference = missionData.Config.MissionBase.name;
			soundList?.PlaySound(openSoundIndex);
			if ((bool)betterAnimation)
			{
				await betterAnimation.GetSequence(openAnimationName).Play().AwaitComplete();
			}
		}
		else
		{
			missionCompleteName.StringReference.TableReference = "shortcommon";
			missionCompleteName.StringReference.TableEntryReference = missionData.Config.MissionBase.name;
			soundList?.PlaySound(completeSoundIndex);
			if ((bool)betterAnimation)
			{
				await betterAnimation.GetSequence(completeAnimationName).Play().AwaitComplete();
			}
		}
	}
}
