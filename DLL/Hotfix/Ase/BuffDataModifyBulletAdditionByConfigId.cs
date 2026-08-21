using System.Collections.Generic;
using System.Text;

namespace Ase;

public class BuffDataModifyBulletAdditionByConfigId : BuffDataBase
{
	public int checkConfigIdCount;

	public List<int> checkConfigIdList = new List<int>();

	public ChangeType changeType;

	public BulletAdditionEnum additionEnum;

	public int modifyValueCount;

	public List<float> modifyValueList = new List<float>();

	public override BuffOperationType EffectType => BuffOperationType.ModifyBulletAdditionByConfigId;

	protected override int paramsMinCount => -1;

	protected override void OnInit(List<string> paramList)
	{
		if (paramList.Count < 1)
		{
			LogWarning("参数错误");
			return;
		}
		checkConfigIdCount = Utility.Convert.StringToInt(paramList[0]);
		if (checkConfigIdCount == 0 || paramList.Count < checkConfigIdCount + 5)
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
		additionEnum = Utility.Convert.StringToEnum<BulletAdditionEnum>(paramList[checkConfigIdCount + 2]);
		modifyValueCount = Utility.Convert.StringToInt(paramList[checkConfigIdCount + 3]);
		if (paramList.Count < checkConfigIdCount + 3 + modifyValueCount)
		{
			LogWarning("参数错误");
			return;
		}
		modifyValueList = new List<float>(modifyValueCount);
		for (int j = checkConfigIdCount + 4; j < checkConfigIdCount + 4 + modifyValueCount; j++)
		{
			modifyValueList.Add(Utility.Convert.StringToFloat(paramList[j]));
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
