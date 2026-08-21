using System;
using System.Collections.Generic;

namespace Ase;

[Obsolete]
public class BuffDataChangeBullet : BuffDataBase
{
	public int bulletId;

	public int changedId;

	public override BuffOperationType EffectType => BuffOperationType.BuffChangeBullet;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		bulletId = Utility.Convert.StringToInt(paramList[0]);
		changedId = Utility.Convert.StringToInt(paramList[1]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		throw new NotImplementedException("该Buff类型弃用");
	}
}
