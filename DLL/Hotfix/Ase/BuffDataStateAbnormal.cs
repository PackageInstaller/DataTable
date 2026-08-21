using System.Collections.Generic;

namespace Ase;

public class BuffDataStateAbnormal : BuffDataState
{
	public float progress;

	public override BuffOperationType EffectType => BuffOperationType.StateAbnormal;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		base.OnInit(paramList);
		progress = Utility.Convert.StringToFloat(paramList[2]);
	}
}
