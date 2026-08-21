using System;
using System.Collections.Generic;
using System.Text;

namespace Ase;

public class BuffDataChangeCreateBullet : BuffDataBase
{
	public int[] args;

	public override BuffOperationType EffectType => BuffOperationType.BuffChangeCreateBullet;

	protected override int paramsMinCount => -1;

	protected override void OnInit(List<string> paramList)
	{
		args = new int[paramList.Count];
		for (int i = 0; i < paramList.Count; i++)
		{
			args[i] = Utility.Convert.StringToInt(paramList[i]);
		}
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		if (args != null)
		{
			for (int i = 0; i < args.Length; i++)
			{
				stringBuilder.Append($",{args[i]}");
			}
		}
		return stringBuilder.ToString();
	}
}
