using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model.Jump;
using ACT.UI;
using Fundamental;

namespace ACT.Model;

public class CraftModel : Model<CraftModel>, IJumpable
{
	public Dictionary<int, ItemData> ItemCraftDic = new Dictionary<int, ItemData>();

	public LuminModelType JumpSourceType => LuminModelType.Compose;

	private void Start()
	{
	}

	private void Update()
	{
	}

	protected override void Init()
	{
		InitItemCraftData();
	}

	private void InitItemCraftData()
	{
		foreach (KeyValuePair<int, ItemData> itemData in RuntimeConfigs.data.itemDatas)
		{
			if (itemData.Value.itemCrafting.Count != 0)
			{
				ItemCraftDic.Add(itemData.Value.id, itemData.Value);
			}
		}
	}

	protected override void UnInit()
	{
		ItemCraftDic.Clear();
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Craft))
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.CanJump
			};
		}
		return new JumpResult
		{
			ShowType = JumpResult.JumpShowType.Forbidden,
			Message = Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.Craft)
		};
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMCRAFTING, new PopupItemCraftData
		{
			itemId = jumpData.Params[1],
			targetCraftNum = -1
		});
	}
}
