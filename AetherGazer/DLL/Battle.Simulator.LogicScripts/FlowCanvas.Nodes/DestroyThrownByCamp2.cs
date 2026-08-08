using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("销毁抛掷物实体(阵营)(逻辑)", 0)]
[Category("Logic/抛掷物")]
[Description("销毁指定阵营的所有抛掷物，若对应抛掷物已处于待销毁状态，则不会再发出事件")]
public class DestroyThrownByCamp2 : FlowNode
{
	private ValueInput<RoleType> _CampInput;

	private FlowOutput m_output;

	protected override void RegisterPorts()
	{
		_CampInput = AddValueInput<RoleType>("阵营", "camp");
		m_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "intput", delegate(Flow f)
		{
			SEntityWorldState sEntityWorldState = base.mSimContext.sEntityWorldState;
			List<ThrownState> mThrowns = sEntityWorldState.status.mThrowns;
			for (int i = 0; i < mThrowns.Count; i++)
			{
				ThrownState thrownState = sEntityWorldState.status.mThrowns[i];
				if (thrownState.mCamp == (uint)_CampInput.GetValue() && !CommonProcessor.GetWorldState().mDestoryThrowns.Contains(thrownState.mCreationIndex))
				{
					ThrownProcessor.DestoryThrown(base.mSimContext, thrownState);
				}
			}
			m_output.Call(f);
		});
	}
}
