using System.Collections.Generic;
using System.Text;

namespace Ase;

public class BuffDataModifyBulletAdditionByTag : BuffDataBase
{
	public int checkTagCount;

	public List<string> checkTagList = new List<string>();

	public ChangeType changeType;

	public BulletAdditionEnum additionEnum;

	public int modifyValueCount;

	public List<float> modifyValueList = new List<float>();

	public override BuffOperationType EffectType => BuffOperationType.ModifyBulletAdditionByTag;

	protected override int paramsMinCount => 0;

	protected override void OnInit(List<string> paramList)
	{
		if (paramList.Count < 1)
		{
			return;
		}
		checkTagCount = Utility.Convert.StringToInt(paramList[0]);
		if (checkTagCount == 0 || paramList.Count < checkTagCount + 5)
		{
			return;
		}
		checkTagList = new List<string>(checkTagCount);
		for (int i = 1; i < checkTagCount + 1; i++)
		{
			checkTagList.Add(paramList[i]);
		}
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[checkTagCount + 1]);
		additionEnum = Utility.Convert.StringToEnum<BulletAdditionEnum>(paramList[checkTagCount + 2]);
		modifyValueCount = Utility.Convert.StringToInt(paramList[checkTagCount + 3]);
		if (paramList.Count >= checkTagCount + 3 + modifyValueCount)
		{
			modifyValueList = new List<float>(modifyValueCount);
			for (int j = checkTagCount + 4; j < checkTagCount + 4 + modifyValueCount; j++)
			{
				modifyValueList.Add(Utility.Convert.StringToFloat(paramList[j]));
			}
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
		stringBuilder.Append($"{additionEnum},");
		stringBuilder.Append($"{modifyValueCount}");
		if (modifyValueList.IsNullOrEmpty())
		{
			stringBuilder.Append(",修改加成列表为空");
		}
		else
		{
			foreach (float modifyValue in modifyValueList)
			{
				stringBuilder.Append($",{modifyValue}");
			}
		}
		return stringBuilder.ToString();
	}
}
