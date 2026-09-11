using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("发送技能执行事件(逻辑)", 0)]
[Category("Logic")]
[Description("直接以指定参数抛出UpdateAbilityLogicEvent事件\n在拦截无动作的自定义逻辑技能的末尾，需要将该流程作为技能进行判定时使用。\n发送事件牵动范围很大，建议仅在以【逻辑输入事件】开头的树-最末尾-使用\n不会对输入值进行检查\n禁书节点，谨慎使用")]
[Color("f89232")]
public class LogicAbilityEventInvoker : FlowNode
{
	private ValueInput<int> vInEntId;

	private ValueInput<int> vInAbilityId;

	private ValueInput<int> vInTime;

	protected override void RegisterPorts()
	{
		vInEntId = AddValueInput<int>("实体ID", "entityId");
		vInAbilityId = AddValueInput<int>("技能Id", "abilityId");
		vInTime = AddValueInput<int>("技能执行时间(ms)", "abilityTime");
		FlowOutput fOut = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			int value = vInEntId.value;
			int value2 = vInAbilityId.value;
			int value3 = vInTime.value;
			base.mSimContext.GetSimInterface().mUpdateAbilityLogicEvent?.Invoke(value, value2, value3, 0);
			f.Call(fOut);
		});
	}
}
