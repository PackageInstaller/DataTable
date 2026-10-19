using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Model;
using ACT.Utility;
using Bamboo.Chronos;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class OtherMessageComp : MonoBehaviour
{
	[SerializeField]
	private BImage speakerImage;

	[SerializeField]
	private LocalizeStringEvent speakerName;

	[SerializeField]
	private TextMeshProUGUI messageText;

	[SerializeField]
	private BImage _textImage;

	[SerializeField]
	private GameObject _textBoard;

	[SerializeField]
	private ActButton _imageBtn;

	[SerializeField]
	private GameObject _imageRoot;

	[SerializeField]
	private GameObject _zipDetail;

	[SerializeField]
	private GameObject _zipCheckFile;

	[SerializeField]
	private TextMeshProUGUI _zipDetailTxt;

	[SerializeField]
	private TextMeshProUGUI zipContentText;

	[SerializeField]
	private GameObject _zipRoot;

	[SerializeField]
	private BetterAnimation _omitAnimator;

	[SerializeField]
	private BetterAnimation bAnimator;

	private Delayer _delay;

	private int _messageVersion;

	public void Init(int sessionId, int contactsId, long messageId, ImageAssetStation imageAssetStation, bool appear, ContentSizeFitter sizeFitter, RectTransform root)
	{
		if (_delay.IsValid())
		{
			_delay.Cancel();
		}
		int messageVersion = ++_messageVersion;
		_imageRoot.SetActive(value: false);
		_textBoard.SetActive(value: true);
		_zipDetail.SetActive(value: false);
		MessageConversation data = CoreUtils.GetData(messageId, RuntimeConfigs.data.messageConversations);
		if (data == null)
		{
			return;
		}
		MessageCharacterData data2 = CoreUtils.GetData(data.speaker, RuntimeConfigs.data.messageCharacterDatas);
		if (data2 == null)
		{
			return;
		}
		imageAssetStation.LoadImage(126, data2.characterIcon, speakerImage);
		speakerName.SetReference(LocalizeTable.ShortCommon, data2.characterName);
		if (appear)
		{
			_omitAnimator.gameObject.SetActive(value: false);
			sizeFitter.enabled = true;
			messageText.alpha = 1f;
			messageText.text = ProcessMessageText(LocalizationUtility.GetLocalizeString(LocalizationTableHelper.TableEnum2TableString(LocalizeTable.MainStory), data.content));
			if (data.nextConversation.Length == 0)
			{
				Model<SNSModel>.Interface.SendSNSFinish(sessionId);
			}
			else if (data.nextConversation.Length == 1)
			{
				MessageConversation data3 = CoreUtils.GetData(data.nextConversation[0], RuntimeConfigs.data.messageConversations);
				if (data3 != null && data3.conversationType == 3)
				{
					Model<SNSModel>.Interface.SendSNSFinish(sessionId);
				}
			}
			return;
		}
		messageText.alpha = 0f;
		_ = RuntimeConfigs.data.game.messageDynamicEffectBase;
		string textString = ProcessMessageText(LocalizationUtility.GetLocalizeString(LocalizationTableHelper.TableEnum2TableString(LocalizeTable.MainStory), data.content));
		int messageDynamicEffectExtra = data.messageDynamicEffectExtra;
		_omitAnimator.gameObject.SetActive(messageDynamicEffectExtra > 0);
		if (messageDynamicEffectExtra > 0)
		{
			_omitAnimator.GetSequence("Loop")?.Play();
		}
		ContentSizeFitter tempSizeFilter = sizeFitter;
		RectTransform tempRoot = root;
		long tempMessageId = messageId;
		int tempSessionId = sessionId;
		PlayAnim();
		_delay = UpdateTimer.Default.DelayMs(messageDynamicEffectExtra, () =>
		{
			if (messageVersion == _messageVersion && !(tempSizeFilter == null) && !(tempRoot == null))
			{
				OnCompleted(textString, tempSizeFilter, tempRoot, tempSessionId, tempMessageId, messageVersion);
			}
		});
	}

	private void OnDestroy()
	{
		_messageVersion++;
		if (_delay.IsValid())
		{
			_delay.Cancel();
		}
	}

	private static string ProcessMessageText(string text)
	{
		if (string.IsNullOrEmpty(text))
		{
			return text;
		}
		string newValue = G.detailUserInfo?.Brief?.Nickname ?? string.Empty;
		return text.Replace("<playername/>", newValue);
	}

	private void OnCompleted(string text, ContentSizeFitter sizeFitter, RectTransform root, int sessionId, long messageId, int messageVersion)
	{
		if (messageVersion == _messageVersion)
		{
			messageText.alpha = 1f;
			messageText.text = ProcessMessageText(text);
			LayoutRebuilder.MarkLayoutForRebuild(root);
			sizeFitter.enabled = true;
			_omitAnimator.gameObject.SetActive(value: false);
			if (_delay.IsValid())
			{
				_delay.Cancel();
			}
			SNSSessionCompUpdateEvt evt = Singleton<EventManager>.instance.GetEvt<SNSSessionCompUpdateEvt>();
			evt.messageType = SNSModel.MessageType.Text;
			evt.sessionId = sessionId;
			evt.messageId = messageId;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.SNS_UpdateLeftInfo, evt);
			MessageConversation data = CoreUtils.GetData(messageId, RuntimeConfigs.data.messageConversations);
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

	public void PlayAnim()
	{
		if (!(bAnimator == null))
		{
			bAnimator?.GetSequence("Show").Play();
		}
	}

	public void ImageInit(int sessionId, int contactsId, long messageId, ImageAssetStation imageAssetStation, bool appear)
	{
		MessageConversation data = CoreUtils.GetData(messageId, RuntimeConfigs.data.messageConversations);
		_imageBtn.OnClick.RemoveAllListeners();
		List<int> imageIds = new List<int>();
		imageIds.Add(data.conversationParm[0]);
		_imageBtn.OnClick.AddListener(() =>
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPIMAGEVIEW, new PopUpImageViewBaseViewData
			{
				imageIds = imageIds
			});
		});
		_imageRoot.SetActive(value: true);
		_textBoard.SetActive(value: false);
		_zipRoot.SetActive(value: false);
		MessageCharacterData data2 = CoreUtils.GetData(data.speaker, RuntimeConfigs.data.messageCharacterDatas);
		speakerName.SetReference(LocalizeTable.ShortCommon, data2.characterName);
		imageAssetStation.LoadImage(126, data2.characterIcon, speakerImage);
		imageAssetStation.LoadImage(136, data.conversationParm[0], _textImage);
		_textImage.icon.SetNativeSize();
		if (data.conversationParm[0] <= 100)
		{
			_textImage.icon.rectTransform.localScale = new Vector3(0.3f, 0.3f, 0.3f);
		}
		else
		{
			_textImage.icon.rectTransform.localScale = new Vector3(1f, 1f, 1f);
		}
		if (!appear)
		{
			SNSSessionCompUpdateEvt evt = Singleton<EventManager>.instance.GetEvt<SNSSessionCompUpdateEvt>();
			evt.messageType = SNSModel.MessageType.Image;
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

	public void ZipInit(int sessionId, int contactsId, long messageId, ImageAssetStation imageAssetStation, bool appear)
	{
		MessageConversation data = CoreUtils.GetData(messageId, RuntimeConfigs.data.messageConversations);
		_imageRoot.SetActive(value: false);
		_textBoard.SetActive(value: false);
		_zipRoot.SetActive(value: true);
		MessageCharacterData data2 = CoreUtils.GetData(data.speaker, RuntimeConfigs.data.messageCharacterDatas);
		speakerName.SetReference(LocalizeTable.ShortCommon, data2.characterName);
		imageAssetStation.LoadImage(126, data2.characterIcon, speakerImage);
		zipContentText.text = ProcessMessageText(LocalizationUtility.GetLocalizeString(LocalizationTableHelper.TableEnum2TableString(LocalizeTable.MainStory), data.content));
		_zipDetail.SetActive(data.conversationParm.Length != 0);
		_zipCheckFile.SetActive(data.conversationParm.Length == 0);
		if (_zipDetail.activeSelf)
		{
			_zipDetailTxt.text = FileUtility.FormatFileSize(data.conversationParm[0], useDecimal: true);
		}
		if (!appear)
		{
			SNSSessionCompUpdateEvt evt = Singleton<EventManager>.instance.GetEvt<SNSSessionCompUpdateEvt>();
			evt.messageType = SNSModel.MessageType.File;
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
