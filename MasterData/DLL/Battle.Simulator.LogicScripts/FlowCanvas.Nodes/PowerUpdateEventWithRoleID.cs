using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("机制值变更事件(实体类型ID)", 0)]
[Category("Logic/事件")]
[Description("机制值变更事件，原能量变更事件")]
public class PowerUpdateEventWithRoleID : PowerUpdateEvent
{
	private ValueInput<int> _roleIDInput;

	protected override void RegisterPorts()
	{
		_roleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
		_energyType = new ValueInput<e_EnergyType>().SetDefaultAndSerializedValue(e_EnergyType.All);
		_out = AddFlowOutput("Out");
		_fullOut = AddFlowOutput("不满变为满");
		_emptyOut = AddFlowOutput("满变为不满");
		AddValueOutput("实体ID", () => _entityID);
		AddValueOutput("机制值", "能量", () => _power);
		AddValueOutput("原机制值", "oldValue", () => _OldValue);
		AddValueOutput("变化值", "delta", () => _power - _OldValue);
	}

	protected override void OnPowerUpdate(int entityID, int newValue, int oldValue, int newMaxValue, int oldMaxValue, EnergyType energyType)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || _roleIDInput.value == entityWithEntityID.entityConfig.mId)
		{
			base.OnPowerUpdate(entityID, newValue, oldValue, newMaxValue, oldMaxValue, energyType);
		}
	}
}
