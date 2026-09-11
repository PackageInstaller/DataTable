using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[TD]得到怪物配置数据", 0)]
[Category("Active/TowerDefense/Common/Data")]
[Description("得到怪物配置数据")]
public class TDGetPointData : FlowControlNodeOfCommon
{
	private int _pt;

	private int _reducedValue;

	protected override void RegisterPorts()
	{
		ValueInput<int> roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddValueOutput("击杀PT点", "pt", () => _pt);
		AddValueOutput("扣血血量", "reducedValue", () => _reducedValue);
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_pt = 0;
			_reducedValue = 0;
			if (ConfigHelper.GetInstance().TryGetConfig<activity_tower_defense_point>(roleIDInput.value, out var config))
			{
				_pt = config.Pt;
				_reducedValue = config.ReducedValue;
				output.Call(f);
			}
			else
			{
				errorOut.Call(f);
			}
		});
	}
}
