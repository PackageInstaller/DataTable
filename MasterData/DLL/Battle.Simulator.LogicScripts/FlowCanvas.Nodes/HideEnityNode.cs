using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[隐藏]隐藏实体(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("隐藏实体，此节点会实体隐藏不参与计算")]
public class HideEnityNode : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> targetIDInput = AddValueInput<int>("目标实体ID", "作用对象");
		AddValueOutput("目标实体ID", "作用对象", () => targetIDInput.value);
		ValueInput<bool> targetHideInput = AddValueInput<bool>("隐藏", "是否隐藏");
		ValueInput<bool> onlyLogicInput = AddValueInput<bool>("仅逻辑", "onlyLogic");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int value = targetIDInput.GetValue();
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
			if (entityWithEntityID != null && !entityWithEntityID.hasEntityActionDeath && !entityWithEntityID.hasEntityHide && targetHideInput.value)
			{
				if (onlyLogicInput.value)
				{
					entityWithEntityID.AddEntityHide(E_EntityHideType.Logic);
				}
				else
				{
					entityWithEntityID.AddEntityHide(E_EntityHideType.Logic | E_EntityHideType.Render);
				}
			}
			if (entityWithEntityID.hasEntityHide && !targetHideInput.value)
			{
				entityWithEntityID.RemoveEntityHide();
			}
			output.Call(f);
		});
	}
}
