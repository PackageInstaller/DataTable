using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoBlackScreenView : BaseUIView
{
	public LocalizeStringEvent descript;

	[SerializeField]
	private Image m_BlackCurtain;

	private CancellationTokenSource m_TokenSource;

	private TextMeshProUGUI m_text;

	private Tween m_BlackCurtainTween;

	protected override void Init()
	{
		base.Init();
		m_TokenSource = new CancellationTokenSource();
		m_text = descript.GetComponent<TextMeshProUGUI>();
		m_BlackCurtain.color = new Color(0f, 0f, 0f, 0f);
		m_BlackCurtain.gameObject.SetActive(value: false);
		m_text.color = new Color(0f, 0f, 0f, 0f);
	}

	public async UniTask ShowBlackScreen(float fadeIn, float last, float fadeOut)
	{
		m_BlackCurtain.gameObject.SetActive(value: true);
		m_BlackCurtainTween = m_BlackCurtain.DOColor(new Color(0f, 0f, 0f, 1f), fadeIn);
		await UniTask.Delay(TimeSpan.FromSeconds(fadeIn + last), ignoreTimeScale: false, PlayerLoopTiming.Update, m_TokenSource.Token);
		m_BlackCurtainTween = m_BlackCurtain.DOColor(new Color(0f, 0f, 0f, 0f), fadeOut);
		await UniTask.Delay(TimeSpan.FromSeconds(fadeOut));
	}

	public void SetBlackScreen(float a)
	{
		m_BlackCurtain.color = new Color(0f, 0f, 0f, a);
		if (a == 0f)
		{
			m_BlackCurtain.gameObject.SetActive(value: false);
		}
		else
		{
			m_BlackCurtain.gameObject.SetActive(value: true);
		}
	}

	public void SetBlackScreenText(int id, float a)
	{
		descript.StringReference.TableEntryReference = id;
		m_text.color = new Color(1f, 1f, 1f, a);
	}

	protected override void UnInit()
	{
		base.UnInit();
		m_BlackCurtainTween.Kill();
		try
		{
			m_TokenSource.Cancel();
			m_TokenSource.Dispose();
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
		}
	}
}
