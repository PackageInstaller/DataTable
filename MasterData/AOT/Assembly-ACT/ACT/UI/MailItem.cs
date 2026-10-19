using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using Fundamental;
using Pb;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MailItem : LoopScrollBaseItem
{
	public MonoMailboxView view;

	public BetterAnimation betterAnimation;

	[Header("TextRoot CanvasGroup")]
	public CanvasGroup textRootCanvasGroup;

	[Header("TextMeshProUGUI")]
	public TextMeshProUGUI titleText;

	public TextMeshProUGUI senderText;

	public TextMeshProUGUI dayNumberText;

	[Header("LocalizeStringEvent")]
	public LocalizeStringEvent titleLocalize;

	public LocalizeStringEvent senderLocalize;

	public LocalizeStringEvent dayLocalize;

	[Header("Button")]
	public Button selectButton;

	[Header("Icon")]
	public GameObject withReward;

	public GameObject withoutReward;

	public GameObject getReward;

	public GameObject collectTag;

	public RedDotItem redDot;

	[Header("遮罩")]
	public Image mask;

	[Header("背景")]
	public GameObject selectBg;

	public CanvasGroup selectCanvasGroup;

	[Header("已读透明度")]
	public float readAlpha = 0.45f;

	[Header("时间显示根节点")]
	public GameObject timeKeepRoot;

	public GameObject timeDayRoot;

	private bool m_IsChosen;

	private int m_ShowInPlayVersion;

	private int m_BoundMailIndex = -1;

	private const long PermanentValue = 4070880000000L;

	public bool IsChosen
	{
		get
		{
			return m_IsChosen;
		}
		set
		{
			SetChosen(value, playAnimation: true);
		}
	}

	public override void ScrollCellIndex(int idx)
	{
		bool flag = m_BoundMailIndex != idx;
		m_BoundMailIndex = idx;
		index = idx;
		ACT.Game.Data.Mail mailByIndex = view.GetMailByIndex(idx);
		CanvasGroup canvasGroup = gameObject.transform.GetComponent<CanvasGroup>();
		canvasGroup.alpha = 1f;
		if (mailByIndex == null)
		{
			return;
		}
		SetChosen(view.curSelectMailIndex == idx, playAnimation: false);
		selectCanvasGroup.alpha = (IsChosen ? 1 : 0);
		if (flag)
		{
			int showInPlayVersion = ++m_ShowInPlayVersion;
			betterAnimation?.GetSequence("Show_In")?.OnComplete((AnimationBuilder _) =>
			{
				if (showInPlayVersion == m_ShowInPlayVersion && index == idx)
				{
					canvasGroup.alpha = 1f;
				}
			}).Play();
		}
		SetText(mailByIndex);
		SetIcon(mailByIndex);
		selectButton.onClick.RemoveAllListeners();
		selectButton.onClick.AddListener(() =>
		{
			if (view.curSelectMailIndex != idx)
			{
				view.OnMailChange(this, idx, 0.14);
				view.PlayAnim("RightSwitch");
			}
		});
	}

	public override void OnUnLoad()
	{
		base.OnUnLoad();
		m_BoundMailIndex = -1;
		m_ShowInPlayVersion++;
	}

	private void SetChosen(bool value, bool playAnimation)
	{
		m_IsChosen = value;
		selectBg.SetActive(value);
		if (!playAnimation || IsShowInPlaying())
		{
			selectCanvasGroup.alpha = (value ? 1 : 0);
			return;
		}
		m_ShowInPlayVersion++;
		betterAnimation?.GetSequence(value ? "Selected" : "Normal")?.Play();
	}

	private bool IsShowInPlaying()
	{
		if (betterAnimation != null && betterAnimation.CurrentAnimationName() == "Show_In")
		{
			return betterAnimation.CurrentAnimationPlaying();
		}
		return false;
	}

	private void SetText(ACT.Game.Data.Mail mail)
	{
		if (MailboxCacheManager.IsTemplateMail(mail))
		{
			ACT.Config.Mail mail2 = RuntimeConfigs.data.mails[mail.TemplateID];
			titleLocalize.enabled = true;
			senderLocalize.enabled = true;
			titleLocalize.StringReference.TableEntryReference = mail2.mailTitle;
			senderLocalize.StringReference.TableEntryReference = mail2.sender;
		}
		else
		{
			titleLocalize.enabled = false;
			senderLocalize.enabled = false;
			titleText.text = mail.Title;
			senderText.text = mail.Sender;
		}
		if (mail.ExpireTs == 4070880000000L)
		{
			timeDayRoot.SetActive(value: false);
			timeKeepRoot.SetActive(value: true);
		}
		else
		{
			timeDayRoot.SetActive(value: true);
			timeKeepRoot.SetActive(value: false);
			dayNumberText.text = TimeManager.GetMailTimeSpanString(mail.ExpireTs - TimeManager.ServerTime.NowTimestamp);
		}
	}

	private void SetIcon(ACT.Game.Data.Mail mail)
	{
		MailState state = (MailState)mail.State;
		MailTag toTag = (MailTag)mail.Tag;
		string text = string.Format(RedDotPathDefine.MailUnread, mail.Id);
		string[] source = text.Split("|");
		redDot.fullPath = source.ToList();
		redDot.displayAction = new UnreadMailAction
		{
			mailId = mail.Id
		};
		redDot.BindTrieNode();
		redDot.UpdateDisplay();
		switch (state)
		{
		case MailState.Unread:
			textRootCanvasGroup.alpha = 1f;
			mask.gameObject.SetActive(value: false);
			Singleton<RedDotManager>.instance.SetLeafNodeActive(text, active: true);
			getReward.SetActive(value: false);
			if (mail.Rewards.Count > 0)
			{
				withReward.SetActive(value: true);
				withoutReward.SetActive(value: false);
			}
			else
			{
				withReward.SetActive(value: false);
				withoutReward.SetActive(value: true);
			}
			break;
		case MailState.Read:
			ChangeMailStateToRead(mail);
			Singleton<RedDotManager>.instance.SetLeafNodeActive(text, active: false);
			break;
		default:
			ChangeMailStateToGetReward();
			Singleton<RedDotManager>.instance.SetLeafNodeActive(text, active: false);
			break;
		}
		ChangeMailTag(toTag);
	}

	public void ChangeMailStateToRead(ACT.Game.Data.Mail mail)
	{
		textRootCanvasGroup.alpha = readAlpha;
		mask.gameObject.SetActive(value: true);
		withoutReward.SetActive(value: false);
		getReward.SetActive(value: false);
		if (mail.Rewards.Count > 0)
		{
			withReward.SetActive(value: true);
			return;
		}
		withoutReward.SetActive(value: true);
		withReward.SetActive(value: false);
	}

	public void ChangeMailStateToGetReward()
	{
		textRootCanvasGroup.alpha = readAlpha;
		mask.gameObject.SetActive(value: true);
		withReward.SetActive(value: false);
		withoutReward.SetActive(value: false);
		getReward.SetActive(value: true);
	}

	public void ChangeMailTag(MailTag toTag)
	{
		collectTag.SetActive(toTag == MailTag.Collect);
	}
}
