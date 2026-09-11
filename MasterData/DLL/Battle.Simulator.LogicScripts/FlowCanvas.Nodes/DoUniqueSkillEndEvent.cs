using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("奥义结束事件", 0)]
[Category("Logic/事件")]
[Description("相当于普通奥义结束事件+连携奥义结束事件")]
public class DoUniqueSkillEndEvent : DoUniqueSkillEventBase
{
	protected override void AddCustomValueInput()
	{
	}

	protected override void AddCustomValueOutput()
	{
	}

	protected override bool IsCurrentCategory(UniqueSkillEvent pEvt)
	{
		return true;
	}

	protected override bool IsCurrentStep(UniqueSkillEvent pEvt)
	{
		return pEvt.mStep == 2;
	}
}
