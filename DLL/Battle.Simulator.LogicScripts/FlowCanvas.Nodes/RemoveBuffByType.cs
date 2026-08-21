using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("按类型移除buff", 0)]
[Category("Logic/Entity")]
[Description("按类型移除buff")]
public class RemoveBuffByType : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<string> subTypeIDInput = AddValueInput<string>("子类型", "Buff类型");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null)
			{
				string value = subTypeIDInput.value;
				if (entityWithEntityID.hasEntityBuff)
				{
					for (int i = 0; i < entityWithEntityID.entityBuff.mBuffConfigID.Count; i++)
					{
						int num = entityWithEntityID.entityBuff.mBuffConfigID[i];
						if (num != 0)
						{
							public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(num);
							if (!entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]) && BuffSubTypeComparer.ContainsAny(value, config.SubType))
							{
								BuffProcessor.RemoveBuffByListIndex(entityWithEntityID, i);
							}
						}
					}
				}
				output.Call(f);
			}
		});
	}
}
