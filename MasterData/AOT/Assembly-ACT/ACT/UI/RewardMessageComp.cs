using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class RewardMessageComp : MonoBehaviour
{
	[SerializeField]
	private BImage speakerImage;

	[SerializeField]
	private LocalizeStringEvent speakerName;

	[SerializeField]
	private LocalizeStringEvent _itemName;

	[SerializeField]
	private LocalizeStringEvent _itemDes;

	[SerializeField]
	private LiteItemUIComponent _item;

	[SerializeField]
	private GameObject newImage;

	[SerializeField]
	private Sprite[] qualityCircleSprites;

	[SerializeField]
	private Sprite[] qualityBgSprites;

	[SerializeField]
	private Image qualityCircleImage;

	[SerializeField]
	private Image qualityBgImage;

	public void Init(int sessionId, long messageId, int speakerId, int rewardId, int rewardCount, ImageAssetStation station, bool appear)
	{
		MessageCharacterData data = CoreUtils.GetData(speakerId, RuntimeConfigs.data.messageCharacterDatas);
		station.LoadImage(126, data.characterIcon, speakerImage);
		speakerName.SetReference(LocalizeTable.ShortCommon, data.characterName);
		Item item = new Item();
		item.Id = rewardId;
		item.Count = rewardCount;
		_item.SetData(item, 0L, ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
		_item.UpdatePerformance();
		_item.showDetailPanel = true;
		ItemData data2 = CoreUtils.GetData(rewardId, RuntimeConfigs.data.itemDatas);
		_itemName.SetReference(LocalizeTable.ShortCommon, data2.nameLocal);
		_itemDes.SetReference(LocalizeTable.LongCommon, data2.descLocal);
		_item.showDetailPanel = true;
		if (G.localPlayer.GotItems.ContainsKey(rewardId))
		{
			newImage.SetActive(value: false);
		}
		else
		{
			newImage.SetActive(value: true);
			G.localPlayer.GotItems.TryAdd(rewardId, value: true);
		}
		qualityBgImage.sprite = qualityBgSprites[data2.quality - 1];
		if (!appear)
		{
			SNSSessionCompUpdateEvt evt = Singleton<EventManager>.instance.GetEvt<SNSSessionCompUpdateEvt>();
			evt.messageType = SNSModel.MessageType.Reward;
			evt.sessionId = sessionId;
			evt.messageId = messageId;
			evt.rewardId = rewardId;
			evt.rewardCount = rewardCount;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.SNS_UpdateLeftInfo, evt);
		}
		MessageConversation data3 = CoreUtils.GetData(messageId, RuntimeConfigs.data.messageConversations);
		if (data3.nextConversation.Length == 0)
		{
			Model<SNSModel>.Interface.SendSNSFinish(sessionId);
		}
		else if (data3.nextConversation.Length == 1 && CoreUtils.GetData(data3.nextConversation[0], RuntimeConfigs.data.messageConversations).conversationType == 3)
		{
			Model<SNSModel>.Interface.SendSNSFinish(sessionId);
		}
	}
}
