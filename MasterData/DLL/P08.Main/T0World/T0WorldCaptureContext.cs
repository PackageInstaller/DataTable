using System.Collections.Generic;
using Cinemachine;
using UnityEngine;

namespace T0World;

public class T0WorldCaptureContext
{
	public bool isOpenCaptureMode;

	public Transform captureContent;

	public GameObject modelObj;

	public T0CaptureEntityBindMono captureEntityMono;

	public CinemachineFreeLook freeLookCamera;

	private CinemachineCollider _cameraCollder;

	private T0WorldCaptureData _captureData;

	public T0WorldCaptureLocationData currentLocationData;

	public T0WorldCaptureAniData currentAniData;

	public T0CharacterIkBehavior ikBehavior;

	public T0ChangeAnimatorController changeAnimatorController;

	public bool islookCamera;

	private Dictionary<string, GameObject> cameraFilterDic;

	public bool isInit;

	public CinemachineCollider cameraCollder
	{
		get
		{
			if (freeLookCamera == null)
			{
				return null;
			}
			if (_cameraCollder == null)
			{
				_cameraCollder = freeLookCamera.transform.GetComponent<CinemachineCollider>();
			}
			return _cameraCollder;
		}
	}

	public T0WorldCaptureData captureData
	{
		get
		{
			if (_captureData == null)
			{
				_captureData = Asset.Load<T0WorldCaptureData>(T0WorldTools.CaptureAssetPath);
			}
			return _captureData;
		}
	}

	public void SetCameraFillter(string fillerName)
	{
		if (cameraFilterDic == null || cameraFilterDic.Count == 0)
		{
			return;
		}
		foreach (KeyValuePair<string, GameObject> item in cameraFilterDic)
		{
			item.Value.SetActive(value: false);
		}
		if (cameraFilterDic.ContainsKey(fillerName))
		{
			cameraFilterDic[fillerName].SetActive(value: true);
		}
	}

	public void Dispose()
	{
		Object.Destroy(modelObj);
		cameraFilterDic?.Clear();
		cameraFilterDic = null;
		isInit = false;
	}

	public void Init()
	{
		captureContent = new GameObject("T0CaptureContent").transform;
		captureContent.gameObject.SetActive(value: false);
		modelObj = Asset.Instantiate(T0WorldTools.CaptureModelAssetPath);
		modelObj.name = $"{T0WorldScene.Scene.characterID}_Capture_Charater";
		captureEntityMono = modelObj.GetComponent<T0CaptureEntityBindMono>();
		freeLookCamera = Asset.Instantiate("T0World/Common/CaptureCamera").GetComponent<CinemachineFreeLook>();
		freeLookCamera.LookAt = captureEntityMono.lookAtPoint;
		freeLookCamera.Follow = captureEntityMono.lookAtPoint;
		ikBehavior = modelObj.GetComponent<T0CharacterIkBehavior>();
		ikBehavior.InitCharaterIk(freeLookCamera.transform);
		changeAnimatorController = modelObj.GetComponent<T0ChangeAnimatorController>();
		GameObject gameObject = Asset.Instantiate(T0WorldTools.CaptureFilterAssetPath);
		if ((bool)gameObject)
		{
			cameraFilterDic?.Clear();
			cameraFilterDic = new Dictionary<string, GameObject>();
			foreach (Transform item in gameObject.transform)
			{
				cameraFilterDic.Add(item.name, item.gameObject);
			}
		}
		modelObj.transform.SetParent(captureContent);
		freeLookCamera.transform.SetParent(captureContent);
		gameObject.transform.SetParent(captureContent);
		isInit = true;
	}
}
