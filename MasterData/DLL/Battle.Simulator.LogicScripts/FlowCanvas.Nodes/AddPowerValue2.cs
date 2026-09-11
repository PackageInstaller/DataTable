using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加机制值(返改变量)", 0)]
[Category("Logic/Attribute")]
[Description("添加能量值,返回结果值,差值量;会调用能量变更事件，不走机制加成和消耗减免")]
public class AddPowerValue2 : FlowControlNode
{
	private int m_curValue;

	private int m_delta;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID", "EntityIDVar");
		ValueInput<int> addValueVar = AddValueInput<int>("增量", "addValueVar");
		ValueInput<int> maxValueVar = AddValueInput<int>("最大值", "maxValueVar");
		AddValueOutput("实体ID", "EntityID", () => entityIDVar.GetValue());
		AddValueOutput("结果值", "CurPowerValue", () => m_curValue);
		AddValueOutput("差值", "DeltaValue", () => m_delta);
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			int oldValue = 0;
			AttributeProcessor.AddPowerValue(entityIDVar.value, maxValueVar.value, addValueVar.value, out m_curValue, out oldValue);
			m_delta = m_curValue - oldValue;
			AttributeProcessor.TryGetEnergyMaxValue(base.mSimContext.GetEntityWithEntityID(entityIDVar.value), out var maxValue);
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.value);
			charactor_param config = ConfigHelper.GetInstance().GetConfig<charactor_param>(entityWithEntityID.entityConfig.mId);
			if (base.mSimContext.GetSimInterface().mOnPowerUpdate != null)
			{
				base.mSimContext.GetSimInterface().mOnPowerUpdate(entityIDVar.value, m_curValue, oldValue, maxValue, maxValue, (EnergyType)config.EnergyType);
			}
			output.Call(f);
		});
	}
}
