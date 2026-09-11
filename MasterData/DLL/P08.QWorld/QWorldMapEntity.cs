using System;
using System.Collections.Generic;
using LuaInterface;
using QwStreaming;
using Unity.Mathematics;
using UnityEngine;

public class QWorldMapEntity : MonoBehaviour, IQWorldCullable, IQwLodObject, IStreamingObject
{
	public QWBubbleBehvaiour bubbleBehvaiour;

	private float check_bubble_range = 2f;

	public int uniqueId;

	public int entityId;

	private QWorldThingEntityData entityData;

	public Vector3 size = Vector3.zero;

	private Bounds _bounds;

	private float _boundSphereRadius;

	private int rendererCount;

	private List<Renderer> _renderers;

	private List<DynamicBone> _dynamicBones;

	public CullMode cullMode = CullMode.Normal;

	private static float[] s_DynamicBoneLodRate = new float[4] { 2.3690765E+20f, 4.304178E+21f, 7.498171E+28f, 2.2647908E+20f };

	private QWCharacterPassController _passController;

	private Transform _shadow;

	private QWorldMiniMapUnit miniMapUnit;

	private IQWAgent agent;

	public static Dictionary<string, Type> componentDict = new Dictionary<string, Type>
	{
		{
			"QWBoxTriggerArea",
			typeof(QWBoxTriggerArea)
		},
		{
			"QWSphereTriggerArea",
			typeof(QWSphereTriggerArea)
		}
	};

	public static string nightBase = "QWWorld/Furniture/";

	public static string exchangeNightBase = "QWWorld/Furniture/night/";

	private IQWBlackboard blackboard;

	protected GameObject buildObj;

	protected ModelInfo modelInfo;

	[SerializeField]
	private QwLodData _lodData;

	[NoToLua]
	internal bool isLoadRequested;

	private string build;

	private string nameStr;

	public Action<int> bubbleClick
	{
		get
		{
			return bubbleBehvaiour?.bubbleClick;
		}
		set
		{
			if (bubbleBehvaiour != null)
			{
				bubbleBehvaiour.bubbleClick = value;
			}
		}
	}

	public bool isShowBubble
	{
		get
		{
			if (bubbleBehvaiour != null)
			{
				return bubbleBehvaiour.isShowBubble;
			}
			return false;
		}
		set
		{
			bubbleBehvaiour.isShowBubble = value;
		}
	}

	public bool isInScreen { get; set; }

	public QWBlackboard BlackBoard => GetBlackBoard() as QWBlackboard;

	public QWNPCBlackboard NPCBlackBoard => GetBlackBoard() as QWNPCBlackboard;

	[NoToLua]
	internal bool neverLoad => build == null;

	[NoToLua]
	internal GameObject loadedModel => buildObj;

	public bool isLoaded => buildObj != null;

	public void AddBubbleTag(int tag, string text, string micon = "")
	{
		bubbleBehvaiour?.AddBubbleTag(tag, text, micon);
	}

	public void RemoveBubbleTag(int tag)
	{
		bubbleBehvaiour?.RemoveBubbleTag(tag);
	}

	public void SetCheckBubbbleRange(float range)
	{
		check_bubble_range = range;
	}

	public void InvokeBubbleClick()
	{
		bubbleBehvaiour?.OnFirstBubbleClick();
	}

	public void SetBubbbleLookAt(bool needLookAt)
	{
		if (bubbleBehvaiour != null)
		{
			bubbleBehvaiour.isNeedLookAt = needLookAt;
		}
	}

	[NoToLua]
	public bool NeedBubbleLookAt()
	{
		return bubbleBehvaiour.isNeedLookAt;
	}

	public float GetCheckBubbleRange()
	{
		return check_bubble_range / 2f;
	}

	[NoToLua]
	public void DisposeBubble()
	{
		bubbleBehvaiour?.DisposeBubble();
	}

	public void InitEntityData(QWorldThingEntityData entityData)
	{
		this.entityData = entityData;
		entityId = entityData.id;
		base.transform.position = entityData.position;
		base.transform.rotation = entityData.rotation;
		base.transform.localScale = entityData.localScale;
		size = entityData.size;
		SetCheckBubbbleRange(entityData.distance);
	}

	[NoToLua]
	public void Init()
	{
		agent = GetComponent<IQWAgent>();
		blackboard = GetComponent<IQWBlackboard>();
	}

	[NoToLua]
	public void Dispose()
	{
		DisposeCullData();
		DisposeBubble();
		DisposeTing();
		RemoveMiniMap();
	}

	public Vector3 GetPosition()
	{
		return base.transform.position;
	}

	public void SetPosition(int x, int y, int z)
	{
		SetPosition(new Vector3(x, y, z));
	}

	public void SetPosition(Vector3 position)
	{
		base.transform.position = position;
	}

	public Quaternion GetRotation()
	{
		return base.transform.rotation;
	}

	public Vector3 GetForward()
	{
		return base.transform.forward;
	}

	public Transform GetTransform()
	{
		return base.transform;
	}

	public void SetHudDisplay(int display)
	{
		if (BlackBoard != null)
		{
			BlackBoard.HudDisplay = display == 1;
		}
	}

	public bool GetDefaultInteract()
	{
		return entityData.defaultInteractive;
	}

	public int GetTeleportId()
	{
		if (entityData != null)
		{
			return entityData.teleportId;
		}
		return 0;
	}

	public int GetEnterRadius()
	{
		if (entityData != null)
		{
			return entityData.enterRadius;
		}
		return 0;
	}

	public int GetExitRadius()
	{
		if (entityData != null)
		{
			return entityData.exitRadius;
		}
		return 0;
	}

	public string GetMiniGameCamera()
	{
		if (entityData != null)
		{
			return entityData.camera;
		}
		return null;
	}

	public bool IsNpc()
	{
		return Is(QWAgentLayer.NPC);
	}

	public bool IsPlayer()
	{
		return Is(QWAgentLayer.Player);
	}

	public bool Is(QWAgentLayer layer)
	{
		if (GetAgent() == null)
		{
			return false;
		}
		return (GetAgent().GetAgentLayer() & layer) != 0;
	}

	private void InitCullData()
	{
		rendererCount = 0;
		if (_renderers == null)
		{
			_renderers = new List<Renderer>();
		}
		buildObj.GetComponentsInChildren(includeInactive: true, _renderers);
		if (_dynamicBones == null)
		{
			_dynamicBones = new List<DynamicBone>();
		}
		buildObj.GetComponentsInChildren(includeInactive: true, _dynamicBones);
		foreach (Renderer renderer in _renderers)
		{
			if (renderer is MeshRenderer || renderer is SkinnedMeshRenderer)
			{
				_bounds.Encapsulate(renderer.localBounds);
				rendererCount++;
			}
		}
		_boundSphereRadius = _bounds.extents.magnitude;
		if (_renderers != null)
		{
			foreach (Renderer renderer2 in _renderers)
			{
				renderer2.enabled = _lodData.visible;
			}
		}
		if (_dynamicBones != null)
		{
			foreach (DynamicBone dynamicBone in _dynamicBones)
			{
				dynamicBone.enabled = _lodData.visible;
			}
		}
		if (_passController == null)
		{
			_passController = U3DUtil.Get<QWCharacterPassController>(base.gameObject);
		}
		_passController.InitMats(_renderers);
	}

	private void DisposeCullData()
	{
	}

	public void ChangeCullMode(int _cullMode)
	{
		cullMode = (CullMode)_cullMode;
	}

	[NoToLua]
	public Bounds GetBounds()
	{
		return _bounds;
	}

	[NoToLua]
	public Bounds GetWorldBounds()
	{
		Vector3 vector = base.transform.TransformPoint(_bounds.center);
		Vector3 vector2 = base.transform.TransformVector(_bounds.extents);
		return new Bounds
		{
			min = vector - vector2,
			max = vector + vector2
		};
	}

	[NoToLua]
	public float GetBoundSphereRadius()
	{
		if (IsNpc())
		{
			if (_boundSphereRadius == 0f)
			{
				return 0.6f;
			}
			return _boundSphereRadius;
		}
		return _boundSphereRadius;
	}

	[NoToLua]
	public bool IsPointInRange(Transform agentTrans, float range)
	{
		float sqrMagnitude = (agentTrans.position - GetPosition()).sqrMagnitude;
		float num = _boundSphereRadius + range;
		if (sqrMagnitude > num * num)
		{
			return false;
		}
		bool flag = GetPointSdf(agentTrans.position) <= range;
		if (bubbleBehvaiour.isNeedLookAt)
		{
			if (flag)
			{
				if (Mathf.Abs(Vector3.Angle((base.transform.position - agentTrans.position).normalized, agentTrans.forward)) < QWBubbleBehvaiour.LookAtRadius)
				{
					return true;
				}
				return false;
			}
			return false;
		}
		return flag;
	}

	private float GetPointSdf(Vector3 point)
	{
		if (_renderers == null || rendererCount == 0)
		{
			return Vector3.Distance(base.transform.position, point);
		}
		float3 float5 = _bounds.extents;
		float3 x = math.abs(base.transform.InverseTransformPoint(point)) - float5;
		return math.length(math.max(x, 0f)) + math.min(math.max(x.x, math.max(x.y, x.z)), 0f);
	}

	private void EnableShadow(bool enabled)
	{
		if (enabled && _shadow == null)
		{
			_shadow = Asset.Instantiate("Char/Shadow").transform;
			_shadow.GetComponent<MeshRenderer>().material.SetColor("_TintColor", new Color(0f, 0f, 0f, 0.25f));
			float num = _boundSphereRadius * 1f;
			_shadow.localScale = new Vector3(num, num, num);
			_shadow.SetParent(base.transform);
			_shadow.localPosition = new Vector3(0f, 0.01f, 0f);
		}
		else if (!enabled && _shadow != null)
		{
			PooledAsset component = _shadow.GetComponent<PooledAsset>();
			if (component != null)
			{
				component.Return();
				_shadow = null;
			}
			else
			{
				Debug.LogError("无法回收阴影");
			}
		}
	}

	public QWorldMiniMapUnit GetMiniMapUnit()
	{
		return miniMapUnit;
	}

	public QWorldMiniMapUnit AddMiniMap()
	{
		if (miniMapUnit != null)
		{
			return miniMapUnit;
		}
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (qWorldScene != null && qWorldScene.GetMap() != null)
		{
			miniMapUnit = qWorldScene.GetMap().AddMiniMap(this);
			return miniMapUnit;
		}
		return null;
	}

	public void RemoveMiniMap()
	{
		if (miniMapUnit != null)
		{
			QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
			if (qWorldScene != null && qWorldScene.GetMap() != null)
			{
				qWorldScene.GetMap().RemoveMiniMap(miniMapUnit);
			}
		}
		miniMapUnit = null;
	}

	[NoToLua]
	public Transform GetTrackTransform()
	{
		return base.transform;
	}

	[NoToLua]
	public ref QwLodData GetLodData()
	{
		return ref _lodData;
	}

	public void AddComponent(string component)
	{
		if (componentDict.TryGetValue(component, out var value))
		{
			base.gameObject.AddComponent(value);
		}
		else if (component == "BoxCollider")
		{
			BoxCollider boxCollider = base.gameObject.AddComponent<BoxCollider>();
			boxCollider.tag = "Obstacle";
			boxCollider.size = size;
		}
		else
		{
			Debug.LogError("Component not found: " + component);
		}
	}

	public IQWBlackboard GetBlackBoard()
	{
		return blackboard;
	}

	[NoToLua]
	public IQWAgent GetAgent()
	{
		return agent;
	}

	public void SetBuild(string path)
	{
		if (!(base.gameObject == null))
		{
			if (build != path)
			{
				build = path;
				RemoveModel();
				modelInfo = ((path != null) ? Streaming.GetModelInfo(path) : null);
			}
			if (_lodData.visible)
			{
				OnAddToStage();
			}
		}
	}

	[NoToLua]
	public void RequestLoad(StreamingLoadMode loadMode)
	{
		QwLodMgr.SetModelLoaded(this, loaded: false);
		if (build == null)
		{
			OnModelLoaded(null);
		}
		else if (modelInfo == null)
		{
			Debug.LogError(base.gameObject.name + " build = " + build + " 但 modelInfo == null!");
		}
		else if (!isLoadRequested)
		{
			isLoadRequested = true;
			StreamingCacheMgr.RequestCache(modelInfo);
			Streaming.RequestObject(this, modelInfo, loadMode);
		}
		else if (loadMode == StreamingLoadMode.Immediate)
		{
			Streaming.ImmediateLoadModel(modelInfo);
		}
	}

	[NoToLua]
	public void RequestModelPreload()
	{
		if (modelInfo != null)
		{
			StreamingCacheMgr.RequestCache(modelInfo);
		}
	}

	[NoToLua]
	public void RequestUnload()
	{
		if (null != buildObj)
		{
			QWOnRemoveFromSatgeAction action = QWAgentActionFactory.Create(QWAgentAction.E_Type.RemoveFromStage) as QWOnRemoveFromSatgeAction;
			BlackBoard.ActionAdd(action);
		}
		RemoveModel();
		OnEntityReleased();
		QwLodMgr.SetModelLoaded(this, loaded: false);
	}

	private void RemoveModel()
	{
		bool num = isLoadRequested || buildObj != null;
		if (null != buildObj)
		{
			StreamingCacheMgr.GetCache(modelInfo).Return(buildObj);
			buildObj = null;
			QwLodMgr.SetModelLoaded(this, loaded: false);
		}
		if (num)
		{
			Streaming.RemoveObject(this, modelInfo);
			isLoadRequested = false;
		}
	}

	public void LuaRequestLoad(int loadMode)
	{
		RequestLoad((StreamingLoadMode)loadMode);
	}

	[NoToLua]
	public void OnModelLoaded(ModelInfo modelInfo)
	{
		if (modelInfo != null)
		{
			StreamingCacheGameObject cache = StreamingCacheMgr.GetCache(modelInfo);
			if (cache != null)
			{
				QwLodMgr.SetModelLoaded(this, loaded: true);
				isLoadRequested = false;
				OnEntityLoaded(cache);
			}
		}
	}

	public void SetName(string value)
	{
		nameStr = value;
	}

	public string GetName()
	{
		return nameStr;
	}

	public int GetEventHud()
	{
		return 1;
	}

	[NoToLua]
	public void OnAddToStage(bool sync = false)
	{
		GetBlackBoard();
		bool firstAdd = false;
		bool num = buildObj != null;
		if (buildObj == null && !string.IsNullOrEmpty(build))
		{
			RequestLoad(sync ? StreamingLoadMode.Immediate : StreamingLoadMode.Default);
		}
		if (num)
		{
			PostEntityLoaded(firstAdd);
		}
	}

	[NoToLua]
	private void OnEntityLoaded(StreamingCacheGameObject streamingCache)
	{
		if (streamingCache != null)
		{
			buildObj = streamingCache.Take();
			buildObj.transform.SetParent(base.transform);
			buildObj.transform.localPosition = Vector3.zero;
			buildObj.transform.localRotation = Quaternion.identity;
			buildObj.transform.localScale = Vector3.one;
			if (GetBlackBoard() != null)
			{
				GetBlackBoard().OnFirstAddToStage(buildObj);
			}
			InitCullData();
			PostEntityLoaded(firstAdd: true);
		}
		else
		{
			Debug.LogError("streamingCache为空但是却期望从缓存中获取：" + modelInfo.assetPath);
		}
	}

	[NoToLua]
	private void PostEntityLoaded(bool firstAdd)
	{
		if (!(null != buildObj))
		{
			return;
		}
		if (BlackBoard != null)
		{
			BlackBoard.isInStage = true;
			BlackBoard.isInHide = false;
			if (firstAdd)
			{
				BlackBoard.attachPoint = buildObj.GetComponent<QWAttachPointSetup>();
				if (!BlackBoard.ActiveHud)
				{
					QWChangeNameAction action = QWAgentActionFactory.Create(QWAgentAction.E_Type.ChangeName) as QWChangeNameAction;
					BlackBoard.Name = GetName();
					BlackBoard.ActiveHud = true;
					BlackBoard.ActionAdd(action);
				}
			}
			QWNPCBlackboard qWNPCBlackboard = blackboard as QWNPCBlackboard;
			if (qWNPCBlackboard != null)
			{
				if (entityData.defaultAnim.IsNotNullOrEmpty())
				{
					qWNPCBlackboard.defaultAnim = entityData.defaultAnim;
					QWCharacterPlayAnimAction qWCharacterPlayAnimAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.PlayAnim) as QWCharacterPlayAnimAction;
					qWCharacterPlayAnimAction.animName = entityData.defaultAnim;
					qWCharacterPlayAnimAction.crossFade = 0f;
					qWNPCBlackboard.ActionAdd(qWCharacterPlayAnimAction);
				}
				if (firstAdd)
				{
					BlackBoard.attachPoint.GetPerformRoot().gameObject.AddComponent<QWNPCMoveComponent>();
					QWOnAddToSatgeAction qWOnAddToSatgeAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.AddToStage) as QWOnAddToSatgeAction;
					qWOnAddToSatgeAction.isFirstAdd = true;
					qWOnAddToSatgeAction.lookAtType = entityData.lookAtType;
					qWOnAddToSatgeAction.lookAtPos = entityData.lookAtPoint;
					qWOnAddToSatgeAction.lookAtEntityId = entityData.lookAtEntityId;
					qWNPCBlackboard.ActionAdd(qWOnAddToSatgeAction);
				}
			}
			BlackBoard.OnAddToStage();
		}
		_lodData.visible = true;
	}

	[NoToLua]
	private void OnEntityReleased()
	{
		if (BlackBoard != null)
		{
			BlackBoard.isInHide = true;
			QWChangeNameAction action = QWAgentActionFactory.Create(QWAgentAction.E_Type.ChangeName) as QWChangeNameAction;
			BlackBoard.ActiveHud = false;
			BlackBoard.ActionAdd(action);
			BlackBoard.OnRemoveToStage();
			BlackBoard.isInStage = false;
		}
		if (_passController != null)
		{
			_passController.ClearMats();
		}
		if (_renderers != null)
		{
			_renderers.Clear();
		}
		if (_dynamicBones != null)
		{
			_dynamicBones.Clear();
		}
	}

	[NoToLua]
	public void DisposeTing()
	{
		if ((bool)_passController)
		{
			_passController.ClearMats();
		}
		RemoveModel();
		QwLodMgr.UpdateLodDataModel(this, ref GetLodData());
		if (BlackBoard != null)
		{
			blackboard = null;
		}
		GetAgent()?.DisposeAgent();
	}
}
