using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[庚辰]鱼机制变更", 0)]
[Category("Logic/角色定制/庚辰")]
[Description("庚辰特殊机制的增加处理")]
public class ModifyYu : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<bool> valueInput = AddValueInput<bool>("鱼(正阳负阴)", "value");
		ValueInput<int> numInput = AddValueInput<int>("数量", "num");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput lessOut = AddFlowOutput("不足", "less");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.graph.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
			{
				if (numInput.value > 0)
				{
					int num = numInput.value;
					do
					{
						if (!AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600220, out var baseValue, out var plusValue, out var tempPlusValue))
						{
							baseValue = 1L;
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600220, baseValue, 0L, 0L);
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600221, YaoUtil.GetYu(valueInput.value), 0L, 0L);
						}
						else if (baseValue == 4)
						{
							AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600222, out var baseValue2, out plusValue, out tempPlusValue);
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600221, baseValue2, 0L, 0L);
							AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600223, out baseValue2, out plusValue, out tempPlusValue);
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600222, baseValue2, 0L, 0L);
							AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600224, out baseValue2, out plusValue, out tempPlusValue);
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600223, baseValue2, 0L, 0L);
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600224, YaoUtil.GetYu(valueInput.value), 0L, 0L);
						}
						else
						{
							baseValue++;
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600220, baseValue, 0L, 0L);
							long num2 = baseValue - 1;
							if ((ulong)num2 <= 3uL)
							{
								switch ((int)num2)
								{
								case 0:
									AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600221, YaoUtil.GetYu(valueInput.value), 0L, 0L);
									break;
								case 1:
									AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600222, YaoUtil.GetYu(valueInput.value), 0L, 0L);
									break;
								case 2:
									AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600223, YaoUtil.GetYu(valueInput.value), 0L, 0L);
									break;
								case 3:
									AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600224, YaoUtil.GetYu(valueInput.value), 0L, 0L);
									break;
								}
							}
						}
					}
					while (--num > 0);
				}
				else if (numInput.value < 0)
				{
					int num3 = Math.Abs(numInput.value);
					if (!AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600220, out var baseValue3, out var plusValue2, out var tempPlusValue2) || baseValue3 < num3)
					{
						lessOut.Call(f);
						return;
					}
					int num4 = 0;
					int num5 = 0;
					long baseValue4 = 0L;
					List<long> list = new List<long>(4);
					for (int i = 0; i < baseValue3; i++)
					{
						switch (i)
						{
						case 0:
							AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600221, out baseValue4, out plusValue2, out tempPlusValue2);
							break;
						case 1:
							AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600222, out baseValue4, out plusValue2, out tempPlusValue2);
							break;
						case 2:
							AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600223, out baseValue4, out plusValue2, out tempPlusValue2);
							break;
						case 3:
							AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600224, out baseValue4, out plusValue2, out tempPlusValue2);
							break;
						}
						switch (baseValue4)
						{
						case 1L:
							num4++;
							break;
						case -1L:
							num5++;
							break;
						}
						list.Add(baseValue4);
					}
					bool flag = false;
					if (!((!valueInput.value) ? (num5 >= num3) : (num4 >= num3)))
					{
						lessOut.Call(f);
						return;
					}
					int num6 = 0;
					int num7 = list.Count;
					do
					{
						if (list[num6] == (valueInput.value ? 1 : (-1)))
						{
							list.RemoveAt(num6);
							num6--;
							num7--;
							num3--;
						}
						num6++;
					}
					while (num3 > 0);
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600220, list.Count, 0L, 0L);
					for (int j = 0; j < list.Count; j++)
					{
						long baseValue5 = 0L;
						if (j < list.Count)
						{
							baseValue5 = list[j];
						}
						switch (j)
						{
						case 0:
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600221, baseValue5, 0L, 0L);
							break;
						case 1:
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600222, baseValue5, 0L, 0L);
							break;
						case 2:
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600223, baseValue5, 0L, 0L);
							break;
						case 3:
							AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 107600224, baseValue5, 0L, 0L);
							break;
						}
					}
				}
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
