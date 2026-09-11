using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否有当前角色所施加的护盾", 0)]
[Category("Logic/Attribute")]
[Description("是否有当前角色所施加的护盾")]
[ExposeAsDefinition]
public class OnAddShield : FlowNode
{
	private int _buffID = -1;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> casterInput = AddValueInput<int>("Caster");
		AddValueOutput("已存在的BuffID", () => _buffID);
		FlowOutput exit = AddFlowOutput("存在");
		FlowOutput noExit = AddFlowOutput("不存在");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			for (int i = 0; i < entityWithEntityID.entityBuff.mBuffCasterArray.Count; i++)
			{
				int num = entityWithEntityID.entityBuff.mBuffCasterArray[i];
				if (!entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]) && num == casterInput.value && (102 == entityWithEntityID.entityBuff.mBuffClassIDArray[i] || 108 == entityWithEntityID.entityBuff.mBuffClassIDArray[i]))
				{
					_buffID = entityWithEntityID.entityBuff.mBuffID[i];
					exit.Call(f);
					return;
				}
			}
			noExit.Call(f);
		});
	}
}
