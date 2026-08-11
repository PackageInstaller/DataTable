using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataDamageRatio : BuffDataBase
{
	public float ratio;

	public string propertyKey;

	public PropertyType propertyType;

	public float fixedValue;

	public EntityTeamType teamType;

	public int damageTextId;

	public int effectId;

	public string pointKey;

	public override BuffOperationType EffectType => BuffOperationType.DamageRatio;

	protected override int paramsMinCount => 6;

	protected override void OnInit(List<string> paramList)
	{
		ratio = Utility.Convert.StringToFloat(paramList[0]);
		propertyKey = paramList[1];
		propertyType = Utility.Convert.StringToEnum<PropertyType>(paramList[2]);
		fixedValue = Utility.Convert.StringToFloat(paramList[3]);
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[4]);
		damageTextId = Utility.Convert.StringToInt(paramList[5]);
		if (paramList.Count > 6)
		{
			effectId = Utility.Convert.StringToInt(paramList[6]);
			if (paramList.Count > 7)
			{
				pointKey = paramList[7];
			}
		}
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return string.Format("{0},{1},{2},{3},{4},{5}{6}{7}", ratio, propertyKey, propertyType, fixedValue, teamType, damageTextId, (effectId == 0) ? string.Empty : $",{effectId}", (effectId == 0 && pointKey == string.Empty) ? string.Empty : ("," + pointKey));
	}

	protected override void OnClear()
	{
		effectId = 0;
		pointKey = string.Empty;
	}
}
