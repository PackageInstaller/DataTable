using MultiScenario;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置场景Scenario(渲染)", 0)]
[Category("Render/Scene")]
[Description("设置场景Scenario，如果有的话")]
public class SetSceneScenario : FlowNode
{
	public string Path = "MultiScenarioManager";

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOut = AddFlowOutput("error");
		ValueInput<string> fromSceneInput = AddValueInput<string>("当前场景名称");
		ValueInput<string> toSceneInput = AddValueInput<string>("需要变化成的场景名称");
		ValueInput<float> weightInput = AddValueInput<float>("最终权重值");
		AddFlowInput("In", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.sceneSetting == null)
			{
				errorOut.Call(f);
			}
			else
			{
				MultiScenarioManager multiScenarioManager = battleScene.sceneSetting.transform.Find(Path)?.GetComponent<MultiScenarioManager>();
				if (multiScenarioManager == null)
				{
					errorOut.Call(f);
				}
				else
				{
					multiScenarioManager.BlendTwoScenarios(fromSceneInput.value, toSceneInput.value, weightInput.value);
					output.Call(f);
				}
			}
		});
	}
}
