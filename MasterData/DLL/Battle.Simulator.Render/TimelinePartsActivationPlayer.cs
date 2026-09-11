using System;
using System.Collections.Generic;
using UnityEngine;

public class TimelinePartsActivationPlayer : CommonSimpleTimelineClipPlayer<TimelineHiddenPartsClip>, ILoopClipPlayer
{
	public CharacterEffect CharacterEffect;

	public bool CharacterShadowEnable;

	public CharacterRenderController m_CharacterRenderController;

	public Action<bool> EnableShadowAction;

	private int _ShadowActiveCount;

	public Action<bool> RenderEnableFunc;

	protected override void OnInitTransform(Transform transform)
	{
		if (m_CharacterRenderController != null)
		{
			m_CharacterRenderController.InitRenderActiveCount();
		}
	}

	protected override void _Initialize(List<TimelineHiddenPartsClip> clips)
	{
	}

	protected override void _EnterNodes(List<TimelineHiddenPartsClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			TimelineHiddenPartsClip timelineHiddenPartsClip = clipsInThisFrame[i];
			if (timelineHiddenPartsClip.HideWithShadow)
			{
				DisableRenders();
			}
			else if (timelineHiddenPartsClip.OnlyHideShadow)
			{
				SetShadowActive(timelineHiddenPartsClip.IsReverse);
			}
			else if (m_CharacterRenderController != null)
			{
				m_CharacterRenderController.SetRendersActive(timelineHiddenPartsClip.ControlGroupIndex, timelineHiddenPartsClip.IsReverse);
			}
		}
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _UpdateNodes(List<TimelineHiddenPartsClip> clipsInThisFrame, float normalized)
	{
	}

	protected override void _ExitNodes(List<TimelineHiddenPartsClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			TimelineHiddenPartsClip timelineHiddenPartsClip = clipsInThisFrame[i];
			if (timelineHiddenPartsClip.ShowOnStop)
			{
				if (timelineHiddenPartsClip.HideWithShadow)
				{
					EnableRenders();
				}
				else if (timelineHiddenPartsClip.OnlyHideShadow)
				{
					SetShadowActive(!timelineHiddenPartsClip.IsReverse);
				}
				else if (m_CharacterRenderController != null)
				{
					m_CharacterRenderController.SetRendersActive(timelineHiddenPartsClip.ControlGroupIndex, !timelineHiddenPartsClip.IsReverse);
				}
			}
		}
	}

	protected override void _Shutdown()
	{
		ResetRenderActive();
		CharacterEffect = null;
		m_CharacterRenderController = null;
		EnableShadowAction = null;
		_ShadowActiveCount = 0;
		RenderEnableFunc = null;
	}

	protected override void _Stop(bool isForceClean = true)
	{
	}

	public void DisableRenders()
	{
		if (m_CharacterRenderController != null)
		{
			m_CharacterRenderController.SetAllRendersActive(pEnble: false);
		}
		SetShadowActive(enable: false);
		if (CharacterEffect != null)
		{
			CharacterEffect.DisableRenders();
		}
		if (RenderEnableFunc != null && _ShadowActiveCount < 0)
		{
			RenderEnableFunc(obj: false);
		}
	}

	public void EnableRenders()
	{
		if (m_CharacterRenderController != null)
		{
			m_CharacterRenderController.SetAllRendersActive(pEnble: true);
		}
		SetShadowActive(enable: true);
		if (CharacterEffect != null)
		{
			CharacterEffect.EnableRenders();
		}
		if (RenderEnableFunc != null && _ShadowActiveCount >= 0)
		{
			RenderEnableFunc(obj: true);
		}
	}

	public void SetShadowActive(bool enable)
	{
		_ShadowActiveCount += (enable ? 1 : (-1));
		enable = _ShadowActiveCount >= 0;
		if (CharacterEffect != null && CharacterShadowEnable && CharacterEffect.shadowEnabled != enable)
		{
			CharacterEffect.shadowEnabled = enable;
		}
		if (EnableShadowAction != null)
		{
			EnableShadowAction(enable);
		}
	}

	public void SetRenderActive(int pIndex, bool pEnable)
	{
		if (m_CharacterRenderController != null)
		{
			m_CharacterRenderController.SetRendersActive(pIndex, pEnable);
		}
	}

	public void ResetRenderActive()
	{
		if (m_CharacterRenderController != null)
		{
			m_CharacterRenderController.RecoverToFirstState();
		}
		if (CharacterEffect != null && CharacterShadowEnable && !CharacterEffect.shadowEnabled)
		{
			CharacterEffect.shadowEnabled = true;
		}
		if (CharacterEffect != null)
		{
			CharacterEffect.EnableRenders();
		}
	}
}
