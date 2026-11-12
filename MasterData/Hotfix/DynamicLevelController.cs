using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class DynamicLevelController : MonoBehaviour
{
	private LogManager.Logger logger;

	protected Action flowCallback;

	private EventDispatcher eventDispatcher;

	protected string scenePath;

	internal const long INVALID_UID = -1L;

	private long _uidCounter;

	private bool _lockEntitiesListUpdate;

	private List<DynamicSimpleEntity> _delayDespawnEntities = new List<DynamicSimpleEntity>();

	public LogManager.Logger _logger
	{
		get
		{
			if (logger == null)
			{
				logger = Singleton<LogManager>.Instance.get_Item("DynamicModule");
			}
			return logger;
		}
	}

	public List<DynamicSimpleEntity> entities { get; private set; } = new List<DynamicSimpleEntity>();

	public List<DynamicSimpleEntity> ActorEntities { get; protected set; } = new List<DynamicSimpleEntity>();

	public virtual void LevelStart()
	{
	}

	public virtual void Initialize(EventDispatcher eventDispatcher)
	{
		this.eventDispatcher = eventDispatcher;
	}

	public virtual void Load(Action callback = null)
	{
		flowCallback = callback;
	}

	protected void LevelLoadProcessUpdate(string sceneName, int process)
	{
		MonoSingleton<ClientManager>.Instance.UpdateLoadingView((float)process / 100f);
		if (process == 200)
		{
			LevelLoadComplete(sceneName);
		}
	}

	protected virtual void LevelLoadComplete(string sceneName)
	{
		StartCoroutine(FinishAndUnloadUnusedResources(() =>
		{
			_logger.LogInfo("关卡加载完毕！");
			if (flowCallback != null)
			{
				flowCallback();
			}
		}));
	}

	protected IEnumerator FinishAndUnloadUnusedResources(Action callback = null)
	{
		GC.Collect();
		yield return MonoSingleton<ResourceManager>.Instance.UnloadUnusedAssets(null);
		yield return null;
		callback?.Invoke();
	}

	public virtual void Unload(Action callback = null)
	{
		MonoSingleton<SceneLoaderController>.Instance.UnloadAdditiveSceneAsync(scenePath, UnloadSceneOptions.None, (string sceneN, int process) =>
		{
			if (process == 300)
			{
				UnloadLevelComplete(callback);
			}
			return true;
		});
	}

	protected virtual void UnloadLevelComplete(Action unloadCallback = null)
	{
		_logger.LogInfo("关卡场景卸载完毕");
		unloadCallback?.Invoke();
	}

	public virtual void LevelEnd()
	{
	}

	public virtual void LevelFinish()
	{
		Clear();
	}

	public virtual void Clear()
	{
		flowCallback = null;
		eventDispatcher = null;
		scenePath = null;
	}

	private long GenerateUniqueID()
	{
		_uidCounter++;
		return _uidCounter;
	}

	public virtual void RegisterEntity(DynamicSimpleEntity entity)
	{
		if (!entities.Contains(entity))
		{
			entity.id = GenerateUniqueID();
			entities.Add(entity);
		}
		else
		{
			_logger.LogError("重复注册实体:" + entity.gameObject.name);
		}
	}

	public virtual void UnRegisterEntity(DynamicSimpleEntity entity)
	{
		entity.id = -1L;
		if (_lockEntitiesListUpdate)
		{
			if (!_delayDespawnEntities.Contains(entity))
			{
				_delayDespawnEntities.Add(entity);
			}
			return;
		}
		int num = entities.IndexOf(entity);
		if (num != -1)
		{
			entities.RemoveAt(num);
			entity.OnDelayDespawnInstance();
		}
		else
		{
			_logger.LogError("重复注销实体:" + entity.gameObject.name);
		}
	}

	protected bool AddEventListener(string aEventName_string, EventDelegate aEventDelegate)
	{
		return AddEventListener(aEventName_string, aEventDelegate, EventDispatchMode.Default);
	}

	private bool AddEventListener(string aEventName_string, EventDelegate aEventDelegate, EventDispatchMode aEventDispatchMode)
	{
		return eventDispatcher.AddEventListener(aEventName_string, aEventDelegate, aEventDispatchMode);
	}

	protected bool HasEventListener(string aEventName_string, EventDelegate aEventDelegate)
	{
		return eventDispatcher.HasEventListener(aEventName_string, aEventDelegate);
	}

	protected bool RemoveEventListener(string aEventName_string, EventDelegate aEventDelegate)
	{
		return eventDispatcher.RemoveEventListener(aEventName_string, aEventDelegate);
	}

	protected bool RemoveAllEventListeners()
	{
		return eventDispatcher.RemoveAllEventListeners();
	}

	public GameObject LoadModel(string path)
	{
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, path, typeof(GameObject)) as GameObject;
		if (null == gameObject)
		{
			return null;
		}
		return UnityEngine.Object.Instantiate(gameObject);
	}
}
