using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取角色攻击距离类型", 0)]
[Category("Logic/Config")]
[Description("获取角色攻击距离类型, characterparam表")]
public class GetRoleRangeType : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput output0 = AddFlowOutput("近战");
		FlowOutput output1 = AddFlowOutput("远程");
		int res = 0;
		AddValueOutput("值", () => res);
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null)
			{
				int mId = entityWithEntityID.entityConfig.mId;
				if (ConfigHelper.GetInstance().TryGetConfig<charactor_param>(mId, out var config))
				{
					res = config.RangeType;
					if (config.RangeType == 0)
					{
						output0.Call(f);
					}
					else
					{
						output1.Call(f);
					}
				}
			}
		});
	}
}
