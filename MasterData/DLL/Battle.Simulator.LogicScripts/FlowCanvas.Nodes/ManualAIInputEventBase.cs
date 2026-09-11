using System;
using System.Collections.Generic;
using Config;

namespace FlowCanvas.Nodes;

public abstract class ManualAIInputEventBase : EventNode
{
	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected int m_entityID;

	protected int m_keyCode;

	private FlowOutput m_output;

	protected ValueInput<bool> m_isDisableInCDInput;

	protected override void RegisterPorts()
	{
		AddBaseFlowOutput();
		AddBaseValueInput();
		AddCustomValueInput();
		AddBaseValueOutput();
		AddCustionValueOutput();
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mManualAIInputEvent = (Action<int, int>)Delegate.Combine(simInterface.mManualAIInputEvent, new Action<int, int>(OnEventHandler));
	}

	public void OnEventHandler(int entityID, int keyCode)
	{
		m_entityID = entityID;
		m_keyCode = keyCode;
		Flow f = new Flow
		{
			returnData = returnData,
			userData = base.mSimContext.GetEntityWithEntityID(entityID)
		};
		if (ConditionFunc(m_isDisableInCDInput.GetValue(), entityID, keyCode, out var _))
		{
			m_output.Call(f);
		}
	}

	private void AddBaseFlowOutput()
	{
		m_output = AddFlowOutput("Out", "输出");
	}

	private void AddBaseValueInput()
	{
		m_isDisableInCDInput = AddValueInput<bool>("CD中不输出事件").SetDefaultAndSerializedValue(v: true);
	}

	private void AddBaseValueOutput()
	{
		AddValueOutput("实体ID", "实体ID:", () => m_entityID);
		AddValueOutput("KeyCode", "keyCode", () => m_keyCode);
	}

	protected abstract void AddCustomValueInput();

	protected abstract void AddCustionValueOutput();

	protected virtual bool ConditionFunc(bool disableInCD, int entityID, int keyCode, out SimEntity simEntity)
	{
		simEntity = base.mSimContext.GetEntityWithEntityID(entityID);
		int num;
		int num2;
		int abilityByInput;
		if (disableInCD)
		{
			abilityByInput = AbilitiesProcessor.GetAbilityByInput(simEntity, keyCode);
			abilityByInput = CDProcessor.CheckAbilityIsAvoid(abilityByInput);
			ConfigHelper.GetInstance().TryGetConfig<AbilityConfig>(abilityByInput, out var config);
			if (config == null)
			{
				return false;
			}
			if (config.OriginAbility != 0)
			{
				num = ((abilityByInput == config.OriginAbility) ? 1 : 0);
				if (num == 0)
				{
					num2 = config.OriginAbility;
					goto IL_0056;
				}
			}
			else
			{
				num = 1;
			}
			num2 = abilityByInput;
			goto IL_0056;
		}
		goto IL_007c;
		IL_0056:
		abilityByInput = num2;
		if (num != 0 && CDProcessor.InCD(simEntity, abilityByInput) && !CDProcessor.IsIgnore(simEntity, abilityByInput) && !CDProcessor.HasAward(simEntity, abilityByInput))
		{
			return false;
		}
		goto IL_007c;
		IL_007c:
		return true;
	}
}
