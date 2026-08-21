using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

namespace MusicGame;

public class Track : EventTrigger
{
	private MusicController musicController;

	[SerializeField]
	private int dataIndex;

	private Queue<BaseNode> nodeList;

	public List<List<int>> trackData;

	public KeyCode keyID;

	public KeyCode othersKeyID;

	public GameObject clickEffect;

	public Transform nodeContent;

	public Transform effectContent;

	public ObjectPooler pool;

	private bool enableClick;

	private bool isLongNodeState;

	private int longNextHitTime;

	private int longEndTime;

	private int longStartTime;

	public int trackIndex;

	private BoxCollider boxCol;

	private bool isUseKey;

	public void Awake()
	{
		nodeList = new Queue<BaseNode>();
	}

	public void InitTrack(MusicController Controller, List<List<int>> gameData, int index)
	{
		musicController = Controller;
		trackData = gameData;
		trackIndex = index;
	}

	public void InitTrackKey(KeyCode keyID)
	{
		this.keyID = keyID;
		if (keyID >= KeyCode.Alpha0 && keyID <= KeyCode.Alpha9)
		{
			othersKeyID = keyID + 256 - 48;
		}
		else if (keyID == KeyCode.Return)
		{
			othersKeyID = KeyCode.KeypadEnter;
		}
		else
		{
			othersKeyID = keyID;
		}
	}

	public int GetShowTime()
	{
		return musicController.GetCurTime();
	}

	public int GetCheckTime()
	{
		return musicController.GetCurTime() - MusicController.judgeLatency;
	}

	public void ResetTrack()
	{
		dataIndex = 0;
		isLongNodeState = false;
		enableClick = false;
		clickEffect?.SetActive(value: false);
		while (nodeList.Count != 0)
		{
			nodeList.Dequeue().gameObject.SetActive(value: false);
		}
	}

	public void OnPause()
	{
		clickEffect?.SetActive(value: false);
	}

	public void Process()
	{
		while (dataIndex < trackData.Count && nodeList.Count < 10)
		{
			Spawn(dataIndex);
			dataIndex++;
		}
		int showTime = GetShowTime();
		foreach (BaseNode node in nodeList)
		{
			node.Process(showTime);
		}
		int checkTime = GetCheckTime();
		if (isLongNodeState)
		{
			if (checkTime > longNextHitTime && longNextHitTime <= longEndTime)
			{
				if (longNextHitTime == longStartTime)
				{
					NodeHit(MusicNodeHitRating.PerfectPlus, MusicNodeHitType.Long);
				}
				else
				{
					NodeHit(MusicNodeHitRating.PerfectPlus, MusicNodeHitType.LongPress);
				}
				longNextHitTime += MusicController.interval;
			}
			if (checkTime > longEndTime)
			{
				isLongNodeState = false;
			}
		}
		if (0 < nodeList.Count)
		{
			BaseNode baseNode = nodeList.Peek();
			if (baseNode.Check(checkTime, musicController.GetMusicLength()))
			{
				baseNode.gameObject.SetActive(value: false);
				nodeList.Dequeue();
			}
		}
	}

	public bool CheckOver()
	{
		return nodeList.Count == 0;
	}

	public bool CheckIsLongPress()
	{
		return isLongNodeState;
	}

	public void Spawn(int index)
	{
		List<int> list = trackData[index];
		GameObject pooledObject;
		if (list.Count == 2)
		{
			pooledObject = pool.GetPooledObject("long");
			LongNode component = pooledObject.GetComponent<LongNode>();
			component.StartNode(list[0], list[1]);
			nodeList.Enqueue(component);
		}
		else
		{
			pooledObject = pool.GetPooledObject("short");
			ShortNode component2 = pooledObject.GetComponent<ShortNode>();
			component2.StartNode(list[0]);
			nodeList.Enqueue(component2);
		}
		pooledObject.SetActive(value: true);
		pooledObject.transform.parent = ((null == nodeContent) ? base.transform : nodeContent);
		pooledObject.transform.localPosition = Vector3.up * 1000f;
	}

	public void SetClickEnable(bool value)
	{
		enableClick = value;
	}

	public static MusicNodeHitRating IsInArea(int curTime, int cmpTime)
	{
		if (curTime < cmpTime + MusicController.perfectPlusArea && curTime > cmpTime - MusicController.perfectPlusArea)
		{
			return MusicNodeHitRating.PerfectPlus;
		}
		if (curTime < cmpTime + MusicController.perfectArea && curTime > cmpTime - MusicController.perfectArea)
		{
			return MusicNodeHitRating.Perfect;
		}
		if (curTime < cmpTime + MusicController.goodArea && curTime > cmpTime - MusicController.goodArea)
		{
			return MusicNodeHitRating.Good;
		}
		return MusicNodeHitRating.Miss;
	}

	public void PressButton(bool pressOrRelease, bool isKeyDown = false)
	{
		if ((isUseKey && !isKeyDown) || !enableClick || (clickEffect.activeSelf & pressOrRelease))
		{
			return;
		}
		clickEffect?.SetActive(pressOrRelease);
		int checkTime = GetCheckTime();
		if (pressOrRelease)
		{
			if (0 >= nodeList.Count)
			{
				return;
			}
			BaseNode baseNode = nodeList.Peek();
			if (baseNode.GetNodeType() == NodeType.Short)
			{
				int reachTime = baseNode.reachTime;
				MusicNodeHitRating musicNodeHitRating = IsInArea(checkTime, reachTime);
				if (musicNodeHitRating != MusicNodeHitRating.Miss)
				{
					NodeHit(musicNodeHitRating, MusicNodeHitType.Short);
					baseNode.gameObject.SetActive(value: false);
					nodeList.Dequeue();
				}
			}
			else
			{
				if (NodeType.Long != baseNode.GetNodeType())
				{
					return;
				}
				LongNode longNode = (LongNode)baseNode;
				int startTime = longNode.startTime;
				if (!longNode.GetValid() || checkTime > startTime + MusicController.longStartArea || checkTime < startTime - MusicController.longStartArea)
				{
					return;
				}
				if (checkTime > startTime)
				{
					int num = Mathf.FloorToInt((checkTime - startTime) / MusicController.interval) + 1;
					for (int i = 0; i < num; i++)
					{
						NodeHit(MusicNodeHitRating.PerfectPlus, (i == 0) ? MusicNodeHitType.Long : MusicNodeHitType.LongPress);
					}
					longNextHitTime = startTime + num * MusicController.interval;
				}
				else
				{
					longNextHitTime = startTime;
				}
				longEndTime = longNode.reachTime;
				longStartTime = longNode.startTime;
				longNode.SetPressState(value: true);
				isLongNodeState = true;
			}
		}
		else
		{
			if (!isLongNodeState)
			{
				return;
			}
			if (checkTime > longEndTime - MusicController.longEndArea)
			{
				if (longEndTime >= longNextHitTime)
				{
					int num2 = Mathf.FloorToInt((longEndTime - longNextHitTime) / MusicController.interval) + 1;
					for (int j = 0; j < num2; j++)
					{
						NodeHit(MusicNodeHitRating.PerfectPlus, MusicNodeHitType.LongPress);
					}
				}
			}
			else
			{
				NodeHit(MusicNodeHitRating.Miss, MusicNodeHitType.None);
			}
			if (0 < nodeList.Count)
			{
				BaseNode baseNode2 = nodeList.Peek();
				if (NodeType.Long == baseNode2.GetNodeType())
				{
					LongNode obj = (LongNode)baseNode2;
					obj.ChangeValid(value: false);
					obj.SetPressState(value: false);
				}
				isLongNodeState = false;
			}
		}
	}

	private void NodeHit(MusicNodeHitRating rating, MusicNodeHitType hitTpye)
	{
		string value = string.Empty;
		if (MusicNodeHitRating.Good == rating)
		{
			value = ((!MusicController.isVertical) ? "good" : "good_vertical");
		}
		else if (MusicNodeHitRating.Perfect == rating || MusicNodeHitRating.PerfectPlus == rating)
		{
			value = ((!MusicController.isVertical) ? "perfect" : "perfect_vertical");
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
		LuaHelper.CallFunction("MusicToLuaBridge.MusicNodeHit", Convert.ToInt32(rating), Convert.ToInt32(hitTpye));
	}

	public void KeyPressCheck()
	{
		if (Input.GetKeyDown(keyID) || Input.GetKeyDown(othersKeyID))
		{
			isUseKey = true;
			PressButton(pressOrRelease: true, isKeyDown: true);
		}
		else if (Input.GetKeyUp(keyID) || Input.GetKeyUp(othersKeyID))
		{
			PressButton(pressOrRelease: false, isKeyDown: true);
			isUseKey = false;
		}
	}
}
