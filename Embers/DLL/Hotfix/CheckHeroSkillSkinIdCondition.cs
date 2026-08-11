#define ENABLE_LOG
using System.Collections.Generic;
using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("获取英雄技能皮肤ID", 0)]
[Category("AI/DragonLost/Skill")]
[Description("根据实体ID获取该实体当前下发的技能皮肤ID，并写回黑板")]
public class CheckHeroSkillSkinIdCondition : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("需要读取技能皮肤数据的实体ID")]
	public BBParameter<int> EntityId;

	[Name("技能ID", 0)]
	[Description("需要读取技能ID")]
	public BBParameter<int> SkillId;

	[Name("黑板技能皮肤ID", 0)]
	[Description("返回给黑板的技能皮肤ID，值为下发的ID")]
	public BBParameter<int> BlackboardHeroSkillSkinId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BlackboardHeroSkillSkinId.value = 0;
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: true);
		if (entity == null)
		{
			LogActionError($"没有找到实体Id = {EntityId.value} 的实体..");
			EndAction();
			return;
		}
		if (!(entity is HeroEntity heroEntity))
		{
			LogActionError($"实体Id = {EntityId.value} 不是HeroEntity..");
			EndAction();
			return;
		}
		Dictionary<int, int> dictionary = heroEntity.BattleHeroData?.HeroModel?.UseSkillCameraSkinId;
		if (dictionary == null || dictionary.Count == 0)
		{
			EndAction();
			return;
		}
		foreach (KeyValuePair<int, int> item in dictionary)
		{
			if (item.Value > 0 && SkillId.value == item.Key)
			{
				BlackboardHeroSkillSkinId.value = item.Value;
				break;
			}
		}
		EndAction();
	}
}
