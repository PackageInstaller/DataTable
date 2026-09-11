using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

namespace T0World;

public class T0CaptureCharacterLogic
{
	private T0CaptureDitherData m_ditherColliderData;

	private GameObject m_faceBindObj;

	private Animator m_animator;

	[SerializeField]
	protected PlayableDirector m_playable;

	public T0WorldCaptureContext context => T0WorldScene.Scene.captureManager.captureContext;

	public T0CaptureDitherData ditherColliderData => m_ditherColliderData;

	public GameObject faceBindObj => m_faceBindObj;

	public Animator animator => m_animator;

	public string runAniName
	{
		get
		{
			if (!animator)
			{
				return string.Empty;
			}
			AnimatorClipInfo[] currentAnimatorClipInfo = animator.GetCurrentAnimatorClipInfo(0);
			if (currentAnimatorClipInfo.Length != 0)
			{
				_ = currentAnimatorClipInfo[0].clip.name;
				return currentAnimatorClipInfo[0].clip.name;
			}
			return string.Empty;
		}
	}

	public virtual PlayableDirector playable
	{
		get
		{
			if (m_playable == null)
			{
				m_playable = context.modelObj.GetComponent<PlayableDirector>();
				if (m_playable == null)
				{
					m_playable = context.modelObj.AddComponent<PlayableDirector>();
				}
			}
			return m_playable;
		}
	}

	public void InitBind(T0CaptureEntityBindMono bindMono)
	{
		m_faceBindObj = bindMono.faceBindObj;
		m_animator = bindMono.aniModel;
		m_ditherColliderData = new T0CaptureDitherData(bindMono.ditherCollider);
	}

	public virtual void PlayFaceTimeline(string faceName)
	{
		PlayableAsset playableAsset = Asset.Load<PlayableAsset>(T0WorldTools.GetFaceAssetPath(faceName));
		playable.Stop();
		playable.playableAsset = playableAsset;
		IEnumerator<PlayableBinding> enumerator = playable.playableAsset.outputs.GetEnumerator();
		while (enumerator.MoveNext())
		{
			PlayableBinding current = enumerator.Current;
			_ = current.streamName;
			playable.SetGenericBinding(current.sourceObject, faceBindObj);
		}
		playable.extrapolationMode = DirectorWrapMode.None;
		playable.Play();
		playable.Evaluate();
	}

	public void StopFaceTimeline()
	{
		if (playable != null)
		{
			playable.Stop();
		}
	}

	public void PlayAction(string animName)
	{
		animator.Play(animName);
		animator.Update(0f);
	}

	public void Dispose()
	{
	}
}
