using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取第一个同步CD的技能", 0)]
[Category("Logic/Config")]
[Description("获取与指定技能同步CD的技能, 如果没有的话,返回这个技能ID")]
public class GetFirstSyncCDSkillID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> abilityIDInput = AddValueInput<int>("AbilityID");
		int res = 0;
		AddValueOutput("结果", () => res);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int value = abilityIDInput.value;
			AbilityConfig config = ConfigHelper.GetInstance().GetConfig<AbilityConfig>(value);
			if (config.SyncCDSkillID != null && config.SyncCDSkillID.Count > 0)
			{
				res = config.SyncCDSkillID.get_Item(0);
			}
			else
			{
				res = value;
			}
			output.Call(f);
		});
	}
}
