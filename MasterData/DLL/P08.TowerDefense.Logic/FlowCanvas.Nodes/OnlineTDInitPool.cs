using System.Collections.Generic;
using Config;
using Google.Protobuf;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[OnlineTD]初始化卡池", 0)]
[Category("Active/TowerDefense/Logic/Gacha")]
[Description("初始化卡池")]
public class OnlineTDInitPool : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> typeMax = AddValueInput<int>("卡池种类数量", "typeMax").SetDefaultAndSerializedValue(4);
		FlowOutput output = AddFlowOutput("初始化结束");
		AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			List<int>[] allGachaPool = GetAllGachaPool(typeMax.value);
			base.mSimContext.sEntityWorldState.status.m_tower_gacha_List = allGachaPool;
			output.Call(f);
		});
	}

	private List<int>[] GetAllGachaPool(int count)
	{
		List<int>[] array = new List<int>[count];
		for (int i = 0; i < count; i++)
		{
			array[i] = new List<int>();
		}
		foreach (KeyValuePair<int, IMessage> item in ConfigHelper.GetInstance().GetAllConfig(typeof(activity_online_tower)))
		{
			activity_online_tower activity_online_tower2 = item.Value as activity_online_tower;
			array[activity_online_tower2.Type].Add(activity_online_tower2.ID);
		}
		return array;
	}
}
