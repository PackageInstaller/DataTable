using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class BuffDataEmpty : BuffDataBase
{
	public override BuffOperationType EffectType => BuffOperationType.Empty;

	protected override int paramsMinCount => 0;

	public static BuffDataEmpty Create()
	{
		return ReferencePool.Acquire<BuffDataEmpty>();
	}

	protected override void OnInit(List<string> paramList)
	{
	}

	protected override void OnResetParams(params object[] args)
	{
	}

	protected override string OnGetDataString()
	{
		return string.Empty;
	}
}
