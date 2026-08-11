using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataExecuteBulletHit : BuffDataBase
{
	public int bulletId;

	public override BuffOperationType EffectType => BuffOperationType.ExecuteBulletHit;

	protected override int paramsMinCount => 1;

	protected override void OnInit(List<string> paramList)
	{
		bulletId = Utility.Convert.StringToInt(paramList[0]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{bulletId}";
	}
}
