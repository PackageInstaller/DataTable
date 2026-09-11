using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到源技能(逻辑)", 0)]
[Category("Logic/Config")]
[Description("获取源技能。如果传入的技能本身就是源技能即取到0,则会走不存在出口,且源技能返回自身")]
public class GetOriginAbilityID : FlowControlNode
{
	private int _originAbilityID;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("AbilityID", "abilityID");
		FlowOutput trueOutput = AddFlowOutput("存在", "true");
		FlowOutput falseOutput = AddFlowOutput("不存在", "false");
		FlowOutput errorOutput = AddFlowOutput("Error", "error");
		AddFlowInput("in", delegate(Flow f)
		{
			AbilityConfig config;
			if (base.mSimContext.GetEntityWithEntityID(entityIDInput.value) == null)
			{
				errorOutput.Call(f);
			}
			else if (!ConfigHelper.GetInstance().TryGetConfig<AbilityConfig>(abilityIDInput.GetValue(), out config))
			{
				errorOutput.Call(f);
			}
			else
			{
				_originAbilityID = config.OriginAbility;
				if (_originAbilityID != 0)
				{
					trueOutput.Call(f);
				}
				else
				{
					_originAbilityID = abilityIDInput.GetValue();
					falseOutput.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.GetValue());
		AddValueOutput("AbilityID", "abilityID", () => abilityIDInput.GetValue());
		AddValueOutput("源技能ID", "originAbilityID", () => _originAbilityID);
	}
}
