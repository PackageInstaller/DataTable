#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase.ECS;
using GameFramework;

namespace Ase;

public class SkillLabelModifyBuff : BuffOperationBase<BuffDataSkillLabel>
{
	private HeroSkillData skillData;

	protected override void OnExecute()
	{
		skillData = base.buffOwner.GetComponent<SkillComponent>()?.GetSkillData(dataBase.skillId);
		if (skillData == null)
		{
			Log.Error("无法获取技能：" + dataBase.skillId);
		}
		else if (dataBase.changeType == ChangeType.Add)
		{
			skillData.AddSkillLabelTypeEnum(dataBase.skillLabel);
		}
		else if (dataBase.changeType == ChangeType.Dec)
		{
			skillData.RemoveSkillLabelTypeEnum(dataBase.skillLabel);
		}
		else
		{
			Log.Error("buff 1402:只支持 Add Dec");
		}
	}

	protected override void OnDispose()
	{
		if (skillData != null)
		{
			if (dataBase.changeType == ChangeType.Add)
			{
				skillData.RemoveSkillLabelTypeEnum(dataBase.skillLabel);
			}
			else if (dataBase.changeType == ChangeType.Dec)
			{
				skillData.AddSkillLabelTypeEnum(dataBase.skillLabel);
			}
		}
	}
}
