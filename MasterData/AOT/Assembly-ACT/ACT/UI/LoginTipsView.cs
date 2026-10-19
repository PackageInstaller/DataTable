using ACT.Battle;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class LoginTipsView : BaseUIView<LoginTipsViewInputController>
{
	private LoginTipsViewData m_Param;

	public LocalizeStringEvent titleEvent;

	public LocalizeStringEvent localStringEvent;

	public TextMeshProUGUI text;

	public Button CancelBtn;

	public Button ConfirmBtn;

	private bool m_isClicked;

	public ViewControlLayer ViewControlLayer;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		ViewControlLayer.Focus();
		m_Param = (LoginTipsViewData)uiViewData;
		m_isClicked = false;
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
		ConfirmBtn.gameObject.SetActive(!m_Param.onlyConfirm);
		CancelBtn.gameObject.SetActive(!m_Param.onlyConfirm);
		if (m_Param.useLongCommon)
		{
			localStringEvent.StringReference = m_Param.content_longCommon;
			return;
		}
		localStringEvent.gameObject.SetActive(m_Param.commonId != 0);
		if (m_Param.commonId != 0)
		{
			localStringEvent.StringReference.TableEntryReference = m_Param.commonId;
		}
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

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		PlayOptionalSound(m_Param?.audioOpenSound);
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		ViewControlLayer.UnFocus();
		if (m_Param.needPause)
		{
			MonoECS.instance.PopPause();
		}
	}

	public void OnConfirmBtn()
	{
		if (!m_isClicked)
		{
			if (m_Param.onlyClickOnce)
			{
				m_isClicked = true;
			}
			PlayOptionalSound(m_Param.audioConfirmSound);
			m_Param.OnConfirm?.Invoke();
			Close();
		}
	}

	public void OnCancelBtn()
	{
		if (!m_isClicked)
		{
			if (m_Param.onlyClickOnce)
			{
				m_isClicked = true;
			}
			PlayOptionalSound(m_Param.audioCancelSound);
			m_Param.OnCancel?.Invoke();
			Close();
		}
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		PlayOptionalSound(m_Param?.audioCloseSound);
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	private static void PlayOptionalSound(string sound)
	{
		if (!string.IsNullOrEmpty(sound))
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(sound);
		}
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
