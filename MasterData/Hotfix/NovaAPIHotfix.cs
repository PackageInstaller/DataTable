using System;
using System.Collections.Generic;
using Cinemachine;
using Coffee.UIEffects;
using Spine;
using Spine.Unity;
using TrueSync;
using UnityEngine;
using UnityEngine.Playables;

public static class NovaAPIHotfix
{
	private const string TimelineCameraTrackName = "CAMERA";

	public static void BindTimelineCameraBrain(GameObject obj, CinemachineBrain cameraBrain)
	{
		if (obj.TryGetComponent<PlayableDirector>(out var component))
		{
			component.SetGenericBinding("CAMERA", cameraBrain);
		}
	}

	public static void PlayTimeline(GameObject obj)
	{
		if (obj.TryGetComponent<PlayableDirector>(out var component))
		{
			component.Stop();
			component.time = 0.0;
			component.Evaluate();
			component.Play();
		}
	}

	public static void PlayL2DAnim(Transform tr, string sAnimClipName, bool bLoop, bool bForcePlay)
	{
		if (tr == null || string.IsNullOrEmpty(sAnimClipName))
		{
			return;
		}
		L2DAnimPlayer[] componentsInChildren = tr.GetComponentsInChildren<L2DAnimPlayer>();
		if (componentsInChildren == null)
		{
			return;
		}
		int num = componentsInChildren.Length;
		if (num > 0)
		{
			for (int i = 0; i < num; i++)
			{
				componentsInChildren[i].PlayAnimInUI(sAnimClipName, bLoop, bForcePlay);
			}
		}
	}

	public static void SkipL2DCGAnim(Transform tr)
	{
		PlayableDirector component = tr.GetComponent<PlayableDirector>();
		if (!(component != null) || !(component.playableAsset != null) || component.state != PlayState.Playing)
		{
			return;
		}
		L2DAnimPlayer[] componentsInChildren = tr.GetComponentsInChildren<L2DAnimPlayer>();
		if (componentsInChildren == null)
		{
			return;
		}
		int num = componentsInChildren.Length;
		if (num > 0)
		{
			for (int i = 0; i < num; i++)
			{
				componentsInChildren[i].bSkipL2DCGAnim = true;
			}
			component.time = component.duration;
		}
	}

	public static int CheckL2DAnimEventCount(GameObject goL2D, string sAnimName)
	{
		if (goL2D == null)
		{
			return 0;
		}
		L2DAnimPlayer[] componentsInChildren = goL2D.GetComponentsInChildren<L2DAnimPlayer>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (componentsInChildren[i].gameObject.name.EndsWith("_a") || componentsInChildren[i].gameObject.name.EndsWith("_F"))
			{
				return componentsInChildren[i].CheckL2DAnimEventCount(sAnimName);
			}
		}
		return 0;
	}

	public static void PlayAnimInUI(GameObject go, string sClipName, bool bLoop, bool bForcePlay)
	{
		if (!(go == null) && !string.IsNullOrEmpty(sClipName))
		{
			go.GetComponent<L2DAnimPlayer>()?.PlayAnimInUI(sClipName, bLoop, bForcePlay);
		}
	}

	public static void PlayAnim_Graphic(SkeletonGraphic skeletonGraphic, int trackIndex, string animName, bool loop)
	{
		if (!(skeletonGraphic == null))
		{
			skeletonGraphic.AnimationState.SetAnimation(trackIndex, animName, loop);
		}
	}

	public static void AddAnim_Graphic(SkeletonGraphic skeletonGraphic, int trackIndex, string animName, bool loop, float delay)
	{
		if (!(skeletonGraphic == null))
		{
			skeletonGraphic.AnimationState.AddAnimation(trackIndex, animName, loop, delay);
		}
	}

	public static float GetTimeScale_Graphic(SkeletonGraphic skeletonGraphic)
	{
		if (skeletonGraphic == null)
		{
			return 0f;
		}
		return skeletonGraphic.timeScale;
	}

	public static void SetTimeScale_Graphic(SkeletonGraphic skeletonGraphic, float scale)
	{
		if (!(skeletonGraphic == null))
		{
			skeletonGraphic.timeScale = scale;
		}
	}

	public static float GetAnimDuration(SkeletonGraphic skeletonGraphic, string animName)
	{
		if (skeletonGraphic == null)
		{
			return 0f;
		}
		SkeletonDataAsset skeletonDataAsset = skeletonGraphic.skeletonDataAsset;
		if (skeletonDataAsset == null)
		{
			return 0f;
		}
		SkeletonData skeletonData = skeletonDataAsset.GetSkeletonData(quiet: true);
		if (skeletonData == null)
		{
			return 0f;
		}
		return skeletonData.FindAnimation(animName)?.Duration ?? 0f;
	}

	public static SoldierLevelController GetSoldierLevelController()
	{
		return ModuleController<AdventureModuleController>.Instance?.levelInstance as SoldierLevelController;
	}

	public static bool MoveSoldier(long actorId, double x, double z)
	{
		if (GetSoldierLevelController() == null)
		{
			return false;
		}
		List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance?.entities;
		if (list == null)
		{
			return false;
		}
		for (int i = 0; i < list.Count; i++)
		{
			SoldierActor soldierActor = list.get_Item(i) as SoldierActor;
			if (!(soldierActor == null) && soldierActor.Id == actorId)
			{
				soldierActor.tsTransform.Position = new TSVector2(x, z);
				soldierActor.tsTransform.PositionY = 0;
				soldierActor.SyncMovementLocation();
				return true;
			}
		}
		return false;
	}

	public static void ChangeUIDissolveTarget(GameObject targetObj, Texture targetTex)
	{
		targetObj.GetComponent<UIDissolve>().transitionTexture = targetTex;
	}

	public static string CompressString(string str)
	{
		return Convert.ToBase64String(GZipUtils.CompressString(str));
	}

	public static string DecompressString(string str)
	{
		return GZipUtils.DecompressString(Convert.FromBase64String(str));
	}
}
