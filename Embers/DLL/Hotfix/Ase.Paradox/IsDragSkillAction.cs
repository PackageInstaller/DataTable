using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("判断技能是否是拖拽技能", 0)]
[Category("✫ DragonLost/Skill")]
[Description("判断给定的技能UV坐标是否对应拖拽技能。")]
public class IsDragSkillAction : ActionTaskBase
{
	[Name("SkillUv", 0)]
	[Description("技能UV坐标")]
	public BBParameter<Vector2> SkillUv;

	[Name("是否是拖拽", 0)]
	[Description("指示给定的技能UV坐标是否对应拖拽技能")]
	public BBParameter<bool> IsDragSkill;

	protected override void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}
}
