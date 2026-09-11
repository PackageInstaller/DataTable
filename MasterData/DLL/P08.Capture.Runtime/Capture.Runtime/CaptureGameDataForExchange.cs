using System.Collections.Generic;
using Cinemachine;
using UnityEngine;

namespace Capture.Runtime;

public class CaptureGameDataForExchange
{
	private const string singleCameraPath = "CaptureGame/Camera/SingleLookCamera";

	public CinemachineFreeLook singleCaptureCamera;

	public CinemachineVirtualCamera multiCaptureCamera;

	public GameObject cameraRoot;

	public CaptureLevelContainer levelContainer = new CaptureLevelContainer();

	public ComponentsManager componentMgr = new ComponentsManager();

	public int stageId;

	public int mainStageId;

	public string stageConfigName;

	public StageData m_stageData;

	public bool isFreeCapture;

	public int singleModeRoleId;

	private Dictionary<GameObject, CaptureEntityTrigger> ceHook = new Dictionary<GameObject, CaptureEntityTrigger>();

	public Transform characterRoot;

	public Transform decoratorRoot;

	public void InstSingleCamera(Transform followTarget, Transform lookAt)
	{
		CaptureGameDataForExchange sceneCtx = (NScene.GetCurrentScene() as CaptureScene).sceneCtx;
		if (Camera.main.gameObject.GetComponent<CinemachineBrain>() == null)
		{
			Camera.main.gameObject.AddComponent<CinemachineBrain>();
		}
		GameObject gameObject = Asset.Instantiate("CaptureGame/Camera/SingleLookCamera");
		singleCaptureCamera = gameObject.GetComponent<CinemachineFreeLook>();
		singleCaptureCamera.Follow = followTarget;
		singleCaptureCamera.LookAt = lookAt;
		if (sceneCtx.m_stageData.cameraParams.singleLimitX)
		{
			Vector2 singleLimitXVlaue = sceneCtx.m_stageData.cameraParams.singleLimitXVlaue;
			singleCaptureCamera.m_XAxis.Value = (singleLimitXVlaue.x + singleLimitXVlaue.y) / 2f;
		}
	}

	public void InstMultiCamera(CameraParams cp)
	{
		CinemachineBrain cinemachineBrain = Camera.main.gameObject.GetComponent<CinemachineBrain>();
		if (cinemachineBrain == null)
		{
			cinemachineBrain = Camera.main.gameObject.AddComponent<CinemachineBrain>();
		}
		cinemachineBrain.m_DefaultBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Linear, 0.3f);
		if (cameraRoot == null)
		{
			cameraRoot = new GameObject("CameraRoot");
			cameraRoot.transform.localPosition = Vector3.zero;
			cameraRoot.transform.localRotation = Quaternion.identity;
		}
		multiCaptureCamera = new GameObject("multipleVm").AddComponent<CinemachineVirtualCamera>();
		multiCaptureCamera.transform.parent = cameraRoot.transform;
		multiCaptureCamera.transform.localPosition = cp.pos;
		multiCaptureCamera.transform.localRotation = Quaternion.Euler(cp.rot.x, cp.rot.y, cp.rot.z);
	}

	public void InsertEntity(CaptureEntity entity)
	{
		levelContainer.InsertObject(entity);
	}

	public void RemoveEntity(CaptureEntity entity)
	{
		levelContainer.RemoveObj(entity);
	}

	public CaptureEntity GetEntityById(int identify)
	{
		return levelContainer.GetEntity(identify);
	}

	public void RemoveEntity(int identify)
	{
		levelContainer.RemoveEntity(identify);
	}

	public void LoadStageCfg()
	{
		ICaptureStageSerializer stageSerializer = CaptureHelper.GetStageSerializer();
		m_stageData = stageSerializer.Load(stageConfigName);
	}

	public bool CheckIsSingleMode()
	{
		return m_stageData.mode == CaptureGameMode.Single;
	}

	public void AddTrigger(CaptureEntityTrigger newTrigger)
	{
		if (!ceHook.ContainsKey(newTrigger.gameObject))
		{
			ceHook.Add(newTrigger.gameObject, newTrigger);
		}
	}

	public void RemoveTrigger(CaptureEntityTrigger newTrigger)
	{
		if (ceHook.ContainsKey(newTrigger.gameObject))
		{
			ceHook.Remove(newTrigger.gameObject);
		}
	}

	public CaptureEntityTrigger TryGetTrigger(GameObject gameObject)
	{
		ceHook.TryGetValue(gameObject, out var value);
		return value;
	}
}
