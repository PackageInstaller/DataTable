using System.Collections.Generic;

namespace Ase;

[Trigger("怪物组2显示技能按钮触发器")]
public class MonsterGroupEvent2ShowSkillBtnEventTrigger : MonsterGroupEventTrigger
{
	public List<HeroSkillTypeEnum> heroSkillTypeEnums;

	public override string TriggerName => "怪物组-显示技能按钮触发器";

	protected override async void DoExecute()
	{
		base.DoExecute();
		if (heroSkillTypeEnums == null || heroSkillTypeEnums.Count <= 0)
		{
			return;
		}
		TouchSystem system = sceneSystem.GetSystem<TouchSystem>();
		if (system != null)
		{
			for (int i = 0; i < heroSkillTypeEnums.Count; i++)
			{
				system.SetSkillBtnHide(heroSkillTypeEnums[i], hide: false);
			}
		}
	}
}
