using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class CustomObjectPool : MonoBehaviour
{
	private Queue<GameObject> objectPoolQueue = new Queue<GameObject>();

	private List<GameObject> activeObjects = new List<GameObject>();

	private GameObject prefab;

	public void Initialize(GameObject prefab, int initialPoolSize)
	{
		this.prefab = prefab;
		for (int i = 0; i < initialPoolSize; i++)
		{
			CreateObjectInPool();
		}
	}

	private GameObject CreateObjectInPool()
	{
		GameObject gameObject = Object.Instantiate(prefab, Vector3.zero, Quaternion.identity);
		gameObject.SetActive(value: false);
		gameObject.transform.SetParent(transform);
		objectPoolQueue.Enqueue(gameObject);
		return gameObject;
	}

	public GameObject RetrieveObjectFromPool()
	{
		if (objectPoolQueue.Count == 0)
		{
			CreateObjectInPool();
		}
		GameObject gameObject = objectPoolQueue.Dequeue();
		gameObject.SetActive(value: true);
		activeObjects.Add(gameObject);
		EventBus.Trigger(ObjectPoolEvents.OnRetrieved, new PoolData(this, gameObject));
		return gameObject;
	}

	public void ReturnObjectToPool(GameObject obj)
	{
		obj.SetActive(value: false);
		activeObjects.Remove(obj);
		objectPoolQueue.Enqueue(obj);
		EventBus.Trigger(ObjectPoolEvents.OnReturned, new PoolData(this, obj));
	}

	public List<GameObject> GetActiveObjects()
	{
		return activeObjects;
	}
}
