using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class BuffDataCreateBuff : BuffDataBase
{
	public EntityTeamType teamType;

	[HideInInspector]
	public DRBuff buffConfig;

	public int createBuffId;

	public int buffLayer;

	public float duration;

	public bool isCheakAddCondition;

	public override BuffOperationType EffectType => BuffOperationType.CreateBuff;

	protected override int paramsMinCount => 4;

	protected override void OnInit(List<string> paramList)
	{
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[0]);
		createBuffId = Utility.Convert.StringToInt(paramList[1]);
		buffLayer = Utility.Convert.StringToInt(paramList[2]);
		duration = Utility.Convert.StringToFloat(paramList[3]);
		if (paramList.Count >= 5)
		{
			isCheakAddCondition = Utility.Convert.StringToBool(paramList[4]);
		}
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return string.Format("{0},{1},{2},{3}{4}", teamType, createBuffId, buffLayer, duration, isCheakAddCondition ? ",TRUE" : string.Empty);
	}

	protected override void OnClear()
	{
		isCheakAddCondition = false;
	}
}
