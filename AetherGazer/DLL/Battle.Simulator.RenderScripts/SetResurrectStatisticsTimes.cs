using FlowCanvas;
using ParadoxNotion.Design;

[Name("统计复活次数", 0)]
[Category("Render/UI")]
[Description("统计复活次数")]
public class SetResurrectStatisticsTimes : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<int> timesInput = AddValueInput<int>("次数");
		AddFlowInput("", delegate(Flow f)
		{
			(NScene.GetCurrentScene() as BattleScene).GetWorldSatetManager().data.dataForLua.resurrectTimes = timesInput.value;
			f.Call(output);
		});
	}
}
