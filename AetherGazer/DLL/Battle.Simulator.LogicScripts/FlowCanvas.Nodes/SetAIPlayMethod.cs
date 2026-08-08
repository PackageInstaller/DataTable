using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置AI玩法", 0)]
[Category("Logic/AI")]
[Description("使用的黑板变量，变量名为【角色ID+00088】\n该节点用于修改输入的实体的【AI玩法】值，输入的实体ID无效时，走error")]
public class SetAIPlayMethod : FlowNode
{
	private int mWantedVarName;

	private ValueInput<int> mWantedVarValue;

	private ValueInput<int> mEntityID;

	protected override void RegisterPorts()
	{
		mEntityID = AddValueInput<int>("实体ID", "entityID");
		mWantedVarValue = AddValueInput<int>("要设置成的值", "wantedValue");
		FlowOutput output = AddFlowOutput("true", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddValueOutput("实体ID", () => mEntityID.value);
		AddFlowInput("In", "in", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(mEntityID.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig)
			{
				errorOut.Call(f);
			}
			else
			{
				mWantedVarName = entityWithEntityID.entityConfig.mId * 100000 + 88;
				if (entityWithEntityID.hasEntityBlackboard)
				{
					AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, mWantedVarName, out var _, out var _, out var _);
					AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, mWantedVarName, mWantedVarValue.value, 0L, 0L);
				}
				output.Call(f);
			}
		});
	}
}
