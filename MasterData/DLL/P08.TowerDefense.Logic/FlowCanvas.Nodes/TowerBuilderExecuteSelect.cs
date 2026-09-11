using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[TD]塔基执行选项(逻辑)", 0)]
[Category("Active/TowerDefense/Logic")]
[Description("塔基执行选项")]
public class TowerBuilderExecuteSelect : FlowControlNodeOfLogic
{
	private int _roleID;

	private SimEntity _simEntity;

	private int _buffID;

	protected override void RegisterPorts()
	{
		ValueInput<int> triggerIDInput = AddValueInput<int>("关联触发器", "triggerID");
		ValueInput<int> configIDInput = AddValueInput<int>("配置ID", "configID");
		FlowOutput createOut = AddFlowOutput("创建", "create");
		FlowOutput upgradeOut = AddFlowOutput("升级", "upgrade");
		FlowOutput destroyOut = AddFlowOutput("销毁", "destroy");
		FlowOutput doneOut = AddFlowOutput("Done", "done");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", delegate(Flow f)
		{
			_roleID = 0;
			_buffID = 0;
			_simEntity = null;
			SimEntity[] entities = base.graph.mSimContext.GetEntities();
			foreach (SimEntity simEntity in entities)
			{
				if (simEntity.hasEntityBlackboard && simEntity.entityBlackboard.var.mTriggerTarget == triggerIDInput.value)
				{
					_simEntity = simEntity;
					break;
				}
			}
			if (configIDInput.value == 0)
			{
				if (_simEntity == null)
				{
					errorOut.Call(f);
				}
				else
				{
					destroyOut.Call(f);
				}
				doneOut.Call(f);
			}
			else
			{
				activity_tower_defense_tower config = ConfigHelper.GetInstance().GetConfig<activity_tower_defense_tower>(configIDInput.value);
				if (_simEntity == null)
				{
					_roleID = config.RoleId;
					createOut.Call(f);
				}
				else
				{
					_buffID = config.BuffConfigId;
					upgradeOut.Call(f);
				}
				doneOut.Call(f);
			}
		});
		AddValueOutput("触发器ID", "triggerID", () => triggerIDInput.value);
		AddValueOutput("实体ID", "entityID", () => (_simEntity != null) ? _simEntity.creationIndex : 0);
		AddValueOutput("实体类型ID", "roleID", () => _roleID);
		AddValueOutput("类型(处理逻辑)ID", "buffID", () => _buffID);
	}
}
