using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("随机得到未添加抗性点的属性(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("随机得到未添加抗性点的属性\n如果没有控制抗性，走\"无控制抗性\"分支并随机返回八个属性中任意一个")]
public class GetRandomElementOfNoneEleResistance : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		int[] elementArr = new int[8] { 1634038339, 1765893492, 1818318706, 1147555692, 1333030511, 1920234338, 1349804917, 1701474162 };
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		AddValueOutput("实体ID", "实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput noResistanceOut = AddFlowOutput("无控制抗性", "noResistance");
		FlowOutput reStateOutput = AddFlowOutput("抗性状态中", "reState");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		int max = 0;
		AddValueOutput("最大点数", "max", () => max);
		int cur = 0;
		AddValueOutput("当前值", "cur", () => cur);
		int res = 0;
		AddValueOutput("元素属性", "element", () => res);
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				Debug.LogError("得到指定属性抗性点数量, 实体为空");
				errorOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityResistance)
			{
				cur = 0;
				max = 0;
				res = elementArr[DRandom.Random((uint)elementArr.Length)];
				noResistanceOut.Call(f);
			}
			else
			{
				EntityResistance entityResistance = entityWithEntityID.entityResistance;
				if (entityResistance.reState)
				{
					reStateOutput.Call(f);
				}
				else
				{
					cur = entityResistance.curValue;
					max = entityResistance.maxValue;
					res = 0;
					if (entityResistance.element != null)
					{
						List<int> list = FrameListPool<int>.Claim();
						HashSet<int> hashSet = new HashSet<int>(entityResistance.element);
						int[] array = elementArr;
						foreach (int item in array)
						{
							if (!hashSet.Contains(item))
							{
								list.Add(item);
							}
						}
						if (list.Count == 0)
						{
							for (int j = 0; j < elementArr.Length; j++)
							{
								list.Add(elementArr[j]);
							}
						}
						res = list[(int)DRandom.Random((uint)list.Count)];
						FrameListPool<int>.Release(list);
					}
					f.Call(output);
				}
			}
		});
	}
}
