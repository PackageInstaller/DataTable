using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("添加破防值组件", 0)]
[Category("Logic/Attribute")]
[Description("添加破防值组件")]
public class AddPostureValueComponent : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> delayTimeInput = AddValueInput<int>("脱战计时时长");
		ValueInput<int> deltaValueInput = AddValueInput<int>("脱战时上涨速度");
		ValueInput<int> intervalInput = AddValueInput<int>("上涨间隔");
		ValueInput<int> maxValueInput = AddValueInput<int>("最大值");
		ValueInput<int> cdTimeInput = AddValueInput<int>("破防保护时间");
		ValueInput<int> breakTimeInput = AddValueInput<int>("破防时长");
		ValueInput<int> damageTypeInput = AddValueInput<int>("元素属性").SetDefaultAndSerializedValue(-1);
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else
			{
				int value = maxValueInput.value;
				int value2 = intervalInput.value;
				if (entityWithEntityID.hasEntityPostureValue)
				{
					entityWithEntityID.ReplaceEntityPostureValue(deltaValueInput.value, value, value, BreakState.tick, value2, cdTimeInput.value, breakTimeInput.value, delayTimeInput.value, value2, 0u, damageTypeInput.value);
				}
				else
				{
					entityWithEntityID.AddEntityPostureValue(deltaValueInput.value, value, value, BreakState.tick, value2, cdTimeInput.value, breakTimeInput.value, delayTimeInput.value, value2, 0u, damageTypeInput.value);
				}
				output.Call(f);
			}
		});
	}
}
