using System.Collections.Generic;
using UnityEngine;

namespace T0World;

public class T0WorldBubblePool
{
	private string _bubblePath = "T0World/Prefab/{0}/Interaction/T0Talk";

	private List<T0WorldBubble> bubbleEntitys;

	private Queue<T0WorldBubble> bubblePool;

	private List<T0InterationBubbleData> bubbleDataList;

	private bool isHide;

	public RectTransform bubbleCanvas;

	public RectTransform bubbleFollowUINode;

	public string bubblePath => string.Format(_bubblePath, T0WorldScene.Scene.characterID);

	public void Init(RectTransform bubbleCanvas, RectTransform bubbleFollowUINode)
	{
		this.bubbleCanvas = bubbleCanvas;
		this.bubbleFollowUINode = bubbleFollowUINode;
		bubbleEntitys = new List<T0WorldBubble>();
		bubblePool = new Queue<T0WorldBubble>();
		bubbleDataList = new List<T0InterationBubbleData>();
		isHide = false;
	}

	public void RegisterBubbleEntity(T0InterationBubbleData bubbleData)
	{
		bubbleDataList.Add(bubbleData);
		UpdateBubbleListShow();
	}

	public void RemoveBubbleEntity(T0InterationBubbleData bubbleData)
	{
		bubbleDataList.Remove(bubbleData);
		UpdateBubbleListShow();
	}

	public void UpdateBubbleListShow()
	{
		for (int i = 0; i < bubbleDataList.Count; i++)
		{
			T0InterationBubbleData t0InterationBubbleData = bubbleDataList[i];
			T0WorldBubble t0WorldBubble = ((i < bubbleEntitys.Count) ? bubbleEntitys[i] : GetBubble());
			if (t0InterationBubbleData.isFollowUI)
			{
				t0WorldBubble.transform.SetParent(bubbleFollowUINode);
			}
			else
			{
				t0WorldBubble.transform.SetParent(bubbleCanvas);
			}
			t0WorldBubble.RefreshBubbleShow(t0InterationBubbleData);
			t0WorldBubble.OnCreate();
		}
		for (int num = bubbleEntitys.Count; num > bubbleDataList.Count; num--)
		{
			T0WorldBubble t0WorldBubble2 = bubbleEntitys[num - 1];
			if ((bool)t0WorldBubble2)
			{
				t0WorldBubble2.OnReuse();
				bubbleEntitys.Remove(t0WorldBubble2);
				bubblePool.Enqueue(t0WorldBubble2);
			}
		}
	}

	public T0WorldBubble GetBubble()
	{
		T0WorldBubble t0WorldBubble = null;
		if (bubblePool.Count == 0)
		{
			GameObject gameObject = Asset.Instantiate(bubblePath);
			gameObject.transform.SetParent(bubbleFollowUINode);
			gameObject.transform.localScale = Vector3.one;
			gameObject.transform.localPosition = Vector3.zero;
			t0WorldBubble = gameObject.GetComponent<T0WorldBubble>();
		}
		else
		{
			t0WorldBubble = bubblePool.Dequeue();
		}
		bubbleEntitys.Add(t0WorldBubble);
		return t0WorldBubble;
	}

	public void Dispose()
	{
		if (bubbleEntitys != null)
		{
			foreach (T0WorldBubble bubbleEntity in bubbleEntitys)
			{
				bubbleEntity.Dispose();
			}
			bubbleEntitys.Clear();
			bubbleEntitys = null;
		}
		if (bubblePool != null)
		{
			foreach (T0WorldBubble item in bubblePool)
			{
				item.Dispose();
			}
			bubblePool.Clear();
			bubblePool = null;
		}
		if (bubbleDataList != null)
		{
			bubbleDataList.Clear();
			bubbleDataList = null;
		}
	}
}
