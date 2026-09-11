using System;
using System.Collections.Generic;
using FlowCanvas.Nodes;
using UnityEngine;

namespace FlowCanvas.Utils;

public class FlowCanvasStatUtil : MonoBehaviour
{
	public static bool checkFlowCanvasEmptyEvent = false;

	public static bool flowCanvasStat = false;

	private static Dictionary<string, double> _eventTotalCostDic = new Dictionary<string, double>();

	private static Dictionary<string, int> _eventCallCountDic = new Dictionary<string, int>();

	private static Dictionary<string, double> _valueTotalCostDic = new Dictionary<string, double>();

	private static Dictionary<string, int> _valueCallCountDic = new Dictionary<string, int>();

	private static Dictionary<string, FlowNode> _keyOfNode = new Dictionary<string, FlowNode>();

	private static Dictionary<string, string> _nodeNameOfKey = new Dictionary<string, string>();

	private static Dictionary<string, string> _portNameOfKey = new Dictionary<string, string>();

	private static Dictionary<string, Port> _keyOfPort = new Dictionary<string, Port>();

	private static DateTime _startDate = new DateTime(1970, 1, 1, 0, 0, 0, 0);

	private static TimeSpan _startTime = TimeSpan.Zero;

	private static TimeSpan _endTime = TimeSpan.Zero;

	private static Dictionary<int, FlowNode> _hashCodeOfFlowNode = new Dictionary<int, FlowNode>();

	private static Dictionary<int, double> _hashCodeOfExecuteTime = new Dictionary<int, double>();

	private static Dictionary<int, TimeSpan> _hashCodeOfStartTimeSpan = new Dictionary<int, TimeSpan>();

	private static Dictionary<string, double> _flowTotalCostDic = new Dictionary<string, double>();

	private static Dictionary<string, int> _flowCallCountDic = new Dictionary<string, int>();

	public static void OnCombatStart()
	{
		flowCanvasStat = PlayerPrefs.GetInt("FlowCanvasStat", 0) == 1;
		checkFlowCanvasEmptyEvent = PlayerPrefs.GetInt("FlowCanvasCheckEmptyEvent", 0) == 1;
		if (flowCanvasStat)
		{
			_startTime = Now();
			Debug.Log("FlowCanvas统计，战斗开始");
		}
	}

	public static void OnCombatEnd()
	{
		if (flowCanvasStat)
		{
			PrintEventCostData();
			ClearAll();
			flowCanvasStat = false;
		}
	}

	public static void OnFlowInput(FlowNode flowNode)
	{
		if (flowNode.name.IndexOf("延迟节点") < 0)
		{
			int hashCode = flowNode.GetHashCode();
			_hashCodeOfFlowNode[hashCode] = flowNode;
			_hashCodeOfStartTimeSpan[hashCode] = Now();
			_hashCodeOfExecuteTime[hashCode] = -1.0;
		}
	}

	public static void OnFlowOutput(FlowNode flowNode)
	{
		int hashCode = flowNode.GetHashCode();
		if (_hashCodeOfFlowNode.ContainsKey(hashCode))
		{
			double num = Now().TotalMilliseconds - _hashCodeOfStartTimeSpan[hashCode].TotalMilliseconds;
			_hashCodeOfExecuteTime[hashCode] = num;
			string nodeKey = GetNodeKey(flowNode);
			_keyOfNode[nodeKey] = flowNode;
			_nodeNameOfKey[nodeKey] = flowNode.name;
			if (!_flowCallCountDic.ContainsKey(nodeKey))
			{
				_flowCallCountDic[nodeKey] = 0;
				_flowTotalCostDic[nodeKey] = 0.0;
			}
			_flowCallCountDic[nodeKey]++;
			_flowTotalCostDic[nodeKey] += num;
		}
	}

	public static object StatValueNode(Port port, FlowNode node, Func<object> action)
	{
		TimeSpan timeSpan = Now();
		object result = action();
		TimeSpan timeSpan2 = Now();
		string portKey = GetPortKey(port);
		_keyOfPort[portKey] = port;
		_nodeNameOfKey[portKey] = node.name;
		_portNameOfKey[portKey] = port.name;
		if (!_valueCallCountDic.ContainsKey(portKey))
		{
			_valueCallCountDic[portKey] = 0;
			_valueTotalCostDic[portKey] = 0.0;
		}
		_valueCallCountDic[portKey]++;
		_valueTotalCostDic[portKey] += timeSpan2.TotalMilliseconds - timeSpan.TotalMilliseconds;
		return result;
	}

	public static void StatEvent(EventNode node, Action action)
	{
		if (node.name.IndexOf("地图初始化完成事件") >= 0)
		{
			action();
			return;
		}
		if (node.name.IndexOf("场景加载事件") >= 0)
		{
			action();
			return;
		}
		TimeSpan timeSpan = Now();
		action();
		TimeSpan timeSpan2 = Now();
		string nodeKey = GetNodeKey(node);
		_keyOfNode[nodeKey] = node;
		_nodeNameOfKey[nodeKey] = node.name;
		if (!_eventCallCountDic.ContainsKey(nodeKey))
		{
			_eventCallCountDic[nodeKey] = 0;
			_eventTotalCostDic[nodeKey] = 0.0;
		}
		_eventCallCountDic[nodeKey]++;
		_eventTotalCostDic[nodeKey] += timeSpan2.TotalMilliseconds - timeSpan.TotalMilliseconds;
	}

	private static string GetPortKey(Port port)
	{
		FlowNode parent = port.parent;
		return parent.UID + " : " + parent.graphAgent.name + " : " + parent.graph.name + " : " + parent.name + " : " + port.name;
	}

	private static string GetNodeKey(FlowNode node)
	{
		return node.graphAgent.name + " : " + node.graph.name + " : " + node.name;
	}

	public static void PrintEventCostData()
	{
		if (_eventCallCountDic.Count > 0 && _valueCallCountDic.Count > 0)
		{
			_endTime = Now();
			WriteToExcel();
		}
	}

	private static void WriteToExcel()
	{
	}

	public static void ClearAll()
	{
		_eventCallCountDic.Clear();
		_eventTotalCostDic.Clear();
		_keyOfNode.Clear();
		_nodeNameOfKey.Clear();
		_hashCodeOfFlowNode.Clear();
		_hashCodeOfStartTimeSpan.Clear();
		_hashCodeOfExecuteTime.Clear();
		_startTime = TimeSpan.Zero;
		_endTime = TimeSpan.Zero;
	}

	private static TimeSpan Now()
	{
		return DateTime.UtcNow - _startDate;
	}
}
