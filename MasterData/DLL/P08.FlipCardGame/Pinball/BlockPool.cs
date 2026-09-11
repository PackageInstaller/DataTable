using System;
using System.Collections.Generic;
using UnityEngine;

namespace Pinball;

public class BlockPool : MonoBehaviour
{
	private static BlockPool _instance;

	private Dictionary<PolygonType, Queue<GameObject>> _blockPools = new Dictionary<PolygonType, Queue<GameObject>>();

	private List<GameObject> _blockTemplates;

	private Transform _blockRoot;

	private Transform _poolRoot;

	public static BlockPool Instance
	{
		get
		{
			if (_instance == null)
			{
				GameObject obj = GameObject.Find("PinballPlayArea/BlockPool");
				_instance = obj.AddComponent<BlockPool>();
				UnityEngine.Object.DontDestroyOnLoad(obj);
			}
			return _instance;
		}
	}

	public void Initialize(List<GameObject> blockTemplates, Transform blockRoot)
	{
		_blockTemplates = blockTemplates;
		_blockRoot = blockRoot;
		_poolRoot = new GameObject("BlockPoolRoot").transform;
		_poolRoot.SetParent(base.transform);
		_poolRoot.localPosition = Vector3.zero;
		foreach (PolygonType value in Enum.GetValues(typeof(PolygonType)))
		{
			if (value != PolygonType.None && value - 1 >= PolygonType.None && (int)(value - 1) < blockTemplates.Count)
			{
				_blockPools[value] = new Queue<GameObject>();
			}
		}
	}

	public GameObject GetBlock(PolygonType type)
	{
		GameObject gameObject = null;
		if (type == PolygonType.None || !_blockPools.ContainsKey(type))
		{
			Debug.LogWarning($"Invalid block type: {type}");
			return null;
		}
		if (_blockPools[type].Count > 0)
		{
			gameObject = _blockPools[type].Dequeue();
			if (_blockRoot != null)
			{
				gameObject.transform.SetParent(_blockRoot);
			}
			gameObject.SetActive(value: true);
		}
		else
		{
			int num = (int)(type - 1);
			if (num >= 0 && num < _blockTemplates.Count)
			{
				gameObject = UnityEngine.Object.Instantiate(_blockTemplates[num], _blockRoot);
				gameObject.transform.localPosition = Vector3.zero;
				gameObject.transform.localRotation = Quaternion.identity;
				gameObject.AddComponent<BlockPoolItem>().Initialize(type);
			}
			else
			{
				Debug.LogError($"No template found for block type: {type}");
			}
		}
		return gameObject;
	}

	public void ReturnBlock(GameObject blockGo)
	{
		if (blockGo == null)
		{
			return;
		}
		BlockPoolItem component = blockGo.GetComponent<BlockPoolItem>();
		if (component != null && _blockPools.ContainsKey(component.BlockType))
		{
			blockGo.SetActive(value: false);
			if (_poolRoot != null)
			{
				blockGo.transform.SetParent(_poolRoot);
			}
			blockGo.transform.localPosition = Vector3.zero;
			blockGo.transform.localRotation = Quaternion.identity;
			ParticleSystem[] componentsInChildren = blockGo.GetComponentsInChildren<ParticleSystem>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				componentsInChildren[i].Stop();
			}
			_blockPools[component.BlockType].Enqueue(blockGo);
		}
		else
		{
			UnityEngine.Object.Destroy(blockGo);
		}
	}

	public void ClearPool(PolygonType type)
	{
		if (!_blockPools.ContainsKey(type))
		{
			return;
		}
		while (_blockPools[type].Count > 0)
		{
			GameObject gameObject = _blockPools[type].Dequeue();
			if (gameObject != null)
			{
				UnityEngine.Object.Destroy(gameObject);
			}
		}
	}

	public void ClearAllPools()
	{
		foreach (PolygonType key in _blockPools.Keys)
		{
			ClearPool(key);
		}
	}

	public int GetPoolCount(PolygonType type)
	{
		if (_blockPools.ContainsKey(type))
		{
			return _blockPools[type].Count;
		}
		return 0;
	}

	private void OnDestroy()
	{
		ClearAllPools();
	}
}
