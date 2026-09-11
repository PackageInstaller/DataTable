using System.Collections.Generic;
using Config;
using Google.Protobuf;
using LuaInterface;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[TD]初始化炮塔列表", 0)]
[Category("Active/TowerDefense/Render/UI")]
[Description("PTUI")]
public class TDLuaData : FlowControlNodeOfRender
{
	private TowerPTUI ui;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (ui == null && !TowerDefensePtUI.TryGetPTUI(out ui))
			{
				errorOut.Call(f);
			}
			else
			{
				object[] array = LuaHelper.CallFunction("GetMardukePlane");
				if (array != null && array.Length != 0)
				{
					object[] array2 = (array[0] as LuaTable).ToArray();
					ui.m_unlockTowerList.Clear();
					for (int i = 0; i < array2.Length; i++)
					{
						ui.m_unlockTowerList.Add(int.Parse(array2[i].ToString()));
					}
				}
				else
				{
					Debug.LogError("=====>>>>> 没有升级数据,全部开放");
					ui.m_unlockTowerList.Clear();
					foreach (KeyValuePair<int, IMessage> item in ConfigHelper.GetInstance().GetAllConfig(typeof(activity_tower_defense_tower)))
					{
						ui.m_unlockTowerList.Add(item.Key);
					}
				}
				output.Call(f);
			}
		});
	}
}
