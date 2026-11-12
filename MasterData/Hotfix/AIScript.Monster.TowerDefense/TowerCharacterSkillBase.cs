using System.Collections.Generic;
using AIScript.DynamicLevel;
using TrueSync;

namespace AIScript.Monster.TowerDefense;

public class TowerCharacterSkillBase : SkillAdvancedBase
{
	private FP addSkillTime_BaseValue;

	private FP addSkillTime_Percent;

	public virtual Dictionary<int, FP> dicPerk_BaseTime { get; }

	public virtual Dictionary<int, FP> dicPerk_AddTime { get; }

	public virtual FP BaseSkillTime { get; }

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_actor is TowerDefenseCharacterActor { beginEnergyOnCast: false } towerDefenseCharacterActor)
		{
			CalTotleTime();
			FP totleSkillTime = (BaseSkillTime + addSkillTime_BaseValue) * (1 + addSkillTime_Percent);
			towerDefenseCharacterActor.skillMgr.BeginRecoveryEnergyCD(towerDefenseCharacterActor.mainSkillId, totleSkillTime);
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	private void CalTotleTime()
	{
		addSkillTime_BaseValue = 0;
		addSkillTime_Percent = 0;
		if (dicPerk_BaseTime != null)
		{
			foreach (KeyValuePair<int, FP> item in dicPerk_BaseTime)
			{
				if (GetPerk(item.Key))
				{
					addSkillTime_BaseValue += item.Value;
				}
			}
		}
		if (dicPerk_BaseTime == null)
		{
			return;
		}
		foreach (KeyValuePair<int, FP> item2 in dicPerk_BaseTime)
		{
			if (GetPerk(item2.Key))
			{
				addSkillTime_Percent += item2.Value;
			}
		}
	}
}
