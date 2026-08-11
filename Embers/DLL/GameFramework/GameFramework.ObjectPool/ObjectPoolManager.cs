using System;
using System.Collections.Generic;

namespace GameFramework.ObjectPool;

internal sealed class ObjectPoolManager : GameFrameworkModule, IObjectPoolManager
{
	private sealed class Object<T> : IReference where T : ObjectBase
	{
		private T m_Object;

		private int m_SpawnCount;

		public string Name => m_Object.Name;

		public bool Locked
		{
			get
			{
				return m_Object.Locked;
			}
			internal set
			{
				m_Object.Locked = value;
			}
		}

		public int Priority
		{
			get
			{
				return m_Object.Priority;
			}
			internal set
			{
				m_Object.Priority = value;
			}
		}

		public bool CustomCanReleaseFlag => m_Object.CustomCanReleaseFlag;

		public DateTime LastUseTime => m_Object.LastUseTime;

		public bool IsInUse => m_SpawnCount > 0;

		public int SpawnCount => m_SpawnCount;

		public Object()
		{
			m_Object = null;
			m_SpawnCount = 0;
		}

		public static Object<T> Create(T obj, bool spawned)
		{
			if (obj == null)
			{
				throw new GameFrameworkException("Object is invalid.");
			}
			Object<T> obj2 = ReferencePool.Acquire<Object<T>>();
			obj2.m_Object = obj;
			obj2.m_SpawnCount = (spawned ? 1 : 0);
			if (spawned)
			{
				obj.OnSpawn();
			}
			return obj2;
		}

		public void Clear()
		{
			m_Object = null;
			m_SpawnCount = 0;
		}

		public T Peek()
		{
			return m_Object;
		}

		public T Spawn()
		{
			m_SpawnCount++;
			m_Object.LastUseTime = DateTime.UtcNow;
			m_Object.OnSpawn();
			return m_Object;
		}

		public void Unspawn()
		{
			m_Object.OnUnspawn();
			m_Object.LastUseTime = DateTime.UtcNow;
			m_SpawnCount--;
			if (m_SpawnCount < 0)
			{
				throw new GameFrameworkException(Utility.Text.Format("Object '{0}' spawn count is less than 0.", Name));
			}
		}

		public void Release(bool isShutdown)
		{
			m_Object.Release(isShutdown);
			ReferencePool.Release(m_Object);
		}
	}

	private sealed class ObjectPool<T> : ObjectPoolBase, IObjectPool<T> where T : ObjectBase
	{
		private readonly GameFrameworkMultiDictionary<string, Object<T>> m_Objects;

		private readonly Dictionary<object, Object<T>> m_ObjectMap;

		private readonly ReleaseObjectFilterCallback<T> m_DefaultReleaseObjectFilterCallback;

		private readonly List<T> m_CachedCanReleaseObjects;

		private readonly List<T> m_CachedToReleaseObjects;

		private readonly bool m_AllowMultiSpawn;

		private float m_AutoReleaseInterval;

		private int m_Capacity;

		private float m_ExpireTime;

		private int m_Priority;

		private float m_AutoReleaseTime;

		public override Type ObjectType => typeof(T);

		public override int Count => m_ObjectMap.Count;

		public override int CanReleaseCount
		{
			get
			{
				GetCanReleaseObjects(m_CachedCanReleaseObjects);
				return m_CachedCanReleaseObjects.Count;
			}
		}

		public override bool AllowMultiSpawn => m_AllowMultiSpawn;

		public override float AutoReleaseInterval
		{
			get
			{
				return m_AutoReleaseInterval;
			}
			set
			{
				m_AutoReleaseInterval = value;
			}
		}

		public override int Capacity
		{
			get
			{
				return m_Capacity;
			}
			set
			{
				if (value < 0)
				{
					throw new GameFrameworkException("Capacity is invalid.");
				}
				if (m_Capacity != value)
				{
					m_Capacity = value;
					Release();
				}
			}
		}

		public override float ExpireTime
		{
			get
			{
				return m_ExpireTime;
			}
			set
			{
				if (value < 0f)
				{
					throw new GameFrameworkException("ExpireTime is invalid.");
				}
				if (ExpireTime != value)
				{
					m_ExpireTime = value;
					Release();
				}
			}
		}

		public override int Priority
		{
			get
			{
				return m_Priority;
			}
			set
			{
				m_Priority = value;
			}
		}

		public ObjectPool(string name, bool allowMultiSpawn, float autoReleaseInterval, int capacity, float expireTime, int priority)
			: base(name)
		{
			m_Objects = new GameFrameworkMultiDictionary<string, Object<T>>();
			m_ObjectMap = new Dictionary<object, Object<T>>();
			m_DefaultReleaseObjectFilterCallback = DefaultReleaseObjectFilterCallback;
			m_CachedCanReleaseObjects = new List<T>();
			m_CachedToReleaseObjects = new List<T>();
			m_AllowMultiSpawn = allowMultiSpawn;
			m_AutoReleaseInterval = autoReleaseInterval;
			Capacity = capacity;
			ExpireTime = expireTime;
			m_Priority = priority;
			m_AutoReleaseTime = 0f;
		}

		public void Register(T obj, bool spawned)
		{
			if (obj == null)
			{
				throw new GameFrameworkException("Object is invalid.");
			}
			Object<T> value = Object<T>.Create(obj, spawned);
			m_Objects.Add(obj.Name, value);
			m_ObjectMap.Add(obj.Target, value);
			if (Count > m_Capacity)
			{
				Release();
			}
		}

		public bool CanSpawn()
		{
			return CanSpawn(string.Empty);
		}

		public bool CanSpawn(string name)
		{
			if (name == null)
			{
				throw new GameFrameworkException("Name is invalid.");
			}
			GameFrameworkLinkedListRange<Object<T>> range = default(GameFrameworkLinkedListRange<Object<T>>);
			if (m_Objects.TryGetValue(name, out range))
			{
				foreach (Object<T> item in range)
				{
					if (m_AllowMultiSpawn || !item.IsInUse)
					{
						return true;
					}
				}
			}
			return false;
		}

		public T Spawn()
		{
			return Spawn(string.Empty);
		}

		public T Spawn(string name)
		{
			if (name == null)
			{
				throw new GameFrameworkException("Name is invalid.");
			}
			GameFrameworkLinkedListRange<Object<T>> range = default(GameFrameworkLinkedListRange<Object<T>>);
			if (m_Objects.TryGetValue(name, out range))
			{
				foreach (Object<T> item in range)
				{
					if (m_AllowMultiSpawn || !item.IsInUse)
					{
						return item.Spawn();
					}
				}
			}
			return null;
		}

		public void Unspawn(T obj)
		{
			if (obj == null)
			{
				throw new GameFrameworkException("Object is invalid.");
			}
			Unspawn(obj.Target);
		}

		public void Unspawn(object target)
		{
			if (target == null)
			{
				throw new GameFrameworkException("Target is invalid.");
			}
			Object<T> obj = GetObject(target);
			if (obj != null)
			{
				obj.Unspawn();
				if (Count > m_Capacity && obj.SpawnCount <= 0)
				{
					Release();
				}
				return;
			}
			throw new GameFrameworkException(Utility.Text.Format("Can not find target in object pool '{0}', target type is '{1}', target value is '{2}'.", new TypeNamePair(typeof(T), base.Name), target.GetType().FullName, target));
		}

		public void SetLocked(T obj, bool locked)
		{
			if (obj == null)
			{
				throw new GameFrameworkException("Object is invalid.");
			}
			SetLocked(obj.Target, locked);
		}

		public void SetLocked(object target, bool locked)
		{
			if (target == null)
			{
				throw new GameFrameworkException("Target is invalid.");
			}
			Object<T> obj = GetObject(target);
			if (obj != null)
			{
				obj.Locked = locked;
				return;
			}
			throw new GameFrameworkException(Utility.Text.Format("Can not find target in object pool '{0}', target type is '{1}', target value is '{2}'.", new TypeNamePair(typeof(T), base.Name), target.GetType().FullName, target));
		}

		public void SetPriority(T obj, int priority)
		{
			if (obj == null)
			{
				throw new GameFrameworkException("Object is invalid.");
			}
			SetPriority(obj.Target, priority);
		}

		public void SetPriority(object target, int priority)
		{
			if (target == null)
			{
				throw new GameFrameworkException("Target is invalid.");
			}
			Object<T> obj = GetObject(target);
			if (obj != null)
			{
				obj.Priority = priority;
				return;
			}
			throw new GameFrameworkException(Utility.Text.Format("Can not find target in object pool '{0}', target type is '{1}', target value is '{2}'.", new TypeNamePair(typeof(T), base.Name), target.GetType().FullName, target));
		}

		public bool ReleaseObject(T obj)
		{
			if (obj == null)
			{
				throw new GameFrameworkException("Object is invalid.");
			}
			return ReleaseObject(obj.Target);
		}

		public bool ReleaseObject(object target)
		{
			if (target == null)
			{
				throw new GameFrameworkException("Target is invalid.");
			}
			Object<T> obj = GetObject(target);
			if (obj == null)
			{
				return false;
			}
			if (obj.IsInUse || obj.Locked || !obj.CustomCanReleaseFlag)
			{
				return false;
			}
			m_Objects.Remove(obj.Name, obj);
			m_ObjectMap.Remove(obj.Peek().Target);
			obj.Release(isShutdown: false);
			ReferencePool.Release(obj);
			return true;
		}

		public override void Release()
		{
			Release(Count - m_Capacity, m_DefaultReleaseObjectFilterCallback);
		}

		public override void Release(int toReleaseCount)
		{
			Release(toReleaseCount, m_DefaultReleaseObjectFilterCallback);
		}

		public void Release(ReleaseObjectFilterCallback<T> releaseObjectFilterCallback)
		{
			Release(Count - m_Capacity, releaseObjectFilterCallback);
		}

		public void Release(int toReleaseCount, ReleaseObjectFilterCallback<T> releaseObjectFilterCallback)
		{
			if (releaseObjectFilterCallback == null)
			{
				throw new GameFrameworkException("Release object filter callback is invalid.");
			}
			if (toReleaseCount < 0)
			{
				toReleaseCount = 0;
			}
			DateTime expireTime = DateTime.MinValue;
			if (m_ExpireTime < float.MaxValue)
			{
				expireTime = DateTime.UtcNow.AddSeconds(0f - m_ExpireTime);
			}
			m_AutoReleaseTime = 0f;
			GetCanReleaseObjects(m_CachedCanReleaseObjects);
			List<T> list = releaseObjectFilterCallback(m_CachedCanReleaseObjects, toReleaseCount, expireTime);
			if (list == null || list.Count <= 0)
			{
				return;
			}
			foreach (T item in list)
			{
				ReleaseObject(item);
			}
		}

		public override void ReleaseAllUnused()
		{
			m_AutoReleaseTime = 0f;
			GetCanReleaseObjects(m_CachedCanReleaseObjects);
			foreach (T cachedCanReleaseObject in m_CachedCanReleaseObjects)
			{
				ReleaseObject(cachedCanReleaseObject);
			}
		}

		public override ObjectInfo[] GetAllObjectInfos()
		{
			List<ObjectInfo> list = new List<ObjectInfo>();
			foreach (KeyValuePair<string, GameFrameworkLinkedListRange<Object<T>>> @object in m_Objects)
			{
				foreach (Object<T> item in @object.Value)
				{
					list.Add(new ObjectInfo(item.Name, item.Locked, item.CustomCanReleaseFlag, item.Priority, item.LastUseTime, item.SpawnCount));
				}
			}
			return list.ToArray();
		}

		internal override void Update(float elapseSeconds, float realElapseSeconds)
		{
			m_AutoReleaseTime += realElapseSeconds;
			if (!(m_AutoReleaseTime < m_AutoReleaseInterval))
			{
				Release();
			}
		}

		internal override void Shutdown()
		{
			foreach (KeyValuePair<object, Object<T>> item in m_ObjectMap)
			{
				item.Value.Release(isShutdown: true);
				ReferencePool.Release(item.Value);
			}
			m_Objects.Clear();
			m_ObjectMap.Clear();
			m_CachedCanReleaseObjects.Clear();
			m_CachedToReleaseObjects.Clear();
		}

		private Object<T> GetObject(object target)
		{
			if (target == null)
			{
				throw new GameFrameworkException("Target is invalid.");
			}
			Object<T> value = null;
			if (m_ObjectMap.TryGetValue(target, out value))
			{
				return value;
			}
			return null;
		}

		private void GetCanReleaseObjects(List<T> results)
		{
			if (results == null)
			{
				throw new GameFrameworkException("Results is invalid.");
			}
			results.Clear();
			foreach (KeyValuePair<object, Object<T>> item in m_ObjectMap)
			{
				Object<T> value = item.Value;
				if (!value.IsInUse && !value.Locked && value.CustomCanReleaseFlag)
				{
					results.Add(value.Peek());
				}
			}
		}

		private List<T> DefaultReleaseObjectFilterCallback(List<T> candidateObjects, int toReleaseCount, DateTime expireTime)
		{
			m_CachedToReleaseObjects.Clear();
			if (expireTime > DateTime.MinValue)
			{
				for (int num = candidateObjects.Count - 1; num >= 0; num--)
				{
					if (candidateObjects[num].LastUseTime <= expireTime)
					{
						m_CachedToReleaseObjects.Add(candidateObjects[num]);
						candidateObjects.RemoveAt(num);
					}
				}
				toReleaseCount -= m_CachedToReleaseObjects.Count;
			}
			int num2 = 0;
			while (toReleaseCount > 0 && num2 < candidateObjects.Count)
			{
				for (int i = num2 + 1; i < candidateObjects.Count; i++)
				{
					if (candidateObjects[num2].Priority > candidateObjects[i].Priority || (candidateObjects[num2].Priority == candidateObjects[i].Priority && candidateObjects[num2].LastUseTime > candidateObjects[i].LastUseTime))
					{
						T value = candidateObjects[num2];
						candidateObjects[num2] = candidateObjects[i];
						candidateObjects[i] = value;
					}
				}
				m_CachedToReleaseObjects.Add(candidateObjects[num2]);
				toReleaseCount--;
				num2++;
			}
			return m_CachedToReleaseObjects;
		}
	}

	private const int DefaultCapacity = int.MaxValue;

	private const float DefaultExpireTime = float.MaxValue;

	private const int DefaultPriority = 0;

	private readonly Dictionary<TypeNamePair, ObjectPoolBase> m_ObjectPools;

	private readonly List<ObjectPoolBase> m_CachedAllObjectPools;

	private readonly Comparison<ObjectPoolBase> m_ObjectPoolComparer;

	internal override int Priority => 6;

	public int Count => m_ObjectPools.Count;

	public ObjectPoolManager()
	{
		m_ObjectPools = new Dictionary<TypeNamePair, ObjectPoolBase>();
		m_CachedAllObjectPools = new List<ObjectPoolBase>();
		m_ObjectPoolComparer = ObjectPoolComparer;
	}

	internal override void Update(float elapseSeconds, float realElapseSeconds)
	{
		foreach (KeyValuePair<TypeNamePair, ObjectPoolBase> objectPool in m_ObjectPools)
		{
			objectPool.Value.Update(elapseSeconds, realElapseSeconds);
		}
	}

	internal override void Shutdown()
	{
		foreach (KeyValuePair<TypeNamePair, ObjectPoolBase> objectPool in m_ObjectPools)
		{
			objectPool.Value.Shutdown();
		}
		m_ObjectPools.Clear();
		m_CachedAllObjectPools.Clear();
	}

	public bool HasObjectPool<T>() where T : ObjectBase
	{
		return InternalHasObjectPool(new TypeNamePair(typeof(T)));
	}

	public bool HasObjectPool(Type objectType)
	{
		if (objectType == null)
		{
			throw new GameFrameworkException("Object type is invalid.");
		}
		if (!typeof(ObjectBase).IsAssignableFrom(objectType))
		{
			throw new GameFrameworkException(Utility.Text.Format("Object type '{0}' is invalid.", objectType.FullName));
		}
		return InternalHasObjectPool(new TypeNamePair(objectType));
	}

	public bool HasObjectPool<T>(string name) where T : ObjectBase
	{
		return InternalHasObjectPool(new TypeNamePair(typeof(T), name));
	}

	public bool HasObjectPool(Type objectType, string name)
	{
		if (objectType == null)
		{
			throw new GameFrameworkException("Object type is invalid.");
		}
		if (!typeof(ObjectBase).IsAssignableFrom(objectType))
		{
			throw new GameFrameworkException(Utility.Text.Format("Object type '{0}' is invalid.", objectType.FullName));
		}
		return InternalHasObjectPool(new TypeNamePair(objectType, name));
	}

	public bool HasObjectPool(Predicate<ObjectPoolBase> condition)
	{
		if (condition == null)
		{
			throw new GameFrameworkException("Condition is invalid.");
		}
		foreach (KeyValuePair<TypeNamePair, ObjectPoolBase> objectPool in m_ObjectPools)
		{
			if (condition(objectPool.Value))
			{
				return true;
			}
		}
		return false;
	}

	public IObjectPool<T> GetObjectPool<T>() where T : ObjectBase
	{
		return (IObjectPool<T>)InternalGetObjectPool(new TypeNamePair(typeof(T)));
	}

	public ObjectPoolBase GetObjectPool(Type objectType)
	{
		if (objectType == null)
		{
			throw new GameFrameworkException("Object type is invalid.");
		}
		if (!typeof(ObjectBase).IsAssignableFrom(objectType))
		{
			throw new GameFrameworkException(Utility.Text.Format("Object type '{0}' is invalid.", objectType.FullName));
		}
		return InternalGetObjectPool(new TypeNamePair(objectType));
	}

	public IObjectPool<T> GetObjectPool<T>(string name) where T : ObjectBase
	{
		return (IObjectPool<T>)InternalGetObjectPool(new TypeNamePair(typeof(T), name));
	}

	public ObjectPoolBase GetObjectPool(Type objectType, string name)
	{
		if (objectType == null)
		{
			throw new GameFrameworkException("Object type is invalid.");
		}
		if (!typeof(ObjectBase).IsAssignableFrom(objectType))
		{
			throw new GameFrameworkException(Utility.Text.Format("Object type '{0}' is invalid.", objectType.FullName));
		}
		return InternalGetObjectPool(new TypeNamePair(objectType, name));
	}

	public ObjectPoolBase GetObjectPool(Predicate<ObjectPoolBase> condition)
	{
		if (condition == null)
		{
			throw new GameFrameworkException("Condition is invalid.");
		}
		foreach (KeyValuePair<TypeNamePair, ObjectPoolBase> objectPool in m_ObjectPools)
		{
			if (condition(objectPool.Value))
			{
				return objectPool.Value;
			}
		}
		return null;
	}

	public ObjectPoolBase[] GetObjectPools(Predicate<ObjectPoolBase> condition)
	{
		if (condition == null)
		{
			throw new GameFrameworkException("Condition is invalid.");
		}
		List<ObjectPoolBase> list = new List<ObjectPoolBase>();
		foreach (KeyValuePair<TypeNamePair, ObjectPoolBase> objectPool in m_ObjectPools)
		{
			if (condition(objectPool.Value))
			{
				list.Add(objectPool.Value);
			}
		}
		return list.ToArray();
	}

	public void GetObjectPools(Predicate<ObjectPoolBase> condition, List<ObjectPoolBase> results)
	{
		if (condition == null)
		{
			throw new GameFrameworkException("Condition is invalid.");
		}
		if (results == null)
		{
			throw new GameFrameworkException("Results is invalid.");
		}
		results.Clear();
		foreach (KeyValuePair<TypeNamePair, ObjectPoolBase> objectPool in m_ObjectPools)
		{
			if (condition(objectPool.Value))
			{
				results.Add(objectPool.Value);
			}
		}
	}

	public ObjectPoolBase[] GetAllObjectPools()
	{
		return GetAllObjectPools(sort: false);
	}

	public void GetAllObjectPools(List<ObjectPoolBase> results)
	{
		GetAllObjectPools(sort: false, results);
	}

	public ObjectPoolBase[] GetAllObjectPools(bool sort)
	{
		if (sort)
		{
			List<ObjectPoolBase> list = new List<ObjectPoolBase>();
			foreach (KeyValuePair<TypeNamePair, ObjectPoolBase> objectPool in m_ObjectPools)
			{
				list.Add(objectPool.Value);
			}
			list.Sort(m_ObjectPoolComparer);
			return list.ToArray();
		}
		int num = 0;
		ObjectPoolBase[] array = new ObjectPoolBase[m_ObjectPools.Count];
		foreach (KeyValuePair<TypeNamePair, ObjectPoolBase> objectPool2 in m_ObjectPools)
		{
			array[num++] = objectPool2.Value;
		}
		return array;
	}

	public void GetAllObjectPools(bool sort, List<ObjectPoolBase> results)
	{
		if (results == null)
		{
			throw new GameFrameworkException("Results is invalid.");
		}
		results.Clear();
		foreach (KeyValuePair<TypeNamePair, ObjectPoolBase> objectPool in m_ObjectPools)
		{
			results.Add(objectPool.Value);
		}
		if (sort)
		{
			results.Sort(m_ObjectPoolComparer);
		}
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>() where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(string.Empty, allowMultiSpawn: false, float.MaxValue, int.MaxValue, float.MaxValue, 0);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType)
	{
		return InternalCreateObjectPool(objectType, string.Empty, allowMultiSpawn: false, float.MaxValue, int.MaxValue, float.MaxValue, 0);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(name, allowMultiSpawn: false, float.MaxValue, int.MaxValue, float.MaxValue, 0);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name)
	{
		return InternalCreateObjectPool(objectType, name, allowMultiSpawn: false, float.MaxValue, int.MaxValue, float.MaxValue, 0);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(int capacity) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(string.Empty, allowMultiSpawn: false, float.MaxValue, capacity, float.MaxValue, 0);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, int capacity)
	{
		return InternalCreateObjectPool(objectType, string.Empty, allowMultiSpawn: false, float.MaxValue, capacity, float.MaxValue, 0);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(float expireTime) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(string.Empty, allowMultiSpawn: false, expireTime, int.MaxValue, expireTime, 0);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, float expireTime)
	{
		return InternalCreateObjectPool(objectType, string.Empty, allowMultiSpawn: false, expireTime, int.MaxValue, expireTime, 0);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, int capacity) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(name, allowMultiSpawn: false, float.MaxValue, capacity, float.MaxValue, 0);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, int capacity)
	{
		return InternalCreateObjectPool(objectType, name, allowMultiSpawn: false, float.MaxValue, capacity, float.MaxValue, 0);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, float expireTime) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(name, allowMultiSpawn: false, expireTime, int.MaxValue, expireTime, 0);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, float expireTime)
	{
		return InternalCreateObjectPool(objectType, name, allowMultiSpawn: false, expireTime, int.MaxValue, expireTime, 0);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(int capacity, float expireTime) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(string.Empty, allowMultiSpawn: false, expireTime, capacity, expireTime, 0);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, int capacity, float expireTime)
	{
		return InternalCreateObjectPool(objectType, string.Empty, allowMultiSpawn: false, expireTime, capacity, expireTime, 0);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(int capacity, int priority) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(string.Empty, allowMultiSpawn: false, float.MaxValue, capacity, float.MaxValue, priority);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, int capacity, int priority)
	{
		return InternalCreateObjectPool(objectType, string.Empty, allowMultiSpawn: false, float.MaxValue, capacity, float.MaxValue, priority);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(float expireTime, int priority) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(string.Empty, allowMultiSpawn: false, expireTime, int.MaxValue, expireTime, priority);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, float expireTime, int priority)
	{
		return InternalCreateObjectPool(objectType, string.Empty, allowMultiSpawn: false, expireTime, int.MaxValue, expireTime, priority);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, int capacity, float expireTime) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(name, allowMultiSpawn: false, expireTime, capacity, expireTime, 0);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, int capacity, float expireTime)
	{
		return InternalCreateObjectPool(objectType, name, allowMultiSpawn: false, expireTime, capacity, expireTime, 0);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, int capacity, int priority) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(name, allowMultiSpawn: false, float.MaxValue, capacity, float.MaxValue, priority);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, int capacity, int priority)
	{
		return InternalCreateObjectPool(objectType, name, allowMultiSpawn: false, float.MaxValue, capacity, float.MaxValue, priority);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, float expireTime, int priority) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(name, allowMultiSpawn: false, expireTime, int.MaxValue, expireTime, priority);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, float expireTime, int priority)
	{
		return InternalCreateObjectPool(objectType, name, allowMultiSpawn: false, expireTime, int.MaxValue, expireTime, priority);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(int capacity, float expireTime, int priority) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(string.Empty, allowMultiSpawn: false, expireTime, capacity, expireTime, priority);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, int capacity, float expireTime, int priority)
	{
		return InternalCreateObjectPool(objectType, string.Empty, allowMultiSpawn: false, expireTime, capacity, expireTime, priority);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, int capacity, float expireTime, int priority) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(name, allowMultiSpawn: false, expireTime, capacity, expireTime, priority);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, int capacity, float expireTime, int priority)
	{
		return InternalCreateObjectPool(objectType, name, allowMultiSpawn: false, expireTime, capacity, expireTime, priority);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, float autoReleaseInterval, int capacity, float expireTime, int priority) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(name, allowMultiSpawn: false, autoReleaseInterval, capacity, expireTime, priority);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, float autoReleaseInterval, int capacity, float expireTime, int priority)
	{
		return InternalCreateObjectPool(objectType, name, allowMultiSpawn: false, autoReleaseInterval, capacity, expireTime, priority);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>() where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(string.Empty, allowMultiSpawn: true, float.MaxValue, int.MaxValue, float.MaxValue, 0);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType)
	{
		return InternalCreateObjectPool(objectType, string.Empty, allowMultiSpawn: true, float.MaxValue, int.MaxValue, float.MaxValue, 0);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(name, allowMultiSpawn: true, float.MaxValue, int.MaxValue, float.MaxValue, 0);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name)
	{
		return InternalCreateObjectPool(objectType, name, allowMultiSpawn: true, float.MaxValue, int.MaxValue, float.MaxValue, 0);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(int capacity) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(string.Empty, allowMultiSpawn: true, float.MaxValue, capacity, float.MaxValue, 0);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, int capacity)
	{
		return InternalCreateObjectPool(objectType, string.Empty, allowMultiSpawn: true, float.MaxValue, capacity, float.MaxValue, 0);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(float expireTime) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(string.Empty, allowMultiSpawn: true, expireTime, int.MaxValue, expireTime, 0);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, float expireTime)
	{
		return InternalCreateObjectPool(objectType, string.Empty, allowMultiSpawn: true, expireTime, int.MaxValue, expireTime, 0);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, int capacity) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(name, allowMultiSpawn: true, float.MaxValue, capacity, float.MaxValue, 0);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, int capacity)
	{
		return InternalCreateObjectPool(objectType, name, allowMultiSpawn: true, float.MaxValue, capacity, float.MaxValue, 0);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, float expireTime) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(name, allowMultiSpawn: true, expireTime, int.MaxValue, expireTime, 0);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, float expireTime)
	{
		return InternalCreateObjectPool(objectType, name, allowMultiSpawn: true, expireTime, int.MaxValue, expireTime, 0);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(int capacity, float expireTime) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(string.Empty, allowMultiSpawn: true, expireTime, capacity, expireTime, 0);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, int capacity, float expireTime)
	{
		return InternalCreateObjectPool(objectType, string.Empty, allowMultiSpawn: true, expireTime, capacity, expireTime, 0);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(int capacity, int priority) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(string.Empty, allowMultiSpawn: true, float.MaxValue, capacity, float.MaxValue, priority);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, int capacity, int priority)
	{
		return InternalCreateObjectPool(objectType, string.Empty, allowMultiSpawn: true, float.MaxValue, capacity, float.MaxValue, priority);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(float expireTime, int priority) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(string.Empty, allowMultiSpawn: true, expireTime, int.MaxValue, expireTime, priority);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, float expireTime, int priority)
	{
		return InternalCreateObjectPool(objectType, string.Empty, allowMultiSpawn: true, expireTime, int.MaxValue, expireTime, priority);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, int capacity, float expireTime) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(name, allowMultiSpawn: true, expireTime, capacity, expireTime, 0);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, int capacity, float expireTime)
	{
		return InternalCreateObjectPool(objectType, name, allowMultiSpawn: true, expireTime, capacity, expireTime, 0);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, int capacity, int priority) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(name, allowMultiSpawn: true, float.MaxValue, capacity, float.MaxValue, priority);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, int capacity, int priority)
	{
		return InternalCreateObjectPool(objectType, name, allowMultiSpawn: true, float.MaxValue, capacity, float.MaxValue, priority);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, float expireTime, int priority) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(name, allowMultiSpawn: true, expireTime, int.MaxValue, expireTime, priority);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, float expireTime, int priority)
	{
		return InternalCreateObjectPool(objectType, name, allowMultiSpawn: true, expireTime, int.MaxValue, expireTime, priority);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(int capacity, float expireTime, int priority) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(string.Empty, allowMultiSpawn: true, expireTime, capacity, expireTime, priority);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, int capacity, float expireTime, int priority)
	{
		return InternalCreateObjectPool(objectType, string.Empty, allowMultiSpawn: true, expireTime, capacity, expireTime, priority);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, int capacity, float expireTime, int priority) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(name, allowMultiSpawn: true, expireTime, capacity, expireTime, priority);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, int capacity, float expireTime, int priority)
	{
		return InternalCreateObjectPool(objectType, name, allowMultiSpawn: true, expireTime, capacity, expireTime, priority);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, float autoReleaseInterval, int capacity, float expireTime, int priority) where T : ObjectBase
	{
		return InternalCreateObjectPool<T>(name, allowMultiSpawn: true, autoReleaseInterval, capacity, expireTime, priority);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, float autoReleaseInterval, int capacity, float expireTime, int priority)
	{
		return InternalCreateObjectPool(objectType, name, allowMultiSpawn: true, autoReleaseInterval, capacity, expireTime, priority);
	}

	public bool DestroyObjectPool<T>() where T : ObjectBase
	{
		return InternalDestroyObjectPool(new TypeNamePair(typeof(T)));
	}

	public bool DestroyObjectPool(Type objectType)
	{
		if (objectType == null)
		{
			throw new GameFrameworkException("Object type is invalid.");
		}
		if (!typeof(ObjectBase).IsAssignableFrom(objectType))
		{
			throw new GameFrameworkException(Utility.Text.Format("Object type '{0}' is invalid.", objectType.FullName));
		}
		return InternalDestroyObjectPool(new TypeNamePair(objectType));
	}

	public bool DestroyObjectPool<T>(string name) where T : ObjectBase
	{
		return InternalDestroyObjectPool(new TypeNamePair(typeof(T), name));
	}

	public bool DestroyObjectPool(Type objectType, string name)
	{
		if (objectType == null)
		{
			throw new GameFrameworkException("Object type is invalid.");
		}
		if (!typeof(ObjectBase).IsAssignableFrom(objectType))
		{
			throw new GameFrameworkException(Utility.Text.Format("Object type '{0}' is invalid.", objectType.FullName));
		}
		return InternalDestroyObjectPool(new TypeNamePair(objectType, name));
	}

	public bool DestroyObjectPool<T>(IObjectPool<T> objectPool) where T : ObjectBase
	{
		if (objectPool == null)
		{
			throw new GameFrameworkException("Object pool is invalid.");
		}
		return InternalDestroyObjectPool(new TypeNamePair(typeof(T), objectPool.Name));
	}

	public bool DestroyObjectPool(ObjectPoolBase objectPool)
	{
		if (objectPool == null)
		{
			throw new GameFrameworkException("Object pool is invalid.");
		}
		return InternalDestroyObjectPool(new TypeNamePair(objectPool.ObjectType, objectPool.Name));
	}

	public void Release()
	{
		GetAllObjectPools(sort: true, m_CachedAllObjectPools);
		foreach (ObjectPoolBase cachedAllObjectPool in m_CachedAllObjectPools)
		{
			cachedAllObjectPool.Release();
		}
	}

	public void ReleaseAllUnused()
	{
		GetAllObjectPools(sort: true, m_CachedAllObjectPools);
		foreach (ObjectPoolBase cachedAllObjectPool in m_CachedAllObjectPools)
		{
			cachedAllObjectPool.ReleaseAllUnused();
		}
	}

	private bool InternalHasObjectPool(TypeNamePair typeNamePair)
	{
		return m_ObjectPools.ContainsKey(typeNamePair);
	}

	private ObjectPoolBase InternalGetObjectPool(TypeNamePair typeNamePair)
	{
		ObjectPoolBase value = null;
		if (m_ObjectPools.TryGetValue(typeNamePair, out value))
		{
			return value;
		}
		return null;
	}

	private IObjectPool<T> InternalCreateObjectPool<T>(string name, bool allowMultiSpawn, float autoReleaseInterval, int capacity, float expireTime, int priority) where T : ObjectBase
	{
		TypeNamePair typeNamePair = new TypeNamePair(typeof(T), name);
		if (HasObjectPool<T>(name))
		{
			throw new GameFrameworkException(Utility.Text.Format("Already exist object pool '{0}'.", typeNamePair));
		}
		ObjectPool<T> objectPool = new ObjectPool<T>(name, allowMultiSpawn, autoReleaseInterval, capacity, expireTime, priority);
		m_ObjectPools.Add(typeNamePair, objectPool);
		return objectPool;
	}

	private ObjectPoolBase InternalCreateObjectPool(Type objectType, string name, bool allowMultiSpawn, float autoReleaseInterval, int capacity, float expireTime, int priority)
	{
		if (objectType == null)
		{
			throw new GameFrameworkException("Object type is invalid.");
		}
		if (!typeof(ObjectBase).IsAssignableFrom(objectType))
		{
			throw new GameFrameworkException(Utility.Text.Format("Object type '{0}' is invalid.", objectType.FullName));
		}
		TypeNamePair typeNamePair = new TypeNamePair(objectType, name);
		if (HasObjectPool(objectType, name))
		{
			throw new GameFrameworkException(Utility.Text.Format("Already exist object pool '{0}'.", typeNamePair));
		}
		Type type = typeof(ObjectPool<>).MakeGenericType(objectType);
		ObjectPoolBase objectPoolBase = (ObjectPoolBase)Activator.CreateInstance(type, name, allowMultiSpawn, autoReleaseInterval, capacity, expireTime, priority);
		m_ObjectPools.Add(typeNamePair, objectPoolBase);
		return objectPoolBase;
	}

	private bool InternalDestroyObjectPool(TypeNamePair typeNamePair)
	{
		ObjectPoolBase value = null;
		if (m_ObjectPools.TryGetValue(typeNamePair, out value))
		{
			value.Shutdown();
			return m_ObjectPools.Remove(typeNamePair);
		}
		return false;
	}

	private static int ObjectPoolComparer(ObjectPoolBase a, ObjectPoolBase b)
	{
		return a.Priority.CompareTo(b.Priority);
	}
}
