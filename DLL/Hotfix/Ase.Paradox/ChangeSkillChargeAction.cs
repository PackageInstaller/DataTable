using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改技能充能数据", 0)]
[Category("✫ DragonLost/Skill")]
[Description("修改技能充能数据")]
public class ChangeSkillChargeAction : ActionTaskBase
{
	[Name("技能ID", 0)]
	[Description("修改的技能ID")]
	public BBParameter<int> SkillId;

	[Name("是否修改当前充能次数", 0)]
	[Description("修改当前充能次数")]
	public bool ChangeCurrentCharge;

	[Name("修改当前充能次数类型", 0)]
	[Description("修改当前充能次数类型")]
	public SkillDataChangeType CurrentChargeType;

	[Name("修改当前充能数据", 0)]
	[Description("修改当前充能数据")]
	public int CurrentCharge;

	[Name("是否修改最大充能次数", 0)]
	[Description("修改最大充能次数")]
	public bool ChangeChargeMaxCount;

	[Name("修改最大充能次数类型", 0)]
	[Description("修改最大充能次数类型")]
	public SkillDataChangeType MaxChargeType;

	[Name("修改最大充能数据", 0)]
	[Description("修改最大充能数据")]
	public int MaxChargeCount;

	[Name("是否修改最大充能时间", 0)]
	[Description("修改最大充能时间")]
	public bool ChangeMaxChargeTime;

	[Name("修改最大充能时间类型", 0)]
	[Description("修改最大充能时间类型")]
	public SkillDataChangeType MaxChargeTimeType;

	[Name("修改最大充能时间数据", 0)]
	[Description("修改最大充能时间数据")]
	public float ChargeTime;

	[Name("是否修改当前充能时间", 0)]
	[Description("修改当前充能时间")]
	public bool ChangeCurrentChargeTime;

	[Name("修改当前能时间类型", 0)]
	[Description("修改当前充能时间类型")]
	public SkillDataChangeType CurrentChargeTimeType;

	[Name("修改当前充能时间数据", 0)]
	[Description("修改当前充能时间数据")]
	public float CurrentChargeTime;

	protected override void OnExecute()
	{
		base.OnExecute();
		HeroSkillData skillData = GetOwnerEntity().GetComponent<SkillComponent>().GetSkillData(SkillId.value);
		if (skillData == null)
		{
			EndAction();
			return;
		}
		if (ChangeCurrentCharge)
		{
			switch (CurrentChargeType)
			{
			case SkillDataChangeType.Set:
				skillData.SkillCoolingData.AmendCurrentChargeCount(CurrentCharge);
				break;
			case SkillDataChangeType.Add:
				skillData.SkillCoolingData.AmendCurrentChargeCount(CurrentCharge + skillData.SkillCoolingData.CurrentChargeNumber);
				break;
			case SkillDataChangeType.Dec:
				skillData.SkillCoolingData.AmendCurrentChargeCount(skillData.SkillCoolingData.CurrentChargeNumber - CurrentCharge);
				break;
			}
		}
		if (ChangeMaxChargeTime)
		{
			switch (MaxChargeTimeType)
			{
			case SkillDataChangeType.Set:
				skillData.SkillCoolingData.AmendChargeTime(ChargeTime);
				break;
			case SkillDataChangeType.Add:
				skillData.SkillCoolingData.AmendChargeTime(ChargeTime + skillData.SkillCoolingData.ChargeTime);
				break;
			case SkillDataChangeType.Dec:
				skillData.SkillCoolingData.AmendChargeTime(skillData.SkillCoolingData.ChargeTime - ChargeTime);
				break;
			}
		}
		if (ChangeChargeMaxCount)
		{
			switch (MaxChargeType)
			{
			case SkillDataChangeType.Set:
				skillData.SkillCoolingData.AmendMaxChargeCount(MaxChargeCount);
				break;
			case SkillDataChangeType.Add:
				skillData.SkillCoolingData.AmendMaxChargeCount(MaxChargeCount + skillData.SkillCoolingData.MaxChargeNumber);
				break;
			case SkillDataChangeType.Dec:
				skillData.SkillCoolingData.AmendMaxChargeCount(skillData.SkillCoolingData.MaxChargeNumber - MaxChargeCount);
				break;
			}
		}
		if (ChangeCurrentChargeTime)
		{
			switch (CurrentChargeTimeType)
			{
			case SkillDataChangeType.Set:
				skillData.SkillCoolingData.AmendCurrentChargeTime(CurrentChargeTime);
				break;
			case SkillDataChangeType.Add:
				skillData.SkillCoolingData.AmendCurrentChargeTime(CurrentChargeTime + skillData.SkillCoolingData.CurrentChargeTime);
				break;
			case SkillDataChangeType.Dec:
				skillData.SkillCoolingData.AmendCurrentChargeTime(skillData.SkillCoolingData.CurrentChargeTime - CurrentChargeTime);
				break;
			}
		}
		EndAction();
	}
}
