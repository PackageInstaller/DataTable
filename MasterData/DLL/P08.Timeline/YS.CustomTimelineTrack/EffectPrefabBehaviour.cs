using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

public class EffectPrefabBehaviour : PlayableBehaviour
{
	public GameObject effectPrefab;

	public Vector3 localPosition;

	public Vector3 localEulerAngles;

	public Vector3 localScale = Vector3.one;

	private GameObject m_instance;

	private GameObject m_parent;

	private EffectController m_effectController;

	private readonly List<ParticleSystem> m_particleSystems = new List<ParticleSystem>();

	private readonly List<MeshRenderer> m_gpuParticleRenderers = new List<MeshRenderer>();

	private readonly List<Animator> m_animators = new List<Animator>();

	private readonly List<Animation> m_animations = new List<Animation>();

	private bool m_runtimeStarted;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		GameObject parent = ResolveParent(playable, playerData);
		if (!EnsureInstance(parent))
		{
			return;
		}
		if (Application.isPlaying)
		{
			if (!m_runtimeStarted)
			{
				StartRuntimePlayback((float)Math.Max(0.1, playable.GetDuration()));
				m_runtimeStarted = true;
			}
		}
		else
		{
			PreviewAt((float)Math.Max(0.0, playable.GetTime()));
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
		if (effectPrefab == null)
		{
			return false;
		}
		m_instance = UnityEngine.Object.Instantiate(effectPrefab);
		m_instance.name = effectPrefab.name;
		if (parent != null)
		{
			m_instance.transform.SetParent(parent.transform, worldPositionStays: false);
		}
		m_instance.transform.localPosition = localPosition;
		m_instance.transform.localRotation = Quaternion.Euler(localEulerAngles);
		m_instance.transform.localScale = localScale;
		m_parent = parent;
		m_runtimeStarted = false;
		m_effectController = m_instance.GetComponent<EffectController>();
		if (m_effectController != null)
		{
			m_effectController.timelineControlNew = true;
		}
		m_particleSystems.Clear();
		m_particleSystems.AddRange(m_instance.GetComponentsInChildren<ParticleSystem>(includeInactive: true));
		m_animators.Clear();
		m_animators.AddRange(m_instance.GetComponentsInChildren<Animator>(includeInactive: true));
		m_animations.Clear();
		m_animations.AddRange(m_instance.GetComponentsInChildren<Animation>(includeInactive: true));
		m_gpuParticleRenderers.Clear();
		m_gpuParticleRenderers.AddRange(from renderer in m_instance.GetComponentsInChildren<MeshRenderer>(includeInactive: true)
			where renderer.sharedMaterial != null && renderer.sharedMaterial.shader != null && renderer.sharedMaterial.shader.name.Contains("GPU_Particles")
			select renderer);
		return true;
	}

	private void StartRuntimePlayback(float duration)
	{
		if (m_effectController != null)
		{
			m_effectController.Initialize(isLoop: false, duration, 1f, EEffectQuality.Fantastic, null);
			return;
		}
		for (int i = 0; i < m_particleSystems.Count; i++)
		{
			m_particleSystems[i].Play(withChildren: true);
		}
		for (int j = 0; j < m_animations.Count; j++)
		{
			if (m_animations[j].clip != null)
			{
				m_animations[j].Play();
			}
		}
	}

	private void PreviewAt(float time)
	{
		for (int i = 0; i < m_particleSystems.Count; i++)
		{
			ParticleSystem particleSystem = m_particleSystems[i];
			particleSystem.Simulate(0f, withChildren: true, restart: true);
			particleSystem.Simulate(time, withChildren: true, restart: false);
		}
		for (int j = 0; j < m_animators.Count; j++)
		{
			AnimationClip previewAnimationClip = GetPreviewAnimationClip(m_animators[j]);
			if (previewAnimationClip != null)
			{
				previewAnimationClip.SampleAnimation(m_animators[j].gameObject, time);
			}
		}
		for (int k = 0; k < m_animations.Count; k++)
		{
			if (m_animations[k].clip != null)
			{
				m_animations[k].clip.SampleAnimation(m_animations[k].gameObject, time);
			}
		}
		for (int l = 0; l < m_gpuParticleRenderers.Count; l++)
		{
			MaterialPropertyBlock materialPropertyBlock = new MaterialPropertyBlock();
			materialPropertyBlock.SetFloat("_GPUDATA_GPUParticleStartTime", -1f);
			materialPropertyBlock.SetFloat("_GPUDATA_GPUParticleTime", time);
			m_gpuParticleRenderers[l].SetPropertyBlock(materialPropertyBlock);
		}
	}

	private static AnimationClip GetPreviewAnimationClip(Animator animator)
	{
		if (animator == null)
		{
			return null;
		}
		AnimatorClipInfo[] currentAnimatorClipInfo = animator.GetCurrentAnimatorClipInfo(0);
		if (currentAnimatorClipInfo != null && currentAnimatorClipInfo.Length != 0 && currentAnimatorClipInfo[0].clip != null)
		{
			return currentAnimatorClipInfo[0].clip;
		}
		if (!(animator.runtimeAnimatorController != null))
		{
			return null;
		}
		return animator.runtimeAnimatorController.animationClips.FirstOrDefault();
	}

	private void DestroyInstance()
	{
		if (m_effectController != null && m_effectController.mIsRunning)
		{
			m_effectController.Stop();
		}
		m_effectController = null;
		m_particleSystems.Clear();
		m_gpuParticleRenderers.Clear();
		m_animators.Clear();
		m_animations.Clear();
		m_parent = null;
		m_runtimeStarted = false;
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
}
