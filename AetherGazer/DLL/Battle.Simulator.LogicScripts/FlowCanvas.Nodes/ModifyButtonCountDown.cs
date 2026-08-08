using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("修改按键倒计时(逻辑)", 0)]
[Category("Logic/ButtonCountDown")]
[Description("整合节点，得到处理逻辑为 100099994 的 buff 对比参数从而修改时间达到调整白框倒计时的目的;\n乘除不处理")]
public class ModifyButtonCountDown : FlowControlNodeOfLogic
{
	private ValueInput<int> _entityIDInput;

	private ValueInput<ButtonType> _indexInput;

	private ValueInput<OperationMethod> _opInput;

	private ValueInput<int> _valueInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_indexInput = AddValueInput<ButtonType>("仅技能一二三", "index");
		_opInput = AddValueInput<OperationMethod>("操作(乘除不处理)", "operationMethod");
		_valueInput = AddValueInput<int>("数值", "length");
		_output = AddFlowOutput("Out", "output");
		_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("启用", "input", delegate(Flow f)
		{
			if (!ButtonCountDownFunction.IsValidButtonType(_indexInput.value))
			{
				Debug.LogError("按键倒计时只支持技能一二三");
				_errorOut.Call(f);
			}
			else
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_entityIDInput.value);
				if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityBuff)
				{
					_errorOut.Call(f);
				}
				else
				{
					int value = (int)_indexInput.value;
					for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
					{
						if (entityWithEntityID.entityBuff.mBuffClassIDArray[i] == 100099994 && !entityWithEntityID.entityBuff.IsInPendingRemoveArray(entityWithEntityID.entityBuff.mBuffID[i]) && entityWithEntityID.entityBuff.mBuffParamsArray[i].v1 == value)
						{
							switch (_opInput.value)
							{
							case OperationMethod.Add:
								entityWithEntityID.entityBuff.mDuringArray[i] += _valueInput.value;
								break;
							case OperationMethod.Set:
								entityWithEntityID.entityBuff.mDuringArray[i] = _valueInput.value;
								break;
							case OperationMethod.Subtract:
								entityWithEntityID.entityBuff.mDuringArray[i] -= _valueInput.value;
								break;
							}
						}
					}
					_output.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.value);
	}
}
