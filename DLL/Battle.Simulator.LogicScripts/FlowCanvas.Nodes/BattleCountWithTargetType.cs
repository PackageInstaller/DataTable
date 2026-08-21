using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("战斗统计(指定敌人类型)", 0)]
[Category("Logic/Trigger")]
[Description("传入一个敌人类型列表和对应类型的敌人数量列表以及死掉的敌人实体id,把数量列表里对应的数量减一,所有的数量都小于等于0才认为列表为空")]
public class BattleCountWithTargetType : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput emptyOut = AddFlowOutput("列表为空");
		FlowOutput notEmptyOut = AddFlowOutput("列表不为空");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<List<int>> enemyTypeListInput = AddValueInput<List<int>>("敌人类型列表");
		ValueInput<List<int>> enemyCountListInput = AddValueInput<List<int>>("敌人数量列表");
		List<int> enemyCountList = null;
		AddValueOutput("敌人数量列表", () => enemyCountList);
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			List<int> value = enemyTypeListInput.value;
			enemyCountList = enemyCountListInput.value;
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && entityWithEntityID.hasEntityConfig)
			{
				for (int i = 0; i < value.Count; i++)
				{
					if (value[i] == entityWithEntityID.entityConfig.mId)
					{
						enemyCountList[i]--;
						break;
					}
				}
			}
			bool flag = true;
			for (int j = 0; j < enemyCountList.Count; j++)
			{
				if (enemyCountList[j] > 0)
				{
					flag = false;
					break;
				}
			}
			if (flag)
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
