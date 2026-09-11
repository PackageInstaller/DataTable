using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("逻辑输入事件", 0)]
[Category("Logic/事件")]
[Description("在获取输入的时候触发")]
public class LogicInputEvent : EventNode
{
	private FlowOutput logicInputEventOutput;

	private ValueOutput<int> entityIDOut;

	private ValueOutput<int> keyCodeOut;

	private ValueInput<bool> isDiableByCDInput;

	private ValueInput<bool> isPredictionInput;

	private int entityID;

	private int keyCode;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		isDiableByCDInput = AddValueInput<bool>("CD中不输出事件").SetDefaultAndSerializedValue(v: true);
		isPredictionInput = AddValueInput<bool>("是否需要预测");
		entityIDOut = AddValueOutput("entityID", () => entityID);
		keyCodeOut = AddValueOutput("keyCode", () => keyCode);
		logicInputEventOutput = AddFlowOutput("输出");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mLogicInputEvent = (Action<int, int>)Delegate.Combine(simInterface.mLogicInputEvent, new Action<int, int>(OnLogicInputEventHandler));
	}

	private void OnLogicInputEventHandler(int entityID, int inputKey)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return;
		}
		int num;
		int num2;
		int abilityByInput;
		if (isDiableByCDInput.GetValue())
		{
			abilityByInput = AbilitiesProcessor.GetAbilityByInput(entityWithEntityID, inputKey);
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
		if (entityWithEntityID.hasEntityRemotePlayer || isPredictionInput.value)
		{
			this.entityID = entityID;
			keyCode = inputKey;
			Flow f = new Flow
			{
				returnData = returnData
			};
			logicInputEventOutput.Call(f);
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
