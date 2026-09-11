using Config;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置机制值最大值", 0)]
[Category("Logic/Attribute")]
[Description("设置机制值最大值")]
public class SetEnergyMaxValue : FlowControlNode
{
	private ValueInput<int> mWantedVarValue;

	private ValueInput<int> mEntityID;

	private ValueInput<OperationMethod> mOperation;

	protected override void RegisterPorts()
	{
		mEntityID = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => mEntityID.value);
		mOperation = AddValueInput<OperationMethod>("操作符");
		mWantedVarValue = AddValueInput<int>("期望添加的变量值");
		FlowOutput o = AddFlowOutput(" ");
		AddFlowInput(" ", delegate(Flow f)
		{
			Invoke(mEntityID.value, mWantedVarValue.value, mOperation.value);
			o.Call(f);
		});
	}

	private void Invoke(int entityID, int value, OperationMethod operation)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID.entityBlackboard.var.mEnergyType == EnergyType.None)
		{
			Debug.LogError($"在 {base.graph.name} 图中，尝试使用【设置机制值最大值】节点调整机制类型为无得 {entityID} 最大机制值");
		}
		else if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.TryGetEnergyMaxValue(entityWithEntityID, out var maxValue);
			int arg = maxValue;
			switch (operation)
			{
			case OperationMethod.Set:
				maxValue = value;
				break;
			case OperationMethod.Add:
				maxValue += value;
				break;
			case OperationMethod.Subtract:
				maxValue -= value;
				break;
			case OperationMethod.Multiply:
				maxValue *= value;
				break;
			case OperationMethod.Divide:
				maxValue /= value;
				break;
			}
			AttributeProcessor.SetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2018, maxValue, 0L, 0L);
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, 2017, out var baseValue, out var _, out var _);
			long num = baseValue;
			charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.entityConfig.mId);
			if (base.mSimContext.GetSimInterface().mOnPowerUpdate != null)
			{
				base.mSimContext.GetSimInterface().mOnPowerUpdate(entityWithEntityID.creationIndex, (int)num, (int)baseValue, maxValue, arg, (EnergyType)config.EnergyType);
			}
		}
	}
}
