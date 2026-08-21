using System;
using System.Collections.Generic;
using Config;

namespace FlowCanvas.Nodes;

public abstract class LogicInputEventBase : EventNode
{
	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	private FlowOutput _Out;

	private ValueOutput<int> keyCodeOut;

	private ValueInput<bool> _IsDiableByCDInput;

	private ValueInput<bool> isPredictionInput;

	private int _EntityID;

	private int _KeyCode;

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mLogicInputEvent = (Action<int, int>)Delegate.Combine(simInterface.mLogicInputEvent, new Action<int, int>(OnLogicInputEventHandler));
	}

	protected override void RegisterPorts()
	{
		_IsDiableByCDInput = AddValueInput<bool>("CD中不输出事件").SetDefaultAndSerializedValue(v: true);
		isPredictionInput = AddValueInput<bool>("是否需要预测");
		_Out = AddFlowOutput("输出");
		AddValueOutput("entityID", () => _EntityID);
	}

	protected abstract bool Condition(int pEntityID, int pInputKey);

	private void OnLogicInputEventHandler(int pEntityID, int pInputKey)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(pEntityID);
		if (entityWithEntityID == null)
		{
			return;
		}
		int num;
		int num2;
		int abilityByInput;
		if (_IsDiableByCDInput.GetValue())
		{
			abilityByInput = AbilitiesProcessor.GetAbilityByInput(entityWithEntityID, pInputKey);
			abilityByInput = CDProcessor.CheckAbilityIsAvoid(abilityByInput);
			ConfigHelper.GetInstance().TryGetConfig<AbilityConfig>(abilityByInput, out var config);
			if (config == null)
			{
				return;
			}
			if (config.OriginAbility != 0)
			{
				num = ((abilityByInput == config.OriginAbility) ? 1 : 0);
				if (num == 0)
				{
					num2 = config.OriginAbility;
					goto IL_005f;
				}
			}
			else
			{
				num = 1;
			}
			num2 = abilityByInput;
			goto IL_005f;
		}
		goto IL_007e;
		IL_007e:
		if ((entityWithEntityID.hasEntityRemotePlayer || isPredictionInput.value) && Condition(pEntityID, pInputKey))
		{
			_EntityID = pEntityID;
			_KeyCode = pInputKey;
			Flow f = new Flow
			{
				returnData = returnData
			};
			_Out.Call(f);
		}
		return;
		IL_005f:
		abilityByInput = num2;
		if (num != 0 && CDProcessor.InCD(entityWithEntityID, abilityByInput) && !CDProcessor.IsIgnore(entityWithEntityID, abilityByInput) && !CDProcessor.HasAward(entityWithEntityID, abilityByInput))
		{
			return;
		}
		goto IL_007e;
	}
}
