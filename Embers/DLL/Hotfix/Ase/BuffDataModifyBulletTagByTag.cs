using System.Collections.Generic;
using System.Text;

namespace Ase;

public class BuffDataModifyBulletTagByTag : BuffDataBase
{
	public int checkTagCount;

	public List<string> checkTagList = new List<string>();

	public ChangeType changeType;

	public int modifyTagCount;

	public List<string> modifyTagList = new List<string>();

	public override BuffOperationType EffectType => BuffOperationType.ModifyBulletTagByTag;

	protected override int paramsMinCount => -1;

	protected override void OnInit(List<string> paramList)
	{
		if (paramList.Count < 1)
		{
			LogWarning("参数错误");
			return;
		}
		checkTagCount = Utility.Convert.StringToInt(paramList[0]);
		if (checkTagCount == 0 || paramList.Count < checkTagCount + 4)
		{
			LogWarning("参数错误");
			return;
		}
		checkTagList = new List<string>(checkTagCount);
		for (int i = 1; i < checkTagCount + 1; i++)
		{
			checkTagList.Add(paramList[i]);
		}
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[checkTagCount + 1]);
		modifyTagCount = Utility.Convert.StringToInt(paramList[checkTagCount + 2]);
		if (paramList.Count < checkTagCount + 2 + modifyTagCount)
		{
			LogWarning("参数错误");
			return;
		}
		modifyTagList = new List<string>(modifyTagCount);
		for (int j = checkTagCount + 3; j < checkTagCount + 3 + modifyTagCount; j++)
		{
			modifyTagList.Add(paramList[j]);
		}
	}

	protected override void OnResetParams(params object[] args)
	{
	}

	protected override string OnGetDataString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append($"{checkTagCount},");
		if (checkTagList.IsNullOrEmpty())
		{
			stringBuilder.Append("检测标签列表为空");
		}
		else
		{
			foreach (string checkTag in checkTagList)
			{
				stringBuilder.Append(checkTag + ",");
			}
		}
		stringBuilder.Append($"{changeType},");
		stringBuilder.Append($"{modifyTagCount}");
		if (modifyTagList.IsNullOrEmpty())
		{
			stringBuilder.Append(",修改标签列表为空");
		}
		else
		{
			foreach (string modifyTag in modifyTagList)
			{
				stringBuilder.Append("," + modifyTag);
			}
		}
		return stringBuilder.ToString();
	}
}
