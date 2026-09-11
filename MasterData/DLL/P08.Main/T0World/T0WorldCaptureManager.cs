using System;
using System.Threading.Tasks;
using P08.T0World.Locomotion;
using UnityEngine.Playables;

namespace T0World;

public class T0WorldCaptureManager : T0CaptureManagerBase
{
	public override void Dispose()
	{
		base.Dispose();
	}

	public override bool IsEnterCaptureMode()
	{
		if (captureContext != null)
		{
			return captureContext.isOpenCaptureMode;
		}
		return false;
	}

	public void EnterCaptureModeFuc()
	{
		T0WorldScene.Scene.ChangeSwitchCursor(value: true);
		LuaHelper.CallFunction("T0WorldShowCaptions", false);
		AudioManager.Instance.Stop("voice");
		AudioManager.Instance.Stop("effect");
		captureContext.changeAnimatorController.ChangeToDefaultController();
		SetCharaterLookState(isLook: false);
		captureContext.modelObj.SetActive(value: true);
		captureContext.freeLookCamera.SetActive(bActive: true);
		captureContext.captureContent.gameObject.SetActive(value: true);
		T0WorldScene.Scene.T0EntityContent.gameObject.SetActive(value: false);
		T0WorldScene.Scene.mWorldUI.ChangePhotoViewMode(T0CaptureModeStateEnum.photo);
		T0WorldScene.Scene.mWorldUI.ChangeState(T0ControlerStateEnum.photo);
		cameraLogic?.ShowCameraController(isShow: true);
		ChangeCaptureScene(1);
		captureContext.isOpenCaptureMode = true;
		T0WorldScene.Scene.interactionManager.InteractContext.ClearFocusEvent();
		T0WorldScene.Scene.agentManager.CharacteraAgent.ClearEvent();
		T0WorldScene.Scene.agentManager.CharacteraAgent.CharacterBoard.CloseAI();
		T0WorldScene.Scene.agentManager.CharacteraAgent.GetComponent<T0ChangeAnimatorController>().UnLoadCurrentController();
		ClearSceneInfo();
	}

	private async void ClearSceneInfo()
	{
		await Task.Delay(1000);
		T0WorldInteractionBehavior component = T0WorldScene.Scene.agentManager.CharacteraAgent.GetComponent<T0WorldInteractionBehavior>();
		if (component != null)
		{
			component.PlayTimeline("108502_clear_scene", out var _, out var _, DirectorWrapMode.Loop);
		}
	}

	private void ExitCaptureModeFuc()
	{
		T0WorldScene.Scene.agentManager.CharacteraAgent.GetComponent<T0ChangeAnimatorController>().ChangeToDefaultController();
		captureContext.changeAnimatorController.UnLoadCurrentController();
		T0WorldScene.Scene.ChangeSwitchCursor(value: false);
		captureContext.captureContent.gameObject.SetActive(value: false);
		T0WorldScene.Scene.T0EntityContent.gameObject.SetActive(value: true);
		cameraLogic?.ShowCameraController(isShow: false);
		T0WorldScene.Scene.mWorldUI.ChangePhotoViewMode(T0CaptureModeStateEnum.normal);
		T0WorldScene.Scene.mWorldUI.ChangeState(T0ControlerStateEnum.normal);
		T0WorldScene.Scene.interactionManager.InteractContext.ClearFocusEvent();
		T0WorldScene.Scene.agentManager.CharacteraAgent.ClearEvent();
		T0WorldScene.Scene.agentManager.CharacteraAgent.CharacterBoard.OpenAI();
		T0WorldScene.Scene.agentManager.RefreshFurnitureAgentEvent();
		T0TimelineMoveBehaviour componentInChildren = T0WorldScene.Scene.agentManager.CharacteraAgent.GetComponentInChildren<T0TimelineMoveBehaviour>();
		if (componentInChildren != null)
		{
			componentInChildren.SetNormalState();
		}
		T0WorldScene.Scene.player.SetPosAndRot(captureContext.currentLocationData.backPlayerPos, captureContext.currentLocationData.backPlayerRot);
		T0WorldScene.Scene.agentManager.CharacteraAgent.SetPosAndRot(captureContext.currentLocationData.backCharaterPos, captureContext.currentLocationData.backCharaterRot);
		UpdateCaptureSurprise();
		captureContext.currentLocationData = null;
		captureContext.currentAniData = null;
		captureContext.isOpenCaptureMode = false;
	}

	public void UpdateCaptureSurprise()
	{
		if (!T0WorldScene.Scene.dataContext.CheckIsHaveKey("CaptureSurpriseBeginState"))
		{
			int num = 0;
			object[] array = LuaHelper.CallFunction("GetT0WorldCaptureCount");
			if (array != null && array.Length != 0)
			{
				num = Convert.ToInt32(array[0]);
			}
			T0WorldScene.Scene.dataContext.RecordCountToData("CaptureCount", num);
			if (num >= 3)
			{
				T0WorldScene.Scene.dataContext.RecordCount("CaptureSurpriseBeginState");
			}
		}
	}

	public override void EnterCaptureMode()
	{
		T0WorldCreator.GetLoadingInst().SetEnterCallback(delegate
		{
			EnterCaptureModeFuc();
		});
		T0WorldCreator.GetLoadingInst().ShowLoadUI();
	}

	public override void ExitCaptureMode()
	{
		characterLogic.StopFaceTimeline();
		T0WorldCreator.GetLoadingInst().SetEnterCallback(delegate
		{
			ExitCaptureModeFuc();
		});
		T0WorldCreator.GetLoadingInst().ShowLoadUI();
	}
}
