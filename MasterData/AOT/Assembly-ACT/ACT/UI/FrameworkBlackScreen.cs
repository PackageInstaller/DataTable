using System;
using ACT.Battle;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class FrameworkBlackScreen : FrameworkComponent
{
	[SerializeField]
	private Image blackCurtain;

	public LocalizeStringEvent descript;

	private TextMeshProUGUI m_text;

	private float m_delayTimeToClose;

	private float m_delatTime;

	private bool m_isPaused;

	private Tween m_Tween;

	private bool m_PausedInput;

	public TextMeshProUGUI Text
	{
		get
		{
			if (m_text == null)
			{
				m_text = descript.GetComponent<TextMeshProUGUI>();
			}
			return m_text;
		}
	}

	public void Init()
	{
		Text.text = string.Empty;
		descript.StringReference.TableEntryReference = default;
		Text.color = new Color(0f, 0f, 0f, 0f);
		m_delayTimeToClose = -1f;
		m_delatTime = 0f;
	}

	public override async UniTask EnableImmediate(FrameworkBlackLoadData data = null)
	{
		await Enable(data);
	}

	public override async UniTask DisableImmediate(FrameworkBlackLoadData data = null)
	{
		await Disable(data);
	}

	private void OnEnable()
	{
		if ((bool)MonoECS.instance)
		{
			m_PausedInput = true;
			MonoECS.instance.PushPauseAllInput();
		}
	}

	private void OnDisable()
	{
		if (m_PausedInput)
		{
			m_PausedInput = false;
			if ((bool)MonoECS.instance)
			{
				MonoECS.instance.PopPauseAllInput();
			}
		}
	}

	public override async UniTask Enable(FrameworkComponentData data = null)
	{
		if (enable)
		{
			if (m_Tween != null)
			{
				await m_Tween.ToUniTask();
			}
			return;
		}
		m_Tween?.Kill();
		m_Tween = null;
		enable = true;
		FrameworkBlackScreenData frameworkBlackScreenData = data as FrameworkBlackScreenData;
		Color bgFromColor = new Color(0f, 0f, 0f, 0f);
		Color bgToColor = new Color(0f, 0f, 0f, 1f);
		Color txtFromColor = new Color(1f, 1f, 1f, 0f);
		Color txtToColor = new Color(1f, 1f, 1f, 1f);
		gameObject.SetActive(value: true);
		if (frameworkBlackScreenData != null && frameworkBlackScreenData.fadeInTime.TotalSeconds > 0.0)
		{
			blackCurtain.color = bgFromColor;
			Text.color = txtFromColor;
			float value = 0f;
			bool completed = false;
			m_Tween = DOTween.To(() => value, (float v) =>
			{
				value = v;
				Text.color = Color.Lerp(txtFromColor, txtToColor, v);
				blackCurtain.color = Color.Lerp(bgFromColor, bgToColor, v);
			}, 1f, (float)frameworkBlackScreenData.fadeInTime.TotalSeconds).OnComplete(() =>
			{
				completed = true;
				m_Tween = null;
			});
			await m_Tween.ToUniTask(TweenCancelBehaviour.Kill, gameObject.GetCancellationTokenOnDestroy());
			if (!completed)
			{
				return;
			}
		}
		Text.color = txtToColor;
		blackCurtain.color = bgToColor;
	}

	public override async UniTask Disable(FrameworkComponentData data = null)
	{
		if (!enable)
		{
			if (m_Tween != null)
			{
				await m_Tween.ToUniTask();
			}
			return;
		}
		m_Tween?.Kill();
		m_Tween = null;
		enable = false;
		m_delayTimeToClose = 0f;
		m_delatTime = 0f;
		FrameworkBlackScreenData frameworkBlackScreenData = data as FrameworkBlackScreenData;
		Color bgFromColor = new Color(0f, 0f, 0f, 1f);
		Color bgToColor = new Color(0f, 0f, 0f, 0f);
		Color txtFromColor = new Color(1f, 1f, 1f, 1f);
		Color txtToColor = new Color(1f, 1f, 1f, 0f);
		if (frameworkBlackScreenData != null && frameworkBlackScreenData.fadeOutTime.TotalSeconds > 0.0)
		{
			blackCurtain.color = bgFromColor;
			Text.color = txtFromColor;
			float value = 0f;
			bool completed = false;
			m_Tween = DOTween.To(() => value, (float v) =>
			{
				value = v;
				Text.color = Color.Lerp(txtFromColor, txtToColor, v);
				blackCurtain.color = Color.Lerp(bgFromColor, bgToColor, v);
			}, 1f, (float)frameworkBlackScreenData.fadeOutTime.TotalSeconds).OnComplete(() =>
			{
				completed = true;
				m_Tween = null;
			});
			await m_Tween.ToUniTask(TweenCancelBehaviour.Kill, gameObject.GetCancellationTokenOnDestroy());
			if (!completed)
			{
				Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(string.Empty);
				return;
			}
		}
		blackCurtain.color = bgToColor;
		Text.color = txtToColor;
		gameObject.SetActive(value: false);
		Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(string.Empty);
	}

	public void SetBlackScreen(float a, float delayTimeToClose = -1f)
	{
		a = Mathf.Clamp01(a);
		m_Tween?.Kill();
		m_Tween = null;
		enable = a != 0f;
		if ((bool)blackCurtain)
		{
			blackCurtain.color = new Color(0f, 0f, 0f, a);
		}
		if ((bool)Text)
		{
			Text.color = new Color(1f, 1f, 1f, a);
		}
		gameObject.SetActive(enable);
		m_delayTimeToClose = delayTimeToClose;
		m_delatTime = 0f;
	}

	public void SetBlackScreenText(int contentId, float alpha)
	{
		if (contentId == 0)
		{
			Text.text = string.Empty;
			descript.StringReference.TableEntryReference = default;
		}
		else
		{
			descript.StringReference.TableEntryReference = contentId;
		}
		Text.color = new Color(1f, 1f, 1f, alpha);
	}

	public void SetBlackScreenText(string text)
	{
		Text.text = text;
	}

	public void ClearText()
	{
		Text.text = string.Empty;
		descript.StringReference.TableEntryReference = default;
	}

	public void Update()
	{
		if (m_delayTimeToClose > 0f)
		{
			m_delatTime += Time.deltaTime;
			if (m_delatTime > m_delayTimeToClose)
			{
				m_delayTimeToClose = 0f;
				m_delatTime = 0f;
				Disable(new FrameworkBlackScreenData
				{
					fadeOutTime = TimeSpan.FromSeconds(1.0)
				});
			}
		}
	}
}
