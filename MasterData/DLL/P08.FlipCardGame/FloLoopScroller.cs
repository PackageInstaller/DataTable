using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(LoopScrollRect))]
[DisallowMultipleComponent]
public sealed class FloLoopScroller : MonoBehaviour, LoopScrollPrefabSource, LoopScrollDataSource
{
	public GameObject item;

	public float loopRange = 1000f;

	private LoopScrollRect _loopScrollRect;

	private Stack<Transform> pool = new Stack<Transform>();

	private bool _inited;

	public LoopScrollRect loopScrollRect => _loopScrollRect;

	public float curValue
	{
		get
		{
			_loopScrollRect.GetVerticalOffsetAndSize(out var _, out var offset);
			return offset / loopRange;
		}
	}

	public void InitRandomValue()
	{
		Init();
		int index = Random.Range(10, 1000);
		_loopScrollRect.ScrollToCellWithinTime(index, 0f);
	}

	public GameObject GetObject(int index)
	{
		if (pool.Count == 0)
		{
			return Object.Instantiate(item);
		}
		Transform obj = pool.Pop();
		obj.gameObject.SetActive(value: true);
		return obj.gameObject;
	}

	public void ReturnObject(Transform trans)
	{
		trans.gameObject.SetActive(value: false);
		trans.SetParent(base.transform, worldPositionStays: false);
		pool.Push(trans);
	}

	public void ProvideData(Transform transform, int idx)
	{
	}

	private void Awake()
	{
		_loopScrollRect = GetComponent<LoopScrollRect>();
	}

	private void Start()
	{
		Init();
	}

	private void Init()
	{
		if (!_inited)
		{
			_inited = true;
			LoopScrollRect obj = _loopScrollRect;
			obj.prefabSource = this;
			obj.dataSource = this;
			obj.totalCount = -1;
			obj.RefillCells();
			item.SetActive(value: false);
		}
	}
}
