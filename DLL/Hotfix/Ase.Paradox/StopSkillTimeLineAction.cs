using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("停止一个技能TimeLine", 0)]
[Category("✫ DragonLost/Skill")]
[Description("通过执行ID停止一个技能TimeLine")]
public class StopSkillTimeLineAction : ActionTaskBase
{
	[Name("Line执行ID", 0)]
	public BBParameter<int> SkillExecuteId;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<SkillTimeLineSystem>().StopSkillTimeLine(SkillExecuteId.value);
		EndAction();
	}
}
