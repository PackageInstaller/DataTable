using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("能否被抓取扩展事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("在【能否被抓取】判断中传出来的回调,该回调在通用抓取判断后,实际结果流出前,配合【设置能否被抓取结果】可对抓取结果进行自定义调整")]
public class DoCanBeGrabExtensionEvent : EventNode
{
	private Stack<Flow.ReturnData> _returnData = new Stack<Flow.ReturnData>(16);

	private FlowOutput _output;

	private int _grabEntityID;

	private int _abilityID;

	private int _projectileID;

	private int _beGrabEntityID;

	private bool _canBeGrab;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mCanBeGrabExtensionEvent = (Action<DamageEventParam, int, bool>)Delegate.Combine(simInterface.mCanBeGrabExtensionEvent, new Action<DamageEventParam, int, bool>(DoEvent));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mCanBeGrabExtensionEvent = (Action<DamageEventParam, int, bool>)Delegate.Remove(simInterface.mCanBeGrabExtensionEvent, new Action<DamageEventParam, int, bool>(DoEvent));
		base.OnGraphStoped();
	}

	protected override void RegisterPorts()
	{
		_output = AddFlowOutput("Out", "output");
		AddValueOutput("被抓取实体ID", "beGrabEntityID", () => _beGrabEntityID);
		AddValueOutput("结果值", "result", () => _canBeGrab);
		AddValueOutput("抓取实体ID", "grabEntityID", () => _grabEntityID);
		AddValueOutput("AbilityID", "abilityID", () => _abilityID);
		AddValueOutput("抛掷物ID", "projectileID", () => _projectileID);
	}

	private void DoEvent(DamageEventParam pDamageEventParam, int pBeGrabEntityID, bool pCanBeGrab)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(pBeGrabEntityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			_returnData.Clear();
			Flow f = new Flow
			{
				returnData = _returnData
			};
			_beGrabEntityID = pBeGrabEntityID;
			_canBeGrab = pCanBeGrab;
			_grabEntityID = pDamageEventParam.casterID;
			_abilityID = pDamageEventParam.abilityID;
			_projectileID = pDamageEventParam.thrownID;
			_output.Call(f);
		}
	}
}
