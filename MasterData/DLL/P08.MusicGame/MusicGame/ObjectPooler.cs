using System.Collections.Generic;
using UnityEngine;

namespace MusicGame;

public class ObjectPooler : MonoBehaviour
{
	public List<ObjectPoolItem> itemsToPool;

	public Dictionary<string, ObjectPoolItem> itemDictionary;

	public Dictionary<string, List<GameObject>> pooledObjectsDictionary;

	public List<GameObject> pooledObjects;

	private Dictionary<string, int> positions;

	private void Awake()
	{
		itemDictionary = new Dictionary<string, ObjectPoolItem>();
		pooledObjectsDictionary = new Dictionary<string, List<GameObject>>();
		pooledObjects = new List<GameObject>();
		positions = new Dictionary<string, int>();
		for (int i = 0; i < itemsToPool.Count; i++)
		{
			ObjectPoolItemToPooledObject(i);
			itemDictionary.Add(itemsToPool[i].tag, itemsToPool[i]);
		}
	}

	public GameObject GetPooledObject(string tag)
	{
		int count = pooledObjectsDictionary[tag].Count;
		for (int i = positions[tag] + 1; i < positions[tag] + pooledObjectsDictionary[tag].Count; i++)
		{
			if (!pooledObjectsDictionary[tag][i % count].activeInHierarchy)
			{
				positions[tag] = i % count;
				return pooledObjectsDictionary[tag][i % count];
			}
		}
		if (itemDictionary[tag].shouldExpand)
		{
			GameObject gameObject = Object.Instantiate(itemDictionary[tag].objectToPool);
			gameObject.SetActive(value: false);
			gameObject.transform.SetParent(base.transform);
			pooledObjectsDictionary[tag].Add(gameObject);
			return gameObject;
		}
		return null;
	}

	public List<GameObject> GetAllPooledObjects(string tag)
	{
		return pooledObjectsDictionary[tag];
	}

	public void Store(GameObject go)
	{
		go.SetActive(value: false);
	}

	private void ObjectPoolItemToPooledObject(int index)
	{
		ObjectPoolItem objectPoolItem = itemsToPool[index];
		pooledObjects = new List<GameObject>();
		for (int i = 0; i < objectPoolItem.amountToPool; i++)
		{
			GameObject gameObject = Object.Instantiate(objectPoolItem.objectToPool);
			gameObject.SetActive(value: false);
			gameObject.transform.SetParent(base.transform);
			pooledObjects.Add(gameObject);
		}
		pooledObjectsDictionary.Add(objectPoolItem.tag, pooledObjects);
		positions.Add(objectPoolItem.tag, 0);
	}
}
