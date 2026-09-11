using System.Collections.Generic;
using Entitas;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置指定目标", 0)]
[Category("Logic/AI")]
[Description("AI设置目标")]
public class AISetTarget : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> indexIDInput = AddValueInput<int>("下标");
		AddValueOutput("实体ID", () => entityIDInput.value);
		int targetID = 0;
		AddValueOutput("目标ID", () => targetID);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int value = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			if (entityWithEntityID == null)
			{
				Debug.LogError("AI设置目标 -- 实体为空");
			}
			else
			{
				List<int> list = FrameListPool<int>.Claim();
				IGroup<SimEntity> obj = base.mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityCamp));
				uint mask = RoleCampProcessor.GetInterestCamp(entityWithEntityID.entityCamp.mRoleTypeCamp);
				obj.DoAction(delegate(SimEntity simEntity)
				{
					if ((mask & simEntity.entityCamp.mRoleTypeCamp) != 0)
					{
						list.Add(simEntity.creationIndex);
					}
				});
				if (list.Count == 0)
				{
					Debug.Log("没有目标");
					output.Call(f);
				}
				else
				{
					targetID = list[indexIDInput.value % list.Count];
					AIProcessor.ChangeTarget(entityWithEntityID, targetID);
					output.Call(f);
				}
				FrameListPool<int>.Release(list);
			}
		});
	}
}
