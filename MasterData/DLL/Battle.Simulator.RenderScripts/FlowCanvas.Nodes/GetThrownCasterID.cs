using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到抛掷物释放者实体ID(渲染)", 0)]
[Category("Render/抛掷物")]
[Description("得到抛掷物的释放者实体ID")]
public class GetThrownCasterID : FlowControlNode
{
	private ValueInput<int> _ThrownIDInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	private int _CasterID;

	protected override void RegisterPorts()
	{
		_ThrownIDInput = AddValueInput<int>("抛掷物ID", "抛掷物ID");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			ThrownManager thrownManager = (NScene.GetCurrentScene() as BattleScene).GetBattleSimulatorSystem().ThrownManager;
			if (thrownManager != null)
			{
				if (thrownManager.TryGetThrown(_ThrownIDInput.value, out var thrownStateOfRender))
				{
					_CasterID = thrownStateOfRender.CasterID;
					_Out.Call(f);
				}
				else
				{
					_Error.Call(f);
				}
			}
		});
		AddValueOutput("抛掷物ID", "thrownID", () => _ThrownIDInput.GetValue());
		AddValueOutput("释放者实体ID", "casterID", () => _CasterID);
	}
}
