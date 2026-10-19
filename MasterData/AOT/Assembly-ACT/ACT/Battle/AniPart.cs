using System;
using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.Battle;

public abstract class AniPart
{
	public Renderer[] renders;

	[NonSerialized]
	private AniPartControl m_Owner;

	[NonSerialized]
	private List<Renderer> m_RenderTargets;

	[NonSerialized]
	public bool isShowing;

	[NonSerialized]
	public float curVal;

	[NonSerialized]
	public Action hideCb;

	[NonSerialized]
	public Action showCb;

	[NonSerialized]
	public float speed;

	[NonSerialized]
	public bool running;

	[NonSerialized]
	public bool needEntityLogicScale;

	[NonSerialized]
	private bool m_VisibilityRenderersHidden;

	[NonSerialized]
	private int m_VisibilityPlaySerial;

	[NonSerialized]
	private int m_VisibilityHideSerial;

	private bool ShouldLatchVisibilityRenderers => VisibilityEffect != CharacterVisibilityEffect.None;

	protected virtual bool UsesMaterialPropertyBlock => true;

	internal virtual CharacterVisibilityEffect VisibilityEffect => CharacterVisibilityEffect.None;

	internal IReadOnlyList<Renderer> VisibilityRenderers => m_RenderTargets;

	public void UpdateCurPlaybackProgress(float entityLogicScale)
	{
		curVal = Mathf.Clamp(curVal + speed * Time.deltaTime * entityLogicScale, 0f, 1f);
		SetMatParameter();
		if (isShowing)
		{
			if (curVal >= 1f)
			{
				if (showCb != null)
				{
					showCb();
					showCb = null;
				}
				running = false;
				HandleForwardPlayEnd();
			}
		}
		else if (curVal <= 0f)
		{
			if (hideCb != null)
			{
				hideCb();
				hideCb = null;
			}
			running = false;
			HandleBackWardPlayEnd();
		}
	}

	internal void CompletePlaybackImmediate(Entity entity = default(Entity))
	{
		speed = 0f;
		running = true;
		if (isShowing)
		{
			curVal = 1f;
			HandleForwardPlayStart(entity);
			SetMatParameter();
			if (showCb != null)
			{
				showCb();
				showCb = null;
			}
			running = false;
			HandleForwardPlayEnd(entity);
		}
		else
		{
			curVal = 0f;
			HandleBackWardPlayStart(entity);
			SetMatParameter();
			if (hideCb != null)
			{
				hideCb();
				hideCb = null;
			}
			running = false;
			HandleBackWardPlayEnd(entity);
		}
	}

	public void EnableRenderers(bool enable)
	{
		if (renders != null)
		{
			Renderer[] array = renders;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].enabled = enable;
			}
		}
	}

	internal void HandleForwardPlayStart(Entity entity = default(Entity))
	{
		m_VisibilityPlaySerial++;
		m_VisibilityHideSerial = m_VisibilityPlaySerial;
		ShowVisibilityRenderers();
		OnForwardPlayStart(entity);
	}

	internal void HandleForwardPlayEnd(Entity entity = default(Entity))
	{
		OnForwardPlayEnd(entity);
		if (m_VisibilityPlaySerial == m_VisibilityHideSerial)
		{
			HideVisibilityRenderers();
		}
	}

	internal void HandleBackWardPlayStart(Entity entity = default(Entity))
	{
		m_VisibilityPlaySerial++;
		ShowVisibilityRenderers();
		OnBackWardPlayStart(entity);
	}

	internal void HandleBackWardPlayEnd(Entity entity = default(Entity))
	{
		OnBackWardPlayEnd(entity);
	}

	private void ShowVisibilityRenderers()
	{
		SetVisibilityRenderersHidden(hidden: false);
	}

	private void HideVisibilityRenderers()
	{
		SetVisibilityRenderersHidden(hidden: true);
	}

	private void SetVisibilityRenderersHidden(bool hidden)
	{
		if (ShouldLatchVisibilityRenderers && m_VisibilityRenderersHidden != hidden && !(m_Owner == null))
		{
			m_Owner.SetVisibilityRenderersHidden(m_RenderTargets, hidden);
			m_VisibilityRenderersHidden = hidden;
		}
	}

	internal void OnDisable()
	{
		curVal = (isShowing ? 1 : 0);
		SetMatParameter();
		running = false;
		if (isShowing)
		{
			if (showCb != null)
			{
				showCb();
				showCb = null;
			}
		}
		else if (hideCb != null)
		{
			hideCb();
			hideCb = null;
		}
		if (isShowing)
		{
			HandleForwardPlayEnd();
		}
		else
		{
			HandleBackWardPlayEnd();
		}
	}

	protected void SetMatParameter()
	{
		if (!UsesMaterialPropertyBlock)
		{
			SetMaterialParametersDirect();
		}
		else
		{
			if (m_Owner == null || m_RenderTargets == null)
			{
				return;
			}
			for (int i = 0; i < m_RenderTargets.Count; i++)
			{
				Renderer renderer = m_RenderTargets[i];
				if (renderer != null)
				{
					SetMatParameters(m_Owner.GetPropertyBlock(renderer));
				}
			}
		}
	}

	protected virtual void SetMatParameters(MaterialPropertyBlock propertyBlock)
	{
	}

	protected virtual void SetMaterialParametersDirect()
	{
	}

	public virtual void Init(AniPartControl owner)
	{
		m_Owner = owner;
		curVal = 0f;
		if (m_RenderTargets == null)
		{
			m_RenderTargets = new List<Renderer>();
		}
		m_RenderTargets.Clear();
		Renderer[] array = renders;
		if (array == null || array.Length == 0)
		{
			array = ((owner != null) ? owner.normalRender : null);
		}
		if (array == null)
		{
			return;
		}
		foreach (Renderer renderer in array)
		{
			if (!(renderer == null) && !m_RenderTargets.Contains(renderer))
			{
				m_RenderTargets.Add(renderer);
			}
		}
	}

	public virtual void OnForwardPlayStart(Entity entity = default(Entity))
	{
	}

	public virtual void OnForwardPlayEnd(Entity entity = default(Entity))
	{
	}

	public virtual void OnBackWardPlayStart(Entity entity = default(Entity))
	{
	}

	public virtual void OnBackWardPlayEnd(Entity entity = default(Entity))
	{
	}

	public virtual void ResetToVisible()
	{
		curVal = 0f;
		isShowing = false;
		running = false;
		showCb = null;
		hideCb = null;
		m_VisibilityPlaySerial++;
		ShowVisibilityRenderers();
		OnResetToVisible();
		SetMatParameter();
	}

	protected virtual void OnResetToVisible()
	{
	}

	protected void RestoreDitherThreshold()
	{
		SetFloatForAllTargets(BattleConsts.SUB_EFFECT_SHADER_DITHER, 1f);
	}

	protected void SetFloatForAllTargets(int propertyId, float value)
	{
		if (!UsesMaterialPropertyBlock || m_Owner == null || m_RenderTargets == null)
		{
			return;
		}
		for (int i = 0; i < m_RenderTargets.Count; i++)
		{
			Renderer renderer = m_RenderTargets[i];
			if (renderer != null)
			{
				m_Owner.GetPropertyBlock(renderer).SetFloat(propertyId, value);
			}
		}
	}

	protected static void SetHdrColor(MaterialPropertyBlock propertyBlock, int propertyId, Color value)
	{
		propertyBlock.SetVector(propertyId, value);
	}

	protected void SetColorForAllTargets(int propertyId, Color value)
	{
		SetVectorForAllTargets(propertyId, value);
	}

	protected void SetVectorForAllTargets(int propertyId, Vector4 value)
	{
		if (!UsesMaterialPropertyBlock || m_Owner == null || m_RenderTargets == null)
		{
			return;
		}
		for (int i = 0; i < m_RenderTargets.Count; i++)
		{
			Renderer renderer = m_RenderTargets[i];
			if (renderer != null)
			{
				m_Owner.GetPropertyBlock(renderer).SetVector(propertyId, value);
			}
		}
	}

	internal bool TryGetVisibilityClaim(out CharacterVisibilityEffect effect, out bool isPlay)
	{
		effect = VisibilityEffect;
		isPlay = false;
		if (effect == CharacterVisibilityEffect.None)
		{
			return false;
		}
		if (running)
		{
			isPlay = true;
			return true;
		}
		if (curVal >= 0.999f && HasSubmittingRenderer())
		{
			return true;
		}
		return false;
	}

	private bool HasSubmittingRenderer()
	{
		if (m_RenderTargets == null)
		{
			return false;
		}
		for (int i = 0; i < m_RenderTargets.Count; i++)
		{
			Renderer renderer = m_RenderTargets[i];
			if (renderer != null && renderer.enabled && renderer.gameObject.activeInHierarchy)
			{
				return true;
			}
		}
		return false;
	}

	protected float EvaluateCurve(AnimationCurve curve)
	{
		if (curve == null || curve.length == 0)
		{
			return 0f;
		}
		float time = curve[0].time;
		float time2 = curve[curve.length - 1].time;
		return curve.Evaluate(Mathf.LerpUnclamped(time, time2, curVal));
	}
}
