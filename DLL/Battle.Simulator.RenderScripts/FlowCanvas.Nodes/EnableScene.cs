using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("显示场景(渲染)", 0)]
[Category("Render/Agent")]
[Description("")]
public class EnableScene : FlowControlNode
{
	private FlowOutput _Output;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_Output = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null || battleScene.sceneSetting == null)
			{
				_Error.Call(f);
			}
			else
			{
				if (battleScene.GetWorldSatetManager().m_breakEntityID == 0 && !battleScene.sceneSetting.gameObject.activeSelf)
				{
					battleScene.sceneSetting.gameObject.SetActive(value: true);
				}
				_Output.Call(f);
			}
		});
	}
}
