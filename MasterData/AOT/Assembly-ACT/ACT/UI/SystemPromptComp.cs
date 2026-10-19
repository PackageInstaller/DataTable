using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class SystemPromptComp : MonoBehaviour
{
	[SerializeField]
	private LocalizeStringEvent prompt;

	[SerializeField]
	private BImage systemPromptIcon;

	public void Init(long messageId, int sessionId, bool appear, ImageAssetStation imageAssetStation)
	{
		MessageConversation data = CoreUtils.GetData(messageId, RuntimeConfigs.data.messageConversations);
		prompt.SetReference(LocalizeTable.MainStory, data.content);
		systemPromptIcon.icon.gameObject.SetActive(data.conversationParm.Length != 0);
		if (data.conversationParm.Length != 0)
		{
			imageAssetStation.LoadImage(191, data.conversationParm[0], systemPromptIcon);
		}
		if (!appear)
		{
			SNSSessionCompUpdateEvt evt = Singleton<EventManager>.instance.GetEvt<SNSSessionCompUpdateEvt>();
			evt.messageType = SNSModel.MessageType.SystemPrompt;
			evt.sessionId = sessionId;
			evt.messageId = messageId;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.SNS_UpdateLeftInfo, evt);
		}
		if (data.nextConversation.Length == 0)
		{
			Model<SNSModel>.Interface.SendSNSFinish(sessionId);
		}
		else if (data.nextConversation.Length == 1 && CoreUtils.GetData(data.nextConversation[0], RuntimeConfigs.data.messageConversations).conversationType == 3)
		{
			Model<SNSModel>.Interface.SendSNSFinish(sessionId);
		}
	}
}
