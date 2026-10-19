using ACT.Config;
using ACT.Core;
using ACT.Game.Data;

namespace ACT.Model;

public class BloodBottleMaterial : IBagItem
{
	public int id { get; private set; }

	public int uid { get; private set; }

	public int usedSkillId { get; private set; }

	public int extraUseCount { get; private set; }

	public int type { get; private set; }

	public bool isEquip { get; private set; }

	public int belongBottle { get; private set; }

	public BloodBottleMaterial()
	{
	}

	public BloodBottleMaterial(PotionAdditives data)
		: this()
	{
		BindAdditivesData(data);
	}

	public void BindAdditivesData(PotionAdditives data)
	{
		id = data.itemId;
		uid = data.id;
		usedSkillId = data.useAbilityName;
		extraUseCount = data.usageLimit;
		type = data.type;
	}

	public void ResetEquipState(bool state)
	{
		isEquip = state;
	}

	public void SetBelongBottle(int bottleId)
	{
		belongBottle = bottleId;
	}

	public int GetId()
	{
		return id;
	}

	public int GetCount()
	{
		return 1;
	}

	public int GetQuality()
	{
		return CoreUtils.GetData(id, RuntimeConfigs.data.itemDatas)?.quality ?? 0;
	}

	public int GetLocalizationName()
	{
		return CoreUtils.GetData(id, RuntimeConfigs.data.itemDatas)?.nameLocal ?? 0;
	}

	public int GetUid()
	{
		return uid;
	}
}
