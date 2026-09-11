using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

namespace MusicGame;

public class MusicSetTrack : EventTrigger
{
	private MusicSetController musicController;

	[SerializeField]
	private int dataIndex;

	private Queue<BaseNode> nodeList;

	public List<List<int>> trackData;

	public GameObject clickEffect;

	public Transform nodeContent;

	public Transform effectContent;

	public ObjectPooler pool;

	public void Awake()
	{
		nodeList = new Queue<BaseNode>();
	}

	public void InitTrack(MusicSetController Controller, List<List<int>> gameData)
	{
		musicController = Controller;
		trackData = gameData;
	}

	public int GetShowTime()
	{
		return musicController.GetCurTime();
	}

	public int GetCheckTime()
	{
		return musicController.GetCurTime() - MusicSetController.judgeLatency;
	}

	public void ResetTrack()
	{
		dataIndex = 0;
		clickEffect?.SetActive(value: false);
		while (nodeList.Count != 0)
		{
			nodeList.Dequeue().gameObject.SetActive(value: false);
		}
	}

	public void Process()
	{
		while (nodeList.Count < 10)
		{
			int num = dataIndex % trackData.Count;
			int round = (dataIndex - num) / trackData.Count;
			Spawn(round, num);
			dataIndex++;
		}
		int showTime = GetShowTime();
		foreach (BaseNode node in nodeList)
		{
			node.Process(showTime);
		}
		int checkTime = GetCheckTime();
		if (0 < nodeList.Count)
		{
			BaseNode baseNode = nodeList.Peek();
			if (baseNode.Check(checkTime, 0))
			{
				baseNode.gameObject.SetActive(value: false);
				nodeList.Dequeue();
			}
		}
	}

	public void Spawn(int round, int index)
	{
		List<int> list = trackData[index];
		if (list.Count == 1)
		{
			GameObject pooledObject = pool.GetPooledObject("short");
			MusicSetShortNode component = pooledObject.GetComponent<MusicSetShortNode>();
			int num = list[0];
			int mEndTime = round * musicController.song_duration + num;
			component.StartNode(round, mEndTime);
			nodeList.Enqueue(component);
			pooledObject.SetActive(value: true);
			pooledObject.transform.parent = ((null == nodeContent) ? base.transform : nodeContent);
			pooledObject.transform.localPosition = Vector3.up * 1000f;
		}
	}

	public override void OnPointerDown(PointerEventData eventData)
	{
		PressButton(pressOrRelease: true);
	}

	public override void OnPointerUp(PointerEventData eventData)
	{
		PressButton(pressOrRelease: false);
	}

	public void PressButton(bool pressOrRelease)
	{
		if (musicController.autoClick)
		{
			return;
		}
		clickEffect?.SetActive(pressOrRelease);
		int checkTime = GetCheckTime();
		if (!pressOrRelease || 0 >= nodeList.Count)
		{
			return;
		}
		BaseNode baseNode = nodeList.Peek();
		if (baseNode.GetNodeType() == NodeType.Short)
		{
			int reachTime = baseNode.reachTime;
			MusicNodeHitRating musicNodeHitRating = Track.IsInArea(checkTime, reachTime);
			if (musicNodeHitRating != MusicNodeHitRating.Miss)
			{
				NodeHit(musicNodeHitRating, MusicNodeHitType.Short);
				baseNode.gameObject.SetActive(value: false);
				nodeList.Dequeue();
			}
		}
	}

	private void NodeHit(MusicNodeHitRating rating, MusicNodeHitType hitTpye)
	{
		if (musicController.isLoadingSheet())
		{
			return;
		}
		string value = string.Empty;
		if (MusicNodeHitRating.Good == rating)
		{
			value = ((MusicSetController.trackType != MusicTrackType.Vertical) ? "good" : "good_vertical");
		}
		else if (MusicNodeHitRating.Perfect == rating || MusicNodeHitRating.PerfectPlus == rating)
		{
			value = ((MusicSetController.trackType != MusicTrackType.Vertical) ? "perfect" : "perfect_vertical");
		}
		if (!string.IsNullOrEmpty(value))
		{
			GameObject pooledObject = pool.GetPooledObject(value);
			if (null != pooledObject)
			{
				pooledObject.SetActive(value: true);
				pooledObject.transform.parent = ((null == effectContent) ? base.transform : effectContent);
				pooledObject.transform.localPosition = Vector3.zero;
				pooledObject.transform.localEulerAngles = Vector3.zero;
			}
		}
		MusicNodeHit(rating, hitTpye);
	}

	public static void MusicNodeHit(MusicNodeHitRating rating, MusicNodeHitType hitTpye)
	{
		LuaHelper.CallFunction("MusicToLuaBridge.MusicSetNodeHit", Convert.ToInt32(rating), Convert.ToInt32(hitTpye));
	}

	private void Update()
	{
		if (!musicController.autoClick || nodeList == null || nodeList.Count == 0)
		{
			return;
		}
		BaseNode baseNode = nodeList.Peek();
		if (null == baseNode)
		{
			return;
		}
		int checkTime = GetCheckTime();
		int reachTime = baseNode.reachTime;
		if (reachTime <= checkTime)
		{
			MusicNodeHitRating musicNodeHitRating = Track.IsInArea(checkTime, reachTime);
			if (musicNodeHitRating != MusicNodeHitRating.Miss)
			{
				NodeHit(musicNodeHitRating, MusicNodeHitType.Short);
				baseNode.gameObject.SetActive(value: false);
				nodeList.Dequeue();
			}
		}
	}
}
