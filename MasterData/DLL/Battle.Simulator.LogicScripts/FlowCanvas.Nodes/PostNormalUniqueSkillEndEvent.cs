using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("发送普通奥义结束事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("如题")]
public class PostNormalUniqueSkillEndEvent : PostUniqueSkillEventBase
{
	protected override void AddCustomValueInput()
	{
	}

	protected override void AddCustomValueOutput()
	{
	}

	protected override bool GetIsCooperating()
	{
		return false;
	}

	protected override int GetStep()
	{
		return 2;
	}
}
