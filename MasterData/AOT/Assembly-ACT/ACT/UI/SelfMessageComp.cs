using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Model;
using ACT.Net;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class SelfMessageComp : MonoBehaviour
{
	[SerializeField]
	private BImage speakerImage;

	[SerializeField]
	private LocalizeStringEvent speakerName;

	[SerializeField]
	private TextMeshProUGUI _speakerNameText;

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
	private BetterAnimation bAnimator;

	private void OnEnable()
	{
		if (speakerName != null)
		{
			speakerName.OnUpdateString.AddListener(OnSpeakerNameUpdated);
		}
	}

	private void OnDisable()
	{
		if (speakerName != null)
		{
			speakerName.OnUpdateString.RemoveListener(OnSpeakerNameUpdated);
		}
	}

	public void Init(int sessionId, int contactsId, long messageId, ImageAssetStation imageAssetStation, bool appear)
	{
		_imageRoot.SetActive(value: false);
		_zipRoot.SetActive(value: false);
		_textBoard.SetActive(value: true);
		MessageConversation data = CoreUtils.GetData(messageId, RuntimeConfigs.data.messageConversations);
		MessageCharacterData data2 = CoreUtils.GetData(data.speaker, RuntimeConfigs.data.messageCharacterDatas);
		InitCharacterHeadIcon(imageAssetStation, data2);
		SetSpeakerName(data2.characterName);
		messageText.text = LocalizationUtility.GetLocalizeString(LocalizationTableHelper.TableEnum2TableString(LocalizeTable.MainStory), data.content);
		if (!appear)
		{
			SNSSessionCompUpdateEvt evt = Singleton<EventManager>.instance.GetEvt<SNSSessionCompUpdateEvt>();
			evt.messageType = SNSModel.MessageType.Text;
			evt.sessionId = sessionId;
			evt.messageId = messageId;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.SNS_UpdateLeftInfo, evt);
		}
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
		if (!appear)
		{
			PlayAnim();
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
		SetSpeakerName(data2.characterName);
		InitCharacterHeadIcon(imageAssetStation, data2);
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
		SetSpeakerName(data2.characterName);
		InitCharacterHeadIcon(imageAssetStation, data2);
		zipContentText.text = LocalizationUtility.GetLocalizeString(LocalizationTableHelper.TableEnum2TableString(LocalizeTable.MainStory), data.content);
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

	private void InitCharacterHeadIcon(ImageAssetStation imageAssetStation, MessageCharacterData speaker)
	{
		int id = speaker.characterIcon;
		if (speaker.id == 10001)
		{
			switch ((Sex)G.detailUserInfo.Brief.Gender)
			{
			case Sex.MALE:
				id = 10002;
				break;
			case Sex.FEMALE:
				id = 10001;
				break;
			}
		}
		imageAssetStation.LoadImage(126, id, speakerImage);
	}

	public void PlayAnim()
	{
		if (!(bAnimator == null))
		{
			bAnimator?.GetSequence("Show").Play();
		}
	}

	private void SetSpeakerName(int characterName)
	{
		speakerName.SetReference(LocalizeTable.ShortCommon, characterName);
		speakerName.RefreshString();
		string localizeString = LocalizationUtility.GetLocalizeString(LocalizationTableHelper.TableEnum2TableString(LocalizeTable.ShortCommon), characterName);
		OnSpeakerNameUpdated(localizeString);
	}

	private void OnSpeakerNameUpdated(string text)
	{
		if (!(_speakerNameText == null))
		{
			_speakerNameText.text = ProcessPlayerName(text);
		}
	}

	private static string ProcessPlayerName(string text)
	{
		if (string.IsNullOrEmpty(text) || text.IndexOf("<playername/>", StringComparison.Ordinal) < 0)
		{
			return text;
		}
		string newValue = G.detailUserInfo?.Brief?.Nickname ?? string.Empty;
		return text.Replace("<playername/>", newValue);
	}
}
