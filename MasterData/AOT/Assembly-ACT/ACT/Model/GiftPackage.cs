using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.RichText;
using Fundamental;

namespace ACT.Model;

public class GiftPackage : IBagItem
{
	public GiftPackageType type { get; set; }

	public ItemData giftItemTableData { get; set; }

	private int uid { get; }

	public GiftPackage(int uid, GiftPackageType type, ItemData itemData)
	{
		this.uid = uid;
		this.type = type;
		giftItemTableData = itemData;
	}

	public GiftPackageType GetGiftPackageType()
	{
		return type;
	}

	public int GetId()
	{
		return giftItemTableData?.id ?? 0;
	}

	public int GetUid()
	{
		return uid;
	}

	public int GetCount()
	{
		if (giftItemTableData != null)
		{
			return G.localPlayer.Inventory.GetItemCount(giftItemTableData.id);
		}
		return 0;
	}

	public int GetQuality()
	{
		if (giftItemTableData != null)
		{
			return giftItemTableData.quality;
		}
		return 0;
	}

	public int GetLocalizationName()
	{
		if (giftItemTableData != null)
		{
			return giftItemTableData.nameLocal;
		}
		return 0;
	}

	public int GetLocalizationDes()
	{
		if (giftItemTableData != null)
		{
			return giftItemTableData.descLocal;
		}
		return 0;
	}

	public int GetPackageRewardContentDes()
	{
		if (RuntimeConfigs.data.bagChests.TryGetValue(giftItemTableData.id, out var value))
		{
			return value.descLocal;
		}
		return 0;
	}

	public List<ItemKv> GetRewardsGainsLimit()
	{
		if (type != GiftPackageType.SelfSelect || !RuntimeConfigs.data.bagChests.TryGetValue(giftItemTableData.id, out var value))
		{
			return null;
		}
		return value.rewardLimit;
	}

	public List<ItemKv> GetSelfSelectRewardsData()
	{
		if (type != GiftPackageType.SelfSelect || !RuntimeConfigs.data.bagChests.TryGetValue(giftItemTableData.id, out var value))
		{
			return null;
		}
		return value.selectableRewardPool;
	}

	public bool GetOpenPrecondition()
	{
		BagChest data = CoreUtils.GetData(giftItemTableData.id, RuntimeConfigs.data.bagChests);
		if (data == null)
		{
			return true;
		}
		MissionGroup data2 = CoreUtils.GetData(data.missionGroupId, RuntimeConfigs.data.missionGroups);
		if (data2 == null)
		{
			return true;
		}
		int num = data2.missionId.FirstOrDefault();
		if (num == 0)
		{
			return true;
		}
		return Singleton<PreconditionInfoManager>.instance.taskDic[num].status != 0;
	}

	public string GetConditionDes()
	{
		BagChest data = CoreUtils.GetData(giftItemTableData.id, RuntimeConfigs.data.bagChests);
		if (data == null)
		{
			return string.Empty;
		}
		MissionGroup data2 = CoreUtils.GetData(data.missionGroupId, RuntimeConfigs.data.missionGroups);
		if (data2 == null)
		{
			return string.Empty;
		}
		int num = data2.missionId.FirstOrDefault();
		if (num == 0)
		{
			return string.Empty;
		}
		ACT.Config.Mission data3 = CoreUtils.GetData(num, RuntimeConfigs.data.missions);
		return CustomTagParser.ReplacePreconditionText(data3, data3.number, data3.param);
	}
}
