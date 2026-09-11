using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("逻辑输入触发器事件", 0)]
[Category("Logic/事件")]
[Description("在获取输入的时候触发器事件")]
public class LogicInputTriggerEvent : EventNode
{
	private FlowOutput logicInputEventOutput;

	private ValueOutput<int> entityIDOut;

	private ValueOutput<int> keyCodeOut;

	private ValueInput<bool> isDiableByCDInput;

	private ValueInput<bool> isPredictionInput;

	private int entityID;

	private int keyCode;

	private int triggerID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		isDiableByCDInput = AddValueInput<bool>("CD中不输出事件").SetDefaultAndSerializedValue(v: true);
		isPredictionInput = AddValueInput<bool>("是否需要预测");
		keyCodeOut = AddValueOutput("triggerID", () => triggerID);
		entityIDOut = AddValueOutput("entityID", () => entityID);
		keyCodeOut = AddValueOutput("keyCode", () => keyCode);
		logicInputEventOutput = AddFlowOutput("输出");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simulatorInferface = base.mLogicEvent;
		simulatorInferface.mLogicInputTriggerEvent = (Action<int, int, int>)Delegate.Combine(simulatorInferface.mLogicInputTriggerEvent, new Action<int, int, int>(OnLogicInputEventHandler));
	}

	private void OnLogicInputEventHandler(int triggerID, int entityID, int inputKey)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return;
		}
		SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(triggerID);
		if (simEntityByTriggerID == null || !simEntityByTriggerID.entityTrigger.mEnabled)
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
			AbilityConfig config = ConfigHelper.GetInstance().GetConfig<AbilityConfig>(abilityByInput);
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
					goto IL_007a;
				}
			}
			else
			{
				num = 1;
			}
			num2 = abilityByInput;
			goto IL_007a;
		}
		goto IL_0099;
		IL_0099:
		if (entityWithEntityID.hasEntityRemotePlayer || isPredictionInput.value)
		{
			this.triggerID = triggerID;
			this.entityID = entityID;
			keyCode = inputKey;
			Flow f = new Flow
			{
				returnData = returnData
			};
			logicInputEventOutput.Call(f);
		}
		return;
		IL_007a:
		abilityByInput = num2;
		if (num != 0 && CDProcessor.InCD(entityWithEntityID, abilityByInput) && !CDProcessor.IsIgnore(entityWithEntityID, abilityByInput) && !CDProcessor.HasAward(entityWithEntityID, abilityByInput))
		{
			return;
		}
		goto IL_0099;
	}
}
