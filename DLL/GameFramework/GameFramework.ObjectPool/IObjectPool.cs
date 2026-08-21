using System;

namespace GameFramework.ObjectPool;

public interface IObjectPool<T> where T : ObjectBase
{
	string Name { get; }

	string FullName { get; }

	Type ObjectType { get; }

	int Count { get; }

	int CanReleaseCount { get; }

	bool AllowMultiSpawn { get; }

	float AutoReleaseInterval { get; set; }

	int Capacity { get; set; }

	float ExpireTime { get; set; }

	int Priority { get; set; }

	void Register(T obj, bool spawned);

	bool CanSpawn();

	bool CanSpawn(string name);

	T Spawn();

	T Spawn(string name);

	void Unspawn(T obj);

	void Unspawn(object target);

	void SetLocked(T obj, bool locked);

	void SetLocked(object target, bool locked);

	void SetPriority(T obj, int priority);

	void SetPriority(object target, int priority);

	bool ReleaseObject(T obj);

	bool ReleaseObject(object target);

	void Release();

	void Release(int toReleaseCount);

	void Release(ReleaseObjectFilterCallback<T> releaseObjectFilterCallback);

	void Release(int toReleaseCount, ReleaseObjectFilterCallback<T> releaseObjectFilterCallback);

	void ReleaseAllUnused();
}
