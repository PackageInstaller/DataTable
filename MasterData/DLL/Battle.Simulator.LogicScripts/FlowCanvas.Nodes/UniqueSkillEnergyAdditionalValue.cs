using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("奥义能量额外加成(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("1.得到配置的加成值(Battle 下 UniqueSkill 表的 additional_value 字段);\n2.使用属性进行加成计算")]
public class UniqueSkillEnergyAdditionalValue : FlowControlNode
{
	private ValueInput<int> _EntityIDInput;

	private ValueInput<int> _RateInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_EntityIDInput = AddValueInput<int>("实体ID", "EntityID");
		_RateInput = AddValueInput<int>("千分比系数", "params").SetDefaultAndSerializedValue(1000);
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", Invoke);
		AddValueOutput("实体ID", "entityID", () => _EntityIDInput.GetValue());
	}

	private void Invoke(Flow f)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(_EntityIDInput.value);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || !entityWithEntityID.hasEntityConfig)
		{
			_Error.Call(f);
			return;
		}
		UniqueSkill config = ConfigHelper.GetInstance().GetConfig<UniqueSkill>(entityWithEntityID.entityConfig.mId);
		int num = CalcUniqueSkillEnergyAddtionalValueWithAttribute.CalcNewAddValue(entityWithEntityID.entityBlackboard.var.mAttributeID, config.AdditionalValue);
		if (entityWithEntityID.hasEntityUniqueSkillEnergy && entityWithEntityID.entityUniqueSkillEnergy.mState == EntityActionStatus.E_ACTIVE)
		{
			int num2 = num * _RateInput.GetValue() / 1000;
			entityWithEntityID.entityUniqueSkillEnergy.mValue += num2;
			base.mSimContext.GetSimInterface().mUniqueSkillEnergyAdditionalValueEvent?.Invoke(entityWithEntityID.creationIndex, num2);
		}
		_Out.Call(f);
	}
}
