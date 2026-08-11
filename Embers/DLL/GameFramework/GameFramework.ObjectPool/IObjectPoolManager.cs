using System;
using System.Collections.Generic;

namespace GameFramework.ObjectPool;

public interface IObjectPoolManager
{
	int Count { get; }

	bool HasObjectPool<T>() where T : ObjectBase;

	bool HasObjectPool(Type objectType);

	bool HasObjectPool<T>(string name) where T : ObjectBase;

	bool HasObjectPool(Type objectType, string name);

	bool HasObjectPool(Predicate<ObjectPoolBase> condition);

	IObjectPool<T> GetObjectPool<T>() where T : ObjectBase;

	ObjectPoolBase GetObjectPool(Type objectType);

	IObjectPool<T> GetObjectPool<T>(string name) where T : ObjectBase;

	ObjectPoolBase GetObjectPool(Type objectType, string name);

	ObjectPoolBase GetObjectPool(Predicate<ObjectPoolBase> condition);

	ObjectPoolBase[] GetObjectPools(Predicate<ObjectPoolBase> condition);

	void GetObjectPools(Predicate<ObjectPoolBase> condition, List<ObjectPoolBase> results);

	ObjectPoolBase[] GetAllObjectPools();

	void GetAllObjectPools(List<ObjectPoolBase> results);

	ObjectPoolBase[] GetAllObjectPools(bool sort);

	void GetAllObjectPools(bool sort, List<ObjectPoolBase> results);

	IObjectPool<T> CreateSingleSpawnObjectPool<T>() where T : ObjectBase;

	ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType);

	IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name) where T : ObjectBase;

	ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name);

	IObjectPool<T> CreateSingleSpawnObjectPool<T>(int capacity) where T : ObjectBase;

	ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, int capacity);

	IObjectPool<T> CreateSingleSpawnObjectPool<T>(float expireTime) where T : ObjectBase;

	ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, float expireTime);

	IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, int capacity) where T : ObjectBase;

	ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, int capacity);

	IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, float expireTime) where T : ObjectBase;

	ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, float expireTime);

	IObjectPool<T> CreateSingleSpawnObjectPool<T>(int capacity, float expireTime) where T : ObjectBase;

	ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, int capacity, float expireTime);

	IObjectPool<T> CreateSingleSpawnObjectPool<T>(int capacity, int priority) where T : ObjectBase;

	ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, int capacity, int priority);

	IObjectPool<T> CreateSingleSpawnObjectPool<T>(float expireTime, int priority) where T : ObjectBase;

	ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, float expireTime, int priority);

	IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, int capacity, float expireTime) where T : ObjectBase;

	ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, int capacity, float expireTime);

	IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, int capacity, int priority) where T : ObjectBase;

	ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, int capacity, int priority);

	IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, float expireTime, int priority) where T : ObjectBase;

	ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, float expireTime, int priority);

	IObjectPool<T> CreateSingleSpawnObjectPool<T>(int capacity, float expireTime, int priority) where T : ObjectBase;

	ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, int capacity, float expireTime, int priority);

	IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, int capacity, float expireTime, int priority) where T : ObjectBase;

	ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, int capacity, float expireTime, int priority);

	IObjectPool<T> CreateSingleSpawnObjectPool<T>(string name, float autoReleaseInterval, int capacity, float expireTime, int priority) where T : ObjectBase;

	ObjectPoolBase CreateSingleSpawnObjectPool(Type objectType, string name, float autoReleaseInterval, int capacity, float expireTime, int priority);

	IObjectPool<T> CreateMultiSpawnObjectPool<T>() where T : ObjectBase;

	ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType);

	IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name) where T : ObjectBase;

	ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name);

	IObjectPool<T> CreateMultiSpawnObjectPool<T>(int capacity) where T : ObjectBase;

	ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, int capacity);

	IObjectPool<T> CreateMultiSpawnObjectPool<T>(float expireTime) where T : ObjectBase;

	ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, float expireTime);

	IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, int capacity) where T : ObjectBase;

	ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, int capacity);

	IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, float expireTime) where T : ObjectBase;

	ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, float expireTime);

	IObjectPool<T> CreateMultiSpawnObjectPool<T>(int capacity, float expireTime) where T : ObjectBase;

	ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, int capacity, float expireTime);

	IObjectPool<T> CreateMultiSpawnObjectPool<T>(int capacity, int priority) where T : ObjectBase;

	ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, int capacity, int priority);

	IObjectPool<T> CreateMultiSpawnObjectPool<T>(float expireTime, int priority) where T : ObjectBase;

	ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, float expireTime, int priority);

	IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, int capacity, float expireTime) where T : ObjectBase;

	ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, int capacity, float expireTime);

	IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, int capacity, int priority) where T : ObjectBase;

	ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, int capacity, int priority);

	IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, float expireTime, int priority) where T : ObjectBase;

	ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, float expireTime, int priority);

	IObjectPool<T> CreateMultiSpawnObjectPool<T>(int capacity, float expireTime, int priority) where T : ObjectBase;

	ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, int capacity, float expireTime, int priority);

	IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, int capacity, float expireTime, int priority) where T : ObjectBase;

	ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, int capacity, float expireTime, int priority);

	IObjectPool<T> CreateMultiSpawnObjectPool<T>(string name, float autoReleaseInterval, int capacity, float expireTime, int priority) where T : ObjectBase;

	ObjectPoolBase CreateMultiSpawnObjectPool(Type objectType, string name, float autoReleaseInterval, int capacity, float expireTime, int priority);

	bool DestroyObjectPool<T>() where T : ObjectBase;

	bool DestroyObjectPool(Type objectType);

	bool DestroyObjectPool<T>(string name) where T : ObjectBase;

	bool DestroyObjectPool(Type objectType, string name);

	bool DestroyObjectPool<T>(IObjectPool<T> objectPool) where T : ObjectBase;

	bool DestroyObjectPool(ObjectPoolBase objectPool);

	void Release();

	void ReleaseAllUnused();
}
