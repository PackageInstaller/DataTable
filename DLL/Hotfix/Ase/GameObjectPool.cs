using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class GameObjectPool
{
	private GameObject templete;

	private int mInitCreateCount = 1;

	private List<GameObject> usedList = new List<GameObject>();

	private List<GameObject> pooledList = new List<GameObject>();

	private RectTransform mParent;

	public GameObjectPool(GameObject templete, RectTransform parent, int createCount = 0)
	{
		this.templete = templete;
		mInitCreateCount = createCount;
		mParent = parent;
		for (int i = 0; i < mInitCreateCount; i++)
		{
			Create(active: false);
		}
	}

	public GameObject Allocate()
	{
		GameObject gameObject = null;
		if (pooledList.Count > 0)
		{
			int count = pooledList.Count;
			gameObject = pooledList[count - 1];
			pooledList.RemoveAt(count - 1);
			usedList.Add(gameObject);
			gameObject.gameObject.SetActive(value: true);
		}
		else
		{
			gameObject = Create();
		}
		return gameObject;
	}

	public GameObject Allocate(out bool newCreate)
	{
		GameObject gameObject = null;
		newCreate = false;
		if (pooledList.Count > 0)
		{
			int count = pooledList.Count;
			gameObject = pooledList[count - 1];
			pooledList.RemoveAt(count - 1);
			usedList.Add(gameObject);
			gameObject.gameObject.SetActive(value: true);
		}
		else
		{
			newCreate = true;
			gameObject = Create();
		}
		return gameObject;
	}

	public GameObject AllocateNoActive(out bool newCreate)
	{
		GameObject gameObject = null;
		newCreate = false;
		if (pooledList.Count > 0)
		{
			int count = pooledList.Count;
			gameObject = pooledList[count - 1];
			pooledList.RemoveAt(count - 1);
			usedList.Add(gameObject);
		}
		else
		{
			newCreate = true;
			gameObject = Create();
		}
		return gameObject;
	}

	private GameObject Create(bool active = true)
	{
		GameObject gameObject = Object.Instantiate(templete, mParent);
		if (active)
		{
			usedList.Add(gameObject);
		}
		else
		{
			pooledList.Add(gameObject);
		}
		gameObject.SetActive(active);
		return gameObject;
	}

	public void Recycle(GameObject item)
	{
		item.SetActive(value: false);
		pooledList.Add(item);
	}

	public void RecycleAll()
	{
		int count = usedList.Count;
		if (count != 0)
		{
			for (int i = 0; i < count; i++)
			{
				Recycle(usedList[i]);
			}
			usedList.Clear();
		}
	}

	public List<GameObject> GetAll()
	{
		List<GameObject> list = new List<GameObject>();
		list.AddRange(usedList);
		list.AddRange(pooledList);
		return list;
	}

	public void Dispose()
	{
		RecycleAll();
		int count = pooledList.Count;
		for (int i = 0; i < count; i++)
		{
			Object.DestroyImmediate(pooledList[i].gameObject);
		}
		pooledList.Clear();
	}
}
