using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("发送奥义事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("发送奥义事件;阶段:1-开始,2-结束;\n是连携:会细到为普通奥义事件和连携奥义事件")]
public class PostUniqueSkillEvent : PostUniqueSkillEventBase
{
	private ValueInput<int> _stepInput;

	private ValueInput<bool> _isCooperating;

	protected override void AddCustomValueInput()
	{
		_stepInput = AddValueInput<int>("阶段", "step");
		_isCooperating = AddValueInput<bool>("是连携", "isCooperating");
	}

	protected override void AddCustomValueOutput()
	{
	}

	protected override bool GetIsCooperating()
	{
		return _isCooperating.value;
	}

	protected override int GetStep()
	{
		return _stepInput.value;
	}
}
