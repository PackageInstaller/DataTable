using System;
using System.Collections.Generic;
using UnityEngine;

public class AdventureLevelObjPoolMgr : SceneSingleton<AdventureLevelObjPoolMgr>
{
	public enum PoolType
	{
		Actor,
		Monster,
		Environment,
		SkillTemplate,
		SkillFS,
		FX,
		Timeline,
		Bullet
	}

	public enum PoolState
	{
		AssetEmpty,
		GameObjectEmpty,
		GameObjectUnUsing,
		GameObjectPrepare2Use,
		GameObjectUsing
	}

	public class PoolBase
	{
		public Transform defaultParentNode { get; protected set; }

		public Action<PoolBase> callback { get; protected set; }

		public string loadPath { get; protected set; }

		public PoolBase(Action<PoolBase> callback, string loadPath, Transform defaultParentNode)
		{
			this.callback = callback;
			this.loadPath = loadPath;
			this.defaultParentNode = defaultParentNode;
		}

		public virtual void Instantiate(UnityEngine.Object asset)
		{
			if (callback != null)
			{
				callback(this);
			}
			callback = null;
		}

		public virtual void EnPool()
		{
			callback = null;
			Enabled(enable: false);
		}

		public virtual void Enabled(bool enable)
		{
		}

		public virtual void Clean()
		{
		}

		public void Reset(Action<PoolBase> callback)
		{
			this.callback = callback;
		}

		public virtual void Preload(int num = 1)
		{
		}

		public virtual void Clear()
		{
			loadPath = null;
			callback = null;
			defaultParentNode = null;
		}
	}

	public class PoolObj : PoolBase
	{
		public GameObject gameObject { get; protected set; }

		public PoolObj(Action<PoolBase> callback, string loadPath, Transform defaultParentNode)
			: base(callback, loadPath, defaultParentNode)
		{
		}

		public override void Instantiate(UnityEngine.Object asset)
		{
			if (null == asset)
			{
				Debug.LogError("asset is empty :" + loadPath);
				return;
			}
			gameObject = UnityEngine.Object.Instantiate(asset) as GameObject;
			if (null == gameObject)
			{
				Debug.LogError("gameobject is empty :" + loadPath);
				return;
			}
			gameObject.transform.SetParent(defaultParentNode);
			base.Instantiate(asset);
		}

		public override void EnPool()
		{
			base.EnPool();
			if (!(null == defaultParentNode) && !(null == gameObject))
			{
				gameObject.transform.SetParent(defaultParentNode);
			}
		}

		public override void Enabled(bool enable)
		{
			if (!(null == gameObject))
			{
				gameObject.SetActive(enable);
			}
		}

		public override void Clear()
		{
			base.Clear();
			if (null != gameObject)
			{
				UnityEngine.Object.Destroy(gameObject);
			}
			gameObject = null;
		}
	}

	public class PoolContainer
	{
		protected Transform defaultParentNode;

		protected UnityEngine.Object asset;

		protected Queue<PoolBase> pool2Init;

		protected Queue<PoolBase> pool2Get;

		protected PoolType poolType;

		public string loadPath { get; protected set; }

		public bool IsEmpty
		{
			get
			{
				if (pool2Init == null || pool2Init.Count == 0)
				{
					if (pool2Get != null)
					{
						return pool2Get.Count == 0;
					}
					return true;
				}
				return false;
			}
		}

		public int Count
		{
			get
			{
				if (pool2Get != null)
				{
					return pool2Get.Count;
				}
				return 0;
			}
		}

		public int AllCount => ((pool2Get != null) ? pool2Get.Count : 0) + ((pool2Init != null) ? pool2Init.Count : 0);

		public PoolContainer(PoolType poolType, string loadPath, int capacity, Transform defaultParentNode, UnityEngine.Object prefab = null)
		{
			this.poolType = poolType;
			this.loadPath = loadPath;
			this.defaultParentNode = defaultParentNode;
			pool2Init = new Queue<PoolBase>(capacity);
			pool2Get = new Queue<PoolBase>(capacity);
			if (null != prefab)
			{
				asset = prefab;
				return;
			}
			switch (poolType)
			{
			case PoolType.Actor:
			case PoolType.Monster:
			{
				string[] array2 = loadPath.Split('$');
				if (array2.Length != 0)
				{
					asset = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Actor, array2[0], typeof(GameObject)) as GameObject;
				}
				break;
			}
			case PoolType.Environment:
				asset = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Env, loadPath, typeof(GameObject)) as GameObject;
				break;
			case PoolType.SkillTemplate:
			{
				string[] array = loadPath.Split('$');
				if (array.Length != 0)
				{
					asset = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Actor, array[0], typeof(GameObject)) as GameObject;
				}
				break;
			}
			case PoolType.Timeline:
				asset = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Actor, loadPath, typeof(GameObject)) as GameObject;
				break;
			case PoolType.Bullet:
				asset = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Actor, loadPath, typeof(GameObject)) as GameObject;
				break;
			}
		}

		public void EnPool(PoolBase poolObj)
		{
			poolObj.EnPool();
			pool2Get.Enqueue(poolObj);
		}

		protected PoolBase GetPoolBase(Action<PoolBase> callback = null)
		{
			return new PoolObj(callback, loadPath, defaultParentNode);
		}

		public PoolBase DePool()
		{
			PoolBase poolBase = null;
			if (pool2Get != null && pool2Get.Count > 0)
			{
				poolBase = pool2Get.Dequeue();
			}
			if (poolBase != null)
			{
				return poolBase;
			}
			poolBase = GetPoolBase();
			Instantiate(poolBase);
			return poolBase;
		}

		public void DePool(Action<PoolBase> callback)
		{
			PoolBase poolBase = null;
			if (pool2Get != null && pool2Get.Count > 0)
			{
				poolBase = pool2Get.Dequeue();
			}
			if (poolBase != null && callback != null)
			{
				callback(poolBase);
				return;
			}
			poolBase = GetPoolBase(callback);
			pool2Init.Enqueue(poolBase);
		}

		public PoolBase Peek()
		{
			if (pool2Init == null || pool2Init.Count == 0)
			{
				return null;
			}
			return pool2Init.Dequeue();
		}

		public void Instantiate(PoolBase poolBase)
		{
			poolBase.Instantiate(asset);
		}

		public void Preload(int num = 1)
		{
			if (pool2Init != null)
			{
				for (int i = 0; i < num; i++)
				{
					PoolObj poolObj = new PoolObj(null, loadPath, defaultParentNode);
					Instantiate(poolObj);
					EnPool(poolObj);
				}
			}
		}

		public void Clean()
		{
		}

		public void Clear()
		{
			defaultParentNode = null;
			asset = null;
			loadPath = null;
			if (pool2Init != null)
			{
				while (pool2Init.Count > 0)
				{
					pool2Init.Dequeue().Clear();
				}
				pool2Init.Clear();
				pool2Init = null;
			}
			if (pool2Get != null)
			{
				while (pool2Get.Count > 0)
				{
					pool2Get.Dequeue().Clear();
				}
				pool2Get.Clear();
				pool2Get = null;
			}
		}
	}

	public class Pool
	{
		protected int updateFrame;

		protected int frameUpdateCount = 1;

		protected int capacity = 1;

		protected int runtimeCapacity = 1;

		protected Dictionary<string, PoolContainer> pool;

		protected PoolType poolType = PoolType.Environment;

		protected Transform defaultParentNode;

		public int Count
		{
			get
			{
				if (pool != null)
				{
					return pool.Count;
				}
				return 0;
			}
		}

		public PoolContainer this[string key]
		{
			get
			{
				PoolContainer value = null;
				pool.TryGetValue(key, out value);
				return value;
			}
		}

		public Pool(PoolType poolType, int capacity, int frameUpdateCount, Transform defaultParentNode)
		{
			this.poolType = poolType;
			this.frameUpdateCount = frameUpdateCount;
			this.capacity = capacity;
			pool = new Dictionary<string, PoolContainer>(capacity);
			runtimeCapacity = this.capacity;
			this.defaultParentNode = new GameObject(poolType.ToString()).transform;
			this.defaultParentNode.SetParent(defaultParentNode);
			this.defaultParentNode.localScale = Vector3.one;
			this.defaultParentNode.localPosition = Vector3.zero;
		}

		protected void Expend()
		{
			runtimeCapacity *= 2;
		}

		public void EnPool(List<PoolBase> poolBases)
		{
			int count = poolBases.Count;
			for (int i = 0; i < count; i++)
			{
				EnPool(poolBases.get_Item(i));
			}
		}

		public void EnPool(PoolBase poolBase)
		{
			Peek(poolBase.loadPath)?.EnPool(poolBase);
		}

		public int GetPoolObjNum(string loadPath)
		{
			return Peek(loadPath)?.Count ?? 0;
		}

		public PoolBase DePool(string loadPath)
		{
			PoolContainer poolContainer = Peek(loadPath);
			if (poolContainer == null)
			{
				if (pool.Count >= runtimeCapacity)
				{
					Expend();
				}
				poolContainer = new PoolContainer(poolType, loadPath, capacity, defaultParentNode);
				pool.Add(loadPath, poolContainer);
			}
			return poolContainer.DePool();
		}

		public void DePool(string loadPath, Action<PoolBase> callback)
		{
			PoolContainer poolContainer = Peek(loadPath);
			if (poolContainer == null)
			{
				if (pool.Count >= runtimeCapacity)
				{
					Expend();
				}
				poolContainer = new PoolContainer(poolType, loadPath, capacity, defaultParentNode);
				pool.Add(loadPath, poolContainer);
			}
			poolContainer.DePool(callback);
		}

		protected PoolContainer Peek(string loadPath)
		{
			if (string.IsNullOrEmpty(loadPath))
			{
				Debug.LogError($"从对象池{poolType}娶对象时传入的路径为空!");
				return null;
			}
			if (pool.TryGetValue(loadPath, out var value))
			{
				return value;
			}
			return null;
		}

		public void Preload(int num = 1)
		{
			if (pool == null)
			{
				return;
			}
			foreach (PoolContainer value in pool.Values)
			{
				value.Preload(num);
			}
		}

		public void Preload(PoolBase poolBase, int num)
		{
			if (pool != null && poolBase != null)
			{
				if (!pool.TryGetValue(poolBase.loadPath, out var value))
				{
					value = new PoolContainer(poolType, poolBase.loadPath, num, defaultParentNode);
				}
				value.Preload(num);
			}
		}

		public void Preload(string loadPath, int num, GameObject prefab = null)
		{
			if (pool != null)
			{
				if (!pool.TryGetValue(loadPath, out var value))
				{
					value = new PoolContainer(poolType, loadPath, num, defaultParentNode, prefab);
					pool.Add(loadPath, value);
				}
				value.Preload(num);
			}
		}

		public void Clean()
		{
			if (pool == null)
			{
				return;
			}
			List<string> list = new List<string>();
			foreach (PoolContainer value in pool.Values)
			{
				if (value.IsEmpty)
				{
					list.Add(value.loadPath);
					value.Clean();
				}
			}
			for (int i = 0; i < list.Count; i++)
			{
				pool.Remove(list.get_Item(i));
			}
		}

		public void Clear()
		{
			if (pool == null)
			{
				return;
			}
			foreach (PoolContainer value in pool.Values)
			{
				value.Clear();
			}
			pool.Clear();
		}

		public void Unload()
		{
		}

		public void Update()
		{
			int num = 0;
			foreach (PoolContainer value in pool.Values)
			{
				PoolBase poolBase = value.Peek();
				if (poolBase != null)
				{
					value.Instantiate(poolBase);
					num++;
				}
				if (num >= frameUpdateCount)
				{
					break;
				}
			}
		}
	}

	protected int dynamicLoad_SceneObjFrameUpdateNum = 5;

	protected int dynamicLoad_PlayerFrameUpdateNum = 1;

	protected int dynamicLoad_MonsterFrameUpdateNum = 1;

	protected int dynamicLoad_FlowScriptUpdateNum = 1;

	protected int dynamicLoad_SkillTempleteUpdateNum = 1;

	protected int dynamicLoad_BulletUpdateNum = 1;

	public const int INITCAPACITY_ENV = 128;

	public const int INITCAPACITY_PLAYER = 1;

	public const int INITCAPACITY_MONSTER = 8;

	public const int INITCAPACITY_FS = 8;

	public const int INITCAPACITY_BULLET = 32;

	public const int INITCAPACITY_SKILLTEMPLETE = 16;

	protected Pool pool_player;

	protected Pool pool_monster;

	protected Pool pool_env;

	protected Pool pool_st;

	protected Pool pool_bullet;

	protected override void Awake()
	{
		base.Awake();
		Initialize();
	}

	public void Initialize()
	{
		pool_player = new Pool(PoolType.Actor, 1, dynamicLoad_PlayerFrameUpdateNum, transform);
		pool_monster = new Pool(PoolType.Monster, 8, dynamicLoad_MonsterFrameUpdateNum, transform);
		pool_env = new Pool(PoolType.Environment, 128, dynamicLoad_SceneObjFrameUpdateNum, transform);
		pool_st = new Pool(PoolType.SkillTemplate, 16, dynamicLoad_SkillTempleteUpdateNum, transform);
		pool_bullet = new Pool(PoolType.Bullet, 32, dynamicLoad_BulletUpdateNum, transform);
	}

	public void Preload_SceneObject(int num = 1)
	{
		pool_env.Preload();
	}

	public void Preload_Monster(int num = 1)
	{
		pool_monster.Preload(num);
	}

	public void Preload_Monster(PoolBase poolBase, int num)
	{
		pool_monster.Preload(poolBase, num);
	}

	public void Preload_Bullet(GameObject prefab, int num, string loadPath)
	{
		pool_bullet.Preload(loadPath, num, prefab);
	}

	public PoolBase De_Bullet(string loadPath)
	{
		return pool_bullet.DePool(loadPath);
	}

	public PoolBase De_SceneObject(string loadPath)
	{
		if (string.IsNullOrEmpty(loadPath))
		{
			return null;
		}
		return pool_env.DePool(loadPath);
	}

	public void De_SceneObject(string loadPath, Action<PoolBase> callback)
	{
		pool_env.DePool(loadPath, callback);
	}

	public void En_SceneObject(List<PoolBase> poolBases)
	{
		if (poolBases != null)
		{
			pool_env.EnPool(poolBases);
		}
	}

	public void En_SceneObject(PoolBase poolBase)
	{
		pool_env.EnPool(poolBase);
	}

	public PoolBase De_Player(string loadPath)
	{
		return pool_player.DePool(loadPath);
	}

	public void De_Player(string loadPath, Action<PoolBase> callback)
	{
		pool_player.DePool(loadPath, callback);
	}

	public void En_Player(PoolBase poolBase)
	{
		pool_player.EnPool(poolBase);
	}

	public int GetCount_Monster(string loadPath)
	{
		return pool_monster.GetPoolObjNum(loadPath);
	}

	public PoolBase De_Monster(string loadPath)
	{
		return pool_monster.DePool(loadPath);
	}

	public void De_Monster(string loadPath, Action<PoolBase> callback)
	{
		pool_monster.DePool(loadPath, callback);
	}

	public void En_Monster(PoolBase poolBase)
	{
		pool_monster.EnPool(poolBase);
	}

	public PoolBase De_SkillTemplate(string loadPath)
	{
		return pool_st.DePool(loadPath);
	}

	public void De_SkillTemplate(string loadPath, Action<PoolBase> callback)
	{
		pool_st.DePool(loadPath, callback);
	}

	public void En_SkillTemplete(PoolBase poolBase)
	{
		pool_st.EnPool(poolBase);
	}

	public void Clear()
	{
		pool_env.Clear();
		pool_player.Clear();
		pool_monster.Clear();
		pool_st.Clear();
		pool_bullet.Clear();
	}

	public void ClearPlayer()
	{
		pool_player.Clear();
	}

	public void ClearMonster()
	{
		pool_monster.Clear();
	}

	public void ClearSkillTemplete()
	{
		pool_st.Clear();
	}

	public void UnloadPlayerAssets()
	{
		pool_player.Unload();
	}

	public void UnloadMonsterAssets()
	{
		pool_monster.Unload();
	}

	public void Unload()
	{
	}

	protected void Update()
	{
		pool_env?.Update();
		pool_player?.Update();
		pool_monster?.Update();
		pool_st?.Update();
	}
}
