using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Cinemachine;
using Dorm;
using Dorm.Character;
using Dorm.Furniture;
using LuaInterface;
using P08.SimBusiness;
using P08.SimBusiness.Input;
using P08.SimBusiness.Pathfinding;
using Pathfinding;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.EventSystems;

public class SimBusinessMgr : SerializedMonoBehaviour
{
	private class SafeMoveCmdTask : DormEntityAction.MoveCmdTask
	{
		protected override IEnumerator StartTask(EntityCmdExecutor executor)
		{
			DormComplexEntity entity = executor.entity;
			Vector3 worldPos = entity.GetWorldPos();
			Vector3 target = (Vector3)instance.navSurface.astarPath.GetNearest((Int3)worldPos, NNConstraint.Default).node.position;
			IList<Vector3> path = DormEntityAction.MoveCmdTask.GetPath(worldPos, target, ignorePathFinding: true);
			Vector3 zero = Vector3.zero;
			return MoveByPathCoroutine(entity, path, zero);
		}
	}

	public static SimBusinessMgr instance;

	public SceneNavSurface navSurface;

	public CinemachineFreeLook freeLookCam;

	public float rotateRateX = 0.2f;

	public float rotateRateY = 0.002f;

	public float limitX = 6f;

	public float limitY = 6f;

	public float wallHide = 0.1f;

	public List<RoomWallTag> roomWallTagList;

	private RoomWallTag floor;

	public GameObject farClipCamTrigger;

	[NoToLua]
	public ColorOutlineControl warningOutlineSetting;

	private Dictionary<object, Bounds> customOccupy = new Dictionary<object, Bounds>();

	private const string OCCUPY_RECT_VFX_PATH = "Dorm/Effect/houzhai/fx_hz_jingying_fanwei";

	private Dictionary<object, EffectController> occupyVfxDict = new Dictionary<object, EffectController>();

	public List<Vector3> previewPathPoints;

	public float previewPathLength;

	public bool IsCalculatingPreviewPath { get; private set; }

	private void Awake()
	{
		instance = this;
	}

	private void OnDestroy()
	{
		if (instance == this)
		{
			instance = null;
		}
	}

	private void FillFurnitureOccupy(FurnitureEntity furniture)
	{
		navSurface.floorCoordinate.FillRectOccupy(furniture.trs.position, furniture.width, furniture.height, furniture.trs.rotation.eulerAngles.y - floor.transform.rotation.eulerAngles.y);
	}

	private void RemoveFurnitureOccupy(FurnitureEntity furniture)
	{
		navSurface.floorCoordinate.RemoveRectOccupy(furniture.trs.position, furniture.width, furniture.height, furniture.trs.rotation.eulerAngles.y - floor.transform.rotation.eulerAngles.y);
	}

	private void OnEnable()
	{
		RoomWallTag.wallHideDot = wallHide;
		FurnitureManager.showAllInteractAreaPosVfx = true;
		FurnitureManager.OnFillFurnitureOccupy = FillFurnitureOccupy;
		FurnitureManager.OnRemoveFurnitureOccupy = RemoveFurnitureOccupy;
	}

	private void OnDisable()
	{
		FurnitureManager.showAllInteractAreaPosVfx = false;
		FurnitureManager.OnFillFurnitureOccupy = null;
		FurnitureManager.OnRemoveFurnitureOccupy = null;
	}

	public void InitFloor()
	{
		floor = roomWallTagList.First((RoomWallTag tag) => tag.tileType == TileType.FLOOR);
		navSurface.InitCoords(floor);
	}

	internal void OnDragCamera(PointerEventData eventData)
	{
		float num = rotateRateX;
		float num2 = rotateRateY;
		float x = eventData.delta.x * num;
		float y = -1f * eventData.delta.y * num2;
		DormCameraManager.RotateCamera(freeLookCam, x, y);
	}

	internal static PathfindingSeeker GetEntityPathSeeker(DormComplexEntity entity)
	{
		return entity?.ModelTrs.GetComponent<PathfindingSeeker>();
	}

	private static bool OnScanGoodsShelfInteractArea(InteractAreaScanner scanner, IProvideInteractArea interactArea)
	{
		int? arg = interactArea.ProvideAction(scanner.entity, out var interactPos, out var exitPos);
		DormEntityAction.Notify("ON_DORM_CHARACTER_MOVE_PICK_INTERACT_AREA", scanner.entity.id, interactArea.Provider.EntityID, interactPos, exitPos, arg);
		return false;
	}

	[NoToLua]
	public static void SetupSimBusinessEntity(DormComplexEntity entity)
	{
		Transform modelTrs = entity.ModelTrs;
		U3DUtil.Get<PathfindingSeeker>(modelTrs.gameObject);
		SimpleSmoothModifier simpleSmoothModifier = U3DUtil.Get<SimpleSmoothModifier>(modelTrs.gameObject);
		simpleSmoothModifier.maxSegmentLength = 0.7f;
		simpleSmoothModifier.strength = 0.1f;
		entity.Scanner.rndPickChance = 1f;
		entity.Scanner.scanDistinct = InteractAreaScanner.ScanDistinctType.InteractArea;
		entity.Scanner.scanAtGridCenter = true;
		entity.Scanner.onAreaScaned = OnScanGoodsShelfInteractArea;
	}

	public static void SetupSimBusinessEntity(int entityID)
	{
		if (DormEntityManager.Instance?.TryGet(entityID) is DormComplexEntity entity)
		{
			SetupSimBusinessEntity(entity);
		}
	}

	public static void ResetEntityInteractScaner(int entityID)
	{
		if (DormEntityManager.Instance?.TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			dormComplexEntity.Scanner.ClearScaned();
		}
	}

	public static void SendMoveToExitMoveCMD(int entityID, Transform target, bool queue = true)
	{
		MoveToTargetCmdTask cmd = new MoveToTargetCmdTask(target);
		DormEntityManager.Instance?.SendCmd(entityID, cmd, queue);
	}

	public static void LoadNavGraph(string path)
	{
		if ((bool)instance && (bool)instance.navSurface)
		{
			instance.navSurface.LoadAstarPath(path);
			instance.InitFloor();
		}
	}

	public static bool TryRefreshShelfCanPlace(int eid)
	{
		if (!instance)
		{
			return false;
		}
		return instance.navSurface.ShelfCheckCanPlace(FurnitureManager.Instance.Get(eid));
	}

	private static void BindTrigger(FurnitureTag shelfTag)
	{
		FurnitureEntity furnitureEntity = shelfTag.FurnitureEntity;
		Transform mainColliderTrs = shelfTag.MainColliderTrs;
		if (mainColliderTrs != null)
		{
			U3DUtil.Get<ShelfTrigger>(mainColliderTrs.gameObject).goodsEntity = furnitureEntity;
		}
	}

	internal static FurnitureEntity GenerateShelf(string prefabPath)
	{
		DormEntity dormEntity = DormEntityManager.Instance.SpawnEntityInternal(prefabPath, null, complex: false, pooled: false);
		dormEntity.needDestoryModelOnDispose = false;
		FurnitureEntity furnitureEntity = new FurnitureEntity();
		int id = dormEntity.id;
		furnitureEntity.entityId = id;
		furnitureEntity.go = dormEntity.model;
		furnitureEntity.trs = dormEntity.ModelTrs;
		furnitureEntity.interactAreas = furnitureEntity.go.GetComponentsInChildren<IProvideInteractArea>();
		FurnitureManager.Instance.AddFurnitureEntity(furnitureEntity);
		BindTrigger((FurnitureTag)(dormEntity.interactProvider = FurnitureManager.SetupFurnitureTag(furnitureEntity)));
		return furnitureEntity;
	}

	public static int GenerateShelfEntity(string path, int cfgID, int width, int height)
	{
		FurnitureEntity furnitureEntity = GenerateShelf(path);
		TileType tileType = TileType.FLOOR;
		furnitureEntity.TileType = tileType;
		FurnitureTag furnitureTag = furnitureEntity.tag;
		furnitureTag.id = cfgID;
		furnitureTag.state = 0u;
		furnitureTag.Size = new Vector3Int(width, height, 0);
		furnitureTag.forceLayOnGrount = true;
		return furnitureEntity.entityId;
	}

	public void OnStartEditShelf()
	{
		foreach (RoomWallTag roomWallTag in roomWallTagList)
		{
			roomWallTag.SetColliderActive(v: true);
		}
	}

	public void OnStopEditShelf()
	{
		foreach (RoomWallTag roomWallTag in roomWallTagList)
		{
			roomWallTag.SetColliderActive(v: false);
		}
	}

	internal void EnableWarningMode(bool v)
	{
		if ((bool)warningOutlineSetting)
		{
			warningOutlineSetting.enabled = v;
		}
	}

	public void SetShelfIsCanPlace(int eid, bool value)
	{
		DormLuaBridge.RefreshIsCanPlace(eid, value);
		EnableWarningMode(!value);
	}

	internal void SetShelfIsCanPlace(FurnitureEntity shelf, bool value)
	{
		FurnitureManager.Instance.RefreshIsCanPlace(shelf, value);
		EnableWarningMode(!value);
	}

	public static void RotateCurEditingShelf()
	{
		FurnitureEntity editingFurniture = FurnitureManager.Instance.editingFurniture;
		if (editingFurniture != null)
		{
			DormLuaBridge.RotateFurniture(editingFurniture, Vector3.up);
			if ((bool)instance)
			{
				bool value = instance.navSurface.ShelfCheckCanPlace(editingFurniture);
				instance.SetShelfIsCanPlace(editingFurniture, value);
			}
			FurnitureManager.RefreshFurnitureInteractPosVfx(editingFurniture);
		}
	}

	public static void FillObstacleOccupy(Collider obstacle)
	{
		Bounds bounds = obstacle.bounds;
		FillCustomOccupy(obstacle, bounds);
	}

	public static void FillCustomOccupy(object obj, Bounds occupy)
	{
		if ((bool)instance)
		{
			RemoveCustomOccupy(obj);
			Vector3Int vector3Int = Vector3Int.CeilToInt(occupy.size / 0.5f);
			instance.navSurface.floorCoordinate.FillRectOccupy(occupy.center, vector3Int.x, vector3Int.z, 0f);
			instance.customOccupy[obj] = occupy;
		}
	}

	public static void RemoveObstacleOccupy(BoxCollider obstacle)
	{
		RemoveCustomOccupy(obstacle);
	}

	public static void RemoveCustomOccupy(object obj)
	{
		if ((bool)instance && instance.customOccupy.TryGetValue(obj, out var value))
		{
			Vector3Int vector3Int = Vector3Int.CeilToInt(value.size / 0.5f);
			instance.navSurface.floorCoordinate.RemoveRectOccupy(value.center, vector3Int.x, vector3Int.z, 0f);
			instance.customOccupy.Remove(obj);
		}
	}

	private static Bounds CalcOccupyBounds(Bounds originBounds, Vector3 originCoordPoint)
	{
		Vector3 vector = new Vector3(0.05f, 0f, 0.05f);
		Vector3 vector2 = originBounds.center - 0.5f * originBounds.size - originCoordPoint;
		Vector3 vector3 = originBounds.center + 0.5f * originBounds.size - originCoordPoint;
		Vector3Int vector3Int = Vector3Int.CeilToInt(vector2 / 0.5f) - new Vector3Int(1, 0, 1);
		Vector3Int vector3Int2 = Vector3Int.CeilToInt(vector3 / 0.5f);
		Vector3 a = new Vector3(1f, 0f, 1f);
		Bounds result = new Bounds
		{
			min = Vector3.Scale(a, 0.5f * (Vector3)vector3Int + originCoordPoint),
			max = Vector3.Scale(a, 0.5f * (Vector3)vector3Int2 + originCoordPoint)
		};
		result.size -= vector;
		return result;
	}

	public void ShowOccupyRectVfx(object obj)
	{
		if (customOccupy.TryGetValue(obj, out var value))
		{
			if (!occupyVfxDict.TryGetValue(obj, out var value2))
			{
				value2 = Asset.Instantiate<EffectController>("Dorm/Effect/houzhai/fx_hz_jingying_fanwei");
				value2.Initialize(isLoop: true, float.MaxValue, 1f, EEffectQuality.Low, null);
				value2.Simulator(0f);
				occupyVfxDict.Add(obj, value2);
			}
			Vector3 originalPoint = navSurface.floorCoordinate.originalPoint;
			Bounds bounds = CalcOccupyBounds(value, originalPoint);
			value2.transform.position = bounds.center;
			value2.transform.localScale = new Vector3(bounds.size.x, 1f, bounds.size.z);
		}
	}

	public void RemoveOccupyRectVfx(object obj)
	{
		if (customOccupy.ContainsKey(obj) && occupyVfxDict.TryGetValue(obj, out var value))
		{
			value.Stop();
			occupyVfxDict.Remove(obj);
		}
	}

	internal static async void CalcPreviewPathToTarget(AstarPath astar, Vector3 start, Vector3 target, Action callback)
	{
		if ((bool)instance)
		{
			instance.IsCalculatingPreviewPath = true;
			Path path = await SceneNavSurface.CalcPathToTarget(astar, start, target);
			instance.previewPathPoints = (path.error ? null : path.vectorPath);
			if (path.error)
			{
				instance.previewPathLength = 0f;
			}
			else
			{
				instance.previewPathLength = path.GetTotalLength();
			}
			instance.IsCalculatingPreviewPath = false;
			DormLuaBridge.Notify("ON_SIM_BUSINESS_PREVIEW_PATH_UPDATE");
			callback?.Invoke();
		}
	}

	public static void CalcPreviewPathToTarget(Vector3 start, Vector3 target, Action callback)
	{
		if ((bool)instance)
		{
			CalcPreviewPathToTarget(instance.navSurface.astarPath, start, target, callback);
		}
	}

	internal static async void CalcPreviewPathToTarget(AstarPath astar, Vector3 start, Transform target, Action callback)
	{
		if ((bool)instance)
		{
			instance.IsCalculatingPreviewPath = true;
			Path path = await SceneNavSurface.CalcPathToTarget(astar, start, target);
			instance.previewPathPoints = (path.error ? null : path.vectorPath);
			if (path.error)
			{
				instance.previewPathLength = 0f;
			}
			else
			{
				instance.previewPathLength = path.GetTotalLength();
			}
			instance.IsCalculatingPreviewPath = false;
			DormLuaBridge.Notify("ON_SIM_BUSINESS_PREVIEW_PATH_UPDATE");
			callback?.Invoke();
		}
	}

	public static void CalcPreviewPathToTarget(Vector3 start, Transform target, Action callback)
	{
		if ((bool)instance)
		{
			CalcPreviewPathToTarget(instance.navSurface.astarPath, start, target, callback);
		}
	}

	public static void SendSafeMove(int entityID, bool queue)
	{
		if ((bool)instance && DormEntityManager.Instance?.TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			dormComplexEntity.CmdExecuter.SendCmd(new SafeMoveCmdTask(), queue);
		}
	}

	public static void SendSafeMove(int entityID, Vector3 pos, bool queue)
	{
		if ((bool)instance && DormEntityManager.Instance?.TryGet(entityID) is DormComplexEntity dormComplexEntity)
		{
			Vector3 vector = (Vector3)instance.navSurface.astarPath.GetNearest((Int3)pos).node.position;
			dormComplexEntity.CmdExecuter.SendCmd(new DormEntityAction.MoveAndLookAtPosCmdTask(vector, vector, ignorePathFinding: true), queue);
		}
	}

	public static void SetupCameraEventTriggerAtMainCamFarClip()
	{
		if (Camera.main.GetComponentInChildren<CameraEventTrigger>() == null && (bool)instance)
		{
			GameObject obj = UnityEngine.Object.Instantiate(instance.farClipCamTrigger, Camera.main.transform, worldPositionStays: false);
			obj.GetComponent<CameraEventTrigger>().fixedAtCamFarClip = true;
			obj.SetActive(value: true);
		}
	}

	public static bool CheckShelfAnyInteractAreaAvailable(int shelfEID)
	{
		return FurnitureManager.Instance.Get(shelfEID).interactAreas.Any((IProvideInteractArea area) => (area as Behaviour).enabled);
	}
}
