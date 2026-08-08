using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("启用奥义", 0)]
[Category("Logic/Abilities")]
[Description("让奥义正常释放")]
public class EnableUniqueSkill : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.GetValue());
			UniqueSkill config;
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				_Error.Call(f);
			}
			else if (!ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(entityWithEntityID.entityConfig.mId, out config))
			{
				_Error.Call(f);
			}
			else
			{
				for (int i = 0; i < config.AbilityId.Count; i++)
				{
					entityWithEntityID.entityBlackboard.var.EnableAbility(config.AbilityId.get_Item(i), isEnable: true);
				}
				_Out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
	}
}
