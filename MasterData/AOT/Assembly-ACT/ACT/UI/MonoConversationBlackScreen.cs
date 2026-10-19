using ACT.DialogueSystem;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.Settings;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoConversationBlackScreen : MonoBehaviour
{
	private bool visible;

	private Tweener tween;

	public MonoConversationView view;

	public CanvasGroup group;

	public Image bg;

	public LocalizeStringEvent localText;

	public MonoTypeWriterEffect typeWriter;

	public bool Visible => visible;

	public void Init()
	{
		visible = false;
		tween?.Kill();
		tween = null;
		group.alpha = 0f;
		group.gameObject.SetActive(value: false);
		SetText(0);
	}

	public void UnInit()
	{
		visible = false;
		tween?.Kill();
		tween = null;
		group.alpha = 0f;
		group.gameObject.SetActive(value: false);
		SetText(0);
	}

	public async UniTask Show(float speed)
	{
		if (!visible)
		{
			visible = true;
			view.RefreshTips();
			if (tween != null)
			{
				tween.Kill();
				tween = null;
			}
			group.gameObject.SetActive(value: true);
			group.alpha = 0f;
			tween = group.DOFade(1f, speed);
			await (Tween)tween;
			tween = null;
		}
	}

	public void ForceShow()
	{
		visible = true;
		view.RefreshTips();
		tween?.Kill();
		tween = null;
		group.gameObject.SetActive(value: true);
		group.alpha = 1f;
	}

	public async UniTask Hide(float speed)
	{
		if (visible)
		{
			visible = false;
			view.RefreshTips();
			if (tween != null)
			{
				tween.Kill();
				tween = null;
			}
			group.gameObject.SetActive(value: true);
			group.alpha = 1f;
			tween = group.DOFade(0f, speed);
			await (Tween)tween;
			tween = null;
			group.gameObject.SetActive(value: false);
			SetText(0);
		}
	}

	public void ForceHide()
	{
		visible = false;
		view.RefreshTips();
		tween?.Kill();
		tween = null;
		group.alpha = 0f;
		group.gameObject.SetActive(value: false);
		SetText(0);
	}

	public void SetText(string v)
	{
		localText.StringReference.TableEntryReference = string.Empty;
		typeWriter.text = v;
	}

	public void SetText(int subtitleEntry)
	{
		if (subtitleEntry == 0)
		{
			SetText(string.Empty);
			return;
		}
		string localizedString = LocalizationSettings.StringDatabase.GetLocalizedString(localText.StringReference.TableReference, subtitleEntry, null, localText.StringReference.LocaleOverride, localText.StringReference.FallbackState);
		localizedString = LuminDialogueUtility.ProcessPlayerName(localizedString);
		typeWriter.text = localizedString;
	}
}
