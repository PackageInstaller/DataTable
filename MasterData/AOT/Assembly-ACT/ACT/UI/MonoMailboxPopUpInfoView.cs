using ACT.Battle;
using ACT.Core;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoMailboxPopUpInfoView : BaseUIView
{
	public enum MailboxPopUpInfoEnterType
	{
		none,
		mailBoxInfo
	}

	private MonoMailboxPopUpInfoViewData m_PrivateData;

	[Header("Text")]
	public LocalizeStringEvent titleLocalize;

	public GameObject deleteAllReadTextGameObject;

	public GameObject deleteSingleTextGameObject;

	[Header("中间内容")]
	public ScrollRect contentScrollRect;

	public LocalizeStringEvent mailboxCapacityLocalize;

	public LocalizeStringEvent mailboxMaxNumLocalize;

	public MonoMailboxPopUpInfoViewData m_Data
	{
		get
		{
			return m_PrivateData;
		}
		set
		{
			m_PrivateData = value;
		}
	}

	protected override void Init()
	{
		base.Init();
		m_Data = uiViewData as MonoMailboxPopUpInfoViewData;
		if (m_Data == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("MonoMailboxPopUpInfoView 传入参数为空!!! 不能为空");
			}
		}
		else if (m_Data.enterType == MailboxPopUpInfoEnterType.mailBoxInfo)
		{
			contentScrollRect.gameObject.SetActive(value: true);
			deleteAllReadTextGameObject.SetActive(value: false);
			deleteSingleTextGameObject.SetActive(value: false);
			mailboxCapacityLocalize.StringReference.GetVariable<int>("0").Value = m_Data.curDisplayableMailCount;
			mailboxCapacityLocalize.StringReference.GetVariable<int>("1").Value = RuntimeConfigs.data.game.maxNumberOfOrdinaryMailboxes;
			mailboxMaxNumLocalize.StringReference.GetVariable<int>("0").Value = RuntimeConfigs.data.game.maxNumberOfOrdinaryMailboxes;
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window");
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation?.GetSequence("Show").Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation?.GetSequence("Hide").Play();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	[GameInputBindingBool("UI/Back")]
	private void OnGamepadBackClick(bool value)
	{
		if (m_Data != null)
		{
			Close();
		}
	}
}
