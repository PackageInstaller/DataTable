using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[修正模式]实体抗拒进入(标志位)", 0)]
[Category("Logic/修正模式")]
[Description("需要自行定义每个标志位的意义, 非计数,除非所有标记为都为0,否则该实体将不会进入修正模式,非计数节点")]
public class SetEnityResistEnterSourceSpaceFlag : FlowControlNodeOfLogic
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> indexInput = AddValueInput<int>("标志位(0-31)", "index");
		ValueInput<bool> resistInput = AddValueInput<bool>("抗拒", "enable");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityExposedValue)
			{
				errorOut.Call(f);
			}
			else if (indexInput.value < 0 || indexInput.value > 31)
			{
				errorOut.Call(f);
			}
			else
			{
				entityWithEntityID.entityExposedValue.SetResistEnterFlag(indexInput.value, resistInput.value);
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
