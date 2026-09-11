using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using Dorm.Furniture;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Networking;

namespace Dorm;

public class DormRoomManager : SerializedMonoBehaviour
{
	public enum RoomState
	{
		mEditFurniture,
		mFreelook
	}

	public static DormRoomManager _instance;

	public bool isCanEdit;

	public GameObject rotationToolGo;

	[SerializeField]
	private GameObject suitGo;

	public List<Collider> cameraColliderS;

	public List<RoomWallTag> wallTags;

	private Transform frontWallTrs;

	private Transform behindWallTrs;

	private Transform leftWallTrs;

	private Transform rightWallTrs;

	private SceneDitherControl frontWallsceneDit;

	private SceneDitherControl behindWallsceneDit;

	private SceneDitherControl leftWallsceneDit;

	private SceneDitherControl rightWallsceneDit;

	private Transform floorTrs;

	[SerializeField]
	private GameObject dormRoomBg;

	[SerializeField]
	private GameObject lightGo;

	public RoomInfo mapFurnitureInfoS;

	public bool isRotateCamera;

	public ColorOutlineControl overrideOutlineOnNotify;

	public static DormRoomManager Instance => _instance;

	public GameObject SuitObject
	{
		get
		{
			if (suitGo == null)
			{
				Debug.LogWarning("suitGo missing, Generate SuitDummy");
				suitGo = GenerateSuitDummy();
			}
			return suitGo;
		}
	}

	private void Awake()
	{
		_instance = this;
		cameraColliderS = new List<Collider>();
		wallTags = new List<RoomWallTag>();
		frontWallTrs = base.transform.Find("FrontWall");
		behindWallTrs = base.transform.Find("BehindWall");
		leftWallTrs = base.transform.Find("LeftWall");
		rightWallTrs = base.transform.Find("RightWall");
		floorTrs = base.transform.Find("Floor");
		frontWallsceneDit = frontWallTrs.GetComponent<SceneDitherControl>();
		behindWallsceneDit = behindWallTrs.GetComponent<SceneDitherControl>();
		leftWallsceneDit = leftWallTrs.GetComponent<SceneDitherControl>();
		rightWallsceneDit = rightWallTrs.GetComponent<SceneDitherControl>();
		if (dormRoomBg != null)
		{
			dormRoomBg.transform.SetParent(Camera.main.transform, worldPositionStays: false);
		}
	}

	private void OnDestroy()
	{
		if ((bool)dormRoomBg)
		{
			UnityEngine.Object.Destroy(dormRoomBg);
		}
	}

	public void RefreshColliderS()
	{
		cameraColliderS.Clear();
		if (DormCameraManager.Instance.triggerPanel != null)
		{
			cameraColliderS.Add(DormCameraManager.Instance.triggerPanel.GetComponent<Collider>());
		}
		wallTags.Clear();
		GameObject[] array = GameObject.FindGameObjectsWithTag("ground");
		for (int i = 0; i < array.Length; i++)
		{
			RoomWallTag component = array[i].GetComponent<RoomWallTag>();
			if (component != null)
			{
				wallTags.Add(component);
			}
		}
	}

	public void ChangeState(RoomState roomState)
	{
		switch (roomState)
		{
		case RoomState.mEditFurniture:
		{
			for (int k = 0; k < cameraColliderS.Count; k++)
			{
				cameraColliderS[k].enabled = false;
			}
			for (int l = 0; l < wallTags.Count; l++)
			{
				wallTags[l].SetColliderActive(v: true);
			}
			break;
		}
		case RoomState.mFreelook:
		{
			for (int i = 0; i < cameraColliderS.Count; i++)
			{
				cameraColliderS[i].enabled = true;
			}
			for (int j = 0; j < wallTags.Count; j++)
			{
				wallTags[j].SetColliderActive(v: false);
			}
			break;
		}
		}
	}

	public Transform GetTrsByType(TileType tileType)
	{
		return tileType switch
		{
			TileType.WALL_FRONT => frontWallTrs, 
			TileType.WALL_BEHIND => behindWallTrs, 
			TileType.WALL_LEFT => leftWallTrs, 
			TileType.WALL_RIGHT => rightWallTrs, 
			_ => floorTrs, 
		};
	}

	public SceneDitherControl GetSceneDitherByType(TileType tileType)
	{
		return tileType switch
		{
			TileType.WALL_FRONT => frontWallsceneDit, 
			TileType.WALL_BEHIND => behindWallsceneDit, 
			TileType.WALL_LEFT => leftWallsceneDit, 
			TileType.WALL_RIGHT => rightWallsceneDit, 
			_ => null, 
		};
	}

	public void InitRoomInfo(int roomId)
	{
		DormCoordinate.Instance.BuildAStarPathCoordinate(roomId);
	}

	public void SetRoomThemeWall(string materialPath, string meshPath = "")
	{
		List<RoomWallTag> roomWallTagS = DormCoordinate.Instance.roomWallTagS;
		Mesh mesh = null;
		if (!string.IsNullOrEmpty(meshPath))
		{
			mesh = Asset.Load<Mesh>(meshPath);
		}
		Material material = Asset.Load<Material>(materialPath);
		for (int i = 0; i < roomWallTagS.Count; i++)
		{
			MeshFilter component = roomWallTagS[i].GetComponent<MeshFilter>();
			MeshRenderer meshRenderer = roomWallTagS[i].meshRenderer;
			SceneDitherControl component2 = roomWallTagS[i].GetComponent<SceneDitherControl>();
			if (component != null && mesh != null)
			{
				component.mesh = mesh;
			}
			if (meshRenderer != null && material != null)
			{
				meshRenderer.material = material;
			}
			if (component2 != null)
			{
				component2.Set();
			}
		}
	}

	public void SetRoomThemeFloor(string gameObjectPath, string extendPath = "")
	{
		Transform transform = DormCoordinate.Instance.floorRoomWallTag.transform;
		Transform transform2 = transform.Find("ground");
		if (transform2 != null)
		{
			UnityEngine.Object.Destroy(transform2.gameObject);
		}
		Transform transform3 = transform.Find("extend");
		if (transform3 != null)
		{
			UnityEngine.Object.Destroy(transform3.gameObject);
		}
		GameObject gameObject = Asset.Load<GameObject>(gameObjectPath);
		GameObject gameObject2 = null;
		if (!string.IsNullOrEmpty(extendPath))
		{
			gameObject2 = Asset.Load<GameObject>(extendPath);
		}
		if (gameObject != null)
		{
			UnityEngine.Object.Instantiate(gameObject, transform).name = "ground";
		}
		if (gameObject2 != null)
		{
			UnityEngine.Object.Instantiate(gameObject2, transform).name = "extend";
		}
	}

	public void SetRoomThemeBG(string bgPath, string lightPath)
	{
		if (dormRoomBg != null)
		{
			UnityEngine.Object.Destroy(dormRoomBg);
			dormRoomBg = null;
		}
		if (lightGo != null)
		{
			UnityEngine.Object.Destroy(lightGo);
			lightGo = null;
		}
		GameObject gameObject = Asset.Load<GameObject>(bgPath);
		if (gameObject != null)
		{
			dormRoomBg = UnityEngine.Object.Instantiate(gameObject, Camera.main.transform, worldPositionStays: false);
		}
		if (!string.IsNullOrEmpty(lightPath))
		{
			GameObject gameObject2 = Asset.Load<GameObject>(lightPath);
			if (gameObject2 != null)
			{
				lightGo = UnityEngine.Object.Instantiate(gameObject2, base.transform, worldPositionStays: true);
			}
		}
	}

	public void UploadImageToServer(string json, string path, Action<string> func)
	{
		StartCoroutine(UploadImage(json, path, func));
	}

	private IEnumerator UploadImage(string json, string path, Action<string> func)
	{
		byte[] bytes = Encoding.UTF8.GetBytes(json);
		using UnityWebRequest www = new UnityWebRequest(path, "POST");
		www.uploadHandler = new UploadHandlerRaw(bytes);
		www.downloadHandler = new DownloadHandlerBuffer();
		www.SetRequestHeader("Content-Type", "application/json");
		yield return www.SendWebRequest();
		if (www.result == UnityWebRequest.Result.ConnectionError || www.result == UnityWebRequest.Result.ProtocolError)
		{
			Debug.LogError("上传错误: " + www.error);
			func?.Invoke("ServerError");
			yield break;
		}
		Debug.Log("上传成功!");
		if (func != null)
		{
			ServerRequstImageData serverRequstImageData = JsonUtility.FromJson<ServerRequstImageData>(www.downloadHandler.text);
			if (serverRequstImageData.errorCode == 0)
			{
				func(serverRequstImageData.data);
			}
			else
			{
				func("ServerError");
			}
		}
	}

	public void ClearCurrentRoom()
	{
		DormCoordinate.Instance.ClearAllOccupy();
		FurnitureManager.Instance.ClearAllEntityS();
	}

	private void ClearChildByTransform(Transform trs)
	{
		for (int i = 0; i < trs.childCount; i++)
		{
			UnityEngine.Object.Destroy(trs.GetChild(i).gameObject);
		}
	}

	internal void EnableWarningMode(bool v)
	{
		if ((bool)overrideOutlineOnNotify)
		{
			overrideOutlineOnNotify.enabled = v;
		}
	}

	private static GameObject GenerateSuitDummy()
	{
		GameObject gameObject = Asset.Instantiate("Dorm/suitCube");
		if (gameObject == null)
		{
			Debug.LogWarning("Load SuitDummy Failed, Dorm/suitCube is NULL!");
			gameObject = new GameObject("suit object");
			BoxCollider boxCollider = gameObject.AddComponent<BoxCollider>();
			FurnitureTag furnitureTag = gameObject.AddComponent<FurnitureTag>();
			boxCollider.size = Vector3.one;
			boxCollider.enabled = false;
			furnitureTag.id = 0;
			furnitureTag.colliderTrs = gameObject.transform;
		}
		gameObject.SetActive(value: false);
		return gameObject;
	}
}
