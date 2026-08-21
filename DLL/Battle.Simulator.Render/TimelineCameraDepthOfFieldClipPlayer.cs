using System.Collections.Generic;
using UnityEngine.Pipelines.SimPipeline;

public class TimelineCameraDepthOfFieldClipPlayer : CommonSimpleTimelineClipPlayer<CameraDepthOfFieldClip>
{
	public NAgent Agent;

	public CameraExtension CameraExtension;

	protected override void _Initialize(List<CameraDepthOfFieldClip> clips)
	{
	}

	protected override void _EnterNodes(List<CameraDepthOfFieldClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		BuffManager buffManager = BuffManager.GetBuffManager();
		if (buffManager == null || CameraExtension == null)
		{
			return;
		}
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			if (IsPlayer() || clipsInThisFrame[i].mBotherOthers)
			{
				buffManager.runningCameraDepthOfFieldClip[clipsInThisFrame[i].Key] = clipsInThisFrame[i];
			}
		}
		if (buffManager.UpdateCameraDepthOfField() == null)
		{
			CameraExtension.dofType = DepthOfFieldType.Disabled;
		}
	}

	protected override void _UpdateNodes(List<CameraDepthOfFieldClip> clipsInThisFrame, float normalized)
	{
		BuffManager buffManager = BuffManager.GetBuffManager();
		if (buffManager == null || CameraExtension == null)
		{
			return;
		}
		CameraDepthOfFieldClip cameraDepthOfFieldClip = buffManager.UpdateCameraDepthOfField();
		CameraDepthOfFieldClip cameraDepthOfFieldClip2 = null;
		for (int i = 0; i < clipsInThisFrame.Count; i++)
		{
			if (cameraDepthOfFieldClip == null)
			{
				break;
			}
			if (cameraDepthOfFieldClip.Key == clipsInThisFrame[i].Key)
			{
				cameraDepthOfFieldClip2 = clipsInThisFrame[i];
				break;
			}
		}
		if (cameraDepthOfFieldClip2 != null)
		{
			float time = 1f;
			if (cameraDepthOfFieldClip2.NormalizedEnd - cameraDepthOfFieldClip2.NormalizedBegin > 0f && normalized - cameraDepthOfFieldClip2.NormalizedBegin >= 0f)
			{
				time = (normalized - cameraDepthOfFieldClip2.NormalizedBegin) / (cameraDepthOfFieldClip2.NormalizedEnd - cameraDepthOfFieldClip2.NormalizedBegin);
			}
			CameraExtension.dofType = cameraDepthOfFieldClip2.mDepthOfFieldType;
			CameraExtension.dofNear = cameraDepthOfFieldClip2.mDepthOfFieldNear;
			CameraExtension.dofFar = cameraDepthOfFieldClip2.mDepthOfFieldFar;
			CameraExtension.dofScale = cameraDepthOfFieldClip2.mDepthOfFieldScale.Evaluate(time);
		}
	}

	protected override void _ExitNodes(List<CameraDepthOfFieldClip> clipsInThisFrame, float normalized, bool isRolleback = false)
	{
		BuffManager buffManager = BuffManager.GetBuffManager();
		if (buffManager != null && !(CameraExtension == null))
		{
			for (int i = 0; i < clipsInThisFrame.Count; i++)
			{
				buffManager.runningCameraDepthOfFieldClip.Remove(clipsInThisFrame[i].Key);
			}
			if (buffManager.UpdateCameraDepthOfField() == null)
			{
				CameraExtension.dofType = DepthOfFieldType.Disabled;
			}
		}
	}

	protected override bool _CanTriggerOnInOutOneFrame()
	{
		return false;
	}

	protected override void _Stop(bool isForceClean = true)
	{
	}

	protected override void _Shutdown()
	{
	}

	public void ResetData()
	{
		CameraExtension.dofType = DepthOfFieldType.Disabled;
	}

	public bool IsPlayer()
	{
		return Agent.IsLocalPlayer;
	}
}
