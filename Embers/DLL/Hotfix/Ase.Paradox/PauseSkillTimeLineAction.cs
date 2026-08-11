using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("暂停一个技能TimeLine", 0)]
[Category("✫ DragonLost/Skill")]
[Description("通过执行ID暂停一个技能TimeLine")]
public class PauseSkillTimeLineAction : ActionTaskBase
{
	[Name("Line执行ID", 0)]
	public BBParameter<int> SkillExecuteId;

	[Name("是否暂停", 0)]
	public bool IsPause;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<SkillTimeLineSystem>().PauseSkillTimeLine(SkillExecuteId.value, IsPause);
		EndAction();
	}
}
