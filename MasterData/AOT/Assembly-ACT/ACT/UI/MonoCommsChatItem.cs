using System.Threading;
using ACT.DialogueSystem;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class MonoCommsChatItem : MonoBehaviour
{
	public const string SHOW_ANIMATION = "Show";

	public const string HIDE_ANIMATION = "Hide";

	public BetterAnimation betterAnimation;

	public TextMeshProUGUI content;

	public LocalizeStringEvent contentLocalizeString;

	private RectTransform m_RectTransform;

	private int m_AnimationVersion;

	public void Initialize()
	{
		if ((object)betterAnimation == null)
		{
			betterAnimation = GetComponent<BetterAnimation>();
		}
		if ((object)m_RectTransform == null)
		{
			m_RectTransform = transform as RectTransform;
		}
	}

	public void SetContent(int contentId)
	{
		Initialize();
		if (!(contentLocalizeString == null))
		{
			contentLocalizeString.StringReference.TableEntryReference = contentId;
			contentLocalizeString.StringReference.TableReference = "MainStory";
		}
	}

	public void SetPosition(Vector2 anchor, Vector2 pivot, Vector2 anchoredPosition)
	{
		Initialize();
		if (!(m_RectTransform == null))
		{
			m_RectTransform.anchorMin = anchor;
			m_RectTransform.anchorMax = anchor;
			m_RectTransform.pivot = pivot;
			m_RectTransform.anchoredPosition = anchoredPosition;
		}
	}

	public async UniTask PlayShowAnimation(int contentId, CancellationToken token)
	{
		SetContent(contentId);
		gameObject.SetActive(value: true);
		await PlayAnimation("Show", token);
	}

	public async UniTask PlayHideAnimation(CancellationToken token)
	{
		await PlayAnimation("Hide", token);
		HideImmediate();
	}

	public void HideImmediate()
	{
		Initialize();
		m_AnimationVersion++;
		betterAnimation?.StopAnimation();
		gameObject.SetActive(value: false);
	}

	private async UniTask PlayAnimation(string animationName, CancellationToken token)
	{
		Initialize();
		int animationVersion = ++m_AnimationVersion;
		AnimationBuilder sequence = betterAnimation?.GetSequence(animationName);
		if (sequence == null)
		{
			return;
		}
		sequence.Play();
		await LuminDialogueUtility.WaitForSecondsOrForceNext(sequence.Duration(), token, () =>
		{
			if (animationVersion == m_AnimationVersion)
			{
				sequence.Complete();
			}
		});
		if (token.IsCancellationRequested || animationVersion != m_AnimationVersion)
		{
			if (animationVersion == m_AnimationVersion)
			{
				betterAnimation.StopAnimation();
			}
		}
		else if (!sequence.IsComplete())
		{
			sequence.Complete();
		}
	}
}
