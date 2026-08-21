using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("能否被传送(逻辑)", 0)]
[Category("Logic/Config")]
[Description("判断传入的实体是否能被传送")]
public class CanBeTransfer : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> beTransferEntityIDInput = AddValueInput<int>("被传送实体ID", "beTransferEntityID");
		FlowOutput trueOut = AddFlowOutput("True", "true");
		FlowOutput falseOut = AddFlowOutput("False", "false");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(beTransferEntityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else if (Invoke(base.mSimContext, entityWithEntityID))
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}

	public static bool Invoke(SimContext pSimContext, SimEntity pSimEntity)
	{
		bool flag = true;
		ISimulatorInferface simInterface = pSimContext.GetSimInterface();
		if (simInterface != null && simInterface.mCanBeTransferExtensionEvent != null)
		{
			Action<int, bool> mCanBeTransferExtensionEvent = simInterface.mCanBeTransferExtensionEvent;
			pSimEntity.entityBlackboard.var.mTempCanBeTransfer = flag;
			mCanBeTransferExtensionEvent(pSimEntity.creationIndex, flag);
			flag = pSimEntity.entityBlackboard.var.mTempCanBeTransfer;
			pSimEntity.entityBlackboard.var.mTempCanBeTransfer = false;
		}
		return flag;
	}
}
