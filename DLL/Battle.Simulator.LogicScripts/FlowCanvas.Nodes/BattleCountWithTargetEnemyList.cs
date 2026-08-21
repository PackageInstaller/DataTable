using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("战斗统计(指定敌人列表)", 0)]
[Category("Logic/Trigger")]
[Description("传入一个敌人列表和死掉的敌人实体id,把敌人列表里的敌人实体id去掉")]
public class BattleCountWithTargetEnemyList : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput emptyOut = AddFlowOutput("列表为空");
		FlowOutput notEmptyOut = AddFlowOutput("列表不为空");
		ValueInput<List<int>> enemyListInput = AddValueInput<List<int>>("敌人列表");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		List<int> list = null;
		AddValueOutput("列表", () => list);
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			list = enemyListInput.value;
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && list.Contains(entityWithEntityID.entityBlackboard.var.mAIID))
			{
				list.Remove(entityWithEntityID.entityBlackboard.var.mAIID);
			}
			if (list.Count == 0)
			{
				emptyOut.Call(f);
			}
			else
			{
				notEmptyOut.Call(f);
			}
		});
	}
}
