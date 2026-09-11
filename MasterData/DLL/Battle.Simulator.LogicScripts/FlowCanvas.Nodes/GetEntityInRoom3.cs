using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("遍历处理房间内的玩家(机制类型)", 0)]
[Category("Logic/PosAndRot")]
[Description("遍历处理房间内的玩家, AI也算; \ncount 就是符合条件的合计数量，每次调用也可以放心使用;\n过滤仅对有机制类型生效:\n0 - 无过滤;\n1 - 机制值满")]
public class GetEntityInRoom3 : FlowControlNodeOfLogic
{
	private ValueInput<int> _WithoutEntityIDInput;

	private ValueInput<bool> _includeHpZoreInput;

	private ValueInput<EnergyType> _energyTypeInput;

	private ValueInput<int> _filterInput;

	private List<int> list;

	private int res;

	private int count;

	private int energyTypeCount;

	protected override void RegisterPorts()
	{
		_WithoutEntityIDInput = AddValueInput<int>("排除实体ID", "withoutID").SetDefaultAndSerializedValue(-1);
		_includeHpZoreInput = AddValueInput<bool>("包含血量为0的实体", "includeHpZore").SetDefaultAndSerializedValue(v: false);
		_energyTypeInput = AddValueInput<EnergyType>("机制类型", "energyType");
		_filterInput = AddValueInput<int>("过滤(看备注)", "filter").SetDefaultAndSerializedValue(0);
		AddValueOutput("实体ID", "entityID", () => res);
		AddValueOutput("数量", "count", () => count);
		AddValueOutput("几种机制类型", "energyTypeCount", () => energyTypeCount);
		FlowOutput doOut = AddFlowOutput("Do");
		FlowOutput doneOut = AddFlowOutput("Done");
		AddFlowInput("", delegate(Flow f)
		{
			res = 0;
			count = 0;
			energyTypeCount = 0;
			uint num = 0u;
			list = FrameListPool<int>.Claim();
			int value = _WithoutEntityIDInput.GetValue();
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = CommonProcessor.GetWorldState().mRoomMembers.GetEnumerator();
			while (enumerator.MoveNext())
			{
				res = enumerator.Current.Value.mEntityID;
				if (res != value)
				{
					SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(res);
					if (entityWithEntityID != null && entityWithEntityID.hasEntityConfig && entityWithEntityID.hasEntityBlackboard && (entityWithEntityID.entityBlackboard.var.mHP > 0 || _includeHpZoreInput.value) && ConfigHelper.GetInstance().TryGetConfig<charactor_param>(entityWithEntityID.entityConfig.mId, out var config))
					{
						EnergyType energyType = (EnergyType)config.EnergyType;
						if (config.EnergyType >= 0 && config.EnergyType < 32)
						{
							num |= (uint)(1 << config.EnergyType);
						}
						else
						{
							Debug.LogError($"=====>>>>> 实体ID {entityWithEntityID.creationIndex} 的机制类型为小于0或者大于31(值为{config.EnergyType}),请核对,图名为:{base.graph.name}, 节点名为:遍历处理房间内的玩家(机制类型)");
						}
						if (energyType == _energyTypeInput.value)
						{
							if (energyType != EnergyType.None && _filterInput.value != 0 && _filterInput.value == 1)
							{
								int powerValue = AttributeProcessor.GetPowerValue(entityWithEntityID.creationIndex);
								AttributeProcessor.TryGetEnergyMaxValue(entityWithEntityID, out var maxValue);
								if (powerValue < maxValue)
								{
									continue;
								}
							}
							list.Add(entityWithEntityID.creationIndex);
							count++;
						}
					}
				}
			}
			num = (num & 0x55555555) + ((num >> 1) & 0x55555555);
			num = (num & 0x33333333) + ((num >> 2) & 0x33333333);
			num = (num & 0xF0F0F0F) + ((num >> 4) & 0xF0F0F0F);
			energyTypeCount = (int)(num * 16843009 >> 24);
			for (int i = 0; i < list.Count; i++)
			{
				res = list[i];
				doOut.Call(f);
			}
			f.Call(doneOut);
			FrameListPool<int>.Release(list);
		});
	}
}
