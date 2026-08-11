using System.Collections.Generic;

namespace Ase;

public class BuffDataParadox : BuffDataBase
{
	public int paradoxId;

	public override BuffOperationType EffectType => BuffOperationType.Paradox;

	protected override int paramsMinCount => 1;

	protected override void OnInit(List<string> paramList)
	{
		paradoxId = Utility.Convert.StringToInt(paramList[0]);
	}

	protected override void OnResetParams(params object[] args)
	{
	}

	protected override string OnGetDataString()
	{
		return $"{paradoxId}";
	}
}
