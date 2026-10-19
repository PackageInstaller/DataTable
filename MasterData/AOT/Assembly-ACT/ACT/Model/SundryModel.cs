using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using UnityEngine.Localization.Settings;

namespace ACT.Model;

public class SundryModel : Model<SundryModel>
{
	protected override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_GetItemCostTIp, onGetItemCostTIp);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Role_Daily_Monster_Exp_Max, OnDailyMonsterExpMax);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Role_Daily_Monster_Coin_Max, OnDailyMonsterCoinMax);
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_GetItemCostTIp, onGetItemCostTIp);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Role_Daily_Monster_Exp_Max, OnDailyMonsterExpMax);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Role_Daily_Monster_Coin_Max, OnDailyMonsterCoinMax);
	}

	private void onGetItemCostTIp(BaseEventContent obj)
	{
		GetTipsItemCostData getTipsItemCostData = (GetTipsItemCostData)obj;
		ItemData data = CoreUtils.GetData(getTipsItemCostData.ItemId, RuntimeConfigs.data.itemDatas);
		Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
		{
			tableName = LocalizationUtility.localizeTableName_Common,
			localizeId = getTipsItemCostData.localizedid,
			variableList = new List<string> { LocalizationSettings.StringDatabase.GetLocalizedString(LocalizationUtility.localizeTableName_shortcommon, data.nameLocal, LocalizationSettings.ProjectLocale, FallbackBehavior.DontUseFallback, null) }
		});
	}

	private void OnDailyMonsterExpMax(BaseEventContent evt)
	{
		GameUtility.OpenToolTip(1803);
	}

	private void OnDailyMonsterCoinMax(BaseEventContent evt)
	{
		GameUtility.OpenToolTip(1804);
	}
}
