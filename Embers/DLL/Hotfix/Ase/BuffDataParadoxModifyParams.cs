using System;
using System.Collections.Generic;
using System.Text;

namespace Ase;

[Obsolete]
public class BuffDataParadoxModifyParams : BuffDataBase
{
	[Serializable]
	public class ParadoxModifyParams
	{
		public string paramsKey;

		public ValueTypeEnum typeEnum;

		public object value;

		public override string ToString()
		{
			return $"{paramsKey},{typeEnum},{value}";
		}
	}

	public int paradoxId;

	public List<ParadoxModifyParams> paradoxParams = new List<ParadoxModifyParams>();

	public override BuffOperationType EffectType => BuffOperationType.ParadoxModifyParams;

	protected override int paramsMinCount => 1;

	protected override void OnInit(List<string> paramList)
	{
		paradoxId = Utility.Convert.StringToInt(paramList[0]);
		if (paramList.Count <= 1)
		{
			return;
		}
		int num = 1;
		int count = paramList.Count;
		while (num < count)
		{
			if (count - num < 3)
			{
				LogWarning("参数数量错误");
				break;
			}
			ParadoxModifyParams paradoxModifyParams = new ParadoxModifyParams();
			paradoxModifyParams.paramsKey = paramList[num];
			paradoxModifyParams.typeEnum = Utility.Convert.StringToEnum<ValueTypeEnum>(paramList[num + 1]);
			num += 2;
			switch (paradoxModifyParams.typeEnum)
			{
			case ValueTypeEnum.Int:
				paradoxModifyParams.value = Utility.Convert.StringToInt(paramList[num]);
				num++;
				break;
			case ValueTypeEnum.Float:
				paradoxModifyParams.value = Utility.Convert.StringToFloat(paramList[num]);
				num++;
				break;
			case ValueTypeEnum.Vector2:
				if (count - num < 2)
				{
					LogWarning("参数数量错误");
					return;
				}
				paradoxModifyParams.value = Utility.Convert.StringToVector2(paramList[num], paramList[num + 1]);
				num += 2;
				break;
			case ValueTypeEnum.Vector3:
				if (count - num < 3)
				{
					LogWarning("参数数量错误");
					return;
				}
				paradoxModifyParams.value = Utility.Convert.StringToVector3(paramList[num], paramList[num + 1], paramList[num + 2]);
				num += 3;
				break;
			case ValueTypeEnum.Bool:
				paradoxModifyParams.value = Utility.Convert.StringToBool(paramList[num]);
				num++;
				break;
			case ValueTypeEnum.String:
				paradoxModifyParams.value = paramList[num];
				num++;
				break;
			}
			paradoxParams.Add(paradoxModifyParams);
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
			for (int i = 0; i < paradoxParams.Count; i++)
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
