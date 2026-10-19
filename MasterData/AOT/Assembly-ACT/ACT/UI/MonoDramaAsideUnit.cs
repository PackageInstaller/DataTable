using System;
using System.Collections.Generic;
using ACT.DialogueSystem;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.Settings;

namespace ACT.UI;

public class MonoDramaAsideUnit : MonoBehaviour
{
	public static class DramaAsideAnimState
	{
		public const string Show = "DialogueShow";

		public const string Hide = "DialogueHide";

		public const string Move = "DialogueMove";

		public const string Quit = "DialogueQuit";
	}

	public Animation animation;

	public BImage image;

	public LocalizeStringEvent speakerName;

	public LocalizeStringEvent content;

	public CanvasGroup canvasGroup;

	public MonoTypeWriterEffect monoTypeWriterEffect;

	public UnityEvent action;

	public bool playable;

	private Queue<string> m_OperationQueue = new Queue<string>();

	private bool m_IsPlaying;

	private MonoErrorEffect[] m_ErrorEffects;

	private float m_errorLength = -1f;

	private TextMeshProUGUI _speakerNameTxt;

	private TextMeshProUGUI m_Text;

	public bool isPlaying => m_IsPlaying;

	public bool isAnimating
	{
		get
		{
			if (null != animation)
			{
				return animation.isPlaying;
			}
			return false;
		}
	}

	public bool isTypeWriting
	{
		get
		{
			if (null != monoTypeWriterEffect)
			{
				return !monoTypeWriterEffect.IsFinished;
			}
			return false;
		}
	}

	private void Awake()
	{
		_speakerNameTxt = speakerName.GetComponent<TextMeshProUGUI>();
		m_Text = content.GetComponent<TextMeshProUGUI>();
	}

	private void GetEffects()
	{
		m_ErrorEffects = GetComponentsInChildren<MonoErrorEffect>();
		MonoErrorEffect[] errorEffects = m_ErrorEffects;
		foreach (MonoErrorEffect monoErrorEffect in errorEffects)
		{
			if (monoErrorEffect.length > m_errorLength)
			{
				m_errorLength = monoErrorEffect.length;
			}
		}
	}

	public void OnAnimationOver()
	{
		action?.Invoke();
		if (m_OperationQueue.Count > 0)
		{
			string text = m_OperationQueue.Dequeue();
			animation.Play(text);
		}
	}

	public void PlayAnim(string name)
	{
		if (playable)
		{
			if (isAnimating)
			{
				m_OperationQueue.Enqueue(name);
			}
			else
			{
				animation.Play(name);
			}
		}
	}

	public void PlayAnimation(string animationName)
	{
		animation.Play(animationName);
	}

	public string WriteContent(long id)
	{
		string localizedString = LocalizationSettings.StringDatabase.GetLocalizedString(content.StringReference.TableReference, id, null, content.StringReference.LocaleOverride, content.StringReference.FallbackState);
		localizedString = LuminDialogueUtility.ProcessPlayerName(localizedString);
		content.OnUpdateString?.Invoke(localizedString);
		return localizedString;
	}

	public void WriteSpeakerName(long id)
	{
		string arg = string.Empty;
		if (id != 0L)
		{
			arg = LocalizationSettings.StringDatabase.GetLocalizedString(speakerName.StringReference.TableReference, id, null, speakerName.StringReference.LocaleOverride, speakerName.StringReference.FallbackState);
			arg = LuminDialogueUtility.ProcessPlayerName(arg);
		}
		speakerName.OnUpdateString?.Invoke(arg);
	}

	[Obsolete("2026.8.7 设计需求，Aside不再显示头像")]
	public void WriteIcon(Sprite sprite)
	{
		image.icon.sprite = sprite;
	}

	public void Stop(string name)
	{
		if ((bool)this)
		{
			AnimationState animationState = animation[name];
			animation.Play(name);
			animationState.time = 0f;
			animation.Sample();
			animationState.enabled = false;
		}
	}

	public void SetVisible(bool isVisible)
	{
		m_IsPlaying = isVisible;
		canvasGroup.alpha = (isVisible ? 1f : 0f);
	}

	public void Uninit()
	{
		m_IsPlaying = false;
		content.StringReference.TableEntryReference = null;
		m_Text.text = string.Empty;
		_speakerNameTxt.text = string.Empty;
		playable = true;
		if (m_ErrorEffects != null)
		{
			MonoErrorEffect[] errorEffects = m_ErrorEffects;
			for (int i = 0; i < errorEffects.Length; i++)
			{
				errorEffects[i].enabled = false;
			}
		}
	}

	public void ClearAnimQueue()
	{
		m_OperationQueue.Clear();
	}

	public async UniTask PlayErrorEffect()
	{
		if (m_ErrorEffects == null)
		{
			GetEffects();
		}
		MonoErrorEffect[] errorEffects = m_ErrorEffects;
		for (int i = 0; i < errorEffects.Length; i++)
		{
			errorEffects[i].enabled = true;
		}
		await UniTask.Delay((int)(m_errorLength * 1000f));
	}
}
