using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataPropertyTargetLayer : BuffDataBase
{
	public string propertyKey;

	public float propertyValue;

	public ChangeType changeType;

	public PropertyType propertyType;

	public EntityTeamType teamType;

	public int buffId;

	public override BuffOperationType EffectType => BuffOperationType.PropertyTargetLayer;

	protected override int paramsMinCount => 6;

	protected override void OnInit(List<string> paramList)
	{
		propertyKey = paramList[0];
		propertyValue = Utility.Convert.StringToFloat(paramList[1]);
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[2]);
		propertyType = Utility.Convert.StringToEnum<PropertyType>(paramList[3]);
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[4]);
		buffId = Utility.Convert.StringToInt(paramList[5]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{propertyKey},{propertyValue},{changeType},{propertyType},{teamType},{buffId}";
	}
}
