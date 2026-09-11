using Cinemachine;
using T0World;
using UnityEngine;

namespace Oath;

public class OathCaptureCameraLogic : T0CaptureCameraLogic
{
	public override CinemachineFreeLook freeLookCamera => OathSceneLoader.Scene.context.captureManager.captureContext.freeLookCamera;

	public override void Init()
	{
		GameObject gameObject = Asset.InstantiateWithoutCache("Oath/Common/CameraController", OathSceneLoader.Scene.context.captureViewUI.transform);
		cameraController = gameObject.GetComponent<OathCaptureCameraController>();
		cameraController.Init(this);
		gameObject.transform.SetAsFirstSibling();
	}
}
