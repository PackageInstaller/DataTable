using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("AI取消技能拖拽", 0)]
[Category("✫ DragonLost/Skill")]
[Description("AI取消技能拖拽")]
public class AICancelSkillDragAction : ActionTaskBase
{
	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<SkillComponent>().RefreshSkillData();
		OnActionFinish();
	}
}
