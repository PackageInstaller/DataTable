using System.Collections.Generic;
using System.Threading;
using ACT.Game.Data;
using ACT.UI;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class AddItemAction : MissionAction
{
	protected override bool ServerAction => true;

	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions options, CancellationToken token)
	{
		if (!(Param is AddItemActionParam { itemId: >0, itemCount: >0 } addItemActionParam))
		{
			return UniTask.CompletedTask;
		}
		if (!addItemActionParam.showTip)
		{
			return UniTask.CompletedTask;
		}
		List<Item> list = ListPool<Item>.Get();
		list.Add(new Item
		{
			Id = addItemActionParam.itemId,
			Count = addItemActionParam.itemCount
		});
		PropPickingUtility.DispatchPropPickingEvt(list, PropPickingWay.Mission);
		ListPool<Item>.Release(list);
		return UniTask.CompletedTask;
	}
}
