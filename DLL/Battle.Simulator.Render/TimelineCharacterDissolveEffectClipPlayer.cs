using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

public class TimelineCharacterDissolveEffectClipPlayer : CommonSimpleTimelineClipPlayer<CharacterDissolveEffectActionClip>
{
	private CharacterEffect m_characterEffect;

	private float m_originDissolveFactor;

	private CharacterEffectOverrider _characterEffectOverrider;

	public CharacterEffect CharacterEffect
	{
		get
		{
			return m_characterEffect;
		}
		set
		{
			m_characterEffect = value;
			if (m_characterEffect != null)
			{
				m_originDissolveFactor = m_characterEffect.dissolveFactor;
			}
			else
			{
				m_originDissolveFactor = 0f;
			}
		}
	}

	protected override void _Initialize(List<CharacterDissolveEffectActionClip> clips)
	{
	}

	protected override void _EnterNodes(List<CharacterDissolveEffectActionClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		ResetCharacterDissolveEffect();
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _UpdateNodes(List<CharacterDissolveEffectActionClip> clipsInThisFrame, float normalized)
	{
		CharacterDissolveEffectActionClip characterDissolveEffectActionClip = clipsInThisFrame[clipsInThisFrame.Count - 1];
		AnimationCurve curve = characterDissolveEffectActionClip.Curve;
		float time = (normalized - characterDissolveEffectActionClip.NormalizedBegin) / (characterDissolveEffectActionClip.NormalizedEnd - characterDissolveEffectActionClip.NormalizedBegin);
		float dissolveFactor = curve.Evaluate(time);
		if (!string.IsNullOrEmpty(characterDissolveEffectActionClip.PartPath))
		{
			if (_characterEffectOverrider == null)
			{
				Transform transform = m_characterEffect.transform.Find(characterDissolveEffectActionClip.PartPath);
				if (transform != null)
				{
					_characterEffectOverrider = U3DUtil.Get<CharacterEffectOverrider>(transform.gameObject);
				}
			}
			if (_characterEffectOverrider != null)
			{
				if (!_characterEffectOverrider.enabled)
				{
					_characterEffectOverrider.enabled = true;
				}
				_characterEffectOverrider.dissolveFactor = dissolveFactor;
			}
		}
		else
		{
			m_characterEffect.dissolveFactor = dissolveFactor;
		}
	}

	protected override void _ExitNodes(List<CharacterDissolveEffectActionClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		ResetCharacterDissolveEffect();
		if (clipsInThisFrame != null && clipsInThisFrame.Count > 0)
		{
			CharacterDissolveEffectActionClip characterDissolveEffectActionClip = clipsInThisFrame[clipsInThisFrame.Count - 1];
			if (_characterEffectOverrider != null && characterDissolveEffectActionClip.DisableOnExit)
			{
				_characterEffectOverrider.enabled = false;
			}
		}
		if (_characterEffectOverrider != null)
		{
			_characterEffectOverrider = null;
		}
	}

	protected override void _Shutdown()
	{
		ResetCharacterDissolveEffect();
		if (_characterEffectOverrider != null)
		{
			_characterEffectOverrider = null;
		}
	}

	protected override void _Stop(bool isForceClean = true)
	{
		ResetCharacterDissolveEffect();
		if (_characterEffectOverrider != null)
		{
			_characterEffectOverrider = null;
		}
	}

	private void ResetCharacterDissolveEffect()
	{
		m_characterEffect.dissolveFactor = m_originDissolveFactor;
	}
}
