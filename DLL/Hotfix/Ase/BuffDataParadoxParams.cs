using System;
using System.Collections.Generic;
using System.Text;

namespace Ase;

public class BuffDataParadoxParams : BuffDataBase
{
	[Serializable]
	public class ParadoxParams
	{
		public string paramsKey;

		public ValueTypeEnum typeEnum;

		public override string ToString()
		{
			return $"{paramsKey},{typeEnum}";
		}
	}

	public int paradoxId;

	public ParadoxParams[] paradoxParams = new ParadoxParams[0];

	public override BuffOperationType EffectType => BuffOperationType.ParadoxParams;

	protected override int paramsMinCount => 1;

	protected override void OnInit(List<string> paramList)
	{
		paradoxId = Utility.Convert.StringToInt(paramList[0]);
		if (paramList.Count > 1 && paramList.Count % 2 != 0)
		{
			paradoxParams = new ParadoxParams[(paramList.Count - 1) / 2];
			for (int i = 0; i < paradoxParams.Length; i++)
			{
				paradoxParams[i] = new ParadoxParams
				{
					paramsKey = paramList[i * 2 + 1],
					typeEnum = Utility.Convert.StringToEnum<ValueTypeEnum>(paramList[i * 2 + 2])
				};
			}
		}
	}

	protected override void OnResetParams(params object[] args)
	{
	}

	protected override string OnGetDataString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append($"{paradoxId}");
		if (!paradoxParams.IsNullOrEmpty())
		{
			for (int i = 0; i < paradoxParams.Length; i++)
			{
				stringBuilder.Append("," + paradoxParams[i].ToString());
			}
		}
		return stringBuilder.ToString();
	}

	protected override void OnClear()
	{
		paradoxParams = null;
	}
}
