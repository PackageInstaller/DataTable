using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到连携奥义抛掷物TimelineID(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("")]
public class GetCooperateThrownTimelineID : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<int> _CooperateUniqueSkillIDInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	private int _ThrownTimelineID;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_CooperateUniqueSkillIDInput = AddValueInput<int>("连携奥义ID", "cooperateUniqueSkillID");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			cooperate_unique_skill config;
			if (entityWithEntityID == null)
			{
				_Error.Call(f);
			}
			else if (!ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(_CooperateUniqueSkillIDInput.GetValue(), out config))
			{
				_Error.Call(f);
			}
			else
			{
				for (int i = 0; i < config.CooperateRoleIds.Count; i++)
				{
					if (config.CooperateRoleIds.get_Item(i) == entityWithEntityID.entityConfig.mId)
					{
						_ThrownTimelineID = config.CooperateThrownIds.get_Item(i);
						break;
					}
				}
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
		AddValueOutput("连携抛掷物TimelineID", "thrownTimelineID", () => _ThrownTimelineID);
	}
}
