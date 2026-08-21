using System.Collections.Generic;
using Cinemachine;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

public class QWorldCameraManager
{
	public QWorldCameraContext data = new QWorldCameraContext();

	private Dictionary<QWCameraFlag, QWUICamera> cameras;

	private HashSet<QWCameraFlag> unRefCameraFlag;

	public static CinemachineBlendDefinition defaultBlend = new CinemachineBlendDefinition
	{
		m_Style = CinemachineBlendDefinition.Style.EaseIn,
		m_Time = 0.6f
	};

	public static QWorldCameraManager Instance;

	public QWCharacterCamera mcCamera;

	private CinemachineBrain brain;

	public CinemachineBrain GetBrain => brain;

	public Camera MainCamera => data.mainCam;

	public void RegisterCharacterCamera(QWCharacterCamera charCam)
	{
		mcCamera = charCam;
	}

	public void ChangeStoryCameraActive(bool active)
	{
		mcCamera.StoryLook.Priority = ((!active) ? 1 : 20);
	}

	public void RegisterCamera(QWUICamera controller, QWCameraFlag flag)
	{
		if (cameras == null)
		{
			cameras = new Dictionary<QWCameraFlag, QWUICamera>();
		}
		if (cameras.ContainsKey(flag))
		{
			cameras.Remove(flag);
		}
		cameras.Add(flag, controller);
		brain = Camera.main.GetComponent<CinemachineBrain>();
		if (flag == QWCameraFlag.Player)
		{
			SetCameraBlend(1);
		}
	}

	public void ClearUnRefCamera()
	{
		if (unRefCameraFlag == null)
		{
			unRefCameraFlag = new HashSet<QWCameraFlag>();
		}
		unRefCameraFlag.Clear();
		foreach (KeyValuePair<QWCameraFlag, QWUICamera> camera in cameras)
		{
			if (!camera.Value)
			{
				unRefCameraFlag.Add(camera.Key);
			}
		}
		foreach (QWCameraFlag item in unRefCameraFlag)
		{
			cameras.Remove(item);
		}
	}

	public void RefreshMainCamera()
	{
		data.mainCam = Camera.main;
	}

	public void ResetCameraBlend()
	{
		GetBrain.m_DefaultBlend = defaultBlend;
	}

	public void SetCameraBlend(int blendType, float time = 0.6f)
	{
		GetBrain.m_DefaultBlend = new CinemachineBlendDefinition((CinemachineBlendDefinition.Style)blendType, time);
	}

	public QWCameraFlag ExcahngeCameraFlag(int cameraFlag)
	{
		return (QWCameraFlag)cameraFlag;
	}

	public void ForceToPlayerCamera()
	{
		ForceUpdate();
		SetCameraBlend(0);
		EnableCamera(1, "", QWorldCameraContext.ForcePlayerOrStoryLayer);
	}

	public void EnableCamera(int flag, string path, int layer)
	{
		QWCameraFlag qWCameraFlag = ExcahngeCameraFlag(flag);
		QWCustomCamera ret;
		while (data.customCameraLayer.TryPeek(out ret))
		{
			if (ret.layer > layer)
			{
				QWCustomCamera qWCustomCamera = data.customCameraLayer.Pop();
				if (qWCameraFlag != QWCameraFlag.CustomCamera)
				{
					if ((bool)data.lastBlendCamera)
					{
						data.lastBlendCamera.Dispose();
					}
					data.lastBlendCamera = qWCustomCamera;
				}
				else
				{
					qWCustomCamera.Dispose();
				}
				continue;
			}
			if (ret.layer != layer)
			{
				break;
			}
			if (ret.cameraShortPath == path)
			{
				return;
			}
			QWCustomCamera qWCustomCamera2 = data.customCameraLayer.Pop();
			if (qWCameraFlag != QWCameraFlag.CustomCamera)
			{
				if ((bool)data.lastBlendCamera)
				{
					data.lastBlendCamera.Dispose();
				}
				data.lastBlendCamera = qWCustomCamera2;
			}
			else
			{
				qWCustomCamera2.Dispose();
			}
			break;
		}
		bool flag2 = false;
		switch (qWCameraFlag)
		{
		case QWCameraFlag.CustomCamera:
		{
			string text = QWorldCameraContext.CustomCameraBasePath + path;
			QWCustomCamera component = Object.Instantiate(Asset.Load(text) as GameObject).GetComponent<QWCustomCamera>();
			if (component.blendDefinition.m_Style == CinemachineBlendDefinition.Style.Cut)
			{
				if (data.cameraFlag == QWCameraFlag.FocusPlayer)
				{
					ExitFocusCamera(force: true);
				}
				else if (data.focusPlayerCamera != null && data.focusPlayerCamera.IsInAct)
				{
					data.focusPlayerCamera.DisableCamera(force: true);
				}
			}
			GetBrain.m_DefaultBlend = component.blendDefinition;
			component.EnableCamera();
			component.layer = layer;
			component.cameraShortPath = path;
			component.cameraPath = text;
			data.customCameraLayer.Push(component);
			data.cameraFlag = qWCameraFlag;
			data.BlendRestoreDirty = true;
			if (component.blendDefinition.m_Style != CinemachineBlendDefinition.Style.Cut)
			{
				data.cutBlendDirty = 0;
				data.lastSwitchCameraBlendTimestamp = Time.time;
				data.blendDuration = component.blendDefinition.m_Time;
			}
			else
			{
				ForceUpdate();
				Instance.MainCamera.transform.position = component.mCamera.transform.position;
				QWorldScene.Scene.ResetWorldStateWithPos(Instance.MainCamera.transform.position);
				data.cutBlendDirty = 2;
			}
			break;
		}
		case QWCameraFlag.Story:
			if (data.customCameraLayer.Count <= 0)
			{
				if (data.cameraFlag == QWCameraFlag.FocusPlayer)
				{
					ExitFocusCamera();
				}
				data.cameraFlag = qWCameraFlag;
			}
			break;
		case QWCameraFlag.Player:
			if (data.customCameraLayer.Count <= 0)
			{
				if (data.cameraFlag == QWCameraFlag.CustomCamera && (bool)data.lastBlendCamera)
				{
					flag2 = true;
					OutBlend(data.lastBlendCamera);
				}
				else if (data.cameraFlag == QWCameraFlag.FocusPlayer)
				{
					ExitFocusCamera();
				}
				data.cameraFlag = qWCameraFlag;
			}
			else if (data.cutBlendDirty > 0)
			{
				ForceUpdate();
				Instance.MainCamera.transform.position = mcCamera.FreeLook.transform.position;
				QWorldScene.Scene.ResetWorldStateWithPos(Instance.MainCamera.transform.position);
			}
			break;
		case QWCameraFlag.FocusPlayer:
			if (data.focusPlayerCamera == null)
			{
				data.focusPlayerCamera = QWFocusCamera.Load();
			}
			data.focusPlayerCamera.FindSafeAreaAndEnable();
			data.cameraFlag = qWCameraFlag;
			break;
		}
		if (!flag2 && (bool)data.lastBlendCamera)
		{
			data.lastBlendCamera.Dispose();
			data.lastBlendCamera = null;
		}
	}

	public void ExitFocusCamera(bool force = false)
	{
		if (data.cameraFlag == QWCameraFlag.FocusPlayer)
		{
			data.focusPlayerCamera.DisableCamera(force);
		}
	}

	public void ExitCustomCamera(string path)
	{
		QWCustomCamera ret;
		while (data.customCameraLayer.TryPeek(out ret))
		{
			if (ret.cameraShortPath == path)
			{
				data.customCameraLayer.RemoveRandom(ret, out var _);
				ret.Dispose();
				break;
			}
		}
	}

	private void OutBlend(QWCustomCamera cam)
	{
		CinemachineBlendDefinition outBlendDefinition = cam.outBlendDefinition;
		GetBrain.m_DefaultBlend = cam.outBlendDefinition;
		data.BlendRestoreDirty = true;
		if (outBlendDefinition.m_Style != CinemachineBlendDefinition.Style.Cut)
		{
			data.cutBlendDirty = 0;
			data.lastSwitchCameraBlendTimestamp = Time.time;
			data.blendDuration = outBlendDefinition.m_Time;
		}
		else
		{
			ForceUpdate();
			QWorldScene.Scene.ResetWorldStateWithPos(Instance.MainCamera.transform.position);
			data.cutBlendDirty = 2;
		}
	}

	public void ExitTopCustomCamera()
	{
		if (data.customCameraLayer.Count > 1)
		{
			if (data.customCameraLayer.TryPeek(out var _))
			{
				QWCustomCamera qWCustomCamera = data.customCameraLayer.Pop();
				OutBlend(qWCustomCamera);
				qWCustomCamera.Dispose();
			}
		}
		else
		{
			EnableCamera(1, "", QWorldCameraContext.ForcePlayerOrStoryLayer);
		}
	}

	public void Init()
	{
		Instance = this;
		data.customCameraLayer = new CustomCameraStack();
		RefreshMainCamera();
	}

	public void InitLight()
	{
		Light[] lights = Light.GetLights(LightType.Directional, 0);
		if (lights != null && lights.Length != 0)
		{
			data._directionalLight = lights[0];
			data._simMainLight = data._directionalLight.GetComponent<SimMainLight>();
		}
	}

	public void CustomCameraBlendControl()
	{
		if (!data.BlendRestoreDirty)
		{
			return;
		}
		if (data.cutBlendDirty > 0)
		{
			data.cutBlendDirty--;
			if (data.cutBlendDirty <= 0)
			{
				data.BlendRestoreDirty = false;
				if ((bool)data.lastBlendCamera)
				{
					data.lastBlendCamera.Dispose();
					data.lastBlendCamera = null;
				}
				ResetCameraBlend();
			}
		}
		else if (Time.time - data.lastSwitchCameraBlendTimestamp > data.blendDuration)
		{
			data.BlendRestoreDirty = false;
			if ((bool)data.lastBlendCamera)
			{
				data.lastBlendCamera.Dispose();
				data.lastBlendCamera = null;
			}
			ResetCameraBlend();
		}
	}

	public void ForceUpdate()
	{
		GetBrain?.ManualUpdate();
	}

	public void LateTick()
	{
		if (data.focusPlayerCamera != null && data.focusPlayerCamera.IsInAct)
		{
			data.focusPlayerCamera?.Tick();
		}
		CustomCameraBlendControl();
	}

	public void Tick()
	{
		if (data.customCameraLayer.Count <= 0)
		{
			bool flag = false;
			foreach (KeyValuePair<QWCameraFlag, QWUICamera> camera in cameras)
			{
				if ((bool)camera.Value && camera.Value.isActiveAndEnabled)
				{
					camera.Value.Tick();
				}
				else if (!camera.Value)
				{
					flag = true;
				}
			}
			if (flag)
			{
				ClearUnRefCamera();
			}
		}
		if (data._simMainLight != null && data._simMainLight.castRegionalShadow)
		{
			Transform transform = Instance.MainCamera.transform;
			Vector3 forward = transform.forward;
			Vector3 position = transform.position;
			forward = new Vector3(forward.x, 0f, forward.z).normalized;
			Bounds regionalShadowBounds = data._simMainLight.regionalShadowBounds;
			Vector3 size = regionalShadowBounds.size;
			data._simMainLight.transform.position = new Vector3(position.x, regionalShadowBounds.center.y, position.z) + forward * Mathf.Min(size.x, size.z) / 2f;
		}
	}

	public void CopyCameraParams(CinemachineVirtualCamera targetCamera)
	{
		if (!(mcCamera == null))
		{
			mcCamera.FreeLook.ForceCameraPosition(targetCamera.transform.position, targetCamera.transform.rotation);
		}
	}

	public QWFocusCamera GetFocusCamera()
	{
		return data.focusPlayerCamera;
	}

	public void Dispose()
	{
		data = null;
		Instance = null;
	}
}
