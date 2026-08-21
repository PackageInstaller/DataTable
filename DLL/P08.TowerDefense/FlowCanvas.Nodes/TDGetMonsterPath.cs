using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[TD]得到怪物途经点坐标组", 0)]
[Category("Active/TowerDefense/Render/UI")]
[Description("得到怪物途经点坐标组")]
public class TDGetMonsterPath : FlowControlNodeOfRender
{
	private List<Vector3> _list = new List<Vector3>(8);

	protected override void RegisterPorts()
	{
		ValueInput<int> startTriggerIDInput = AddValueInput<int>("起点触发器ID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddValueOutput("路径点坐标组", "posList", () => _list);
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_list.Clear();
			AddNextWayPoint(_list, startTriggerIDInput.value);
			if (_list.Count <= 0)
			{
				errorOut.Call(f);
			}
			else
			{
				output.Call(f);
			}
		});
	}

	private void AddNextWayPoint(List<Vector3> pList, int pTriggerID)
	{
		IBlackboard blackboard = base.mMapTriggers[pTriggerID].blackboard;
		Int3 value = blackboard.GetValue<Int3>("TRIGGER_POSITION");
		pList.Add((Vector3)value);
		List<int> value2 = blackboard.GetValue<List<int>>("TRIGGER_ENABLE");
		if (value2 != null && value2.Count > 0)
		{
			AddNextWayPoint(pList, value2[0]);
		}
	}
}
