using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("普通奥义结束事件", 0)]
[Category("Logic/事件")]
[Description("如题")]
public class DoNormalUniqueSkillEndEvent : DoUniqueSkillEventBase
{
	protected override void AddCustomValueInput()
	{
	}

	protected override void AddCustomValueOutput()
	{
	}

	protected override bool IsCurrentCategory(UniqueSkillEvent pEvt)
	{
		return !pEvt.mIsCooperating;
	}

	protected override bool IsCurrentStep(UniqueSkillEvent pEvt)
	{
		return pEvt.mStep == 2;
	}
}
