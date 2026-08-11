#define ENABLE_FATAL_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework.ObjectPool;
using UnityEngine;

namespace GameFramework.Runtime;

[DisallowMultipleComponent]
[AddComponentMenu("Game Framework/Object Pool")]
public sealed class ObjectPoolComponent : GameFrameworkComponent
{
	private IObjectPoolManager m_ObjectPoolManager = null;

	public int Count => m_ObjectPoolManager.Count;

	protected override void Awake()
	{
		base.Awake();
		m_ObjectPoolManager = GameFrameworkEntry.GetModule<IObjectPoolManager>();
		if (m_ObjectPoolManager == null)
		{
			Log.Fatal("Object pool manager is invalid.");
		}
	}

	public bool HasObjectPool<T>() where T : ObjectBase
	{
		return m_ObjectPoolManager.HasObjectPool<T>();
	}

	public bool HasObjectPool(Type objectType)
	{
		return m_ObjectPoolManager.HasObjectPool(objectType);
	}

	public bool HasObjectPool<T>(string name) where T : ObjectBase
	{
		return m_ObjectPoolManager.HasObjectPool<T>(name);
	}

	public bool HasObjectPool(Type objectType, string name)
	{
		return m_ObjectPoolManager.HasObjectPool(objectType, name);
	}

	public bool HasObjectPool(Predicate<ObjectPoolBase> condition)
	{
		return m_ObjectPoolManager.HasObjectPool(condition);
	}

	public IObjectPool<T> GetObjectPool<T>() where T : ObjectBase
	{
		return m_ObjectPoolManager.GetObjectPool<T>();
	}

	public ObjectPoolBase GetObjectPool(Type objectType)
	{
		return m_ObjectPoolManager.GetObjectPool(objectType);
	}

	public IObjectPool<T> GetObjectPool<T>(string name) where T : ObjectBase
	{
		return m_ObjectPoolManager.GetObjectPool<T>(name);
	}

	public ObjectPoolBase GetObjectPool(Type objectType, string name)
	{
		return m_ObjectPoolManager.GetObjectPool(objectType, name);
	}

	public ObjectPoolBase GetObjectPool(Predicate<ObjectPoolBase> condition)
	{
		return m_ObjectPoolManager.GetObjectPool(condition);
	}

	public ObjectPoolBase[] GetObjectPools(Predicate<ObjectPoolBase> condition)
	{
		return m_ObjectPoolManager.GetObjectPools(condition);
	}

	public void GetObjectPools(Predicate<ObjectPoolBase> condition, List<ObjectPoolBase> results)
	{
		m_ObjectPoolManager.GetObjectPools(condition, results);
	}

	public ObjectPoolBase[] GetAllObjectPools()
	{
		return m_ObjectPoolManager.GetAllObjectPools();
	}

	public void GetAllObjectPools(List<ObjectPoolBase> results)
	{
		m_ObjectPoolManager.GetAllObjectPools(results);
	}

	public ObjectPoolBase[] GetAllObjectPools(bool sort)
	{
		return m_ObjectPoolManager.GetAllObjectPools(sort);
	}

	public void GetAllObjectPools(bool sort, List<ObjectPoolBase> results)
	{
		m_ObjectPoolManager.GetAllObjectPools(sort, results);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>() where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool<T>();
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType)
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool(objectType);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool<T>(name);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name)
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool(objectType, name);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(int capacity) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool<T>(capacity);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, int capacity)
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool(objectType, capacity);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(float expireTime) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool<T>(expireTime);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, float expireTime)
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool(objectType, expireTime);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, int capacity) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool<T>(name, capacity);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, int capacity)
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool(objectType, name, capacity);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, float expireTime) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool<T>(name, expireTime);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, float expireTime)
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool(objectType, name, expireTime);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(int capacity, float expireTime) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool<T>(capacity, expireTime);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, int capacity, float expireTime)
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool(objectType, capacity, expireTime);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(int capacity, int priority) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool<T>(capacity, priority);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, int capacity, int priority)
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool(objectType, capacity, priority);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(float expireTime, int priority) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool<T>(expireTime, priority);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, float expireTime, int priority)
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool(objectType, expireTime, priority);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, int capacity, float expireTime) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool<T>(name, capacity, expireTime);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, int capacity, float expireTime)
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool(objectType, name, capacity, expireTime);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, int capacity, int priority) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool<T>(name, capacity, priority);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, int capacity, int priority)
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool(objectType, name, capacity, priority);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, float expireTime, int priority) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool<T>(name, expireTime, priority);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, float expireTime, int priority)
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool(objectType, name, expireTime, priority);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(int capacity, float expireTime, int priority) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool<T>(capacity, expireTime, priority);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, int capacity, float expireTime, int priority)
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool(objectType, capacity, expireTime, priority);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, int capacity, float expireTime, int priority) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool<T>(name, capacity, expireTime, priority);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, int capacity, float expireTime, int priority)
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool(objectType, name, capacity, expireTime, priority);
	}

	public IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, float autoReleaseInterval, int capacity, float expireTime, int priority) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool<T>(name, autoReleaseInterval, capacity, expireTime, priority);
	}

	public ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, float autoReleaseInterval, int capacity, float expireTime, int priority)
	{
		return m_ObjectPoolManager.CreateSingleSpawnObjectPool(objectType, name, autoReleaseInterval, capacity, expireTime, priority);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>() where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool<T>();
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType)
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool(objectType);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool<T>(name);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name)
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool(objectType, name);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(int capacity) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool<T>(capacity);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, int capacity)
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool(objectType, capacity);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(float expireTime) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool<T>(expireTime);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, float expireTime)
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool(objectType, expireTime);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, int capacity) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool<T>(name, capacity);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, int capacity)
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool(objectType, name, capacity);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, float expireTime) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool<T>(name, expireTime);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, float expireTime)
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool(objectType, name, expireTime);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(int capacity, float expireTime) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool<T>(capacity, expireTime);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, int capacity, float expireTime)
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool(objectType, capacity, expireTime);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(int capacity, int priority) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool<T>(capacity, priority);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, int capacity, int priority)
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool(objectType, capacity, priority);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(float expireTime, int priority) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool<T>(expireTime, priority);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, float expireTime, int priority)
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool(objectType, expireTime, priority);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, int capacity, float expireTime) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool<T>(name, capacity, expireTime);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, int capacity, float expireTime)
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool(objectType, name, capacity, expireTime);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, int capacity, int priority) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool<T>(name, capacity, priority);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, int capacity, int priority)
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool(objectType, name, capacity, priority);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, float expireTime, int priority) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool<T>(name, expireTime, priority);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, float expireTime, int priority)
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool(objectType, name, expireTime, priority);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(int capacity, float expireTime, int priority) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool<T>(capacity, expireTime, priority);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, int capacity, float expireTime, int priority)
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool(objectType, capacity, expireTime, priority);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, int capacity, float expireTime, int priority) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool<T>(name, capacity, expireTime, priority);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, int capacity, float expireTime, int priority)
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool(objectType, name, capacity, expireTime, priority);
	}

	public IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, float autoReleaseInterval, int capacity, float expireTime, int priority) where T : ObjectBase
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool<T>(name, autoReleaseInterval, capacity, expireTime, priority);
	}

	public ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, float autoReleaseInterval, int capacity, float expireTime, int priority)
	{
		return m_ObjectPoolManager.CreateMultiSpawnObjectPool(objectType, name, autoReleaseInterval, capacity, expireTime, priority);
	}

	public bool DestroyObjectPool<T>() where T : ObjectBase
	{
		return m_ObjectPoolManager.DestroyObjectPool<T>();
	}

	public bool DestroyObjectPool(Type objectType)
	{
		return m_ObjectPoolManager.DestroyObjectPool(objectType);
	}

	public bool DestroyObjectPool<T>(string name) where T : ObjectBase
	{
		return m_ObjectPoolManager.DestroyObjectPool<T>(name);
	}

	public bool DestroyObjectPool(Type objectType, string name)
	{
		return m_ObjectPoolManager.DestroyObjectPool(objectType, name);
	}

	public bool DestroyObjectPool<T>(IObjectPool<T> objectPool) where T : ObjectBase
	{
		return m_ObjectPoolManager.DestroyObjectPool(objectPool);
	}

	public bool DestroyObjectPool(ObjectPoolBase objectPool)
	{
		return m_ObjectPoolManager.DestroyObjectPool(objectPool);
	}

	public void Release()
	{
		m_ObjectPoolManager.Release();
	}

	public void ReleaseAllUnused()
	{
		m_ObjectPoolManager.ReleaseAllUnused();
	}
}
