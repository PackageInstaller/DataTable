using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

public class TimelineCameraDarkCornerClipPlayer : CommonSimpleTimelineClipPlayer<DarkCornerClip>
{
	public NAgent Agent;

	public CameraExtension CameraExtension;

	public AttachPointSetup AttachPointSetup;

	public void ResetCameraVignetteParams()
	{
		CameraExtension.vignetteColor = Color.black;
		CameraExtension.vignetteStrength = 0f;
		CameraExtension.vignetteSoft = 0.2f;
		CameraExtension.vignetteBounded = false;
		CameraExtension.vignetteTransform = Vector2.one * 0.5f;
		CameraExtension.vignetteTarget = null;
	}

	public bool IsPlay()
	{
		return Agent.IsLocalPlayer;
	}

	protected override void _Initialize(List<DarkCornerClip> clips)
	{
	}

	protected override void _EnterNodes(List<DarkCornerClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		BuffManager buffManager = BuffManager.GetBuffManager();
		if (buffManager == null || CameraExtension == null)
		{
			return;
		}
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			if (IsPlay())
			{
				buffManager.runningDarkCornerClip[clipsInThisFrame[i].Key] = clipsInThisFrame[i];
			}
		}
	}

	protected override void _UpdateNodes(List<DarkCornerClip> clipsInThisFrame, float normalized)
	{
		BuffManager buffManager = BuffManager.GetBuffManager();
		if (buffManager == null || CameraExtension == null)
		{
			return;
		}
		DarkCornerClip darkCornerClip = buffManager.UpdateDarkCorner();
		DarkCornerClip darkCornerClip2 = null;
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			if (darkCornerClip == null)
			{
				break;
			}
			if (darkCornerClip.Key == clipsInThisFrame[i].Key)
			{
				darkCornerClip2 = clipsInThisFrame[i];
				break;
			}
		}
		if (darkCornerClip2 == null)
		{
			return;
		}
		float time = (normalized - darkCornerClip2.NormalizedBegin) / (darkCornerClip2.NormalizedEnd - darkCornerClip2.NormalizedBegin);
		float vignetteStrength = darkCornerClip2.strengthCurve.Evaluate(time);
		float vignetteSoft = darkCornerClip2.softCurve.Evaluate(time);
		CameraExtension.vignetteColor = darkCornerClip2.color;
		CameraExtension.vignetteStrength = vignetteStrength;
		CameraExtension.vignetteSoft = vignetteSoft;
		CameraExtension.vignetteBounded = darkCornerClip2.bounded;
		if (!darkCornerClip2.isUseScreenPos)
		{
			if (AttachPointSetup != null)
			{
				Transform attachPoint = AttachPointSetup.GetAttachPoint(darkCornerClip2.transPath);
				if (attachPoint == null)
				{
					CameraExtension.vignetteTarget = base.Transform;
				}
				else
				{
					CameraExtension.vignetteTarget = attachPoint;
				}
			}
		}
		else
		{
			CameraExtension.vignetteTransform = darkCornerClip2.screenPos;
		}
	}

	protected override void _ExitNodes(List<DarkCornerClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		BuffManager buffManager = BuffManager.GetBuffManager();
		if (buffManager != null && !(CameraExtension == null))
		{
			for (int i = 0; i < clipsInThisFrame.Count; i++)
			{
				buffManager.runningDarkCornerClip.Remove(clipsInThisFrame[i].Key);
			}
			if (buffManager.UpdateDarkCorner() == null)
			{
				ResetCameraVignetteParams();
			}
		}
	}

	protected override void _Shutdown()
	{
		if (IsPlay())
		{
			ResetCameraVignetteParams();
		}
	}

	protected override void _Stop(bool isForceClean = true)
	{
		if (IsPlay())
		{
			ResetCameraVignetteParams();
		}
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}
}
