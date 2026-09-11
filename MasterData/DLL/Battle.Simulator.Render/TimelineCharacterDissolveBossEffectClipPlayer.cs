using System.Collections.Generic;
using RenderPipeline.SimPipeline.Script.Scene;
using UnityEngine;

public class TimelineCharacterDissolveBossEffectClipPlayer : CommonSimpleTimelineClipPlayer<CharacterDissolveBossEffectActionClip>
{
	private CharacterEffect m_characterEffect;

	private DissolveController _dissolveController;

	public CharacterEffect CharacterEffect
	{
		get
		{
			return m_characterEffect;
		}
		set
		{
			m_characterEffect = value;
		}
	}

	protected override void _Initialize(List<CharacterDissolveBossEffectActionClip> clips)
	{
	}

	protected override void _EnterNodes(List<CharacterDissolveBossEffectActionClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		ResetCharacterDissolveEffect();
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _UpdateNodes(List<CharacterDissolveBossEffectActionClip> clipsInThisFrame, float normalized)
	{
		CharacterDissolveBossEffectActionClip characterDissolveBossEffectActionClip = clipsInThisFrame[clipsInThisFrame.Count - 1];
		AnimationCurve curve = characterDissolveBossEffectActionClip.Curve;
		float time = (normalized - characterDissolveBossEffectActionClip.NormalizedBegin) / (characterDissolveBossEffectActionClip.NormalizedEnd - characterDissolveBossEffectActionClip.NormalizedBegin);
		float dissolveIntensity = curve.Evaluate(time);
		if (string.IsNullOrEmpty(characterDissolveBossEffectActionClip.PartPath))
		{
			return;
		}
		if (_dissolveController == null)
		{
			Transform transform = m_characterEffect.transform.Find(characterDissolveBossEffectActionClip.PartPath);
			if (transform != null)
			{
				_dissolveController = U3DUtil.Get<DissolveController>(transform.gameObject);
			}
		}
		if (_dissolveController != null)
		{
			if (!_dissolveController.enabled)
			{
				_dissolveController.enabled = true;
			}
			_dissolveController.dissolveIntensity = dissolveIntensity;
		}
	}

	protected override void _ExitNodes(List<CharacterDissolveBossEffectActionClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		ResetCharacterDissolveEffect();
		if (clipsInThisFrame != null && clipsInThisFrame.Count > 0)
		{
			CharacterDissolveBossEffectActionClip characterDissolveBossEffectActionClip = clipsInThisFrame[clipsInThisFrame.Count - 1];
			if (_dissolveController != null && characterDissolveBossEffectActionClip.DisableOnExit)
			{
				_dissolveController.enabled = false;
			}
		}
		if (_dissolveController != null)
		{
			_dissolveController = null;
		}
	}

	protected override void _Shutdown()
	{
		ResetCharacterDissolveEffect();
		if (_dissolveController != null)
		{
			_dissolveController = null;
		}
	}

	protected override void _Stop(bool isForceClean = true)
	{
		ResetCharacterDissolveEffect();
		if (_dissolveController != null)
		{
			_dissolveController = null;
		}
	}

	private void ResetCharacterDissolveEffect()
	{
	}
}
