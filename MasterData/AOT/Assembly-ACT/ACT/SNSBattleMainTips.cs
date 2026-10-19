using System;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT;

public class SNSBattleMainTips : MonoBehaviour
{
	public BetterAnimation Animation;

	public GameObject tipsIcon;

	public Image messageBoard;

	public LocalizeStringEvent SNSName;

	public TextMeshProUGUI SNSNameText;

	public TextMeshProUGUI SNScontent;

	private bool _isProcessingNewSNSMessages;

	private Color _fadeColor = new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, 0);

	private Color _normalColor = new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue);

	private void Awake()
	{
		messageBoard.color = _normalColor;
		tipsIcon.SetActive(value: false);
		if (Model<SNSModel>.HasInstance())
		{
			Model<SNSModel>.Interface.OnNewSNSMessageNotify += OnNewSNSMessage;
		}
	}

	private void OnDestroy()
	{
		if (Model<SNSModel>.HasInstance())
		{
			Model<SNSModel>.Interface.OnNewSNSMessageNotify -= OnNewSNSMessage;
		}
	}

	private void OnNewSNSMessage()
	{
		if (!_isProcessingNewSNSMessages)
		{
			ProcessNewSNSMessages().Forget();
		}
	}

	private async UniTaskVoid ProcessNewSNSMessages()
	{
		_isProcessingNewSNSMessages = true;
		tipsIcon.SetActive(value: true);
		messageBoard.color = _fadeColor;
		try
		{
			while (Model<SNSModel>.Interface.NewMessagesQueue.Count > 0)
			{
				await UniTask.WaitUntil(() => this != null && Model<SNSModel>.Interface.InBattleMain(), PlayerLoopTiming.Update, this.GetCancellationTokenOnDestroy());
				if (Model<SNSModel>.Interface.NewMessagesQueue.Count != 0)
				{
					SNSModel.SpecificMsg msg = Model<SNSModel>.Interface.NewMessagesQueue.Dequeue();
					MessageCharacterData data = CoreUtils.GetData(msg.ContactId, RuntimeConfigs.data.messageCharacterDatas);
					if (data != null)
					{
						SNSName.StringReference.TableEntryReference = data.characterName;
					}
					MessageConversation messageConversation = Model<SNSModel>.Interface.GetSession(msg.SessionId)?.GetLatestMessage();
					SNScontent.text = ((messageConversation == null) ? string.Empty : ProcessMessageText(LocalizationUtility.GetLocalizeString(LocalizationTableHelper.TableEnum2TableString(LocalizeTable.MainStory), messageConversation.content)));
					Model<SNSModel>.Interface.SetSpecificMsg(msg, needUnlock: true);
					Animation.GetSequence("Show").Play();
					Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Message/NewMessage_Toast");
					await UniTask.Delay(4000, ignoreTimeScale: false, PlayerLoopTiming.Update, this.GetCancellationTokenOnDestroy());
					continue;
				}
				break;
			}
		}
		catch (OperationCanceledException)
		{
		}
		finally
		{
			if (this != null)
			{
				if (tipsIcon != null)
				{
					tipsIcon.SetActive(value: false);
				}
				messageBoard.color = _normalColor;
				_isProcessingNewSNSMessages = false;
				Model<SNSModel>.Interface.ClearSpecificMsg();
			}
		}
	}

	private string ProcessMessageText(string text)
	{
		if (string.IsNullOrEmpty(text))
		{
			return text;
		}
		string text2 = text.Replace("<playername/>", G.detailUserInfo?.Brief?.Nickname);
		if (SNSNameText.text.Length + text2.Length >= 11)
		{
			return $"{text2.Substring(0, 11 - SNSNameText.text.Length)}...";
		}
		if (text2.Length <= 6)
		{
			return text2;
		}
		return $"{text2.Substring(0, 6)}...";
	}
}
