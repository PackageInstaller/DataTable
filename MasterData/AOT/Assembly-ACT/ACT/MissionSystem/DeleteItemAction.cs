using System.Threading;
using ACT.Core;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class DeleteItemAction : MissionAction
{
	protected override bool ServerAction => true;

	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions options, CancellationToken token)
	{
		if (!(Param is DeleteItemActionParam { itemId: >0, itemCount: >0 } deleteItemActionParam))
		{
			return UniTask.CompletedTask;
		}
		if (!deleteItemActionParam.showTip)
		{
			return UniTask.CompletedTask;
		}
		if (RuntimeConfigs.data.itemDatas.TryGetValue(deleteItemActionParam.itemId, out var value))
		{
			GameUtility.OpenToolTip(new LocalizedString("Common", 41000213L) { 
			{
				"0",
				new LocalizedString(LocalizationUtility.localizeTableName_shortcommon, value.nameLocal)
			} });
		}
		return UniTask.CompletedTask;
	}
}
