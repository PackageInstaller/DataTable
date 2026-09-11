using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取配置信息(equip_skill)", 0)]
[Category("Common/Config")]
[Description("获取equip_skill效果")]
public class GetEquipSkill : FlowNode
{
	private equip_skill config;

	protected override void RegisterPorts()
	{
		ValueInput<int> IDInput = AddValueInput<int>("ID");
		AddFlowInput("", delegate
		{
			config = ConfigHelper.GetInstance().GetConfig<equip_skill>(IDInput.value);
		});
		AddValueOutput("Attribute", () => config.Attribute);
		AddValueOutput("EquipEffectId", () => config.EquipEffectId);
		AddValueOutput("Upgrade", () => config.Upgrade);
		AddValueOutput("Lvmax", () => config.Lvmax);
		AddValueOutput("Percent", () => config.Percent);
		AddValueOutput("Type", () => config.Type);
		AddValueOutput("TypeInner", () => config.TypeInner);
	}
}
