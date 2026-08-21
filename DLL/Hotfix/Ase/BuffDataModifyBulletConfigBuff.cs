using System.Collections.Generic;

namespace Ase;

public class BuffDataModifyBulletConfigBuff : BuffDataBase
{
	public BulletModifyEnum modifyEnum;

	public string key;

	public ChangeType changeType;

	public int[] buffList;

	public int[] targetList;

	public override BuffOperationType EffectType => BuffOperationType.ModifyBulletConfigBuff;

	protected override int paramsMinCount => 5;

	protected override void OnInit(List<string> paramList)
	{
		modifyEnum = Utility.Convert.StringToEnum<BulletModifyEnum>(paramList[0]);
		key = paramList[1];
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[2]);
		if ((paramList.Count - 3) % 2 != 0)
		{
			base.IsVaild = true;
			LogWarning("参数数量错误");
			return;
		}
		int num = (paramList.Count - 3) / 2;
		buffList = new int[num];
		targetList = new int[num];
		for (int i = 0; i < num; i++)
		{
			buffList[i] = Utility.Convert.StringToInt(paramList[3 + i * 2]);
			targetList[i] = Utility.Convert.StringToInt(paramList[3 + i * 2 + 1]);
		}
	}

	protected override void OnResetParams(params object[] args)
	{
	}

	protected override string OnGetDataString()
	{
		return string.Format("{0},{1},{2},{3},{4}", modifyEnum, key, changeType, string.Join(",", buffList), string.Join(",", targetList));
	}

	protected override void OnClear()
	{
		buffList = null;
		targetList = null;
	}
}
