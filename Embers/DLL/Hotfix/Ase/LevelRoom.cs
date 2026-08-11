using System.Collections.Generic;
using Cinemachine;
using PepijnWillekens.EasyWallColliderUnity;
using UnityEngine;
using UnityEngine.AI;

namespace Ase;

public class LevelRoom : MonoBehaviour
{
	public int[] LevelAreaIndex;

	public List<int> areas = new List<int>();

	public GameObject ground;

	public List<GameObject> monsterGrounds;

	public List<GameObject> navMeshGos;

	public GameObject stencilMask;

	public GameObject airWallRoot;

	public CinemachineVirtualCamera virtualCamera;

	public bool lockHero = true;

	public bool followHero = true;

	public UIAudioPlayer enterAudioPlayer;

	public UIAudioPlayer exitAudioPlayer;

	private List<NavMeshBuildSource> navMeshBuildSourceList;

	private SceneSystem sceneSystem;

	private string sceneName;

	private GameObject lightRoot;

	public bool subSceneConnect;

	public string SceneName => sceneName;

	public List<NavMeshBuildSource> GetNavMeshBuildSource()
	{
		return navMeshBuildSourceList;
	}

	public void VriCameraFollowSet(Transform heroTran)
	{
		if (virtualCamera != null)
		{
			if (followHero)
			{
				virtualCamera.m_Follow = heroTran;
			}
			if (lockHero)
			{
				virtualCamera.m_LookAt = heroTran;
			}
		}
	}

	public void VirCameraFollowNull()
	{
		if (virtualCamera != null)
		{
			if (followHero)
			{
				virtualCamera.m_Follow = null;
			}
			if (lockHero)
			{
				virtualCamera.m_LookAt = null;
			}
		}
	}

	public void OnEnterRoom(Transform heroTran)
	{
		if (virtualCamera != null)
		{
			if (lockHero)
			{
				virtualCamera.m_LookAt = heroTran;
			}
			if (followHero)
			{
				virtualCamera.m_Follow = heroTran;
			}
			virtualCamera.gameObject.SetActive(value: true);
		}
		OpenStencilMask();
		if (enterAudioPlayer != null)
		{
			enterAudioPlayer.AudioInvoke();
		}
	}

	public void OnExitRoom()
	{
		if (virtualCamera != null)
		{
			virtualCamera.gameObject.SetActive(value: false);
		}
		CloseStencilMask();
		if (exitAudioPlayer != null)
		{
			exitAudioPlayer.AudioInvoke();
		}
	}

	public bool CreateNavMeshData(GameObject go, out NavMeshBuildSource navMeshBuildSource, int areaType)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		navMeshBuildSource = default(NavMeshBuildSource);
		MeshFilter component = go.GetComponent<MeshFilter>();
		if ((bool)component)
		{
			Mesh sharedMesh = component.sharedMesh;
			if (sharedMesh == null || !sharedMesh.isReadable)
			{
				return false;
			}
			((NavMeshBuildSource)(ref navMeshBuildSource)).shape = (NavMeshBuildSourceShape)0;
			((NavMeshBuildSource)(ref navMeshBuildSource)).sourceObject = sharedMesh;
			((NavMeshBuildSource)(ref navMeshBuildSource)).transform = component.transform.localToWorldMatrix;
			((NavMeshBuildSource)(ref navMeshBuildSource)).area = areaType;
			return true;
		}
		MeshCollider component2 = go.GetComponent<MeshCollider>();
		if ((bool)(Object)(object)component2)
		{
			Mesh sharedMesh2 = component2.sharedMesh;
			if (sharedMesh2 == null || !sharedMesh2.isReadable)
			{
				return false;
			}
			((NavMeshBuildSource)(ref navMeshBuildSource)).shape = (NavMeshBuildSourceShape)0;
			((NavMeshBuildSource)(ref navMeshBuildSource)).sourceObject = sharedMesh2;
			((NavMeshBuildSource)(ref navMeshBuildSource)).transform = ((Component)(object)component2).transform.localToWorldMatrix;
			((NavMeshBuildSource)(ref navMeshBuildSource)).area = areaType;
			return true;
		}
		Terrain component3 = go.GetComponent<Terrain>();
		if ((bool)(Object)(object)component3)
		{
			((NavMeshBuildSource)(ref navMeshBuildSource)).shape = (NavMeshBuildSourceShape)1;
			((NavMeshBuildSource)(ref navMeshBuildSource)).sourceObject = (Object)(object)component3.terrainData;
			((NavMeshBuildSource)(ref navMeshBuildSource)).transform = Matrix4x4.TRS(((Component)(object)component3).transform.position, Quaternion.identity, Vector3.one);
			((NavMeshBuildSource)(ref navMeshBuildSource)).area = areaType;
			return true;
		}
		Collider component4 = go.GetComponent<Collider>();
		BoxCollider val = (BoxCollider)(object)((component4 is BoxCollider) ? component4 : null);
		if (val != null)
		{
			((NavMeshBuildSource)(ref navMeshBuildSource)).shape = (NavMeshBuildSourceShape)2;
			((NavMeshBuildSource)(ref navMeshBuildSource)).transform = ((Component)(object)val).transform.localToWorldMatrix;
			((NavMeshBuildSource)(ref navMeshBuildSource)).area = areaType;
			((NavMeshBuildSource)(ref navMeshBuildSource)).size = val.size;
			return true;
		}
		CapsuleCollider val2 = (CapsuleCollider)(object)((component4 is CapsuleCollider) ? component4 : null);
		if (val2 != null)
		{
			((NavMeshBuildSource)(ref navMeshBuildSource)).shape = (NavMeshBuildSourceShape)4;
			((NavMeshBuildSource)(ref navMeshBuildSource)).transform = ((Component)(object)val2).transform.localToWorldMatrix;
			((NavMeshBuildSource)(ref navMeshBuildSource)).area = areaType;
			((NavMeshBuildSource)(ref navMeshBuildSource)).size = new Vector3(val2.radius * 2f, val2.height, val2.radius * 2f);
			return true;
		}
		return false;
	}

	public void CreateAllNavMeshData()
	{
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0051: Unknown result type (might be due to invalid IL or missing references)
		//IL_0092: Unknown result type (might be due to invalid IL or missing references)
		//IL_0103: Unknown result type (might be due to invalid IL or missing references)
		navMeshBuildSourceList = new List<NavMeshBuildSource>();
		if (CreateNavMeshData(ground, out var navMeshBuildSource, 3))
		{
			navMeshBuildSourceList.Add(navMeshBuildSource);
		}
		if (navMeshGos != null)
		{
			for (int i = 0; i < navMeshGos.Count; i++)
			{
				if (CreateNavMeshData(navMeshGos[i], out var navMeshBuildSource2, 0))
				{
					navMeshBuildSourceList.Add(navMeshBuildSource2);
				}
			}
		}
		if (monsterGrounds != null)
		{
			for (int j = 0; j < monsterGrounds.Count; j++)
			{
				if (CreateNavMeshData(monsterGrounds[j], out var navMeshBuildSource3, 3))
				{
					navMeshBuildSourceList.Add(navMeshBuildSource3);
				}
			}
		}
		if (!(airWallRoot != null))
		{
			return;
		}
		EasyWallCollider[] componentsInChildren = airWallRoot.GetComponentsInChildren<EasyWallCollider>();
		for (int k = 0; k < componentsInChildren.Length; k++)
		{
			if (!componentsInChildren[k].usedToNavMesh)
			{
				continue;
			}
			for (int l = 0; l < componentsInChildren[k].colliderContainer.childCount; l++)
			{
				if (CreateNavMeshData(componentsInChildren[k].colliderContainer.GetChild(l).gameObject, out var navMeshBuildSource4, 1))
				{
					navMeshBuildSourceList.Add(navMeshBuildSource4);
				}
			}
		}
	}

	public void CloseStencilMask()
	{
		if ((bool)stencilMask)
		{
			stencilMask.SetActive(value: false);
		}
		if ((bool)lightRoot)
		{
			lightRoot.SetActive(value: false);
		}
	}

	public void OpenStencilMask()
	{
		if ((bool)stencilMask)
		{
			stencilMask.SetActive(value: true);
		}
		if ((bool)lightRoot)
		{
			lightRoot.SetActive(value: true);
		}
	}

	public void Init(SceneSystem sceneSystem)
	{
		virtualCamera?.gameObject.SetActive(value: false);
		CreateAllNavMeshData();
		lightRoot = base.transform.Find("Light")?.gameObject;
		if ((bool)lightRoot)
		{
			lightRoot.SetActive(value: false);
		}
		sceneName = base.transform.parent.parent.name + "-" + base.transform.name;
		this.sceneSystem = sceneSystem;
	}

	public void OnStart()
	{
		sceneSystem.UpdateRoomSubScene(this, active: false);
	}

	public Bounds GetRoomBounds()
	{
		Vector3 vector = ground.GetComponent<MeshRenderer>().bounds.min;
		Vector3 vector2 = ground.GetComponent<MeshRenderer>().bounds.max;
		foreach (GameObject navMeshGo in navMeshGos)
		{
			if ((bool)navMeshGo)
			{
				vector = Vector3.Min(vector, navMeshGo.GetComponent<MeshRenderer>().bounds.min);
				vector2 = Vector3.Max(vector2, navMeshGo.GetComponent<MeshRenderer>().bounds.max);
			}
		}
		return new Bounds((vector + vector2) / 2f, vector2 - vector);
	}
}
