using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置普攻段数", 0)]
[Category("Logic/Abilities")]
[Description("将普攻段数设置为指定值\n普攻段数: 从0开始，设置后，下一次普攻将从该段开始（若用普攻续上）\nOut: 正常输出\nError: 实体不存在；输入的段数大于等于该角色的普攻槽数量-1；对应角色配置不存在")]
public class SetAttackIndex : FlowControlNode
{
	private ValueInput<int> vInEntId;

	private ValueInput<int> vInIndex;

	private FlowOutput fOut;

	private FlowOutput fError;

	protected override void RegisterPorts()
	{
		vInEntId = AddValueInput<int>("实体Id");
		vInIndex = AddValueInput<int>("普攻段数");
		fOut = AddFlowOutput("Out");
		fError = AddFlowOutput("Error");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(vInEntId.GetValue());
			if (entityWithEntityID == null)
			{
				fError.Call(f);
			}
			else if (vInIndex.value >= entityWithEntityID.entityBlackboard.var.mMeleesSlots.Count)
			{
				fError.Call(f);
			}
			else
			{
				entityWithEntityID.entityBlackboard.var.meleeIndex = vInIndex.value;
				fOut.Call(f);
			}
		});
		AddValueOutput("实体Id", () => vInEntId.value);
	}
}
