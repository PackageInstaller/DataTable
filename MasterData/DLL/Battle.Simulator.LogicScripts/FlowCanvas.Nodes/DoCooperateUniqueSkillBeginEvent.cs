using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("连携奥义开始事件(仅发起者)", 0)]
[Category("Common/事件")]
[Description("接收连携奥义开始事件")]
public class DoCooperateUniqueSkillBeginEvent : DoUniqueSkillEventBase
{
	protected override void AddCustomValueInput()
	{
	}

	protected override void AddCustomValueOutput()
	{
	}

	protected override bool IsCurrentCategory(UniqueSkillEvent pEvt)
	{
		return pEvt.mIsCooperating;
	}

	protected override bool IsCurrentStep(UniqueSkillEvent pEvt)
	{
		return pEvt.mStep == 1;
	}
}
