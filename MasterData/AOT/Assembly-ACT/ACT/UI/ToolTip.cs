using System.Collections;
using ACT.Utility;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class ToolTip : BaseUIView
{
	private static ToolTip __instance;

	public TextMeshProUGUI TipText;

	public CanvasGroup TipGroup;

	public LocalizeStringEvent TipTextLocal;

	public GameObject Text3;

	public bool isRun;

	private Coroutine m_FadeCorotine;

	private ToolTipData m_ToolTipdata;

	public static ToolTip Instance => __instance;

	protected override void Init()
	{
		base.Init();
		isRun = false;
		m_ToolTipdata = uiViewData as ToolTipData;
		if (m_ToolTipdata != null)
		{
			StartCoroutine(ShowTip(m_ToolTipdata.tipTextId, m_ToolTipdata.rTimeLength, m_ToolTipdata.tipTextInteger, m_ToolTipdata.isChange));
		}
	}

	private IEnumerator ShowTip(int tipTextId, float rTimeLength, int tipTextInteger, bool isChange)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/NegativeTips_Open");
		if (m_FadeCorotine != null)
		{
			StopCoroutine(m_FadeCorotine);
		}
		gameObject.SetActive(value: true);
		isRun = true;
		TipTextLocal.StringReference.TableEntryReference = tipTextId;
		if (tipTextInteger != 0)
		{
			TipTextLocal.StringReference.GetVariable<int>("0").Value = tipTextInteger;
		}
		m_FadeCorotine = StartCoroutine(Fade(rTimeLength));
		yield return m_FadeCorotine;
		if (UIController.State == UIState.Opened)
		{
			Close();
		}
		isRun = false;
	}

	private IEnumerator Fade(float fadeTime)
	{
		float rCurTime = 0f;
		yield return new WaitUntil(() =>
		{
			TipGroup.alpha = Mathf.Lerp(1f, 0f, Mathf.InverseLerp(0f, fadeTime, rCurTime));
			rCurTime += Time.deltaTime;
			return rCurTime >= fadeTime;
		});
	}

	protected override void UnInit()
	{
		base.UnInit();
		StopCoroutine("ShowTip");
		StopCoroutine("Fade");
	}
}
