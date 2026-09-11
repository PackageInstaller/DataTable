using System;

namespace FlowCanvas.Nodes;

public class IsTargetInRangeWithGreaterOrLessBase : FlowNode
{
	protected FlowOutput _greaterOut;

	protected FlowOutput _lessOut;

	protected FlowOutput _equalsOut;

	protected FlowOutput _errorOut;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体1ID");
		ValueInput<int> entityID2Input = AddValueInput<int>("实体2ID");
		ValueInput<int> rangeInput = AddValueInput<int>("范围");
		_greaterOut = AddFlowOutput("大于");
		_lessOut = AddFlowOutput("小于");
		_equalsOut = AddFlowOutput("等于");
		_errorOut = AddFlowOutput("Error", "errorOut");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(entityID2Input.value);
			if (entityWithEntityID == null || entityWithEntityID2 == null)
			{
				_errorOut.Call(f);
			}
			else
			{
				Check(f, entityWithEntityID, entityWithEntityID2, rangeInput.value);
			}
		});
	}

	protected virtual void Check(Flow f, SimEntity entity, SimEntity aimEntity, int range)
	{
		throw new NotImplementedException();
	}
}
