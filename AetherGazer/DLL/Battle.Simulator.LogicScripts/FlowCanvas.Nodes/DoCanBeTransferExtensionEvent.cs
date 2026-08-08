using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("能否被传送扩展事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("在【能否被传送】判断中传出来的回调,配合【设置能否被抓取结果】可对抓取结果进行自定义调整;\n实体类型ID为0时候,监听所有角色的传送事件")]
public class DoCanBeTransferExtensionEvent : EventNode
{
	private Stack<Flow.ReturnData> _returnData = new Stack<Flow.ReturnData>(16);

	private FlowOutput _output;

	private ValueInput<int> _roleIDInput;

	private int _beTransferEntityID;

	private int _configID;

	private bool _canBeTransfer;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mCanBeTransferExtensionEvent = (Action<int, bool>)Delegate.Combine(simInterface.mCanBeTransferExtensionEvent, new Action<int, bool>(DoEvent));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mCanBeTransferExtensionEvent = (Action<int, bool>)Delegate.Remove(simInterface.mCanBeTransferExtensionEvent, new Action<int, bool>(DoEvent));
		base.OnGraphStoped();
	}

	protected override void RegisterPorts()
	{
		_output = AddFlowOutput("Out", "output");
		_roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		AddValueOutput("被传送实体ID", "beTransferEntityID", () => _beTransferEntityID);
		AddValueOutput("结果值", "result", () => _canBeTransfer);
		AddValueOutput("实体类型ID", "roleID", () => _configID);
	}

	private void DoEvent(int pBeTransferEntityID, bool pCanBeGrab)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(pBeTransferEntityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard && (_roleIDInput.value == 0 || (entityWithEntityID.hasEntityConfig && _roleIDInput.value == entityWithEntityID.entityConfig.mId)))
		{
			_returnData.Clear();
			Flow f = new Flow
			{
				returnData = _returnData
			};
			_beTransferEntityID = entityWithEntityID.creationIndex;
			_configID = entityWithEntityID.ENTITY_CONFIG_ID;
			_canBeTransfer = pCanBeGrab;
			_output.Call(f);
		}
	}
}
