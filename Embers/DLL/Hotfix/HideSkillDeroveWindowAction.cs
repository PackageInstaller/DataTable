using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("关闭技能的派生窗口", 0)]
[Category("✫ DragonLost/Skill")]
[Description("主动关闭技能的派生窗口,只有派生的技能有效")]
public class HideSkillDeroveWindowAction : ActionTaskBase
{
	[Name("技能ID", 0)]
	[Description("技能ID")]
	public BBParameter<int> SkillId;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<SkillComponent>().HideSkillDeriveWindow(SkillId.value);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"关闭技能的派生窗口 技能ID : {SkillId.value}", ownerEntity);
		}
		EndAction();
	}
}
