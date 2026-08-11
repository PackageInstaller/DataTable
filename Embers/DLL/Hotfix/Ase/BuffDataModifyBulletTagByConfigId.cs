using System.Collections.Generic;
using System.Text;

namespace Ase;

public class BuffDataModifyBulletTagByConfigId : BuffDataBase
{
	public int checkConfigIdCount;

	public List<int> checkConfigIdList = new List<int>();

	public ChangeType changeType;

	public int modifyTagCount;

	public List<string> modifyTagList = new List<string>();

	public override BuffOperationType EffectType => BuffOperationType.ModifyBulletTagByConfigId;

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
		modifyTagCount = Utility.Convert.StringToInt(paramList[checkConfigIdCount + 2]);
		if (paramList.Count < checkConfigIdCount + 2 + modifyTagCount)
		{
			LogWarning("参数错误");
			return;
		}
		modifyTagList = new List<string>(modifyTagCount);
		for (int j = checkConfigIdCount + 3; j < checkConfigIdCount + 3 + modifyTagCount; j++)
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
