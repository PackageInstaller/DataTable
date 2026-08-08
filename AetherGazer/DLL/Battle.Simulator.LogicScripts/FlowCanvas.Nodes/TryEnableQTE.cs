using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("检查是否能触发QTE(过时)", 0)]
[Category("Logic/QTE")]
[Description("如题")]
public class TryEnableQTE : FlowNode
{
	private ValueInput<int> _entityIDInput;

	private ValueInput<int> _targetIDInput;

	private ValueInput<string> _qteArgStrInput;

	private FlowOutput _trueOut;

	private FlowOutput _falseOut;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "EntityID");
		_targetIDInput = AddValueInput<int>("目标ID", "TargetID");
		_qteArgStrInput = AddValueInput<string>("QTE触发参数(字符)", "QTETriggerArgStr").SetDefaultAndSerializedValue(string.Empty);
		_trueOut = AddFlowOutput("True");
		_falseOut = AddFlowOutput("False");
		AddFlowInput("In", Invoke);
	}

	private void Invoke(Flow f)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.value);
		if (entityWithEntityID == null)
		{
			Debug.LogError("无法的EntityID " + _entityIDInput.value);
			return;
		}
		SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(_targetIDInput.value);
		if (entityWithEntityID2 == null)
		{
			Debug.LogError("无法的EntityID " + _targetIDInput.value);
		}
		else
		{
			_falseOut.Call(f);
		}
	}
}
