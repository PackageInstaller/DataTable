using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断怪物类型", 0)]
[Category("Logic/Config")]
[Description("判断怪物类型, 小怪还是精英还是boss, 其他中包括玩家和AI")]
public class SwitchEnemyType : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput MonsterNormal = AddFlowOutput("小怪");
		FlowOutput MonsterElitel = AddFlowOutput("精英");
		FlowOutput MonsterBoss = AddFlowOutput("BOSS");
		FlowOutput Other = AddFlowOutput("其他");
		FlowOutput error = AddFlowOutput("出错");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				error.Call(f);
			}
			else
			{
				switch (entityWithEntityID.entityBlackboard.var.enemyType)
				{
				case EnemyType.MonsterBoss:
					MonsterBoss.Call(f);
					break;
				case EnemyType.MonsterElitel:
					MonsterElitel.Call(f);
					break;
				case EnemyType.MonsterNormal:
					MonsterNormal.Call(f);
					break;
				case EnemyType.Other:
					Other.Call(f);
					break;
				}
			}
		});
	}
}
