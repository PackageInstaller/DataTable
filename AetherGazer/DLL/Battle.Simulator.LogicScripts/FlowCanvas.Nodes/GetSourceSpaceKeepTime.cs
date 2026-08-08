using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到修正模式时长(逻辑)", 0)]
[Category("Logic/SourceSpace")]
[Description("在修正模式中,得到修正模式持续时长")]
public class GetSourceSpaceKeepTime : FlowControlNode
{
	private FlowOutput _InSourceSpace;

	private FlowOutput _OutsideSourceSpace;

	private FlowOutput _Error;

	private int _KeepTime;

	protected override void RegisterPorts()
	{
		_InSourceSpace = AddFlowOutput("间层中", "inSourceSpace");
		_OutsideSourceSpace = AddFlowOutput("间层外", "outsideSourceSpace");
		_Error = AddFlowOutput("非间层中", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			EntitySourceSpace entitySourceSpace = base.mSimContext.entitySourceSpace;
			if (entitySourceSpace != null)
			{
				if (entitySourceSpace.Enable)
				{
					_KeepTime = entitySourceSpace.SourceSpaceKeepTime;
					_InSourceSpace.Call(f);
				}
				else
				{
					_KeepTime = -1;
					_OutsideSourceSpace.Call(f);
				}
			}
			else
			{
				_KeepTime = -1;
				_Error.Call(f);
			}
		});
		AddValueOutput("时长(毫秒)", "newKeepTime", () => _KeepTime);
	}
}
