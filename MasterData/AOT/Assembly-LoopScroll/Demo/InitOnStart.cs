using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Demo;

[RequireComponent(typeof(LoopScrollRect))]
[DisallowMultipleComponent]
public class InitOnStart : MonoBehaviour, LoopScrollPrefabSource, ILoopScrollDataSource
{
	public GameObject item;

	public int totalCount = -1;

	private Stack<Transform> pool = new Stack<Transform>();

	public GameObject GetObject(int index)
	{
		if (pool.Count == 0)
		{
			return UnityEngine.Object.Instantiate(item);
		}
		Transform transform = pool.Pop();
		transform.gameObject.SetActive(value: true);
		return transform.gameObject;
	}

	public void ReturnObject(Transform trans)
	{
		trans.SendMessage("ScrollCellReturn", SendMessageOptions.DontRequireReceiver);
		trans.gameObject.SetActive(value: false);
		trans.SetParent(transform, worldPositionStays: false);
		pool.Push(trans);
	}

	public void ProvideData(Transform transform, int idx)
	{
		transform.SendMessage("ScrollCellIndex", idx);
	}

	private void Start()
	{
		LoopScrollRect component = GetComponent<LoopScrollRect>();
		component.prefabSource = this;
		component.totalCount = totalCount;
		component.RefillCells();
	}

	public void ScrollCellIndex(int idx)
	{
		throw new NotImplementedException();
	}

	public void OnLoad(int idx)
	{
		throw new NotImplementedException();
	}

	public void OnShow()
	{
		throw new NotImplementedException();
	}

	public void OnHide()
	{
		throw new NotImplementedException();
	}

	public void OnUnLoad()
	{
		throw new NotImplementedException();
	}

	public void PlayCustomAnimation(float delaySecond)
	{
		throw new NotImplementedException();
	}

	public int GetIndex()
	{
		throw new NotImplementedException();
	}
}
