using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GuildActivityManager : MonoBehaviour
{
	private GuildActivityInputManager _inputManager;

	private GuildActivityCameraManager _cameraManager;

	private Action<int> _onNodeClick;

	private Action<int> _onBonusClick;

	private Action _onBgClick;

	private Action<int> _onLevelLoaded;

	private Action _onNodeTimer;

	private Dictionary<int, GuildActivityWarFieldLevel> _levelDic = new Dictionary<int, GuildActivityWarFieldLevel>(new IntComparer());

	public GuildActivitySelfData luaData;

	private int _curLevel;

	private int _timer;

	private bool _onWarField;

	public Dictionary<int, GuildActivityNodeData> dataOfNode;

	private GuildActivityWarFieldNode _selectedNode;

	private static GuildActivityManager _instance;

	private void Awake()
	{
		_instance = this;
		_inputManager = GetComponent<GuildActivityInputManager>();
		_cameraManager = GetComponent<GuildActivityCameraManager>();
		GuildActivityInputManager inputManager = _inputManager;
		inputManager.onSingleFingerMove = (Action<Vector2>)Delegate.Combine(inputManager.onSingleFingerMove, new Action<Vector2>(OnSingleFingerMove));
		dataOfNode = new Dictionary<int, GuildActivityNodeData>();
	}

	public void StartGame(int enterNodeId)
	{
		if (enterNodeId == 0)
		{
			enterNodeId = luaData.curNode;
		}
		_cameraManager.StartGame();
		_timer = FuncTimerManager.inst.CreateFuncTimer(OnTimer, 1f);
		for (int i = 0; i < _levelDic[_curLevel].nodes.Count; i++)
		{
			GuildActivityWarFieldNode guildActivityWarFieldNode = _levelDic[_curLevel].nodes[i];
			if (guildActivityWarFieldNode.id == enterNodeId)
			{
				_cameraManager.OnNodeClick(guildActivityWarFieldNode);
				break;
			}
		}
	}

	private void OnSingleFingerMove(Vector2 deltaPos)
	{
		ClickBg();
	}

	public GuildActivityWarFieldLevel LoadLevel(int level)
	{
		if (_curLevel != level && _levelDic.ContainsKey(_curLevel))
		{
			_levelDic[_curLevel].gameObject.SetActive(value: false);
		}
		GuildActivityWarFieldLevel component;
		if (_levelDic.ContainsKey(level))
		{
			_levelDic[level].gameObject.SetActive(value: true);
			component = _levelDic[level].gameObject.GetComponent<GuildActivityWarFieldLevel>();
		}
		else
		{
			component = UnityEngine.Object.Instantiate(Asset.Load<GameObject>($"GuildActivityUI/prefab/level{level}"), base.transform).GetComponent<GuildActivityWarFieldLevel>();
		}
		_levelDic[level] = component;
		_curLevel = level;
		_onLevelLoaded?.Invoke(level);
		int count = _levelDic[_curLevel].nodes.Count;
		for (int i = 0; i < count; i++)
		{
			GuildActivityWarFieldNode guildActivityWarFieldNode = _levelDic[_curLevel].nodes[i];
			if (dataOfNode.ContainsKey(guildActivityWarFieldNode.id))
			{
				GuildActivityNodeData data = dataOfNode[guildActivityWarFieldNode.id];
				switch (guildActivityWarFieldNode.nodeType)
				{
				case GuildActivityWarFieldNodeType.Boss:
					guildActivityWarFieldNode.GetComponent<GuildActivityWarFieldBossNodeUI>().SetData(data);
					break;
				case GuildActivityWarFieldNodeType.Normal:
					guildActivityWarFieldNode.GetComponent<GuildActivityWarFieldNormalNodeUI>().SetData(data);
					break;
				case GuildActivityWarFieldNodeType.Elite:
					guildActivityWarFieldNode.GetComponent<GuildActivityWarFieldEliteNodeUI>().SetData(data);
					break;
				}
			}
		}
		if (luaData != null)
		{
			GuildActivityWarFieldNode guildActivityWarFieldNode2 = null;
			for (int j = 0; j < count; j++)
			{
				GuildActivityWarFieldNode guildActivityWarFieldNode3 = _levelDic[_curLevel].nodes[j];
				if (guildActivityWarFieldNode3.id == luaData.spawnNodeIdList[_curLevel - 1])
				{
					guildActivityWarFieldNode2 = guildActivityWarFieldNode3;
				}
				UpdateNode(guildActivityWarFieldNode3);
			}
			if (guildActivityWarFieldNode2 != null)
			{
				_cameraManager.OnNodeClick(guildActivityWarFieldNode2);
			}
		}
		return component;
	}

	public void UpdateNodeData(GuildActivityNodeDataList dataList, bool isFirst = false)
	{
		try
		{
			luaData = dataList.selfData;
			for (int i = 0; i < dataList.dataList.Count; i++)
			{
				GuildActivityNodeData guildActivityNodeData = dataList.dataList[i];
				if (!dataOfNode.ContainsKey(guildActivityNodeData.id))
				{
					dataOfNode.Add(guildActivityNodeData.id, guildActivityNodeData);
				}
				else
				{
					dataOfNode[guildActivityNodeData.id] = guildActivityNodeData;
				}
				int count = _levelDic[_curLevel].nodes.Count;
				for (int j = 0; j < count; j++)
				{
					GuildActivityWarFieldNode guildActivityWarFieldNode = _levelDic[_curLevel].nodes[j];
					if (guildActivityWarFieldNode.id == dataList.dataList[i].id)
					{
						switch (guildActivityWarFieldNode.nodeType)
						{
						case GuildActivityWarFieldNodeType.Boss:
							guildActivityWarFieldNode.GetComponent<GuildActivityWarFieldBossNodeUI>().SetData(guildActivityNodeData);
							break;
						case GuildActivityWarFieldNodeType.Normal:
							guildActivityWarFieldNode.GetComponent<GuildActivityWarFieldNormalNodeUI>().SetData(guildActivityNodeData);
							break;
						case GuildActivityWarFieldNodeType.Elite:
							guildActivityWarFieldNode.GetComponent<GuildActivityWarFieldEliteNodeUI>().SetData(guildActivityNodeData);
							break;
						}
					}
				}
			}
			int count2 = _levelDic[_curLevel].nodes.Count;
			for (int k = 0; k < count2; k++)
			{
				UpdateNode(_levelDic[_curLevel].nodes[k]);
			}
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			throw;
		}
	}

	private void UpdateNode(GuildActivityWarFieldNode node)
	{
		switch (node.nodeType)
		{
		case GuildActivityWarFieldNodeType.Born:
			node.GetComponent<GuildActivityWarFieldBornNodeUI>().UpdateView();
			break;
		case GuildActivityWarFieldNodeType.Boss:
			node.GetComponent<GuildActivityWarFieldBossNodeUI>().UpdateView();
			break;
		case GuildActivityWarFieldNodeType.Normal:
			node.GetComponent<GuildActivityWarFieldNormalNodeUI>().UpdateView();
			break;
		case GuildActivityWarFieldNodeType.Elite:
			node.GetComponent<GuildActivityWarFieldEliteNodeUI>().UpdateView();
			break;
		}
	}

	public void SetOnWarField(bool onWarField)
	{
		_onWarField = onWarField;
		_cameraManager.SetOnWarField(onWarField);
	}

	public bool IsOnWarField()
	{
		return _onWarField;
	}

	public void SetZoom(float value)
	{
		_cameraManager.SetZoom(value);
	}

	public void ClickNode(GuildActivityWarFieldNode node)
	{
		if (_selectedNode != null)
		{
			_selectedNode.SetSelected(value: false);
		}
		_selectedNode = node;
		if (_selectedNode != null)
		{
			_selectedNode.SetSelected(value: true);
		}
		_cameraManager.OnNodeClick(node);
		_onNodeClick?.Invoke(node.id);
	}

	public void ClickBonusNode(GuildActivityWarFieldNode node)
	{
		_onBonusClick?.Invoke(node.id);
	}

	public void ClickBg()
	{
		if (_selectedNode != null)
		{
			_selectedNode.SetSelected(value: false);
		}
		_selectedNode = null;
		_onBgClick?.Invoke();
	}

	public void AddTimer(Action action)
	{
		_onNodeTimer = (Action)Delegate.Combine(_onNodeTimer, action);
	}

	public void RemoveTimer(Action action)
	{
		_onNodeTimer = (Action)Delegate.Remove(_onNodeTimer, action);
	}

	private void OnTimer()
	{
		_onNodeTimer?.Invoke();
	}

	public int GetServerTime()
	{
		return (int)(double)LuaHelper.CallFunction("GetServerTime")[0];
	}

	public bool IsNodeCanReach(int nodeId)
	{
		Stack openStack = new Stack();
		Dictionary<int, bool> closeDic = new Dictionary<int, bool>();
		GuildActivityWarFieldNode node = GetNode(nodeId);
		if (11004 == nodeId)
		{
			Debug.Log("11004");
		}
		return HandleNode1(nodeId, node, ref openStack, ref closeDic);
	}

	private bool HandleNode1(int fromId, GuildActivityWarFieldNode node, ref Stack openStack, ref Dictionary<int, bool> closeDic)
	{
		bool flag = dataOfNode.ContainsKey(node.id) && dataOfNode[node.id].myOccupiedTimestamp > 0;
		if (node.nodeType == GuildActivityWarFieldNodeType.Boss)
		{
			int num = node.map_id - 101;
			if (luaData.spawnNodeIdList.Count > num + 1)
			{
				flag = true;
			}
		}
		else if (node.nodeType == GuildActivityWarFieldNodeType.Born)
		{
			flag = luaData.spawnNodeIdList.IndexOf(node.id) >= 0;
		}
		if (flag)
		{
			return true;
		}
		if (openStack.Contains(node.id))
		{
			return false;
		}
		if (closeDic.ContainsKey(node.id))
		{
			return false;
		}
		bool flag2 = false;
		if (node.id == fromId && node.nodeType != GuildActivityWarFieldNodeType.Born)
		{
			flag2 = true;
		}
		else if (node.nodeType == GuildActivityWarFieldNodeType.Born)
		{
			flag2 = luaData.spawnNodeIdList.IndexOf(node.id) >= 0;
		}
		else if (dataOfNode.ContainsKey(node.id) && dataOfNode[node.id].occupied_num > 0)
		{
			flag2 = true;
		}
		else if (node.nodeType == GuildActivityWarFieldNodeType.Boss)
		{
			int num2 = node.map_id - 101;
			if (luaData.spawnNodeIdList.Count > num2 + 1)
			{
				flag2 = true;
			}
		}
		if (!flag2)
		{
			return false;
		}
		bool flag3 = false;
		openStack.Push(node.id);
		for (int i = 0; i < node.neighbours.Count; i++)
		{
			if (HandleNode1(fromId, node.neighbours[i], ref openStack, ref closeDic))
			{
				flag3 = true;
				break;
			}
		}
		if (!flag3)
		{
			closeDic[node.id] = true;
		}
		openStack.Pop();
		return flag3;
	}

	private GuildActivityWarFieldNode GetNode(int id)
	{
		List<GuildActivityWarFieldNode> nodes = _levelDic[_curLevel].nodes;
		for (int i = 0; i < nodes.Count; i++)
		{
			if (nodes[i].id == id)
			{
				return nodes[i];
			}
		}
		return null;
	}

	public void SetOnNodeClick(Action<int> onNodeClick)
	{
		_onNodeClick = onNodeClick;
	}

	public void SetOnBonusClick(Action<int> onBonusNodeClick)
	{
		_onBonusClick = onBonusNodeClick;
	}

	public void SetOnZoomByFingerHandler(Action<float> handler)
	{
		_cameraManager.SetOnZoomByFingerHandler(handler);
	}

	public void SetOnBgClick(Action onBgClick)
	{
		_onBgClick = onBgClick;
	}

	public void SetOnLevelLoaded(Action<int> handler)
	{
		_onLevelLoaded = handler;
	}

	public static GuildActivityManager GetInstance()
	{
		return _instance;
	}

	private void OnDestroy()
	{
		if (FuncTimerManager.inst != null)
		{
			FuncTimerManager.inst.RemoveFuncTimer(_timer);
		}
		_timer = 0;
		_instance = null;
	}
}
