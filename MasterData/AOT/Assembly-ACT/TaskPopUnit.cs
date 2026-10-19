using ACT.Battle;
using ACT.MissionSystem;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

public class TaskPopUnit : MonoBehaviour
{
	[Header("任务成功")]
	public LocalizeStringEvent missionCompleteName;

	public LocalizeStringEvent missionCompleteChapter;

	[Header("任务开启")]
	public LocalizeStringEvent missionOpenName;

	public LocalizeStringEvent missionOpenChapter;

	public AnimatorSoundList soundList;

	public BetterAnimation betterAnimation;

	[Header("任务打开")]
	public string openAnimationName = "Open";

	public int openSoundIndex;

	[Header("任务完成")]
	public string completeAnimationName = "Closed";

	public int completeSoundIndex = 1;

	public async UniTask PlayAnimation(int missionId, bool isOpen)
	{
		MissionData missionData = Singleton<MissionManager>.instance.GetMissionData(missionId);
		if (isOpen)
		{
			missionOpenName.StringReference.TableReference = "shortcommon";
			missionOpenChapter.StringReference.TableReference = "shortcommon";
			missionOpenName.OnUpdateString?.Invoke(missionData.Config.GetGroupDescription());
			missionOpenChapter.OnUpdateString?.Invoke(missionData.Config.GetMissionChapterSubTitle() + ":" + missionData.Config.GetMissionChapterTitle());
			soundList.PlaySound(openSoundIndex);
			if ((bool)betterAnimation)
			{
				AnimationBuilder sequence = betterAnimation.GetSequence(openAnimationName);
				if (sequence != null)
				{
					await sequence.Play().AwaitComplete();
				}
			}
			return;
		}
		missionCompleteName.StringReference.TableReference = "shortcommon";
		missionCompleteChapter.StringReference.TableReference = "shortcommon";
		missionOpenName.OnUpdateString?.Invoke(missionData.Config.GetGroupDescription());
		missionOpenChapter.OnUpdateString?.Invoke(missionData.Config.GetMissionChapterSubTitle() + ":" + missionData.Config.GetMissionChapterTitle());
		soundList.PlaySound(completeSoundIndex);
		if ((bool)betterAnimation)
		{
			AnimationBuilder sequence2 = betterAnimation.GetSequence(completeAnimationName);
			if (sequence2 != null)
			{
				await sequence2.Play().AwaitComplete();
			}
		}
	}
}
