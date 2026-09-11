using System.Collections.Generic;
using Cinemachine;
using T0World;
using UnityEngine;

namespace Oath;

public class OathCaptureContext
{
	public GameObject modelObj;

	public T0CaptureEntityBindMono captureEntityMono;

	public CinemachineFreeLook freeLookCamera;

	private CinemachineCollider _cameraCollder;

	private T0WorldCaptureData _captureData;

	public T0WorldCaptureAniData currentAniData;

	public T0CharacterIkBehavior ikBehavior;

	public bool islookCamera;

	private GameObject filterParentNode;

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
				_captureData = Asset.Load<T0WorldCaptureData>(OathConst.GetCaptureDataPath(OathSceneLoader.Scene.context.characterID));
			}
			return _captureData;
		}
	}

	private void InitFilterNode()
	{
		filterParentNode = Asset.Instantiate(OathConst.GetFilterPerfabPath(OathSceneLoader.Scene.context.characterID));
		if (!filterParentNode)
		{
			return;
		}
		cameraFilterDic?.Clear();
		cameraFilterDic = new Dictionary<string, GameObject>();
		foreach (Transform item in filterParentNode.transform)
		{
			cameraFilterDic.Add(item.name, item.gameObject);
		}
	}

	public void SetCameraFilter(string fillerName)
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
		Asset.Unload(OathConst.GetModelAssetPath(OathSceneLoader.Scene.context.characterID));
		Object.Destroy(modelObj);
		Object.Destroy(freeLookCamera.gameObject);
		Object.Destroy(filterParentNode);
		cameraFilterDic?.Clear();
		cameraFilterDic = null;
		isInit = false;
	}

	public void Init()
	{
		modelObj = Asset.Instantiate(OathConst.GetModelAssetPath(OathSceneLoader.Scene.context.characterID));
		captureEntityMono = modelObj.GetComponent<T0CaptureEntityBindMono>();
		freeLookCamera = Asset.Instantiate("Oath/Common/CaptureCamera").GetComponent<CinemachineFreeLook>();
		freeLookCamera.LookAt = captureEntityMono.lookAtPoint;
		freeLookCamera.Follow = captureEntityMono.lookAtPoint;
		ikBehavior = modelObj.GetComponent<T0CharacterIkBehavior>();
		ikBehavior.InitCharaterIk(freeLookCamera.transform);
		ikBehavior.ChangeIkState(T0CharacterIkControlerStateEnum.close);
		ikBehavior.bipedIk.enabled = false;
		InitFilterNode();
		isInit = true;
	}
}
