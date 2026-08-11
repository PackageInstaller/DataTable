using System.Collections.Generic;
using System.Text;

namespace Ase;

public class BuffDataModifyBuffLabelByConfigId : BuffDataBase
{
	public int checkConfigIdCount;

	public List<int> checkConfigIdList = new List<int>();

	public ChangeType changeType;

	public int modifyLabelCount;

	public List<string> modifyLabelList = new List<string>();

	public override BuffOperationType EffectType => BuffOperationType.ModifyBuffLabelByConfigId;

	protected override int paramsMinCount => -1;

	protected override void OnInit(List<string> paramList)
	{
		if (paramList.Count < 1)
		{
			LogWarning("参数错误");
			return;
		}
		checkConfigIdCount = Utility.Convert.StringToInt(paramList[0]);
		if (checkConfigIdCount == 0 || paramList.Count < checkConfigIdCount + 4)
		{
			LogWarning("参数错误");
			return;
		}
		checkConfigIdList = new List<int>(checkConfigIdCount);
		for (int i = 1; i < checkConfigIdCount + 1; i++)
		{
			checkConfigIdList.Add(Utility.Convert.StringToInt(paramList[i]));
		}
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[checkConfigIdCount + 1]);
		modifyLabelCount = Utility.Convert.StringToInt(paramList[checkConfigIdCount + 2]);
		if (paramList.Count < checkConfigIdCount + 3 + modifyLabelCount)
		{
			LogWarning("参数错误");
			return;
		}
		modifyLabelList = new List<string>(modifyLabelCount);
		for (int j = checkConfigIdCount + 3; j < checkConfigIdCount + 3 + modifyLabelCount; j++)
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
		stringBuilder.Append($"{checkConfigIdCount},");
		if (checkConfigIdList.IsNullOrEmpty())
		{
			stringBuilder.Append("检测配置ID列表为空");
		}
		else
		{
			foreach (int checkConfigId in checkConfigIdList)
			{
				stringBuilder.Append($"{checkConfigId},");
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
