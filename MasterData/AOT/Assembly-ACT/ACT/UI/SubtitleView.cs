using System;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class SubtitleView : BaseUIView
{
	private SubtitleViewData m_data;

	public LocalizeStringEvent m_subtitle;

	public TextMeshProUGUI txt;

	[NonSerialized]
	public int contentId;

	protected override void AddEventListener()
	{
	}

	protected override void RemoveEventListener()
	{
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		m_data = (uiViewData as SubtitleViewData) ?? new SubtitleViewData();
		SetViewShowMode(0f);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	public void UpdateSubtitleWords()
	{
		m_subtitle.StringReference.TableEntryReference = contentId;
	}

	public void SetViewShowMode(float a)
	{
		txt.color = new Color(1f, 1f, 1f, a);
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}
}
