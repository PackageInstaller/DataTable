using System;
using ACT.Battle;
using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CommonInfoView : BaseUIView
{
	public class CommonInfoParam : UIViewData
	{
		public int titleId;

		public int commonId;

		public bool onlyConfirm;

		public Action OnConfirm;

		public Action OnCancel;

		public bool useLongCommon;

		public LocalizedString content_longCommon;

		public string[] Titletexts;

		public string[] texts;

		public bool needPause;

		public bool showBottomGroup;
	}

	public LocalizeStringEvent titleEvent;

	public LocalizeStringEvent localStringEvent;

	public TextMeshProUGUI text;

	public ActButton CancelBtn;

	public ActButton ConfirmBtn;

	public Transform content;

	protected CommonInfoParam m_Param;

	protected override void PlayOpenAnimation()
	{
		betterAnimation?.GetSequence("Show").Play();
	}

	protected override void PlayCloseAnimation()
	{
		betterAnimation?.GetSequence("Hide").Play();
	}

	protected override void Init()
	{
		base.Init();
		m_Param = (CommonInfoParam)uiViewData;
		if (m_Param.titleId != 0)
		{
			titleEvent.gameObject.SetActive(value: true);
			titleEvent.StringReference.TableEntryReference = m_Param.titleId;
		}
		else if (m_Param.Titletexts != null && m_Param.Titletexts.Length != 0)
		{
			titleEvent.gameObject.SetActive(value: true);
			for (int i = 0; i < m_Param.Titletexts.Length; i++)
			{
				titleEvent.OnUpdateString.Invoke(m_Param.Titletexts[i]);
			}
		}
		else
		{
			titleEvent.gameObject.SetActive(value: false);
		}
		if (m_Param.needPause)
		{
			MonoECS.instance.PushPause();
		}
		if (!m_Param.showBottomGroup)
		{
			ConfirmBtn.gameObject.SetActive(value: false);
			CancelBtn.gameObject.SetActive(value: false);
		}
		else
		{
			ConfirmBtn.gameObject.SetActive(value: true);
			CancelBtn.gameObject.SetActive(!m_Param.onlyConfirm);
		}
		if (m_Param.useLongCommon)
		{
			localStringEvent.StringReference = m_Param.content_longCommon;
			return;
		}
		localStringEvent.StringReference.TableEntryReference = m_Param.commonId;
		if (m_Param.texts == null || m_Param.texts.Length == 0)
		{
			return;
		}
		if (m_Param.commonId == 0)
		{
			for (int j = 0; j < m_Param.texts.Length; j++)
			{
				localStringEvent.OnUpdateString.Invoke(m_Param.texts[j]);
			}
		}
		for (int k = 0; k < m_Param.texts.Length; k++)
		{
			localStringEvent.StringReference.GetVariable<string>(k.ToString()).Value = m_Param.texts[k];
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		if (m_Param.needPause)
		{
			MonoECS.instance.PopPause();
		}
	}

	public void OnConfirmBtn()
	{
		m_Param.OnConfirm?.Invoke();
		Close();
	}

	public void OnCancelBtn()
	{
		m_Param.OnCancel?.Invoke();
		Close();
	}
}
