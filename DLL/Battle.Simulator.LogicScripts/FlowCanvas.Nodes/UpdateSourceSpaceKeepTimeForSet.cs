using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修正模式更新(设置)(逻辑)", 0)]
[Category("Logic/SourceSpace")]
[Description("发送进入修正模式的指令,这里的持续时长需要大于【SourceSpaceRenderConfigAsset】中【进入时长】\n当目标死亡时候,修正模式强制结束")]
public class UpdateSourceSpaceKeepTimeForSet : FlowControlNode
{
	private int m_newRaceID = -1;

	private int m_newKeepTime = -1;

	private ValueInput<int> m_breakEntityIDInput;

	protected override void RegisterPorts()
	{
		ValueInput<int> SetRaceIDInput = AddValueInput<int>("阵营", "SetRaceIDInput");
		ValueInput<int> SetTimeInput = AddValueInput<int>("设置时长(毫秒)", "SetTimeInput");
		m_breakEntityIDInput = AddValueInput<int>("Break实体ID", "breakEntityID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			EntitySourceSpace entitySourceSpace = base.mSimContext.entitySourceSpace;
			if (entitySourceSpace != null && entitySourceSpace.Enable && entitySourceSpace.SourceSpaceKeepTime > 0)
			{
				entitySourceSpace.SourceSpaceRaceID = SetRaceIDInput.GetValue();
				m_newRaceID = SetRaceIDInput.GetValue();
				entitySourceSpace.SourceSpaceKeepTime = SetTimeInput.GetValue();
				m_newKeepTime = SetTimeInput.GetValue();
				base.mSimContext.PostEvent(SourceSpaceEvent.Claim(SourceSpaceEvent.E_SourceSpaceState.Update, m_newKeepTime, m_newRaceID, m_breakEntityIDInput.GetValue()));
				output.Call(f);
			}
			else
			{
				m_newKeepTime = -1;
				error.Call(f);
			}
		});
		AddValueOutput("新的阵营", "newRaceID", () => m_newRaceID);
		AddValueOutput("新的时长(毫秒)", "newKeepTime", () => m_newKeepTime);
	}
}
