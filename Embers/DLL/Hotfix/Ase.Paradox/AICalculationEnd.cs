using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("AI行为计算完成", 0)]
[Category("✫ DragonLost/Skill")]
[Description("通知AI行为计算完成")]
public class AICalculationEnd : ActionTaskBase
{
	[Name("技能名称", 0)]
	[Description("计算完成的技能名称")]
	public BBParameter<int> resultSkillId;

	protected override async void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<AIParadoxComponent>()?.AICalculationEnd(resultSkillId.value);
		OnActionFinish();
	}
}
