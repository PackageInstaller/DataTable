using System.Collections.Generic;
using System.Text;

namespace Ase;

public class BuffDataModifyBuffLabelByLabel : BuffDataBase
{
	public int checkLabelCount;

	public List<string> checkLabelList = new List<string>();

	public ChangeType changeType;

	public int modifyLabelCount;

	public List<string> modifyLabelList = new List<string>();

	public override BuffOperationType EffectType => BuffOperationType.ModifyBuffLabelByLabel;

	protected override int paramsMinCount => -1;

	protected override void OnInit(List<string> paramList)
	{
		if (paramList.Count < 1)
		{
			LogWarning("参数错误");
			return;
		}
		checkLabelCount = Utility.Convert.StringToInt(paramList[0]);
		if (checkLabelCount == 0 || paramList.Count < checkLabelCount + 4)
		{
			LogWarning("参数错误");
			return;
		}
		checkLabelList = new List<string>(checkLabelCount);
		for (int i = 1; i < checkLabelCount + 1; i++)
		{
			checkLabelList.Add(paramList[i]);
		}
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[checkLabelCount + 1]);
		modifyLabelCount = Utility.Convert.StringToInt(paramList[checkLabelCount + 2]);
		if (paramList.Count < checkLabelCount + 3 + modifyLabelCount)
		{
			LogWarning("参数错误");
			return;
		}
		modifyLabelList = new List<string>(modifyLabelCount);
		for (int j = checkLabelCount + 3; j < checkLabelCount + 3 + modifyLabelCount; j++)
		{
			modifyLabelList.Add(paramList[j]);
		}
	}

	protected override void OnResetParams(params object[] args)
	{
	}

	protected override string OnGetDataString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append($"{checkLabelCount},");
		if (checkLabelList.IsNullOrEmpty())
		{
			stringBuilder.Append("检测标签列表为空");
		}
		else
		{
			foreach (string checkLabel in checkLabelList)
			{
				stringBuilder.Append(checkLabel + ",");
			}
		}
		stringBuilder.Append($"{changeType},");
		stringBuilder.Append($"{modifyLabelCount}");
		if (modifyLabelList.IsNullOrEmpty())
		{
			stringBuilder.Append(",修改标签列表为空");
		}
		else
		{
			foreach (string modifyLabel in modifyLabelList)
			{
				stringBuilder.Append("," + modifyLabel);
			}
		}
		return stringBuilder.ToString();
	}
}
