using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Model;
using ACT.Sound.Management;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.Settings;
using UnityEngine.UI;

namespace ACT.UI;

public class LoungeConversation : MonoBehaviour
{
	[Header("说话人")]
	public TMP_Text speakerText;

	public LocalizeStringEvent speaker;

	public HorizontalLayoutGroup speakerRootLayout;

	[Header("说话内容")]
	public LocalizeStringEvent content;

	public MonoTypeWriterEffect m_ContentTypeWriter;

	[Header("情绪音高")]
	public GameObject[] waves;

	public float autoNextTime = 0.5f;

	public int typerSpeed = 50;

	[Header("跳过按钮")]
	public ActButton nextButton;

	public GameObject mainPanel;

	[Header("字出完之后选项延迟出现的事件")]
	public float optionDelayTime = 0.3f;

	[Header("对话选项文字普通字色")]
	private Color btnTextNormelColor;

	private int m_speakerId;

	private CancellationTokenSource m_showCts;

	private CancellationTokenSource cts;

	private CancellationTokenSource imageCTS;

	public void Init()
	{
		ColorUtility.TryParseHtmlString("#EFF0E1", out var color);
		btnTextNormelColor = color;
		mainPanel.gameObject.SetActive(value: false);
		InitState();
	}

	public void UnInit()
	{
		InitState();
	}

	private void InitState()
	{
		m_speakerId = 0;
		speaker.StringReference.TableEntryReference = null;
		speaker.OnUpdateString?.Invoke(string.Empty);
		content.StringReference.TableEntryReference = null;
		content.OnUpdateString?.Invoke(string.Empty);
		Singleton<DramaVoiceManager>.instance.Release();
	}

	public async UniTask Show(int characterId, LoungeConversationType interactType, Action action = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		CancelShow();
		m_showCts = new CancellationTokenSource();
		cancellationToken = m_showCts.Token;
		gameObject.SetActive(value: true);
		m_speakerId = characterId;
		string speakContent = "";
		int nameLocal = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityDatas).nameLocal;
		List<CharacterText> list = new List<CharacterText>();
		foreach (CharacterText value in RuntimeConfigs.data.characterTexts.Values)
		{
			if (value.characterId == characterId && Model<LoungeModel>.Interface.CheckCondition(value.unlockType) && value.type == (int)interactType)
			{
				list.Add(value);
			}
		}
		if (list.Count > 0)
		{
			int num = 0;
			for (int i = 0; i < list.Count; i++)
			{
				num += list[i].weight;
			}
			int num2 = UnityEngine.Random.Range(0, num);
			int num3 = 0;
			CharacterText characterText = list[0];
			for (int j = 0; j < list.Count; j++)
			{
				num3 += list[j].weight;
				if (num2 < num3)
				{
					characterText = list[j];
					break;
				}
			}
			string localizeString = LocalizationUtility.GetLocalizeString("longcommon", characterText.text);
			speakContent = localizeString ?? string.Empty;
		}
		bool flag = characterId != 0 && !string.IsNullOrEmpty(speakContent);
		m_ContentTypeWriter.TimeSpace = 50;
		nextButton.gameObject.SetActive(speakContent != string.Empty);
		nextButton.OnClick.RemoveAllListeners();
		nextButton.OnClick.AddListener(ManualClicked);
		try
		{
			if (flag)
			{
				mainPanel.SetActive(value: true);
			}
			List<UniTask> tasks = new List<UniTask>();
			if (characterId != 0)
			{
				mainPanel.SetActive(value: true);
				if (nameLocal > 0)
				{
					tasks.Add(SetSpeakerNameByLocalized(nameLocal));
				}
				speakerRootLayout.gameObject.SetActive(nameLocal != 0);
				await UniTask.WhenAll(tasks).AttachExternalCancellation(cancellationToken);
				if (cancellationToken.IsCancellationRequested)
				{
					return;
				}
				tasks.Clear();
				if (!string.IsNullOrEmpty(speakContent))
				{
					mainPanel.SetActive(value: true);
					SetContentTextByText(speakContent);
				}
				LayoutRebuilder.ForceRebuildLayoutImmediate(speakerText.transform as RectTransform);
				LayoutRebuilder.MarkLayoutForRebuild(speakerRootLayout.transform as RectTransform);
			}
			await UniTask.WhenAll(tasks).AttachExternalCancellation(cancellationToken).SuppressCancellationThrow();
			tasks.Clear();
			await UniTask.WaitUntil(() => m_ContentTypeWriter.IsFinished, PlayerLoopTiming.Update, cancellationToken).SuppressCancellationThrow();
			nextButton.gameObject.SetActive(value: false);
			if (!cancellationToken.IsCancellationRequested)
			{
				await UniTask.WaitForSeconds(optionDelayTime, ignoreTimeScale: false, PlayerLoopTiming.Update, cancellationToken).SuppressCancellationThrow();
				if (!cancellationToken.IsCancellationRequested)
				{
					await UniTask.WaitUntil(() => m_ContentTypeWriter.IsFinished, PlayerLoopTiming.Update, cancellationToken).SuppressCancellationThrow();
					action?.Invoke();
				}
			}
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
		try
		{
			Singleton<DramaVoiceManager>.instance.StopCurrentVoice();
		}
		catch (Exception exception2)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception2);
			}
		}
	}

	public async UniTask Hide()
	{
		Singleton<DramaVoiceManager>.instance.StopCurrentVoice();
		CancelAndDisposeCts(ref cts);
		if (!(cts = new CancellationTokenSource()).IsCancellationRequested)
		{
			speaker.StringReference.TableEntryReference = null;
			speaker.OnUpdateString?.Invoke(string.Empty);
			content.StringReference.TableEntryReference = null;
			content.OnUpdateString?.Invoke(string.Empty);
		}
	}

	private void OnDestroy()
	{
		CancelShow();
		CancelAndDisposeCts(ref cts);
		CancelAndDisposeCts(ref imageCTS);
	}

	private static void CancelAndDisposeCts(ref CancellationTokenSource cts)
	{
		if (cts != null)
		{
			cts.Cancel();
			cts.Dispose();
			cts = null;
		}
	}

	public void Close()
	{
		CancelShow();
		m_ContentTypeWriter?.StopTweenString();
		if (gameObject.activeSelf)
		{
			InitState();
			gameObject.SetActive(value: false);
		}
	}

	private void CancelShow()
	{
		if (m_showCts != null)
		{
			m_showCts.Cancel();
			m_showCts.Dispose();
			m_showCts = null;
		}
	}

	public void ManualClicked()
	{
		if (gameObject.activeSelf && !m_ContentTypeWriter.IsFinished && !m_ContentTypeWriter.IsFinished)
		{
			m_ContentTypeWriter.StopTweenString();
		}
	}

	private async UniTask SetSpeakerNameByLocalized(int nameEntry)
	{
		string text = (await LocalizationSettings.StringDatabase.GetLocalizedStringAsync(speaker.StringReference.TableReference, nameEntry, null, speaker.StringReference.LocaleOverride, speaker.StringReference.FallbackState).Task).Replace("<playername/>", G.detailUserInfo.Brief.Nickname);
		speakerText.text = text;
	}

	private bool SetSpeakerNameByText(string speakerName)
	{
		if (string.Equals(speakerName, speakerText.text))
		{
			return false;
		}
		speakerText.text = speakerName;
		return true;
	}

	private void SetContentTextByText(string text)
	{
		m_ContentTypeWriter.text = text;
	}
}
