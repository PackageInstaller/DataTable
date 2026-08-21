using System.Collections.Generic;
using System.Threading.Tasks;
using Ase;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using Sirenix.OdinInspector;
using UnityEngine;

public abstract class BaseMapDataNode : SerializedMonoBehaviour, IInit, IStart, IDispose
{
	public const string MapDataNodeKey = "MAPDATANODEKEY";

	protected SceneSystem sceneSystem;

	protected MapDataNodeState mapDataNodeState;

	protected EntityCallbacks callbacks;

	protected BaseEntity entity;

	private LevelMapDataNodeLoadingTag loadingTag;

	private ISubscription<TaskChangeNotifyMessager> subscription;

	private ISubscription<LevelChangeNotifyMessager> subscription_UpdateLevel;

	private bool isDead;

	private bool taskConditionResult;

	protected bool IsNeedCreate;

	protected bool IsNeedDestory;

	protected bool setParadoxFinish;

	[SerializeField]
	private int uid;

	public Bounds bound = new Bounds(Vector3.zero, Vector3.one);

	public LevelArea levelArea;

	public LevelMapDataEvent loadLevel;

	public LevelMapDataEvent unLoadLevel = LevelMapDataEvent.ExitView;

	[Tooltip("任务条件通过时,自动触发")]
	public bool openSubscriptionTask;

	[Tooltip("角色等级改变时，自动触发")]
	public bool openSubscriptionPlayerLevel;

	[Tooltip("CopyOpen改变时，自动触发")]
	public bool openSubscriptionCopyOpen;

	public bool meetAllconditions;

	public bool invertCondition;

	public List<OpenCondition> activeTaskCondition = new List<OpenCondition>();

	[SerializeField]
	private bool saveNode;

	[SerializeField]
	public Dictionary<string, MapDataNodeParadoxParameter> nodeParadoxMsg = new Dictionary<string, MapDataNodeParadoxParameter>();

	protected Dictionary<string, MapDataNodeParadoxParameter> initNodeParadoxMsg = new Dictionary<string, MapDataNodeParadoxParameter>();

	public Dictionary<string, List<ParadoxParamCondition>> ParadoxParamCondition = new Dictionary<string, List<ParadoxParamCondition>>();

	public SceneSystem SceneSystem
	{
		get
		{
			return sceneSystem;
		}
		set
		{
			sceneSystem = value;
		}
	}

	public bool isInitState => mapDataNodeState == MapDataNodeState.Unsummoned;

	public bool isCreating => mapDataNodeState == MapDataNodeState.Summoning;

	public bool isBorned => mapDataNodeState == MapDataNodeState.Summoned;

	public bool isKilled
	{
		get
		{
			if (mapDataNodeState != MapDataNodeState.Dead && mapDataNodeState != MapDataNodeState.ReleaseFinish)
			{
				return mapDataNodeState == MapDataNodeState.DeadNoRelease;
			}
			return true;
		}
	}

	public WorldBase World => sceneSystem?.GetWorld();

	public bool IsLoaded => loadingTag == LevelMapDataNodeLoadingTag.Loaded;

	public bool IsLoading => loadingTag == LevelMapDataNodeLoadingTag.Loading;

	public bool IsDead => isDead;

	public BaseEntity Entity => entity;

	public bool SetParadoxFinish => setParadoxFinish;

	public virtual string NodeType => "Default";

	public virtual bool UsedOcTree => true;

	public virtual bool DisplayNode => true;

	public virtual bool IsMechanismNode => false;

	public bool SaveNode => saveNode;

	public virtual bool SubscriptionTask => openSubscriptionTask;

	public virtual bool SubscriptionPlayerLevel => openSubscriptionPlayerLevel;

	public virtual bool SubscriptionCopyOpen => openSubscriptionCopyOpen;

	public bool TaskConditionResult
	{
		get
		{
			CheckCondition();
			return taskConditionResult;
		}
	}

	public int Uid => uid;

	public void OnInit(object data = null)
	{
		loadingTag = LevelMapDataNodeLoadingTag.NotLoaded;
		sceneSystem = (SceneSystem)data;
		callbacks = new EntityCallbacks(EntityCreated, EntityOnStart, EntityDead, EntityRelease);
		bound.center = ((Component)this).transform.position;
		if (DisplayNode && nodeParadoxMsg != null)
		{
			foreach (KeyValuePair<string, MapDataNodeParadoxParameter> item in nodeParadoxMsg)
			{
				initNodeParadoxMsg.Add(item.Key, item.Value);
			}
		}
		OnInited(sceneSystem);
	}

	public virtual void OnInited(object data = null)
	{
	}

	public void OnStart(object data = null)
	{
		if (UsedOcTree)
		{
			sceneSystem.AddObjectInOcTree(this, bound);
		}
		RegisterTaskSubscribe();
		OnStarted();
	}

	public virtual void OnStarted(object data = null)
	{
	}

	public virtual void ClearDataRefrence()
	{
		if (UsedOcTree)
		{
			sceneSystem?.RemoveObjectInOcTree(this);
		}
		UnRegisterTaskSubscribe();
		UnRegisterSystemNotify();
		isDead = false;
		sceneSystem = null;
		entity = null;
	}

	public void ReceiveMapDataEvent(LevelMapDataEvent eventType, BaseEntity otherEntity = null)
	{
		if (UsedOcTree)
		{
			if (eventType == loadLevel || eventType == LevelMapDataEvent.LoadNode)
			{
				if (!IsLoaded && !IsLoading)
				{
					LoadNode();
				}
			}
			else if (eventType == unLoadLevel || eventType == LevelMapDataEvent.UnLoadNode)
			{
				if (IsLoaded || IsLoading)
				{
					UnLoadNode();
				}
			}
			else if (eventType == LevelMapDataEvent.RestLevel)
			{
				loadingTag = LevelMapDataNodeLoadingTag.NotLoaded;
				isDead = false;
				nodeParadoxMsg.Clear();
				if (initNodeParadoxMsg != null)
				{
					foreach (KeyValuePair<string, MapDataNodeParadoxParameter> item in initNodeParadoxMsg)
					{
						nodeParadoxMsg.Add(item.Key, item.Value);
					}
				}
			}
		}
		OnReceiveMapDataEvent(eventType, otherEntity);
	}

	private void CheckCondition()
	{
		taskConditionResult = sceneSystem.CheckCondition(activeTaskCondition, meetAllconditions, invertCondition);
	}

	protected void RegisterTaskSubscribe()
	{
		if ((SubscriptionTask || ParadoxParamCondition.Count > 0) && subscription == null)
		{
			subscription = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTaskMessager().Subscribe<TaskChangeNotifyMessager>(OnTaskChangeNotify);
		}
		if (SubscriptionPlayerLevel && subscription_UpdateLevel == null)
		{
			subscription_UpdateLevel = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<LevelChangeNotifyMessager>(OnGetLevelNotify);
		}
	}

	protected void UnRegisterTaskSubscribe()
	{
		if ((SubscriptionTask || ParadoxParamCondition.Count > 0) && subscription != null)
		{
			subscription.Dispose();
			subscription = null;
		}
		if (subscription_UpdateLevel != null)
		{
			subscription_UpdateLevel.Dispose();
			subscription_UpdateLevel = null;
		}
	}

	protected virtual void RegisterSystemNotify()
	{
	}

	protected virtual void UnRegisterSystemNotify()
	{
	}

	private void OnTaskChangeNotify(TaskChangeNotifyMessager notifyMessager)
	{
		if (notifyMessager.changeNotifyType == TaskSystem.TaskChangeNotifyType.LevelNodeCheck && (SubscriptionTask || SubscriptionCopyOpen))
		{
			DataChangeCheckActiveTaskCondition();
		}
		if (notifyMessager.changeNotifyType == TaskSystem.TaskChangeNotifyType.IndexStateUpdate || notifyMessager.changeNotifyType == TaskSystem.TaskChangeNotifyType.LevelNodeCheck)
		{
			TaskIndexStateChange();
		}
		else if (notifyMessager.changeNotifyType == TaskSystem.TaskChangeNotifyType.CopyOpenUpdate)
		{
			CopyOpenValueChange(notifyMessager.taskDataViewModel.CopyOpen);
		}
	}

	private void OnGetLevelNotify(LevelChangeNotifyMessager messager)
	{
		if (SubscriptionPlayerLevel)
		{
			DataChangeCheckActiveTaskCondition();
		}
	}

	private void DataChangeCheckActiveTaskCondition()
	{
		if (activeTaskCondition != null && activeTaskCondition.Count > 0)
		{
			OnTaskConditionChanged();
		}
	}

	protected virtual void OnTaskConditionChanged()
	{
	}

	protected virtual bool CheckLoadingCondition()
	{
		return true;
	}

	public void LoadNode()
	{
		if (IsDead || !CheckLoadingCondition())
		{
			return;
		}
		if (DisplayNode)
		{
			loadingTag = LevelMapDataNodeLoadingTag.Loading;
			if (LevelMapData.FrameLoading)
			{
				sceneSystem.RequestLoadNode(this);
			}
			else
			{
				OnLoadNode();
			}
		}
		else
		{
			loadingTag = LevelMapDataNodeLoadingTag.Loaded;
			OnLoadNode();
		}
	}

	protected virtual void OnLoadNode()
	{
	}

	public void ForceLoadNode()
	{
		if (IsDead)
		{
			return;
		}
		if (DisplayNode)
		{
			loadingTag = LevelMapDataNodeLoadingTag.Loading;
			if (LevelMapData.FrameLoading)
			{
				sceneSystem.RequestLoadNode(this);
			}
			else
			{
				OnForceLoadNode();
			}
		}
		else
		{
			loadingTag = LevelMapDataNodeLoadingTag.Loaded;
			OnForceLoadNode();
		}
	}

	protected virtual void OnForceLoadNode()
	{
	}

	public void StartLoadNode()
	{
		if (loadingTag == LevelMapDataNodeLoadingTag.Loading)
		{
			OnLoadNode();
		}
	}

	public void OnLoadFailed()
	{
		loadingTag = LevelMapDataNodeLoadingTag.NotLoaded;
	}

	private void UnLoadNode()
	{
		loadingTag = LevelMapDataNodeLoadingTag.NotLoaded;
		OnUnLoadNode();
	}

	public virtual void OnUnLoadNode()
	{
	}

	private async void EntityCreated(BaseEntity baseEntity)
	{
		if (baseEntity == null)
		{
			return;
		}
		if (!IsLoading)
		{
			baseEntity.DoEntityRelease();
			return;
		}
		loadingTag = LevelMapDataNodeLoadingTag.Loaded;
		entity = baseEntity;
		RegisterSystemNotify();
		entity.SetData("MAPDATANODEKEY", this);
		await UniTask.WaitUntil(() => entity == null || entity.GetComponent<AIParadoxComponent>().IsLoadingFinished());
		if (nodeParadoxMsg != null)
		{
			foreach (KeyValuePair<string, MapDataNodeParadoxParameter> item in nodeParadoxMsg)
			{
				SetParadoxMessage(item.Key, item.Value);
			}
		}
		SetParadoxParameterCondition();
		OnEntityCreated();
		setParadoxFinish = true;
		IsNeedCreate = false;
		if (IsNeedDestory)
		{
			OnUnLoadNode();
			IsNeedDestory = false;
		}
	}

	private void SetParadoxParameterCondition()
	{
		if (ParadoxParamCondition == null)
		{
			return;
		}
		foreach (KeyValuePair<string, List<ParadoxParamCondition>> item in ParadoxParamCondition)
		{
			if (item.Value == null)
			{
				continue;
			}
			for (int i = 0; i < item.Value.Count; i++)
			{
				if (item.Value[i].condition != null && item.Value[i].condition.SatisfyCondition(sceneSystem))
				{
					SetParadoxMessage(item.Key, item.Value[i].ParamterValue);
					break;
				}
			}
		}
	}

	private void TaskIndexStateChange()
	{
		if (entity == null || ParadoxParamCondition == null)
		{
			return;
		}
		foreach (KeyValuePair<string, List<ParadoxParamCondition>> item in ParadoxParamCondition)
		{
			if (item.Value == null)
			{
				continue;
			}
			for (int i = 0; i < item.Value.Count; i++)
			{
				if (item.Value[i].condition is TaskIndexStateCondition && item.Value[i].condition.SatisfyCondition(sceneSystem))
				{
					SetParadoxMessage(item.Key, item.Value[i].ParamterValue);
					break;
				}
			}
		}
	}

	private void CopyOpenValueChange(int copyOpen)
	{
		if (entity == null || ParadoxParamCondition == null)
		{
			return;
		}
		foreach (KeyValuePair<string, List<ParadoxParamCondition>> item in ParadoxParamCondition)
		{
			if (item.Value == null)
			{
				continue;
			}
			for (int i = 0; i < item.Value.Count; i++)
			{
				if (item.Value[i].condition is CopyOpenCondition && item.Value[i].condition.SatisfyCondition(sceneSystem))
				{
					SetParadoxMessage(item.Key, item.Value[i].ParamterValue);
					break;
				}
			}
		}
	}

	private async void EntityOnStart(BaseEntity baseEntity)
	{
		OnEntityStart();
	}

	protected virtual void OnEntityCreated()
	{
	}

	protected virtual void OnEntityStart()
	{
	}

	private void EntityRelease(BaseEntity baseEntity, bool isnormal)
	{
		setParadoxFinish = false;
		loadingTag = LevelMapDataNodeLoadingTag.NotLoaded;
		UnRegisterSystemNotify();
		OnEntityRelease(isnormal);
		entity = null;
		IsNeedDestory = false;
		if (IsNeedCreate)
		{
			LoadNode();
		}
	}

	protected virtual void OnEntityRelease(bool isnormal)
	{
	}

	private void EntityDead(BaseEntity baseEntity, bool isnormal)
	{
		isDead = true;
		UnRegisterSystemNotify();
		OnEntityDead(isnormal);
	}

	protected virtual void OnEntityDead(bool isnormal)
	{
	}

	public virtual void OnReceiveMapDataEvent(LevelMapDataEvent eventType, BaseEntity otherEntity = null)
	{
	}

	protected async Task<GameObject> LoadEntityView(int entityId, string assetPath)
	{
		return await World.GetSystem<EntityViewCacheSystem>().AsyncLoadEntityView(entityId, assetPath);
	}

	protected async Task<GameObject> LoadMechanismObj(int entityId, string assetPath)
	{
		return await World.GetSystem<MechanismCacheSystem>().LoadMechanismObj(entityId, assetPath);
	}

	public void SendParadoxMessage(string key, MapDataNodeParadoxParameter messageValue)
	{
		if (nodeParadoxMsg == null)
		{
			nodeParadoxMsg = new Dictionary<string, MapDataNodeParadoxParameter>();
		}
		if (nodeParadoxMsg.ContainsKey(key))
		{
			nodeParadoxMsg[key] = messageValue;
		}
		else
		{
			nodeParadoxMsg.Add(key, messageValue);
		}
		SetParadoxMessage(key, messageValue);
	}

	public void SendParadoxMessage(Dictionary<string, MapDataNodeParadoxParameter> msgs)
	{
		if (msgs == null)
		{
			return;
		}
		foreach (KeyValuePair<string, MapDataNodeParadoxParameter> msg in msgs)
		{
			SendParadoxMessage(msg.Key, msg.Value);
		}
	}

	protected void SetParadoxMessage(string key, MapDataNodeParadoxParameter mapDataNodeParadoxParameter)
	{
		if (entity != null)
		{
			AIParadoxComponent aiParadoxComponent = entity.GetComponent<AIParadoxComponent>();
			if (aiParadoxComponent != null)
			{
				mapDataNodeParadoxParameter.parameter?.InjectData(key, ref aiParadoxComponent);
			}
		}
	}

	public abstract void OnDisposed();

	public void OnDispose()
	{
		OnDisposed();
		ClearDataRefrence();
	}
}
