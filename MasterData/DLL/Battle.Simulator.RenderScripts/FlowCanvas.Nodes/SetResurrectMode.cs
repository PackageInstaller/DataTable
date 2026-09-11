using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置复活模式", 0)]
[Category("Render/Resurrect")]
[Description("设置复活模式:0为默认,1为QTE复活,等策划内部规定")]
public class SetResurrectMode : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> ModeInput = AddValueInput<int>("复活模式", "ResurrectMode").SetDefaultAndSerializedValue(0);
		FlowOutput Output = AddFlowOutput("");
		FlowOutput ErrorOutput = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				ErrorOutput.Call(f);
			}
			else
			{
				battleScene.resurrectMode = ModeInput.value;
				Output.Call(f);
			}
		});
	}
}
