using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using Spine;
using Spine.Unity;
using UnityEngine;

namespace Ase;

public class CastingWindow : UGuiWindow
{
	private CastingViewModel viewModel;

	public int DelayTime = 1500;

	public int LifeTime = 2000;

	private CastingSkeleton[] resetCastingSkeletonDatas;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<CastingViewModel>();
		CanvasGroup.blocksRaycasts = false;
		CanvasGroup.interactable = false;
		GetSpineData();
	}

	protected override async void OnShow()
	{
		ResetAnimationToStart();
		await UniTask.Delay(LifeTime);
		if (!base.Dismissed)
		{
			Visibility = false;
		}
	}

	public void ResetAnimationToStart()
	{
		if (resetCastingSkeletonDatas == null || resetCastingSkeletonDatas.Length == 0)
		{
			return;
		}
		CastingSkeleton[] array = resetCastingSkeletonDatas;
		foreach (CastingSkeleton castingSkeleton in array)
		{
			if ((Object)(object)castingSkeleton.SkeletonGraphic == null)
			{
				break;
			}
			castingSkeleton.SkeletonGraphic.AnimationState.ClearTracks();
			castingSkeleton.SkeletonGraphic.Skeleton.SetToSetupPose();
			castingSkeleton.SkeletonGraphic.Update(0f);
			TrackEntry trackEntry = castingSkeleton.SkeletonGraphic.AnimationState.SetAnimation(0, castingSkeleton.AnimationName, loop: false);
			trackEntry.AnimationStart = castingSkeleton.StartTime;
			trackEntry.TrackTime = castingSkeleton.StartTime;
		}
	}

	public void CloseUI()
	{
		Close();
	}

	private void GetSpineData()
	{
		SkeletonGraphic[] componentsInChildren = base.transform.GetComponentsInChildren<SkeletonGraphic>();
		resetCastingSkeletonDatas = new CastingSkeleton[componentsInChildren.Length];
		for (int i = 0; i < resetCastingSkeletonDatas.Length; i++)
		{
			resetCastingSkeletonDatas[i] = new CastingSkeleton();
			resetCastingSkeletonDatas[i].SkeletonGraphic = componentsInChildren[i];
			resetCastingSkeletonDatas[i].AnimationName = componentsInChildren[i].startingAnimation;
		}
	}
}
