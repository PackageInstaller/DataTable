using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("改变BUFF特效等级", 0)]
[Category("P08/渲染/函数")]
[Description("根据传入的等级,修改Entity身上等级特效的等级,用以切换特效显示,buffCollection存放buff特效的列表,例如BattleRenderLaucher中的CommonBuffRender使用的")]
public class ChangeBuffLevel : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "out");
		FlowOutput abnormalOut = AddFlowOutput("Error", "无效EntityID");
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID", "实体ID");
		ValueInput<int> buffClassVar = AddValueInput<int>("类型(处理逻辑)ID", "Buff类型");
		ValueInput<Dictionary<int, List<GameObject>>> buffCollectionVar = AddValueInput<Dictionary<int, List<GameObject>>>("buffCollection");
		ValueInput<int> buffLevelVar = AddValueInput<int>("Buff等级");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID == null)
			{
				abnormalOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityBuff)
			{
				output.Call(f);
			}
			else
			{
				List<int> list = FrameListPool<int>.Claim();
				for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
				{
					if (entityWithEntityID.entityBuff.mBuffClassIDArray[i] == buffClassVar.value)
					{
						list.Add(entityWithEntityID.entityBuff.mBuffID[i]);
					}
				}
				Dictionary<int, List<GameObject>> value = buffCollectionVar.value;
				for (int j = 0; j < list.Count; j++)
				{
					List<GameObject> value2 = null;
					if (value.TryGetValue(list[j], out value2) && value2.Count > 0)
					{
						for (int k = 0; k < value2.Count; k++)
						{
							EffectLevel component = value2[k].GetComponent<EffectLevel>();
							if (component != null)
							{
								component.PlayLevel(buffLevelVar.value);
							}
						}
					}
				}
				FrameListPool<int>.Release(list);
				output.Call(f);
			}
		});
	}
}
