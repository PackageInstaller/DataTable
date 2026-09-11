using System;
using Spine;
using Spine.Unity;
using UnityEngine;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

public class SpineAnimationBehaviour : PlayableBehaviour
{
	public GameObject spinePrefab;

	public string animationName;

	public bool loop;

	public Vector3 localPosition;

	public Vector3 localEulerAngles;

	public Vector3 localScale = Vector3.one;

	private GameObject m_instance;

	private GameObject m_parent;

	private SkeletonAnimation m_skeletonAnimation;

	private SkeletonGraphic m_skeletonGraphic;

	private IAnimationStateComponent m_animationStateComponent;

	private IHasSkeletonDataAsset m_skeletonDataAssetHolder;

	private Spine.Animation m_cachedAnimation;

	private string m_cachedAnimationName;

	private bool m_loggedMissingComponent;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		GameObject parent = ResolveParent(playable, playerData);
		if (!EnsureInstance(parent))
		{
			return;
		}
		Spine.Animation animation = GetAnimation();
		if (animation != null && m_animationStateComponent != null)
		{
			Spine.AnimationState animationState = m_animationStateComponent.AnimationState;
			if (animationState != null)
			{
				ResetToSetupPose();
				animationState.ClearTracks();
				animationState.SetAnimation(0, animation, loop);
				animationState.Update((float)Math.Max(0.0, playable.GetTime()));
				RefreshVisual();
			}
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		DestroyInstance();
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		DestroyInstance();
	}

	private GameObject ResolveParent(Playable playable, object playerData)
	{
		if (playerData is GameObject result)
		{
			return result;
		}
		PlayableDirector playableDirector = playable.GetGraph().GetResolver() as PlayableDirector;
		if (!(playableDirector != null))
		{
			return null;
		}
		return playableDirector.gameObject;
	}

	private bool EnsureInstance(GameObject parent)
	{
		if (m_instance != null && m_parent == parent)
		{
			return true;
		}
		if (m_instance != null)
		{
			DestroyInstance();
		}
		if (spinePrefab == null)
		{
			return false;
		}
		m_instance = UnityEngine.Object.Instantiate(spinePrefab);
		m_instance.name = spinePrefab.name;
		if (parent != null)
		{
			m_instance.transform.SetParent(parent.transform, worldPositionStays: false);
		}
		m_instance.transform.localPosition = localPosition;
		m_instance.transform.localRotation = Quaternion.Euler(localEulerAngles);
		m_instance.transform.localScale = localScale;
		m_parent = parent;
		m_skeletonAnimation = m_instance.GetComponentInChildren<SkeletonAnimation>(includeInactive: true);
		m_skeletonGraphic = m_instance.GetComponentInChildren<SkeletonGraphic>(includeInactive: true);
		IAnimationStateComponent skeletonAnimation = m_skeletonAnimation;
		m_animationStateComponent = skeletonAnimation ?? m_skeletonGraphic;
		IHasSkeletonDataAsset skeletonAnimation2 = m_skeletonAnimation;
		m_skeletonDataAssetHolder = skeletonAnimation2 ?? m_skeletonGraphic;
		m_cachedAnimation = null;
		m_cachedAnimationName = null;
		m_skeletonAnimation?.Initialize(overwrite: false);
		m_skeletonGraphic?.Initialize(overwrite: false);
		if (m_animationStateComponent == null && !m_loggedMissingComponent)
		{
			Debug.LogError(spinePrefab.name + " 上未找到 SkeletonAnimation 或 SkeletonGraphic，SpineAnimationTrack 无法播放。", spinePrefab);
			m_loggedMissingComponent = true;
		}
		return m_animationStateComponent != null;
	}

	private Spine.Animation GetAnimation()
	{
		if (m_skeletonDataAssetHolder == null || string.IsNullOrEmpty(animationName))
		{
			return null;
		}
		if (m_cachedAnimation != null && m_cachedAnimationName == animationName)
		{
			return m_cachedAnimation;
		}
		SkeletonDataAsset skeletonDataAsset = m_skeletonDataAssetHolder.SkeletonDataAsset;
		if (skeletonDataAsset == null)
		{
			return null;
		}
		m_cachedAnimation = skeletonDataAsset.GetSkeletonData(quiet: false)?.FindAnimation(animationName);
		m_cachedAnimationName = animationName;
		return m_cachedAnimation;
	}

	private void ResetToSetupPose()
	{
		if (m_skeletonAnimation != null && m_skeletonAnimation.Skeleton != null)
		{
			m_skeletonAnimation.Skeleton.SetToSetupPose();
		}
		if (m_skeletonGraphic != null && m_skeletonGraphic.Skeleton != null)
		{
			m_skeletonGraphic.Skeleton.SetToSetupPose();
		}
	}

	private void RefreshVisual()
	{
		if (m_skeletonAnimation != null)
		{
			m_skeletonAnimation.Update(0f);
			m_skeletonAnimation.LateUpdate();
		}
		if (m_skeletonGraphic != null)
		{
			m_skeletonGraphic.Update(0f);
			m_skeletonGraphic.UpdateMesh();
		}
	}

	private void DestroyInstance()
	{
		m_skeletonAnimation = null;
		m_skeletonGraphic = null;
		m_animationStateComponent = null;
		m_skeletonDataAssetHolder = null;
		m_cachedAnimation = null;
		m_cachedAnimationName = null;
		m_parent = null;
		if (!(m_instance == null))
		{
			if (Application.isPlaying)
			{
				UnityEngine.Object.Destroy(m_instance);
			}
			else
			{
				UnityEngine.Object.DestroyImmediate(m_instance);
			}
			m_instance = null;
		}
	}

	public static Spine.Animation FindAnimation(GameObject spinePrefab, string animationName)
	{
		if (spinePrefab == null || string.IsNullOrEmpty(animationName))
		{
			return null;
		}
		SkeletonAnimation componentInChildren = spinePrefab.GetComponentInChildren<SkeletonAnimation>(includeInactive: true);
		SkeletonGraphic componentInChildren2 = spinePrefab.GetComponentInChildren<SkeletonGraphic>(includeInactive: true);
		IHasSkeletonDataAsset hasSkeletonDataAsset = componentInChildren;
		SkeletonDataAsset skeletonDataAsset = (hasSkeletonDataAsset ?? componentInChildren2)?.SkeletonDataAsset;
		if (skeletonDataAsset == null)
		{
			return null;
		}
		return skeletonDataAsset.GetSkeletonData(quiet: false)?.FindAnimation(animationName);
	}
}
