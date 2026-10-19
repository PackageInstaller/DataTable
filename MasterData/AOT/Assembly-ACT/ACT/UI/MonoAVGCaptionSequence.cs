using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Core;
using ACT.DialogueSystem;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class MonoAVGCaptionSequence : MonoBehaviour
{
	[Serializable]
	public class Line
	{
		public long key;

		public TextMeshProUGUI text;

		public CanvasGroup group;

		public MonoTypeWriterEffect typeWriter;

		public AVGCaptionAppearMode appearMode = AVGCaptionAppearMode.TypeWriter;

		public float appearDelay;

		public float fadeDuration = 0.25f;

		public int typeWriterSpeed;

		public float hideDelay;

		public float hideDuration = 0.25f;

		[NonSerialized]
		public int ContentId;

		[NonSerialized]
		public string LocalizedText;
	}

	public Line[] lines = Array.Empty<Line>();

	public float holdDuration = 0.5f;

	public AVGCaptionHideMode hideMode;

	[ValuePickerFromExcel("dialogueSFX.xlsx", "dialogueSFXData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "description")]
	public int typeWriterSoundId;

	public int typeWriterSoundInterval = 2;

	private readonly List<UniTask> m_Tasks = new List<UniTask>(8);

	private bool m_ForceComplete;

	private bool m_Playing;

	private int m_CurrentLineIndex = -1;

	private string m_TypeWriterSoundKey = string.Empty;

	public bool IsPlaying => m_Playing;

	public void Prepare(LuminDialogueFlowProcessor flow)
	{
		if (typeWriterSoundId > 0 && RuntimeConfigs.data.dialogueSFXDatas.TryGetValue(typeWriterSoundId, out var value))
		{
			m_TypeWriterSoundKey = value.key;
		}
		else
		{
			m_TypeWriterSoundKey = string.Empty;
		}
		for (int i = 0; i < lines.Length; i++)
		{
			Line line = lines[i];
			if (line == null)
			{
				continue;
			}
			line.ContentId = ((line.key > 0) ? flow.GetGenderContentId(line.key) : 0);
			line.LocalizedText = ((line.ContentId > 0) ? LocalizationUtility.GetLocalizeString("MainStory", line.ContentId) : string.Empty);
			if (line.LocalizedText == null)
			{
				line.LocalizedText = string.Empty;
			}
			line.LocalizedText = LuminDialogueUtility.ProcessPlayerName(line.LocalizedText);
			if (!(line.text == null))
			{
				if (line.group == null)
				{
					line.group = line.text.GetComponent<CanvasGroup>();
				}
				if (line.typeWriter == null)
				{
					line.typeWriter = line.text.GetComponent<MonoTypeWriterEffect>();
				}
				SetLineAlpha(line, 0f);
				line.text.text = string.Empty;
				line.text.gameObject.SetActive(value: true);
			}
		}
	}

	public async UniTask PlayIn(CancellationToken token)
	{
		m_ForceComplete = false;
		m_Playing = true;
		for (int i = 0; i < lines.Length; i++)
		{
			if (token.IsCancellationRequested)
			{
				break;
			}
			if (m_ForceComplete)
			{
				break;
			}
			Line line = lines[i];
			if (IsLineValid(line))
			{
				m_CurrentLineIndex = i;
				await WaitSeconds(line.appearDelay, token);
				if (token.IsCancellationRequested || m_ForceComplete)
				{
					break;
				}
				await ShowLine(line, token);
			}
		}
		if (!token.IsCancellationRequested && !m_ForceComplete)
		{
			await WaitSeconds(holdDuration, token);
		}
		m_CurrentLineIndex = -1;
	}

	public async UniTask Hide(CancellationToken token)
	{
		if (hideMode == AVGCaptionHideMode.LineByLine)
		{
			for (int i = 0; i < lines.Length; i++)
			{
				if (token.IsCancellationRequested)
				{
					break;
				}
				if (m_ForceComplete)
				{
					break;
				}
				Line line = lines[i];
				if (IsLineValid(line))
				{
					await WaitSeconds(line.hideDelay, token);
					if (token.IsCancellationRequested || m_ForceComplete)
					{
						break;
					}
					await HideLine(line, token);
				}
			}
		}
		else
		{
			m_Tasks.Clear();
			for (int j = 0; j < lines.Length; j++)
			{
				Line line2 = lines[j];
				if (IsLineValid(line2))
				{
					m_Tasks.Add(HideLineWithDelay(line2, token));
				}
			}
			await UniTask.WhenAll(m_Tasks);
			m_Tasks.Clear();
		}
		m_Playing = false;
	}

	public void CompleteCurrent()
	{
		if (m_CurrentLineIndex >= 0 && m_CurrentLineIndex < lines.Length)
		{
			CompleteLine(lines[m_CurrentLineIndex], visible: true);
		}
	}

	public void SkipToEnd()
	{
		m_ForceComplete = true;
		for (int i = 0; i < lines.Length; i++)
		{
			CompleteLine(lines[i], visible: true);
		}
	}

	public void CompleteImmediate(bool visible)
	{
		m_ForceComplete = true;
		m_Playing = false;
		for (int i = 0; i < lines.Length; i++)
		{
			CompleteLine(lines[i], visible);
		}
	}

	private void CompleteLine(Line line, bool visible)
	{
		if (IsLineValid(line))
		{
			DOTween.Kill(GetTweenTarget(line), complete: true);
			if (line.typeWriter != null)
			{
				line.typeWriter.StopTweenString();
			}
			line.text.text = (visible ? line.LocalizedText : string.Empty);
			SetLineAlpha(line, visible ? 1f : 0f);
		}
	}

	private async UniTask ShowLine(Line line, CancellationToken token)
	{
		switch (line.appearMode)
		{
		case AVGCaptionAppearMode.Instant:
			line.text.text = line.LocalizedText;
			SetLineAlpha(line, 1f);
			break;
		case AVGCaptionAppearMode.TypeWriter:
			await ShowLineTypeWriter(line, token);
			break;
		default:
			await ShowLineFade(line, token);
			break;
		}
	}

	private async UniTask ShowLineFade(Line line, CancellationToken token)
	{
		line.text.text = line.LocalizedText;
		SetLineAlpha(line, 0f);
		object tweenTarget = GetTweenTarget(line);
		DOTween.Kill(tweenTarget, complete: true);
		await (Tween)CreateFadeTween(line, 1f, line.fadeDuration).SetId(tweenTarget);
	}

	private async UniTask ShowLineTypeWriter(Line line, CancellationToken token)
	{
		if (line.typeWriter == null)
		{
			await ShowLineFade(line, token);
			return;
		}
		SetLineAlpha(line, 1f);
		line.typeWriter.TimeSpace = ((line.typeWriterSpeed < 35) ? 35 : line.typeWriterSpeed);
		line.typeWriter.text = line.LocalizedText;
		if (!string.IsNullOrEmpty(m_TypeWriterSoundKey))
		{
			PlayTypeWriterSound(line, token).Forget();
		}
		await UniTask.WaitUntil(() => token.IsCancellationRequested || m_ForceComplete || line.typeWriter.IsFinished);
	}

	private async UniTask HideLineWithDelay(Line line, CancellationToken token)
	{
		await WaitSeconds(line.hideDelay, token);
		if (!token.IsCancellationRequested && !m_ForceComplete)
		{
			await HideLine(line, token);
		}
	}

	private async UniTask HideLine(Line line, CancellationToken token)
	{
		object tweenTarget = GetTweenTarget(line);
		DOTween.Kill(tweenTarget, complete: true);
		await (Tween)CreateFadeTween(line, 0f, line.hideDuration).SetId(tweenTarget);
	}

	private async UniTask PlayTypeWriterSound(Line line, CancellationToken token)
	{
		int num = Mathf.Max(1, typeWriterSoundInterval);
		float delay = (float)Mathf.Max(35, line.typeWriter.TimeSpace * num) * 0.001f;
		while (!token.IsCancellationRequested && !m_ForceComplete && line.typeWriter != null && !line.typeWriter.IsFinished)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(m_TypeWriterSoundKey);
			await WaitSeconds(delay, token);
		}
	}

	private async UniTask WaitSeconds(float seconds, CancellationToken token)
	{
		if (!(seconds <= 0f))
		{
			float timer = 0f;
			while (!token.IsCancellationRequested && !m_ForceComplete && timer < seconds)
			{
				timer += Time.deltaTime;
				await UniTask.Yield(PlayerLoopTiming.Update, token).SuppressCancellationThrow();
			}
		}
	}

	private Tweener CreateFadeTween(Line line, float alpha, float duration)
	{
		if (line.group != null)
		{
			return line.group.DOFade(alpha, duration);
		}
		return line.text.DOFade(alpha, duration);
	}

	private object GetTweenTarget(Line line)
	{
		if (!(line.group != null))
		{
			return line.text;
		}
		return line.group;
	}

	private void SetLineAlpha(Line line, float alpha)
	{
		if (line.group != null)
		{
			line.group.alpha = alpha;
			return;
		}
		Color color = line.text.color;
		color.a = alpha;
		line.text.color = color;
	}

	private static bool IsLineValid(Line line)
	{
		if (line != null)
		{
			return line.text != null;
		}
		return false;
	}
}
