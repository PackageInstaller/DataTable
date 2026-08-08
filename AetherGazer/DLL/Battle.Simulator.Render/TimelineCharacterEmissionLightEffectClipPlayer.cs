using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;

public class TimelineCharacterEmissionLightEffectClipPlayer : CommonSimpleTimelineClipPlayer<CharacterEmissionLightEffectClip>
{
	private CharacterEffect _characterEffect;

	private Color _originColor = Color.white;

	private CharacterEffectOverrider _characterEffectOverrider;

	public CharacterEffect CharacterEffect
	{
		get
		{
			return _characterEffect;
		}
		set
		{
			_characterEffect = value;
			if (_characterEffect != null)
			{
				_originColor = _characterEffect.emissionColor;
			}
			else
			{
				_originColor = Color.white;
			}
		}
	}

	protected override void _Initialize(List<CharacterEmissionLightEffectClip> clips)
	{
	}

	protected override void _EnterNodes(List<CharacterEmissionLightEffectClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		ResetCharacterDissolveEffect();
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _UpdateNodes(List<CharacterEmissionLightEffectClip> clipsInThisFrame, float normalized)
	{
		CharacterEmissionLightEffectClip characterEmissionLightEffectClip = clipsInThisFrame[clipsInThisFrame.Count - 1];
		float num = characterEmissionLightEffectClip.AnimationCurve.Evaluate(normalized);
		if (num == 0f)
		{
			return;
		}
		if (!string.IsNullOrEmpty(characterEmissionLightEffectClip.PartPath))
		{
			if (_characterEffectOverrider == null)
			{
				Transform transform = _characterEffect.transform.Find(characterEmissionLightEffectClip.PartPath);
				if (transform != null)
				{
					_characterEffectOverrider = transform.GetComponent<CharacterEffectOverrider>();
				}
			}
			if (_characterEffectOverrider != null)
			{
				if (!_characterEffectOverrider.enabled)
				{
					_characterEffectOverrider.enabled = true;
					_characterEffectOverrider.overrideEmission = true;
				}
				_characterEffectOverrider.emissionColor = characterEmissionLightEffectClip.Color * Mathf.Pow(2f, num);
			}
		}
		else
		{
			_characterEffect.emissionColor = characterEmissionLightEffectClip.Color * Mathf.Pow(2f, num);
		}
	}

	protected override void _ExitNodes(List<CharacterEmissionLightEffectClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		ResetCharacterDissolveEffect();
		if (clipsInThisFrame != null && clipsInThisFrame.Count > 0)
		{
			CharacterEmissionLightEffectClip characterEmissionLightEffectClip = clipsInThisFrame[clipsInThisFrame.Count - 1];
			if (_characterEffectOverrider != null && characterEmissionLightEffectClip.DisableOnExit)
			{
				_characterEffectOverrider.overrideEmission = false;
				if (!_characterEffectOverrider.overrideEmission && !_characterEffectOverrider.overrideDissolve && !_characterEffectOverrider.overrideRimLight)
				{
					_characterEffectOverrider.enabled = false;
				}
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
		_characterEffect.emissionColor = _originColor;
	}
}
