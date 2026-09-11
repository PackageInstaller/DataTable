using System;
using System.Collections.Generic;
using System.Linq;
using Cinemachine;
using Dorm;
using Dorm.Character;
using Dorm.MiniGame;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Playables;
using UnityEngine.SceneManagement;
using UnityEngine.Timeline;

public class DanceGameController : MonoBehaviour
{
	private static ISet<string> addedCueSheet = new HashSet<string>();

	public List<PositionAttachIsNotChild> dummyList;

	[NonSerialized]
	public CinemachineBrain brain;

	public PlayableDirector director;

	public static readonly CinemachineBlendDefinition cut = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0f);

	private static int loadAyncTaskID = -1;

	public static Scene loadScene;

	public static void AddCue(string cueSheet, string cueName, bool useAwbFile = false)
	{
		AddCue(cueSheet, useAwbFile ? (cueName + ".awb") : string.Empty);
	}

	public static void AddCue(string cueSheet, string awbFile = null)
	{
		if (CriAtom.GetCueSheet(cueSheet) == null)
		{
			addedCueSheet.Add(cueSheet);
			CriAtom.AddCueSheetAsync(cueSheet, cueSheet + ".acb", awbFile ?? string.Empty, null, loadAwbOnMemory: true);
		}
	}

	[NoToLua]
	public static bool TryGetCueInfo(string cueSheetName, string cueName, string awbFile, out CriAtomEx.CueInfo cueInfo)
	{
		AddCue(cueSheetName, awbFile);
		CriAtomExAcb acb = CriAtom.GetAcb(cueSheetName);
		if (acb != null && acb.GetCueInfo(cueName, out cueInfo))
		{
			return true;
		}
		cueInfo = default(CriAtomEx.CueInfo);
		return false;
	}

	public static void RemoveAddedCueSheets()
	{
		foreach (string item in addedCueSheet)
		{
			CriAtom.RemoveCueSheet(item);
		}
		addedCueSheet.Clear();
	}

	public static int GetCueInfoLength(string cueSheetName, string cueName, string awbFile)
	{
		if (TryGetCueInfo(cueSheetName, cueName, awbFile, out var cueInfo))
		{
			return (int)cueInfo.length;
		}
		return 0;
	}

	public static void SetEntityAnimeSpeed(int entityID, float speed)
	{
		DormEntity dormEntity = DormEntityManager.Instance.TryGet(entityID);
		if (dormEntity != null)
		{
			dormEntity.animator.speed = speed;
		}
	}

	internal static void SetDummyFollowEntity(IEnumerable<PositionAttachIsNotChild> dummys, string dummyName, int entityID)
	{
		PositionAttachIsNotChild positionAttachIsNotChild = dummys.FirstOrDefault(delegate(PositionAttachIsNotChild link)
		{
			if (link.gameObject.name == dummyName)
			{
				if (entityID == 0)
				{
					if ((bool)link.AttachTransform)
					{
						return true;
					}
				}
				else if (!link.AttachTransform)
				{
					return true;
				}
			}
			return false;
		});
		if ((bool)positionAttachIsNotChild)
		{
			positionAttachIsNotChild.AttachTransform = DormEntityManager.Instance.TryGet(entityID)?.ModelTrs;
		}
	}

	public void SetDummyFollowEntity(string dummyName, int entityID)
	{
		IEnumerable<PositionAttachIsNotChild> enumerable = dummyList;
		SetDummyFollowEntity(enumerable ?? GetComponentsInChildren<PositionAttachIsNotChild>(), dummyName, entityID);
	}

	public Transform GetDummy(string dummyName)
	{
		return dummyList.FirstOrDefault((PositionAttachIsNotChild link) => link.gameObject.name == dummyName)?.transform;
	}

	public static DanceGameController Load(string prefabPath)
	{
		return Asset.Instantiate(prefabPath).GetComponent<DanceGameController>();
	}

	public CinemachineBrain InitCinemachineBrain()
	{
		if (NScene.GetCurrentScene() is MiniGameScene miniGameScene)
		{
			if ((bool)brain && miniGameScene.cinemachineBrain != brain)
			{
				UnityEngine.Object.Destroy(miniGameScene.cinemachineBrain);
				miniGameScene.cinemachineBrain = brain;
			}
			else
			{
				miniGameScene.cinemachineBrain.m_DefaultBlend = cut;
				brain = miniGameScene.cinemachineBrain;
				brain.enabled = true;
			}
		}
		TimelineAsset timelineAsset = director.playableAsset as TimelineAsset;
		if ((bool)director && (bool)timelineAsset)
		{
			foreach (TrackAsset outputTrack in timelineAsset.GetOutputTracks())
			{
				if (outputTrack is CinemachineTrack key)
				{
					director.SetGenericBinding(key, brain);
				}
			}
		}
		return brain;
	}

	private static Vector3 AdjustPos(Collider[] walls, DormEntity player, Vector3 colliderPos, Quaternion colliderRot)
	{
		Vector3 zero = Vector3.zero;
		CapsuleCollider component = player.FindAttachPoint("gua_Hit").GetComponent<CapsuleCollider>();
		if ((bool)component)
		{
			Vector3 positionA = component.transform.position - player.ModelTrs.position + colliderPos;
			foreach (Collider collider in walls)
			{
				Transform transform = collider.transform;
				if (Physics.ComputePenetration(component, positionA, component.transform.rotation, collider, transform.position, transform.rotation, out var direction, out var distance))
				{
					zero += direction * distance;
				}
			}
		}
		return zero;
	}

	public static void UpdateCharaGrabPos(Collider[] walls, int entityID, PointerEventData eventData)
	{
		DormEntity dormEntity = DormEntityManager.Instance.TryGet(entityID);
		if (dormEntity == null)
		{
			return;
		}
		Vector2 position = eventData.position;
		if (!Physics.Raycast(Camera.main.ScreenPointToRay(position), out var hitInfo, 10f, -5 & ~DormConst.CHARA_LAYER_MASK))
		{
			return;
		}
		Vector3 point = hitInfo.point;
		if (hitInfo.collider.gameObject.layer != LayerMask.NameToLayer("ground"))
		{
			Vector3 direction = Vector3.ProjectOnPlane(Vector3.down, hitInfo.normal);
			if (Physics.Raycast(point, direction, out var hitInfo2, 10f, DormConst.GROUND_LAYER_MASK))
			{
				point = hitInfo2.point;
			}
			else
			{
				point.y = 0f;
			}
		}
		Vector3 vector = Camera.main.transform.position - point;
		vector.y = 0f;
		if (vector == Vector3.zero)
		{
			vector = dormEntity.GetForward();
		}
		vector.Normalize();
		Quaternion quaternion = Quaternion.LookRotation(vector);
		point += AdjustPos(walls, dormEntity, point, quaternion);
		dormEntity.PutAt(point, quaternion);
	}

	public static void InitCampEntity(int entityID)
	{
		DormEntity dormEntity = DormEntityManager.Instance.TryGet(entityID);
		if (dormEntity != null)
		{
			GameObject gameObject = dormEntity.FindAttachPoint("gua_Hit").gameObject;
			if (gameObject.GetComponent<Collider>() == null)
			{
				CapsuleCollider capsuleCollider = gameObject.AddComponent<CapsuleCollider>();
				capsuleCollider.center = new Vector3(0f, 0f, 0f);
				capsuleCollider.radius = dormEntity.radius;
				capsuleCollider.height = dormEntity.height;
				capsuleCollider.direction = 1;
				capsuleCollider.enabled = true;
			}
			gameObject.layer = DormConst.CHARA_LAYER_ID;
			dormEntity.model.AddComponent<EntityClickTrigger>().eid = entityID;
		}
	}

	[Obsolete("Asset.LoadLevelSync实际上调用SceneManager.LoadLevel，根据文档描述使用 SceneManager.LoadScene 时，不会立即加载场景，无法正确统计加载场景中的物体")]
	public static Scene LoadSceneObj(string path)
	{
		AssetManager.TryGetAssetNameAndBundleName(path, out var assetName, out var _);
		Asset.LoadLevelSync(path, isAddtive: true);
		Scene sceneByPath = SceneManager.GetSceneByPath(assetName);
		GameObject[] rootGameObjects = sceneByPath.GetRootGameObjects();
		for (int i = 0; i < rootGameObjects.Length; i++)
		{
			rootGameObjects[i].tag = "Scene";
		}
		DormTagBase.Collect(GameObject.FindGameObjectsWithTag("Scene"));
		return sceneByPath;
	}

	public static bool LoadSceneObjAsync(string path, Action callback)
	{
		if (loadAyncTaskID != -1)
		{
			return false;
		}
		AssetManager.TryGetAssetNameAndBundleName(path, out var assetPath, out var _);
		AssetBundleLoadOperation op = Asset.LoadLevelAsync(path, isAddtive: true);
		loadAyncTaskID = FuncTimerManager.inst.CreateFuncFrameTimer(delegate
		{
			if (op.IsDone())
			{
				loadScene = SceneManager.GetSceneByPath(assetPath);
				GameObject[] rootGameObjects = loadScene.GetRootGameObjects();
				for (int i = 0; i < rootGameObjects.Length; i++)
				{
					rootGameObjects[i].tag = "Scene";
				}
				DormTagBase.Collect(GameObject.FindGameObjectsWithTag("Scene"));
				callback?.Invoke();
				FuncTimerManager.inst.StopFuncTimer(loadAyncTaskID);
				loadAyncTaskID = -1;
			}
		});
		return true;
	}
}
