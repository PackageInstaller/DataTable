using System;
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class BuffDataWeaponKeenness : BuffDataBase
{
	public override BuffOperationType EffectType => BuffOperationType.WeaponKeenness;

	protected override int paramsMinCount => 0;

	public static BuffDataWeaponKeenness Create()
	{
		return ReferencePool.Acquire<BuffDataWeaponKeenness>();
	}

	protected override void OnInit(List<string> paramList)
	{
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return "";
	}
}
