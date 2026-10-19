using ACT.Game;
using ACT.Game.Data;
using Cysharp.Threading.Tasks;

namespace ACT.MissionSystem;

public class ItemCondition : MissionCondition
{
	protected override async void OnInMissionWorld()
	{
		do
		{
			if (CheckCondition())
			{
				MarkSuccess();
				break;
			}
			await UniTask.Yield();
		}
		while (InMissionWorld);
	}

	public override bool PreCheckCondition()
	{
		return CheckCondition();
	}

	private bool CheckCondition()
	{
		ItemConditionParam itemConditionParam = Param as ItemConditionParam;
		Item itemInfo = G.localPlayer.Inventory.GetItemInfo(itemConditionParam.itemId);
		if (itemInfo != null && itemInfo.Count >= itemConditionParam.itemCount)
		{
			return true;
		}
		return false;
	}
}
