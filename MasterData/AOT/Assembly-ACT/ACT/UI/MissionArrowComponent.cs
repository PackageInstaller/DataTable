using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.ECS;
using Cinemachine.Utility;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MissionArrowComponent : MonoBehaviour, IBattleMainComponent
{
	private bool m_Initialized;

	private MonoBattleMainBaseView _view;

	private MissionArrowPools _missionArrowPool;

	public RectTransform arrowArea;

	public GameObject normalMissionArrowPrefab;

	public GameObject chaseUAVMissionArrowPreafb;

	public RectTransform invisibleArea;

	private List<MissionArrowData> m_TempMissionDatas = new List<MissionArrowData>();

	private Camera m_VirtulCamera;

	private CanvasGroup _canvasGroup;

	private void Awake()
	{
		_missionArrowPool = new MissionArrowPools(arrowArea.parent, normalMissionArrowPrefab, chaseUAVMissionArrowPreafb);
		_canvasGroup = GetComponent<CanvasGroup>();
	}

	public List<MissionArrowData> GetMissionArrowDatas()
	{
		return m_TempMissionDatas;
	}

	private void LateUpdate()
	{
		if (m_Initialized)
		{
			RefreshMissionArrow();
		}
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
		m_Initialized = true;
		_view = view;
		m_VirtulCamera = GameUtility.zNormalVCamera;
		m_VirtulCamera.enabled = false;
		m_VirtulCamera.fieldOfView = GameUtility.mainCamera.fieldOfView;
		m_VirtulCamera.nearClipPlane = GameUtility.mainCamera.nearClipPlane;
		m_VirtulCamera.farClipPlane = 10000f;
		m_VirtulCamera.orthographic = GameUtility.mainCamera.orthographic;
		m_VirtulCamera.orthographicSize = GameUtility.mainCamera.orthographicSize;
		m_VirtulCamera.aspect = GameUtility.mainCamera.aspect;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Scene_Change_Complete, SwitchMissionArrows);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TracingArrowAdded, OnTracingArrowAdded);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TracingArrowRemoved, OnTracingArrowRemoved);
		List<MissionArrowData> currentTrackMissionDatas = Model<BattleMainMarkModel>.Interface.GetCurrentTrackMissionDatas();
		if (currentTrackMissionDatas == null || currentTrackMissionDatas.Count <= 0)
		{
			return;
		}
		foreach (MissionArrowData item in currentTrackMissionDatas)
		{
			OnAddMissionArrow(item);
		}
	}

	public void UnInitialize()
	{
		m_Initialized = false;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Scene_Change_Complete, SwitchMissionArrows);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TracingArrowAdded, OnTracingArrowAdded);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TracingArrowRemoved, OnTracingArrowRemoved);
		List<MissionArrowData> currentTrackMissionDatas = Model<BattleMainMarkModel>.Interface.GetCurrentTrackMissionDatas();
		if (currentTrackMissionDatas == null || currentTrackMissionDatas.Count <= 0)
		{
			return;
		}
		foreach (MissionArrowData item in currentTrackMissionDatas)
		{
			OnRemoveMissionArrow(item);
		}
	}

	private void OnDestroy()
	{
		List<MissionArrowData> currentTrackMissionDatas = Model<BattleMainMarkModel>.Interface.GetCurrentTrackMissionDatas();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Scene_Change_Complete, SwitchMissionArrows);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TracingArrowAdded, OnTracingArrowAdded);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TracingArrowRemoved, OnTracingArrowRemoved);
		if (currentTrackMissionDatas == null || currentTrackMissionDatas.Count <= 0)
		{
			return;
		}
		foreach (MissionArrowData item in currentTrackMissionDatas)
		{
			OnRemoveMissionArrow(item);
		}
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}

	private void OnTracingArrowAdded(BaseEventContent evt)
	{
		OnAddMissionArrow((evt as MissionNArrowPointAddedEvt).missionArrowData);
	}

	private void OnTracingArrowRemoved(BaseEventContent evt)
	{
		OnRemoveMissionArrow((evt as MissionNArrowPointRemovedEvt).missionArrowData);
	}

	private void OnAddMissionArrow(MissionArrowData arrowData)
	{
		MissionPointData missionPointData = arrowData.missionPointData;
		MissionArrow arrow = _missionArrowPool.GetArrow(missionPointData.GetType());
		arrow.Init(missionPointData.GetSpriteId());
		arrowData.arrow = arrow;
	}

	private void OnRemoveMissionArrow(MissionArrowData arrowData)
	{
		if (arrowData.arrow != null)
		{
			arrowData.arrow.UnInit();
			_missionArrowPool.ReleaseArrow(arrowData.arrow);
			arrowData.arrow = null;
		}
	}

	private void RefreshMissionArrow()
	{
		if (MonoECS.instance.mainEntity == null)
		{
			return;
		}
		m_TempMissionDatas.Clear();
		m_TempMissionDatas.AddRange(Model<BattleMainMarkModel>.Interface.GetCurrentTrackMissionDatas());
		CompTransform compTransform = MonoECS.instance.mainEntity.GetCompTransform();
		for (int i = 0; i < m_TempMissionDatas.Count; i++)
		{
			MissionArrowData missionArrowData = m_TempMissionDatas[i];
			if (missionArrowData.arrow == null)
			{
				continue;
			}
			_canvasGroup.alpha = 1f;
			missionArrowData.arrow.Count = 1;
			if (!missionArrowData.missionPointData.IsSameWorld)
			{
				missionArrowData.arrow.Hide();
				continue;
			}
			missionArrowData.arrow.NormalStyle();
			Vector3 guidePointPosition = missionArrowData.missionPointData.GetGuidePointPosition();
			if (guidePointPosition.IsNaN())
			{
				return;
			}
			Camera mainCamera = GameUtility.mainCamera;
			Vector3 position = mainCamera.transform.position;
			Vector3 vector = mainCamera.WorldToScreenPoint(guidePointPosition);
			bool flag = missionArrowData.missionPointData.Radius > 0f;
			bool flag2 = flag && missionArrowData.missionPointData.InRadius(compTransform?.physicsPosition ?? Vector3.zero);
			bool flag3 = vector.z >= 0f && RectTransformUtility.RectangleContainsScreenPoint(invisibleArea, vector, GameUtility.uiCamera);
			if ((!flag && !flag3) || (flag && !flag2))
			{
				Quaternion quaternion = (missionArrowData.missionPointData.Use3DLogic ? mainCamera.transform.rotation : Quaternion.identity);
				Vector3 position2 = position - quaternion * new Vector3(0f, 0f, 1000f);
				m_VirtulCamera.gameObject.transform.position = position2;
				m_VirtulCamera.transform.rotation = quaternion;
				vector = m_VirtulCamera.WorldToScreenPoint(guidePointPosition);
				Vector2 vector2 = UIUtility.OvalConstraint((Vector2)vector - UIUtility.screenCenter, _view.semiMajorAxis, _view.semiMinorAxis) + UIUtility.screenCenter;
				missionArrowData.arrow.SetInScreen(inScreen: false);
				vector.x = vector2.x;
				vector.y = vector2.y;
				vector.z = missionArrowData.arrow.transform.position.z;
				missionArrowData.arrow.SetPosOutScreen(GameUtility.uiCamera.ScreenToWorldPoint(vector));
				missionArrowData.arrow.SetRot(Quaternion.FromToRotation(Vector2.up, (Vector2)vector - UIUtility.screenCenter));
				missionArrowData.arrow.NormalStyle();
				goto IL_037e;
			}
			missionArrowData.arrow.SetInScreen(inScreen: true);
			missionArrowData.arrow.SetInScreenLeft(vector.x <= UIUtility.screenCenter.x);
			missionArrowData.arrow.SetPosInScreen(guidePointPosition.IsNaN() ? Vector3.zero : guidePointPosition);
			missionArrowData.arrow.SetRot(Quaternion.FromToRotation(Vector2.up, Vector2.down));
			MissionPointData missionPointData = missionArrowData.missionPointData;
			if (missionPointData is StateObjectMissionPoint)
			{
				if (!(missionPointData is ChaseMissionPoint))
				{
					goto IL_034d;
				}
			}
			else if (missionPointData is NPCMissionPoint)
			{
				goto IL_034d;
			}
			bool flag4 = false;
			goto IL_0355;
			IL_037e:
			missionArrowData.Distance = (int)Vector3.Distance(guidePointPosition, compTransform?.physicsPosition ?? Vector3.zero);
			continue;
			IL_034d:
			flag4 = true;
			goto IL_0355;
			IL_0355:
			if (flag4)
			{
				missionArrowData.arrow.Hide();
			}
			else if (missionArrowData.missionPointData is FixedAreaMissionPoint)
			{
				missionArrowData.arrow.NormalStyle();
			}
			goto IL_037e;
		}
		m_TempMissionDatas.MergeElement((MissionArrowData x, MissionArrowData y) =>
		{
			if (x.IsInsideScreen || y.IsInsideScreen)
			{
				return false;
			}
			if (x.arrow == null || y.arrow == null)
			{
				return false;
			}
			if (!x.arrow.IsShow || !y.arrow.IsShow)
			{
				return false;
			}
			return !(x.GetType() != y.GetType()) && x.CanMerge(y);
		}, (MissionArrowData x, MissionArrowData y) =>
		{
			y.arrow.MergeIntoOtherArrowStyle(x.arrow);
			float num = Mathf.Min(1.5f, 0.5f * (float)x.arrow.Count);
			y.arrow.transform.position = num * x.arrow.transform.position + (1f - num) * y.arrow.transform.position;
			return y;
		});
		if (m_TempMissionDatas.Count == 0)
		{
			_canvasGroup.alpha = 0f;
		}
	}

	private void SwitchMissionArrows(BaseEventContent obj)
	{
		foreach (KeyValuePair<SceneStatus, List<MissionArrowData>> item in Model<BattleMainMarkModel>.Interface.MissionArrowDict)
		{
			if (item.Key == MonoECS.instance.sceneStatus)
			{
				continue;
			}
			List<MissionArrowData> value = item.Value;
			if (value == null || value.Count <= 0)
			{
				continue;
			}
			foreach (MissionArrowData item2 in item.Value)
			{
				if (item2.arrow.IsShow)
				{
					item2.arrow.Hide();
				}
			}
		}
	}
}
