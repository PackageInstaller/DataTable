using System.Collections.Generic;

namespace Ase;

[Trigger("显示技能按钮触发器")]
public class SkillBtnShowTrigger : BaseTrigger
{
	public List<HeroSkillTypeEnum> SkillTypeEnums;

	public override string TriggerName => "显示技能按钮触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (SkillTypeEnums == null || SkillTypeEnums.Count <= 0)
		{
			return;
		}
		TouchSystem system = sceneSystem.GetSystem<TouchSystem>();
		if (system != null)
		{
			for (int i = 0; i < SkillTypeEnums.Count; i++)
			{
				system.SetSkillBtnHide(SkillTypeEnums[i], hide: false);
			}
		}
	}
}
