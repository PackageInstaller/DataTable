using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取目标位置(要先设置)", 0)]
[Category("Logic/Attribute")]
[Description("获取目标位置(要先设置)")]
public class GetTargetPosition : PureFunctionNode<Int3, int>
{
	public override Int3 Invoke(int entityID)
	{
		return base.parentNode.mSimContext.GetEntityWithEntityID(entityID).entityBlackboard.var.mTargetPos;
	}
}
