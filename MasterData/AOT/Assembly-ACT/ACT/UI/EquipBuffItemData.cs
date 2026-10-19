using System;
using ACT.Config;
using ACT.Core;

namespace ACT.UI;

public struct EquipBuffItemData
{
	public int id;

	public int baseNum;

	public int normalWhiteNum;

	public int normalRedNum;

	public int normalGreenNum;

	public int ownEquipChange;

	public int ownGemChange;

	public string lockReason;

	public int Num => baseNum + ownEquipChange + ownGemChange;

	public int changeNum => ownEquipChange + ownGemChange;

	public bool isLock => !string.IsNullOrEmpty(lockReason);

	public int[] SkillTotalId(int id)
	{
		SkillGroupData data = CoreUtils.GetData(CoreUtils.GetData(id, RuntimeConfigs.data.equipFeatureDatas).skillGroupData, RuntimeConfigs.data.skillGroupDatas);
		if (data == null)
		{
			return Array.Empty<int>();
		}
		return data.skillTotalIds;
	}
}
