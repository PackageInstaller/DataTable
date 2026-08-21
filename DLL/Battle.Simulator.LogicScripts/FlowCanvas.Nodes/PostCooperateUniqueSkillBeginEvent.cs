using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("发送连携奥义开始事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("发送连携奥义开始事件")]
public class PostCooperateUniqueSkillBeginEvent : PostUniqueSkillEventBase
{
	protected override void AddCustomValueInput()
	{
	}

	protected override void AddCustomValueOutput()
	{
	}

	protected override bool GetIsCooperating()
	{
		return true;
	}

	protected override int GetStep()
	{
		return 1;
	}
}
