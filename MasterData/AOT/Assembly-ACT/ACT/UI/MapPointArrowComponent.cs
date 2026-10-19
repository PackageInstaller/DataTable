using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.NPC;
using ACT.Utility;
using ACT.World;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MapPointArrowComponent : MonoBehaviour, IBattleMainComponent
{
	[Header("预制体")]
	public GameObject mapPointArrowPrefab;

	[Header("箭头区域")]
	public RectTransform arrowArea;

	[Header("不可见区域（屏幕内判定）")]
	public RectTransform invisibleArea;

	private MonoBattleMainBaseView _view;

	private MapPointArrow _currentArrow;

	private Camera _virtualCamera;

	private CanvasGroup _canvasGroup;

	private MapPointTraceInfo _currentTraceInfo;

	private Vector3 _targetWorldPos;

	private int _lastDistance;

	private MapPointArrow _specialPointArrow;

	private Vector3 _specialPointWorldPos;

	private ACT.World.MapArea _specialPointMapArea;

	private int _specialPointLastDistance;

	private void Awake()
	{
		_canvasGroup = GetComponent<CanvasGroup>();
		if (_canvasGroup == null)
		{
			_canvasGroup = gameObject.AddComponent<CanvasGroup>();
		}
	}

	private void LateUpdate()
	{
		RefreshMapPointArrow();
		RefreshMonsterPointArrow();
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
		_view = view;
		_targetWorldPos = Vector3.zero;
		_virtualCamera = GameUtility.zNormalVCamera;
		_virtualCamera.enabled = false;
		_virtualCamera.fieldOfView = GameUtility.mainCamera.fieldOfView;
		_virtualCamera.nearClipPlane = GameUtility.mainCamera.nearClipPlane;
		_virtualCamera.farClipPlane = 10000f;
		_virtualCamera.orthographic = GameUtility.mainCamera.orthographic;
		_virtualCamera.orthographicSize = GameUtility.mainCamera.orthographicSize;
		_virtualCamera.aspect = GameUtility.mainCamera.aspect;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_MapPointTraceEvt, OnMapPointTraceChanged);
		if (Model<TrackModel>.HasInstance())
		{
			Model<TrackModel>.Interface.OnTrackMonsterPointChanged += OnMonsterPointTraceChanged;
			Model<TrackModel>.Interface.OnTrackCollectionPointChanged += OnCollectionPointTraceChanged;
		}
		if (!Model<MapModel>.HasInstance())
		{
			return;
		}
		MapPointTraceInfo currentTraceMapPoint = Model<MapModel>.Interface.CurrentTraceMapPoint;
		if (currentTraceMapPoint != null && currentTraceMapPoint.pointId != 0)
		{
			CreateArrowForTracePoint(currentTraceMapPoint);
		}
		if (Model<TrackModel>.HasInstance())
		{
			if (Model<TrackModel>.Interface.IsTrackingMonsterPoint)
			{
				CreateMonsterPointArrow();
			}
			else if (Model<TrackModel>.Interface.IsTrackingCollectionPoint)
			{
				CreateCollectPointArrow();
			}
		}
	}

	public void UnInitialize()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_MapPointTraceEvt, OnMapPointTraceChanged);
		if (Model<TrackModel>.HasInstance())
		{
			Model<TrackModel>.Interface.OnTrackMonsterPointChanged -= OnMonsterPointTraceChanged;
			Model<TrackModel>.Interface.OnTrackCollectionPointChanged -= OnCollectionPointTraceChanged;
		}
		RemoveCurrentArrow();
		RemoveSpecialPointArrow();
	}

	public void OpenComponent()
	{
		gameObject.SetActive(value: true);
	}

	public void CloseComponent()
	{
		gameObject.SetActive(value: false);
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}

	private void OnMapPointTraceChanged(BaseEventContent evt)
	{
		if (evt is MapPointTraceRefresh mapPointTraceRefresh)
		{
			if (mapPointTraceRefresh.id != 0)
			{
				MapPointTraceInfo traceInfo = new MapPointTraceInfo((MapIconType)mapPointTraceRefresh.iconType, (ACT.World.MapArea)mapPointTraceRefresh.mapArea, mapPointTraceRefresh.id);
				CreateArrowForTracePoint(traceInfo);
			}
			else
			{
				RemoveCurrentArrow();
			}
		}
	}

	private void OnMonsterPointTraceChanged()
	{
		if (Model<TrackModel>.HasInstance())
		{
			if (Model<TrackModel>.Interface.IsTrackingMonsterPoint)
			{
				CreateMonsterPointArrow();
			}
			else
			{
				RemoveSpecialPointArrow();
			}
		}
	}

	private void OnCollectionPointTraceChanged()
	{
		if (Model<TrackModel>.HasInstance())
		{
			if (Model<TrackModel>.Interface.IsTrackingCollectionPoint)
			{
				CreateCollectPointArrow();
			}
			else
			{
				RemoveSpecialPointArrow();
			}
		}
	}

	private void CreateArrowForTracePoint(MapPointTraceInfo traceInfo)
	{
		RemoveCurrentArrow();
		if (!TryGetTracePointInfo(traceInfo, out var worldPos, out var spriteId))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"[MapPointArrowComponent] 无法获取追踪点信息: Type={traceInfo.iconType}, Id={traceInfo.pointId}");
			}
			return;
		}
		_currentTraceInfo = traceInfo;
		_targetWorldPos = worldPos;
		if (mapPointArrowPrefab != null)
		{
			GameObject gameObject = Object.Instantiate(mapPointArrowPrefab, arrowArea);
			_currentArrow = gameObject.GetComponent<MapPointArrow>();
			if (_currentArrow != null)
			{
				_currentArrow.Init(traceInfo, worldPos, spriteId);
			}
		}
	}

	private void RemoveCurrentArrow()
	{
		if (_currentArrow != null)
		{
			_currentArrow.UnInit();
			Object.Destroy(_currentArrow.gameObject);
			_currentArrow = null;
		}
		_currentTraceInfo = null;
		_targetWorldPos = Vector3.zero;
		_lastDistance = 0;
	}

	private void CreateCollectPointArrow()
	{
		RemoveSpecialPointArrow();
		if (!Model<TrackModel>.HasInstance() || !Model<TrackModel>.Interface.IsTrackingCollectionPoint)
		{
			return;
		}
		_specialPointWorldPos = Model<TrackModel>.Interface.GetTrackCollectionPointWorldPos();
		_specialPointMapArea = Model<TrackModel>.Interface.GetTrackCollectionMapArea();
		int trackCollectionSpriteId = Model<TrackModel>.Interface.GetTrackCollectionSpriteId();
		if (mapPointArrowPrefab != null)
		{
			GameObject gameObject = Object.Instantiate(mapPointArrowPrefab, arrowArea);
			_specialPointArrow = gameObject.GetComponent<MapPointArrow>();
			if (_specialPointArrow != null)
			{
				MapPointTraceInfo traceInfo = new MapPointTraceInfo(MapIconType.CollectionPoint, _specialPointMapArea, Model<TrackModel>.Interface.GetTrackCollectionPointId());
				_specialPointArrow.Init(traceInfo, _specialPointWorldPos, trackCollectionSpriteId);
			}
		}
	}

	private void CreateMonsterPointArrow()
	{
		RemoveSpecialPointArrow();
		if (!Model<TrackModel>.HasInstance() || !Model<TrackModel>.Interface.IsTrackingMonsterPoint)
		{
			return;
		}
		_specialPointWorldPos = Model<TrackModel>.Interface.GetTrackMonsterPointWorldPos();
		_specialPointMapArea = Model<TrackModel>.Interface.GetTrackMonsterPointMapArea();
		int spriteId = 0;
		if (Model<MaterialTrackModel>.HasInstance() && Model<MaterialTrackModel>.Interface.IsTrackingEnemyId)
		{
			spriteId = Model<MaterialTrackModel>.Interface.GetMonsterTypeIconAtlasId(Model<MaterialTrackModel>.Interface.GetTrackEnemyId());
		}
		if (mapPointArrowPrefab != null)
		{
			GameObject gameObject = Object.Instantiate(mapPointArrowPrefab, arrowArea);
			_specialPointArrow = gameObject.GetComponent<MapPointArrow>();
			if (_specialPointArrow != null)
			{
				MapPointTraceInfo traceInfo = new MapPointTraceInfo(MapIconType.MonsterPoint, _specialPointMapArea, Model<TrackModel>.Interface.GetTrackMonsterPointId());
				_specialPointArrow.Init(traceInfo, _specialPointWorldPos, spriteId);
			}
		}
	}

	private void RemoveSpecialPointArrow()
	{
		if (_specialPointArrow != null)
		{
			_specialPointArrow.UnInit();
			Object.Destroy(_specialPointArrow.gameObject);
			_specialPointArrow = null;
		}
		_specialPointWorldPos = Vector3.zero;
		_specialPointMapArea = ACT.World.MapArea.None;
		_specialPointLastDistance = 0;
	}

	private bool TryGetTracePointInfo(MapPointTraceInfo traceInfo, out Vector3 worldPos, out int spriteId)
	{
		worldPos = Vector3.zero;
		spriteId = 0;
		switch (traceInfo.iconType)
		{
		case MapIconType.SelfPoint:
			return TryGetSelfPointInfo(traceInfo.pointId, out worldPos, out spriteId);
		case MapIconType.Npc:
			return TryGetNpcIconInfo(traceInfo, out worldPos, out spriteId);
		case MapIconType.Transfer:
		case MapIconType.LightHouse:
		case MapIconType.Abyss:
		case MapIconType.Raid:
		case MapIconType.Temple:
		case MapIconType.SpotPoint:
			return TryGetStaticIconInfo(traceInfo, out worldPos, out spriteId);
		case MapIconType.WeekBoss:
		case MapIconType.WorldBoss:
			return TryGetBossIconInfo(traceInfo, out worldPos, out spriteId);
		case MapIconType.SideMission:
			foreach (ReceiveMissionData receiveMissionData in Singleton<RuntimeNpcManager>.instance.GetReceiveMissionDatas((int)traceInfo.mapArea))
			{
				if (receiveMissionData.missionId == traceInfo.pointId)
				{
					worldPos = Singleton<RuntimeNpcManager>.instance.GetNpcPosition(receiveMissionData.npcUid);
					spriteId = 10909;
					return true;
				}
			}
			return false;
		case MapIconType.MainMission:
		case MapIconType.DailyMission:
		case MapIconType.LegendMission:
			return TryGetMissionPointInfo(traceInfo.pointId, out worldPos, out spriteId);
		default:
			return false;
		}
	}

	private bool TryGetSelfPointInfo(int pointId, out Vector3 worldPos, out int spriteId)
	{
		worldPos = Vector3.zero;
		spriteId = 0;
		SelfNodeData selfNode = Model<MapSelfNodeModel>.Interface.GetSelfNode(pointId);
		if (selfNode != null)
		{
			worldPos = selfNode.worldPos;
			spriteId = selfNode.iconTypeId;
			return true;
		}
		return false;
	}

	private bool TryGetNpcIconInfo(MapPointTraceInfo traceInfo, out Vector3 worldPos, out int spriteId)
	{
		worldPos = Vector3.zero;
		spriteId = 0;
		foreach (NpcShowEntranceCollection item in Singleton<RuntimeNpcManager>.instance.GetNpcCollectionByMapArea(traceInfo.mapArea))
		{
			int npcConfigUid = item.NpcConfigUid;
			if (traceInfo.pointId == npcConfigUid)
			{
				worldPos = item.WorldPosition;
				NPCHeadIconConfig.IconConfig iconConfig = GameLoader.meta.npcOrInteractObjectIconConfig.FindConfigById(item.TipIconID);
				spriteId = iconConfig.icon;
				return true;
			}
		}
		return false;
	}

	private bool TryGetStaticIconInfo(MapPointTraceInfo traceInfo, out Vector3 worldPos, out int spriteId)
	{
		worldPos = Vector3.zero;
		spriteId = 0;
		HashSet<BakeStaticMapIconData> mapIconDataBy = MapUtility.ConfigWorldMapGraph.GetMapIconDataBy(traceInfo.mapArea);
		if (mapIconDataBy != null)
		{
			foreach (BakeStaticMapIconData item in mapIconDataBy)
			{
				if (item.uid == traceInfo.pointId)
				{
					worldPos = item.initPos;
					spriteId = MapUtility.GetMapIconSpriteIdByBakeData(item);
					return true;
				}
			}
		}
		return false;
	}

	private bool TryGetBossIconInfo(MapPointTraceInfo traceInfo, out Vector3 worldPos, out int spriteId)
	{
		worldPos = Vector3.zero;
		spriteId = 0;
		HashSet<BakeStaticMapIconData> mapIconDataBy = MapUtility.ConfigWorldMapGraph.GetMapIconDataBy(traceInfo.mapArea);
		if (mapIconDataBy != null)
		{
			foreach (BakeStaticMapIconData item in mapIconDataBy)
			{
				if (item.uid == traceInfo.pointId)
				{
					worldPos = item.initPos;
					EntityEnemyData data = CoreUtils.GetData(CoreUtils.DetermineActualMonster(item.worldBossId), RuntimeConfigs.data.entityEnemyDatas);
					spriteId = (Model<MonsterHandModel>.Interface.WildBossUnLock(item.worldBossId) ? data.monsterIcon : 99);
					return true;
				}
			}
		}
		return false;
	}

	private bool TryGetMissionPointInfo(int pointId, out Vector3 worldPos, out int spriteId)
	{
		worldPos = Vector3.zero;
		spriteId = 0;
		return false;
	}

	private bool HasMissionTrackPoint()
	{
		if (!Model<BattleMainMarkModel>.HasInstance())
		{
			return false;
		}
		List<MissionArrowData> currentTrackMissionDatas = Model<BattleMainMarkModel>.Interface.GetCurrentTrackMissionDatas();
		if (currentTrackMissionDatas == null || currentTrackMissionDatas.Count == 0)
		{
			return false;
		}
		foreach (MissionArrowData item in currentTrackMissionDatas)
		{
			if (item.arrow != null && item.missionPointData.IsSameWorld)
			{
				return true;
			}
		}
		return false;
	}

	private void RefreshMapPointArrow()
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		bool flag = (_currentArrow != null && _currentTraceInfo != null && _targetWorldPos != Vector3.zero) || _specialPointArrow != null;
		if (_canvasGroup != null)
		{
			_canvasGroup.alpha = (((mainEntity != null) & flag) ? 1 : 0);
		}
		if (mainEntity == null || _currentArrow == null || _currentTraceInfo == null)
		{
			return;
		}
		if (HasMissionTrackPoint())
		{
			_currentArrow.Hide();
			return;
		}
		if (_specialPointArrow != null)
		{
			_currentArrow.Hide();
			return;
		}
		ACT.World.MapArea playerMapArea = MapUtility.playerMapArea;
		if (_currentTraceInfo.mapArea != playerMapArea)
		{
			_currentArrow.Hide();
			return;
		}
		_currentArrow.NormalStyle();
		Vector3 targetWorldPos = _targetWorldPos;
		Camera mainCamera = GameUtility.mainCamera;
		Vector3 position = mainCamera.transform.position;
		Vector3 vector = mainCamera.WorldToScreenPoint(targetWorldPos);
		if (vector.z >= 0f && RectTransformUtility.RectangleContainsScreenPoint(invisibleArea, vector, GameUtility.uiCamera))
		{
			_currentArrow.SetInScreen(inScreen: true);
			_currentArrow.SetInScreenLeft(vector.x <= UIUtility.screenCenter.x);
			_currentArrow.SetPosInScreen(targetWorldPos);
			_currentArrow.SetRot(Quaternion.FromToRotation(Vector2.up, Vector2.down));
			_currentArrow.Hide();
		}
		else
		{
			Quaternion identity = Quaternion.identity;
			Vector3 position2 = identity * (position + new Vector3(0f, 0f, -1000f));
			_virtualCamera.gameObject.transform.position = position2;
			_virtualCamera.transform.rotation = identity;
			vector = _virtualCamera.WorldToScreenPoint(targetWorldPos);
			Vector2 vector2 = UIUtility.OvalConstraint((Vector2)vector - UIUtility.screenCenter, _view.semiMajorAxis, _view.semiMinorAxis) + UIUtility.screenCenter;
			_currentArrow.SetInScreen(inScreen: false);
			vector.x = vector2.x;
			vector.y = vector2.y;
			vector.z = _currentArrow.transform.position.z;
			_currentArrow.SetPosOutScreen(GameUtility.uiCamera.ScreenToWorldPoint(vector));
			_currentArrow.SetRot(Quaternion.FromToRotation(Vector2.up, (Vector2)vector - UIUtility.screenCenter));
			_currentArrow.NormalStyle();
		}
		int num = (int)Vector3.Distance(targetWorldPos, mainEntity.GetCompTransform().physicsPosition);
		_currentArrow.SetDistance(_lastDistance, num);
		_lastDistance = num;
	}

	private void RefreshMonsterPointArrow()
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity == null || _specialPointArrow == null)
		{
			return;
		}
		if (HasMissionTrackPoint())
		{
			_specialPointArrow.Hide();
			return;
		}
		ACT.World.MapArea playerMapArea = MapUtility.playerMapArea;
		if (_specialPointMapArea != playerMapArea)
		{
			_specialPointArrow.Hide();
			return;
		}
		_specialPointArrow.NormalStyle();
		Vector3 specialPointWorldPos = _specialPointWorldPos;
		Camera mainCamera = GameUtility.mainCamera;
		Vector3 position = mainCamera.transform.position;
		Vector3 vector = mainCamera.WorldToScreenPoint(specialPointWorldPos);
		if (vector.z >= 0f && RectTransformUtility.RectangleContainsScreenPoint(invisibleArea, vector, GameUtility.uiCamera))
		{
			_specialPointArrow.SetInScreen(inScreen: true);
			_specialPointArrow.SetInScreenLeft(vector.x <= UIUtility.screenCenter.x);
			_specialPointArrow.SetPosInScreen(specialPointWorldPos);
			_specialPointArrow.SetRot(Quaternion.FromToRotation(Vector2.up, Vector2.down));
			_specialPointArrow.Hide();
		}
		else
		{
			Quaternion identity = Quaternion.identity;
			Vector3 position2 = identity * (position + new Vector3(0f, 0f, -1000f));
			_virtualCamera.gameObject.transform.position = position2;
			_virtualCamera.transform.rotation = identity;
			vector = _virtualCamera.WorldToScreenPoint(specialPointWorldPos);
			Vector2 vector2 = UIUtility.OvalConstraint((Vector2)vector - UIUtility.screenCenter, _view.semiMajorAxis, _view.semiMinorAxis) + UIUtility.screenCenter;
			_specialPointArrow.SetInScreen(inScreen: false);
			vector.x = vector2.x;
			vector.y = vector2.y;
			vector.z = _specialPointArrow.transform.position.z;
			_specialPointArrow.SetPosOutScreen(GameUtility.uiCamera.ScreenToWorldPoint(vector));
			_specialPointArrow.SetRot(Quaternion.FromToRotation(Vector2.up, (Vector2)vector - UIUtility.screenCenter));
			_specialPointArrow.NormalStyle();
		}
		int num = (int)Vector3.Distance(specialPointWorldPos, mainEntity.GetCompTransform().physicsPosition);
		_specialPointArrow.SetDistance(_specialPointLastDistance, num);
		_specialPointLastDistance = num;
	}

	public MapPointArrow GetCurrentArrow()
	{
		return _currentArrow;
	}

	public bool HasTracePoint()
	{
		if (_currentArrow != null)
		{
			return _currentTraceInfo != null;
		}
		return false;
	}

	public void HighLightArrow()
	{
		_currentArrow?.HighLight();
	}

	public MapPointArrow GetMonsterPointArrow()
	{
		return _specialPointArrow;
	}

	public bool HasMonsterPointTrack()
	{
		return _specialPointArrow != null;
	}

	public void HighLightMonsterPointArrow()
	{
		_specialPointArrow?.HighLight();
	}
}
