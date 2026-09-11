using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("初始化架势槽", 0)]
[Category("Logic/Attribute")]
[Description("用来给角色初始化修正状态的复合节点, 其中 修正值最大值占比 使用属性的中的值,如果没有找到占比值,则使用传入的默认值")]
public class InitExposedStatus : FlowControlNodeOfLogic
{
	private ValueInput<int> m_entityIDInput;

	private ValueInput<long> m_valueInput;

	private ValueInput<int> m_maxValuePercentInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private ValueInput<long> m_reducedValuePermillInput;

	private ValueInput<int> m_delayInput;

	private ValueInput<int> m_tickInput;

	protected override void RegisterPorts()
	{
		m_entityIDInput = AddValueInput<int>("实体ID", "entityID");
		m_valueInput = AddValueInput<long>("当前值", "curValue").SetDefaultAndSerializedValue(0L);
		m_maxValuePercentInput = AddValueInput<int>("总量占血量上限【百分比】", "defaultPercent").SetDefaultAndSerializedValue(60);
		m_reducedValuePermillInput = AddValueInput<long>("减少量占血量上限【千分比】", "reducedValue").SetDefaultAndSerializedValue(5L);
		m_delayInput = AddValueInput<int>("延迟(毫秒)", "delay").SetDefaultAndSerializedValue(0);
		m_tickInput = AddValueInput<int>("间隔(毫秒)", "tick").SetDefaultAndSerializedValue(1000);
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (!CommonProcessor.TryGetAliveRole(base.mSimContext, m_entityIDInput.GetValue(), out var simEntity))
			{
				m_error.Call(f);
			}
			else
			{
				if (simEntity.hasEntityExposedValueBreak)
				{
					simEntity.RemoveEntityExposedValueBreak();
				}
				if (!AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2170, out var baseValue, out var _, out var _))
				{
					baseValue = m_maxValuePercentInput.value;
					Debug.LogError("属性中无法获取到修正值的最大血量占比,故使用传入的默认值:" + baseValue);
				}
				long newMMaxValue = simEntity.entityBlackboard.var.mMaxHP * baseValue / 100;
				long newMReducedValue = simEntity.entityBlackboard.var.mMaxHP * m_reducedValuePermillInput.value / 1000;
				if (simEntity.hasEntityExposedValue)
				{
					simEntity.ReplaceEntityExposedValue(m_valueInput.value, newMMaxValue, newMReducedValue, m_tickInput.value, m_delayInput.value, 0u, newMManualEnter: false);
				}
				else
				{
					simEntity.AddEntityExposedValue(m_valueInput.value, newMMaxValue, newMReducedValue, m_tickInput.value, m_delayInput.value, 0u, newMManualEnter: false);
				}
				m_out.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => m_entityIDInput.GetValue());
	}
}
