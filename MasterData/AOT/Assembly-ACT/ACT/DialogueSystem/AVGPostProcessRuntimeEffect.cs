using System.Threading;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using UnityEngine;
using UnityEngine.Rendering;
using XPostProcessing;

namespace ACT.DialogueSystem;

public class AVGPostProcessRuntimeEffect
{
	private const float MaxSafeAnimationLength = 30f;

	private AssetLoadHandle m_Handle;

	private GameObject m_Instance;

	private Volume m_Volume;

	private IPostProcessWeightTarget m_WeightTarget;

	private Animator m_Animator;

	private Animation m_Animation;

	private Tweener m_WeightTweener;

	public bool ReleaseOnDialogueEnd { get; }

	public AVGPostProcessRuntimeEffect(AssetLoadHandle handle, GameObject instance, Volume volume, IPostProcessWeightTarget weightTarget, Animator animator, Animation animation, bool releaseOnDialogueEnd)
	{
		m_Handle = handle;
		m_Instance = instance;
		m_Volume = volume;
		m_WeightTarget = weightTarget;
		m_Animator = animator;
		m_Animation = animation;
		ReleaseOnDialogueEnd = releaseOnDialogueEnd;
		if (m_Animator != null)
		{
			m_Animator.cullingMode = AnimatorCullingMode.AlwaysAnimate;
		}
	}

	public void SetWeight(float weight)
	{
		KillWeightTween();
		if (m_WeightTarget != null)
		{
			m_WeightTarget.Weight = weight;
		}
		else if (m_Volume != null)
		{
			m_Volume.weight = weight;
		}
	}

	public UniTask TweenWeight(float targetWeight, float duration, CancellationToken token)
	{
		KillWeightTween();
		if (m_WeightTarget == null && m_Volume == null)
		{
			return UniTask.CompletedTask;
		}
		if (duration <= 0f)
		{
			SetWeight(targetWeight);
			return UniTask.CompletedTask;
		}
		m_WeightTweener = DOTween.To(GetWeight, SetTweenWeight, targetWeight, duration).OnComplete(() =>
		{
			m_WeightTweener = null;
		}).OnKill(() =>
		{
			m_WeightTweener = null;
		});
		return m_WeightTweener.ToUniTask(TweenCancelBehaviour.Kill, token);
	}

	private float GetWeight()
	{
		if (m_WeightTarget != null)
		{
			return m_WeightTarget.Weight;
		}
		if (m_Volume != null)
		{
			return m_Volume.weight;
		}
		return 0f;
	}

	private void SetTweenWeight(float weight)
	{
		if (m_WeightTarget != null)
		{
			m_WeightTarget.Weight = weight;
		}
		else if (m_Volume != null)
		{
			m_Volume.weight = weight;
		}
	}

	public float PlayAnimation(string stateName, int layer)
	{
		if (m_Animator != null && m_Animator.runtimeAnimatorController != null)
		{
			return PlayAnimator(stateName, layer);
		}
		if (m_Animation != null)
		{
			return PlayLegacyAnimation(stateName);
		}
		return 0f;
	}

	public void Release()
	{
		KillWeightTween();
		if (m_Animator != null)
		{
			m_Animator.enabled = false;
		}
		if (m_Animation != null)
		{
			m_Animation.Stop();
		}
		m_Instance = null;
		m_Volume = null;
		m_WeightTarget = null;
		m_Animator = null;
		m_Animation = null;
		if (m_Handle.IsValid)
		{
			AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
			m_Handle = default;
		}
	}

	private float PlayAnimator(string stateName, int layer)
	{
		if (m_Animator.layerCount <= 0)
		{
			return 0f;
		}
		if (layer < 0 || layer >= m_Animator.layerCount)
		{
			layer = 0;
		}
		if (string.IsNullOrEmpty(stateName))
		{
			m_Animator.Play(0, layer, 0f);
		}
		else
		{
			m_Animator.Play(stateName, layer, 0f);
		}
		m_Animator.Update(0f);
		return GetSafeAnimationLength(m_Animator.GetCurrentAnimatorStateInfo(layer).length);
	}

	private float PlayLegacyAnimation(string stateName)
	{
		if (string.IsNullOrEmpty(stateName))
		{
			if (m_Animation.clip == null)
			{
				return 0f;
			}
			m_Animation.Play();
			return GetSafeAnimationLength(m_Animation.clip.length);
		}
		AnimationState animationState = m_Animation[stateName];
		if (animationState == null)
		{
			return 0f;
		}
		m_Animation.Play(stateName);
		return GetSafeAnimationLength(animationState.length);
	}

	private float GetSafeAnimationLength(float length)
	{
		if (float.IsNaN(length) || float.IsInfinity(length) || length <= 0f || length > 30f)
		{
			return 0f;
		}
		return length;
	}

	private void KillWeightTween()
	{
		if (m_WeightTweener != null)
		{
			m_WeightTweener.Kill();
			m_WeightTweener = null;
		}
	}
}
