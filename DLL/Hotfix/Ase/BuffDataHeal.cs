using System.Collections.Generic;

namespace Ase;

public class BuffDataHeal : BuffDataBase
{
	public float healRatio;

	public List<float> healRatioList;

	public string healProperty;

	public List<string> healPropertyList;

	public PropertyType healAddType;

	public List<int> healAddTypeList;

	public EntityTeamType healAddFrom;

	public List<int> healAdditionFromList;

	public float healFixAddition;

	public int skillId;

	public bool isCreateByBullet;

	public override BuffOperationType EffectType => BuffOperationType.Heal;

	protected override int paramsMinCount => -1;

	protected override void OnInit(List<string> paramList)
	{
		if (paramList.Count != 0)
		{
			healRatio = Utility.Convert.StringToFloat(paramList[0]);
			healRatioList = new List<float> { healRatio };
			healProperty = paramList[1];
			healPropertyList = new List<string> { paramList[1] };
			healAddType = Utility.Convert.StringToEnum<PropertyType>(paramList[2]);
			healAddTypeList = new List<int> { (int)healAddType };
			healFixAddition = Utility.Convert.StringToFloat(paramList[3]);
			healAddFrom = Utility.Convert.StringToEnum<EntityTeamType>(paramList[4]);
			healAdditionFromList = new List<int> { (int)healAddFrom };
			skillId = Utility.Convert.StringToInt(paramList[5]);
			isCreateByBullet = false;
		}
	}

	protected override void OnResetParams(params object[] args)
	{
		if (args != null && args.Length != 0 && args[0] is DRBullet dRBullet)
		{
			healRatioList = dRBullet.HealRatio;
			healPropertyList = dRBullet.HealAdd;
			healAddTypeList = dRBullet.HealAddType;
			healAdditionFromList = dRBullet.HealAdditionFrom;
			healFixAddition = dRBullet.HealFixAddition;
			skillId = dRBullet.SkillId;
			isCreateByBullet = true;
		}
	}

	protected override string OnGetDataString()
	{
		return $"{healRatio},{healProperty},{healAddType},{healAddFrom},{healFixAddition},{skillId}";
	}
}
