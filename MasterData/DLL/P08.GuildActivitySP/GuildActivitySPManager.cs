using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GuildActivitySPManager : MonoBehaviour
{
	private GuildActivitySPInputManager _spInputManager;

	private GuildActivitySPCameraManager _cameraManager;

	private Action<int> _onNodeClick;

	private Action<int> _onBonusClick;

	private Action _onBgClick;

	private Action<int> _onLevelLoaded;

	private Action _onNodeTimer;

	private Dictionary<int, GuildActivitySPWarFieldLevel> _levelDic = new Dictionary<int, GuildActivitySPWarFieldLevel>(new IntComparer());

	public GuildActivitySPSelfData luaData;

	private int _curLevel;

	private int _timer;

	private bool _onWarField;

	public Dictionary<int, GuildActivitySPNodeData> dataOfNode;

	private GuildActivitySPWarFieldNode _selectedNode;

	private static GuildActivitySPManager _instance;

	private void Awake()
	{
		_instance = this;
		_spInputManager = GetComponent<GuildActivitySPInputManager>();
		_cameraManager = GetComponent<GuildActivitySPCameraManager>();
		GuildActivitySPInputManager spInputManager = _spInputManager;
		spInputManager.onSingleFingerMove = (Action<Vector2>)Delegate.Combine(spInputManager.onSingleFingerMove, new Action<Vector2>(OnSingleFingerMove));
		dataOfNode = new Dictionary<int, GuildActivitySPNodeData>();
	}

	public void MoveCameraToNode(int enterNodeId, float time = 0.2f, float offset = 0.2f, Action onComplete = null)
	{
		for (int i = 0; i < _levelDic[_curLevel].nodes.Count; i++)
		{
			GuildActivitySPWarFieldNode guildActivitySPWarFieldNode = _levelDic[_curLevel].nodes[i];
			if (guildActivitySPWarFieldNode.id == enterNodeId)
			{
				_cameraManager.MoveCameraToNode(guildActivitySPWarFieldNode, _cameraManager.GetCameraMinSize(), time, offset, onComplete);
				break;
			}
		}
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
			GuildActivitySPWarFieldNode guildActivitySPWarFieldNode = _levelDic[_curLevel].nodes[i];
			if (guildActivitySPWarFieldNode.id == enterNodeId)
			{
				_cameraManager.OnNodeClick(guildActivitySPWarFieldNode);
				break;
			}
		}
	}

	private void OnSingleFingerMove(Vector2 deltaPos)
	{
		ClickBg();
	}

	public GuildActivitySPWarFieldLevel LoadLevel(int level, int activityID)
	{
		if (_curLevel != level && _levelDic.ContainsKey(_curLevel))
		{
			_levelDic[_curLevel].gameObject.SetActive(value: false);
		}
		GuildActivitySPWarFieldLevel component;
		if (_levelDic.ContainsKey(level))
		{
			_levelDic[level].gameObject.SetActive(value: true);
			component = _levelDic[level].gameObject.GetComponent<GuildActivitySPWarFieldLevel>();
		}
		else
		{
			component = UnityEngine.Object.Instantiate(Asset.Load<GameObject>($"GuildActivitySPUI/prefab/splevel_{activityID}_{level}"), base.transform).GetComponent<GuildActivitySPWarFieldLevel>();
		}
		_levelDic[level] = component;
		_cameraManager.InitCameraSetting(_levelDic[level].map_id);
		_curLevel = level;
		_onLevelLoaded?.Invoke(level);
		int count = _levelDic[_curLevel].nodes.Count;
		for (int i = 0; i < count; i++)
		{
			GuildActivitySPWarFieldNode guildActivitySPWarFieldNode = _levelDic[_curLevel].nodes[i];
			if (dataOfNode.ContainsKey(guildActivitySPWarFieldNode.id))
			{
				GuildActivitySPNodeData data = dataOfNode[guildActivitySPWarFieldNode.id];
				switch (guildActivitySPWarFieldNode.nodeType)
				{
				case GuildActivitySPWarFieldNodeType.BigBoss:
					guildActivitySPWarFieldNode.GetComponent<GuildActivitySPWarFieldBigBossNodeUI>().SetData(data);
					break;
				case GuildActivitySPWarFieldNodeType.SmallBoss:
					guildActivitySPWarFieldNode.GetComponent<GuildActivitySPWarFieldSmallBossNodeUI>().SetData(data);
					break;
				case GuildActivitySPWarFieldNodeType.Normal:
					guildActivitySPWarFieldNode.GetComponent<GuildActivitySPWarFieldNormalNodeUI>().SetData(data);
					break;
				case GuildActivitySPWarFieldNodeType.Elite:
					guildActivitySPWarFieldNode.GetComponent<GuildActivitySPWarFieldEliteNodeUI>().SetData(data);
					break;
				}
			}
		}
		if (luaData != null)
		{
			GuildActivitySPWarFieldNode guildActivitySPWarFieldNode2 = null;
			for (int j = 0; j < count; j++)
			{
				GuildActivitySPWarFieldNode guildActivitySPWarFieldNode3 = _levelDic[_curLevel].nodes[j];
				if (guildActivitySPWarFieldNode3.id == luaData.spawnNodeIdList[_curLevel - 1])
				{
					guildActivitySPWarFieldNode2 = guildActivitySPWarFieldNode3;
				}
				UpdateNode(guildActivitySPWarFieldNode3);
			}
			if (guildActivitySPWarFieldNode2 != null)
			{
				_cameraManager.OnNodeClick(guildActivitySPWarFieldNode2);
			}
		}
		return component;
	}

	public void UpdateNodeData(GuildActivitySPNodeDataList dataList, bool isFirst = false)
	{
		try
		{
			luaData = dataList.selfData;
			for (int i = 0; i < dataList.dataList.Count; i++)
			{
				GuildActivitySPNodeData guildActivitySPNodeData = dataList.dataList[i];
				if (!dataOfNode.ContainsKey(guildActivitySPNodeData.id))
				{
					dataOfNode.Add(guildActivitySPNodeData.id, guildActivitySPNodeData);
				}
				else
				{
					dataOfNode[guildActivitySPNodeData.id] = guildActivitySPNodeData;
				}
				int count = _levelDic[_curLevel].nodes.Count;
				for (int j = 0; j < count; j++)
				{
					GuildActivitySPWarFieldNode guildActivitySPWarFieldNode = _levelDic[_curLevel].nodes[j];
					if (guildActivitySPWarFieldNode.id == dataList.dataList[i].id)
					{
						switch (guildActivitySPWarFieldNode.nodeType)
						{
						case GuildActivitySPWarFieldNodeType.BigBoss:
							guildActivitySPWarFieldNode.GetComponent<GuildActivitySPWarFieldBigBossNodeUI>().SetData(guildActivitySPNodeData);
							break;
						case GuildActivitySPWarFieldNodeType.SmallBoss:
							guildActivitySPWarFieldNode.GetComponent<GuildActivitySPWarFieldSmallBossNodeUI>().SetData(guildActivitySPNodeData);
							break;
						case GuildActivitySPWarFieldNodeType.Normal:
							guildActivitySPWarFieldNode.GetComponent<GuildActivitySPWarFieldNormalNodeUI>().SetData(guildActivitySPNodeData);
							break;
						case GuildActivitySPWarFieldNodeType.Elite:
							guildActivitySPWarFieldNode.GetComponent<GuildActivitySPWarFieldEliteNodeUI>().SetData(guildActivitySPNodeData);
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

	private void UpdateNode(GuildActivitySPWarFieldNode node)
	{
		switch (node.nodeType)
		{
		case GuildActivitySPWarFieldNodeType.Born:
			node.GetComponent<GuildActivitySPWarFieldBornNodeUI>().UpdateView();
			break;
		case GuildActivitySPWarFieldNodeType.BigBoss:
			node.GetComponent<GuildActivitySPWarFieldBigBossNodeUI>().UpdateView();
			break;
		case GuildActivitySPWarFieldNodeType.SmallBoss:
			node.GetComponent<GuildActivitySPWarFieldSmallBossNodeUI>().UpdateView();
			break;
		case GuildActivitySPWarFieldNodeType.Normal:
			node.GetComponent<GuildActivitySPWarFieldNormalNodeUI>().UpdateView();
			break;
		case GuildActivitySPWarFieldNodeType.Elite:
			node.GetComponent<GuildActivitySPWarFieldEliteNodeUI>().UpdateView();
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

	public void ClickNode(GuildActivitySPWarFieldNode node)
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

	public void ClickBonusNode(GuildActivitySPWarFieldNode node)
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
		GuildActivitySPWarFieldNode node = GetNode(nodeId);
		if (11004 == nodeId)
		{
			Debug.Log("11004");
		}
		return HandleNode1(nodeId, node, ref openStack, ref closeDic);
	}

	private bool HandleNode1(int fromId, GuildActivitySPWarFieldNode node, ref Stack openStack, ref Dictionary<int, bool> closeDic)
	{
		bool flag = dataOfNode.ContainsKey(node.id) && dataOfNode[node.id].myDispatchTime > 0;
		if (node.nodeType == GuildActivitySPWarFieldNodeType.BigBoss)
		{
			int num = node.map_id - 101;
			if (luaData.spawnNodeIdList.Count > num + 1)
			{
				flag = true;
			}
		}
		else if (node.nodeType == GuildActivitySPWarFieldNodeType.SmallBoss && dataOfNode.ContainsKey(node.id) && dataOfNode[node.id].health <= 0)
		{
			flag = true;
		}
		else if (node.nodeType == GuildActivitySPWarFieldNodeType.Born)
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
		if (node.id == fromId && node.nodeType != GuildActivitySPWarFieldNodeType.Born)
		{
			flag2 = true;
		}
		else if (node.nodeType == GuildActivitySPWarFieldNodeType.Born)
		{
			flag2 = luaData.spawnNodeIdList.IndexOf(node.id) >= 0;
		}
		else if (dataOfNode.ContainsKey(node.id) && dataOfNode[node.id].is_occupied > 0)
		{
			flag2 = true;
		}
		else if (node.nodeType == GuildActivitySPWarFieldNodeType.BigBoss)
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

	public GuildActivitySPWarFieldNode GetNode(int id)
	{
		List<GuildActivitySPWarFieldNode> nodes = _levelDic[_curLevel].nodes;
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

	public static GuildActivitySPManager GetInstance()
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

	public void SetCanClickFlag(bool flag)
	{
		_spInputManager.canClick = flag;
	}
}
