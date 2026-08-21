using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionPropertyPercentTarget : BuffConditionBase
{
	protected Ase.ECS.PropertyData propertyData;

	private EntityTeamType teamType;

	private string propertyKey;

	private float compareValue;

	private CompareMethodType methodType;

	public override BuffConditionType BuffConditionType => BuffConditionType.PropertyPercent;

	protected override int paramsMinCount => 4;

	protected override void OnInit(List<string> paramList)
	{
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[0]);
		propertyKey = paramList[1];
		compareValue = Utility.Convert.StringToFloat(paramList[2]);
		methodType = Utility.Convert.StringToEnum<CompareMethodType>(paramList[3]);
		BaseEntity targetByTeamType = BuffExtension.GetTargetByTeamType(entityFrom, entityTarget, teamType);
		if (targetByTeamType != null)
		{
			propertyData = targetByTeamType.GetPropertyDataOrCreate(propertyKey);
		}
	}

	protected override string OnGetDataString()
	{
		return $"{propertyKey},{compareValue},{methodType}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		return ComparePropertyValue();
	}

	private bool ComparePropertyValue()
	{
		if (propertyData != null)
		{
			return ConditionExtensions.CompareValueMethod(methodType, propertyData.ScaleValue, compareValue);
		}
		return false;
	}
}
