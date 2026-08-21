using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("冥王专属连携结束设置奥义能量值(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("冥王变身结束,恢复连携,设置奥义能量值的专属节点，没有考虑属性;\nError:实体不存在、没有奥义能量组件、未配置连携技ID、连携技ID取不到、未参与连携;\n未启用:连携奥义未启用")]
public class SetUniqueSkillEnergyValueOf1111 : FlowControlNode
{
	private ValueInput<int> _entityIDInput;

	private ValueInput<int> _AddValueInput;

	private FlowOutput _output;

	private FlowOutput _unabledOut;

	private FlowOutput _errorOut;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_output = AddFlowOutput("Out", "output");
		_unabledOut = AddFlowOutput("未启用", "unable");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityUniqueSkillEnergy)
			{
				_errorOut.Call(f);
			}
			else
			{
				SimWorldState simWorldState = base.mSimContext.sEntityWorldState.status;
				cooperate_unique_skill config;
				if (base.mSimContext.sEntityWorldState.status.m_cooperateUniqueSkillIsActive <= 0)
				{
					_unabledOut.Call(f);
				}
				else if (!ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(simWorldState.m_CooperateUniqueSkillID, out config))
				{
					_errorOut.Call(f);
				}
				else if (!config.CooperateRoleIds.Contains(entityWithEntityID.entityConfig.mId))
				{
					_errorOut.Call(f);
				}
				else
				{
					int num = 0;
					Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = simWorldState.mRoomMembers.GetEnumerator();
					while (enumerator.MoveNext())
					{
						int mEntityID = enumerator.Current.Value.mEntityID;
						SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(mEntityID);
						if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityBlackboard && entityWithEntityID2.entityBlackboard.var.mHP > 0 && entityWithEntityID2.hasEntityConfig && config.CooperateRoleIds.Contains(entityWithEntityID2.entityConfig.mId) && entityWithEntityID2.entityConfig.mId != 1111 && entityWithEntityID2.hasEntityUniqueSkillEnergy)
						{
							num += entityWithEntityID2.entityUniqueSkillEnergy.mValue;
						}
					}
					int num2 = config.CooperateRoleIds.Count - 1;
					num2 = ((num2 <= 0) ? 1 : num2);
					entityWithEntityID.entityUniqueSkillEnergy.mValue = IntMath.Divide(num, num2);
					_output.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.GetValue());
	}
}
