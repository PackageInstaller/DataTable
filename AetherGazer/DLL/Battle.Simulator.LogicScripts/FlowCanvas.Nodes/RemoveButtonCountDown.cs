using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("移除按键倒计时(逻辑)", 0)]
[Category("Logic/ButtonCountDown")]
[Description("整合节点，通过添加 100099993 这个 buff 来隐藏掉按键倒计时周围的白框")]
public class RemoveButtonCountDown : FlowControlNodeOfLogic
{
	private ValueInput<int> _entityIDInput;

	private ValueInput<ButtonType> _indexInput;

	private FlowOutput _output;

	private FlowOutput _errorOut;

	protected override void RegisterPorts()
	{
		_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		_indexInput = AddValueInput<ButtonType>("仅技能一二三", "index");
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
				if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
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
							entityWithEntityID.entityBuff.mDuringArray[i] = 0;
						}
					}
					BuffProcessor.TryAddBuff(entityWithEntityID.creationIndex, entityWithEntityID.creationIndex, 100099993, 0, 1, 1, isOnce: false, isLoop: false, isOverride: false, (int)_indexInput.value, 0, 0, 0, 0, 1, out var _);
					_output.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => _entityIDInput.value);
	}
}
