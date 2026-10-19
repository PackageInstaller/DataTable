using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.Net;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Pb;
using Sirenix.Serialization;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoMailboxView : BaseUIView<MonoMailBoxViewInputController>
{
	private MonoMailboxViewData m_PrivateData;

	[Header("默认选中的邮件下标")]
	public int defaultSelectMailIndex;

	[Header("手柄提示组件")]
	public GamePadTipsComp gamePadTips;

	[Header("各板块的根节点")]
	public GameObject topRoot;

	public GameObject leftRoot;

	public GameObject middleRoot;

	public GameObject buttonRoot;

	public GameObject noCountBackGround;

	[Header("左侧邮件 LoopVerticalScrollRect")]
	public LoopVerticalScrollRect mailLoopScrollRect;

	[Header("邮件详情 ScrollRect")]
	public ScrollRect detailScrollRect;

	[Header("邮件详情文字")]
	public TextMeshProUGUI detailTitleText;

	public TextMeshProUGUI detailContentText;

	public TextMeshProUGUI detailSenderText;

	public TextMeshProUGUI detailSendTimeText;

	public LocalizeStringEvent detailTitleLocalize;

	public LocalizeStringEvent detailContentLocalize;

	public LocalizeStringEvent detailSenderLocalize;

	public LocalizeStringEvent detailSendTimeLocalize;

	[SerializeField]
	public ActButton mailLinkButton;

	[SerializeField]
	private TextMeshProUGUI _mailLinkText;

	[Header("邮件详情文字布局")]
	public RectTransform detailContentRectTransform;

	public RectTransform detailEndRectTransform;

	[Header("奖励 LoopHorizontalScrollRect")]
	public LoopHorizontalScrollRect rewardLoopScrollRect;

	[Header("奖励布局")]
	public GameObject rewardName;

	public GameObject rewardScrollRectGo;

	[Header("底下按钮")]
	public ActButton getAllRewardBtn;

	public ActButton deleteAllReadBtn;

	public ActButton collectBtn;

	public ActButton collectedBtn;

	public ActButton getRewardBtn;

	public ActButton deleteBtn;

	[OdinSerialize]
	public Dictionary<MailSubController, List<GameObject>> AllInputIcons;

	[OdinSerialize]
	public Dictionary<MailSubController, ViewControlLayer> ViewControlLayers;

	private List<ACT.Game.Data.Mail> orderedDisplayMailList = new List<ACT.Game.Data.Mail>();

	private List<Item> rewardList = new List<Item>();

	[HideInInspector]
	public int curSelectMailIndex = -1;

	private MailItem curSelectMailItem;

	private List<int> unReadToReadIdList = new List<int>();

	private const float sendUnReadToReadReqInterval = 10f;

	private float timer;

	private List<GamePadTipsAction> _tipsActions = new List<GamePadTipsAction>();

	private Dictionary<string, GamePadTipsAction> actionDic = new Dictionary<string, GamePadTipsAction>();

	public MonoMailboxViewData m_Data
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

	protected override void OnInputControllerCreate()
	{
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		InitGameTipsDic();
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").Play();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Email/Open");
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").Play();
	}

	protected override void Init()
	{
		base.Init();
		MonoECS.instance.PushPause();
		ReLoadDisplayableMailList();
		mailLoopScrollRect.OnItemLoad.AddListener(OnMailLoaded);
		if (orderedDisplayMailList.Count > 0)
		{
			LoadMailInfo();
		}
		getRewardBtn.OnClick.RemoveAllListeners();
		getRewardBtn.OnClick.AddListener(() =>
		{
			GetRewardSingleMail(GetMailByIndex(curSelectMailIndex));
		});
		collectBtn.OnClick.RemoveAllListeners();
		collectBtn.OnClick.AddListener(() =>
		{
			ChangeTagSingleMail(GetMailByIndex(curSelectMailIndex));
		});
		collectedBtn.OnClick.RemoveAllListeners();
		collectedBtn.OnClick.AddListener(() =>
		{
			ChangeTagSingleMail(GetMailByIndex(curSelectMailIndex));
		});
		getAllRewardBtn.OnClick.RemoveAllListeners();
		getAllRewardBtn.OnClick.AddListener(() =>
		{
			GetRewardAllMail();
		});
		deleteBtn.OnClick.RemoveAllListeners();
		deleteBtn.OnClick.AddListener(() =>
		{
			OpenDeleteSingleMailPopUp();
		});
		deleteAllReadBtn.OnClick.RemoveAllListeners();
		deleteAllReadBtn.OnClick.AddListener(() =>
		{
			OpenDeleteAllReadMailPopUp();
		});
		timer = 0f;
		unReadToReadIdList = new List<int>();
	}

	protected override void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_RefreshMailboxPanel, Refresh);
	}

	public void Refresh(BaseEventContent obj = null)
	{
		ReLoadDisplayableMailList();
		if (curSelectMailItem != null)
		{
			curSelectMailItem.IsChosen = false;
		}
		curSelectMailItem = null;
		curSelectMailIndex = -1;
		if (orderedDisplayMailList.Count > 0)
		{
			LoadMailInfo();
		}
	}

	private void ReLoadDisplayableMailList()
	{
		orderedDisplayMailList.Clear();
		orderedDisplayMailList.AddRange(Singleton<MailboxCacheManager>.instance.GetOrderedDisplayableMail().ToList());
		CheckNoCount();
	}

	private void InitGameTipsDic()
	{
		actionDic.Add("UI/RSUpDownSelect", new GamePadTipsAction
		{
			inputAction = "UI/RSUpDownSelect",
			localizeKey = 2165,
			localizeTable = "Common"
		});
		actionDic.Add("UI/LSLeftRightSelect", new GamePadTipsAction
		{
			inputAction = "UI/LSLeftRightSelect"
		});
		actionDic.Add("UI/Back", new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		});
		actionDic.Add("LargeMapView/Select", new GamePadTipsAction
		{
			inputAction = "LargeMapView/Select",
			localizeKey = 774,
			localizeTable = "Common"
		});
		actionDic.Add("UI/LSUpDownSelect", new GamePadTipsAction
		{
			inputAction = "UI/LSUpDownSelect"
		});
	}

	private async void LoadMailInfo()
	{
		mailLoopScrollRect.totalCount = orderedDisplayMailList.Count;
		await UniTask.DelayFrame(3);
		mailLoopScrollRect.RefillCells();
		mailLoopScrollRect.RefreshCells();
		LayoutRebuilder.ForceRebuildLayoutImmediate(transform as RectTransform);
		if (defaultSelectMailIndex < orderedDisplayMailList.Count)
		{
			OnMailChange(mailLoopScrollRect.content.GetChild(defaultSelectMailIndex).GetComponent<MailItem>(), defaultSelectMailIndex);
		}
		SetGamePadTipsActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	private void LoadRewardInfo(ACT.Game.Data.Mail mail)
	{
		rewardList.Clear();
		foreach (Item reward in mail.Rewards)
		{
			rewardList.Add(reward);
		}
		rewardList.Sort(SortUtility.DefaultItemSort);
		if (rewardList.Count == 0)
		{
			rewardName.SetActive(value: false);
			rewardScrollRectGo.SetActive(value: false);
			return;
		}
		rewardName.SetActive(value: false);
		rewardScrollRectGo.SetActive(value: false);
		rewardName.SetActive(value: true);
		rewardScrollRectGo.SetActive(value: true);
		rewardLoopScrollRect.OnItemShow.RemoveListener(OnRewardShow);
		rewardLoopScrollRect.ClearCells();
		rewardLoopScrollRect.totalCount = rewardList.Count;
		rewardLoopScrollRect.OnItemShow.AddListener(OnRewardShow);
		rewardLoopScrollRect.RefillCells();
		rewardLoopScrollRect.ForceUpdateConstraint();
	}

	protected override void UnInit()
	{
		base.UnInit();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		actionDic.Clear();
		_tipsActions.Clear();
		MonoECS.instance.PopPause();
		if (curSelectMailItem != null)
		{
			curSelectMailItem.IsChosen = false;
		}
		curSelectMailItem = null;
		curSelectMailIndex = -1;
		ReadAllCachedMail();
		timer = 0f;
	}

	protected override void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_RefreshMailboxPanel, Refresh);
	}

	private void Update()
	{
		if (UIController.State != UIState.Opened)
		{
			return;
		}
		if (timer < 10f)
		{
			timer += Time.deltaTime;
			return;
		}
		if (unReadToReadIdList != null && unReadToReadIdList.Count > 0)
		{
			ReadAllCachedMail();
			unReadToReadIdList.Clear();
		}
		timer = 0f;
	}

	public void OnMailChange(MailItem mailItem, int targetIndex, double timeDelay = 0.0)
	{
		if (targetIndex < orderedDisplayMailList.Count && curSelectMailIndex != targetIndex)
		{
			curSelectMailIndex = targetIndex;
			if (curSelectMailItem != null)
			{
				curSelectMailItem.IsChosen = false;
			}
			curSelectMailItem = mailItem;
			curSelectMailItem.IsChosen = true;
			ACT.Game.Data.Mail mailByIndex = GetMailByIndex(targetIndex);
			if (timeDelay > 0.0)
			{
				SetMailDetailWithDelay(mailByIndex, timeDelay).Forget();
			}
			else
			{
				SetMailDetail(mailByIndex);
			}
			if (mailByIndex.State == 0 && mailByIndex.Rewards.Count < 1)
			{
				ReadSingleMail(mailByIndex);
			}
		}
	}

	private async UniTaskVoid SetMailDetailWithDelay(ACT.Game.Data.Mail mail, double delaySeconds)
	{
		await UniTask.Delay(TimeSpan.FromSeconds(delaySeconds), ignoreTimeScale: false, PlayerLoopTiming.Update, this.GetCancellationTokenOnDestroy());
		if (mail != null && GetMailByIndex(curSelectMailIndex)?.Id == mail.Id)
		{
			SetMailDetail(mail);
		}
	}

	public void SetMailDetail(ACT.Game.Data.Mail mail)
	{
		if (MailboxCacheManager.IsTemplateMail(mail))
		{
			ACT.Config.Mail templateMail = RuntimeConfigs.data.mails[mail.TemplateID];
			SetTemplateMailDetailText(templateMail, mail);
		}
		else
		{
			SetFixedMailDetailText(mail);
		}
		SetDetailLayout();
		LoadRewardInfo(mail);
		SetCollectBtnImage((MailTag)mail.Tag);
		SetGetRewardBtnOrDeleteBtn(mail);
		GamePadTipsStatusChange(GetController().ControllerType);
	}

	private void SetTemplateMailDetailText(ACT.Config.Mail templateMail, ACT.Game.Data.Mail mail)
	{
		detailTitleLocalize.enabled = true;
		detailContentLocalize.enabled = true;
		detailSenderLocalize.enabled = true;
		detailTitleLocalize.StringReference.TableEntryReference = templateMail.mailTitle;
		detailContentLocalize.StringReference.TableEntryReference = templateMail.mailShow;
		detailSenderLocalize.StringReference.TableEntryReference = templateMail.sender;
		detailSendTimeText.text = TimeManager.GetDateTimeString(TimeManager.LocalTime.GetDateTime(mail.CreateTs), "yyyy/MM/dd  HH:mm");
		SetMailLink(mail);
	}

	private void SetFixedMailDetailText(ACT.Game.Data.Mail mail)
	{
		detailTitleLocalize.enabled = false;
		detailContentLocalize.enabled = false;
		detailSenderLocalize.enabled = false;
		detailTitleText.text = mail.Title;
		detailContentText.text = mail.Content;
		detailSenderText.text = mail.Sender;
		detailSendTimeText.text = TimeManager.GetDateTimeString(TimeManager.LocalTime.GetDateTime(mail.CreateTs), "yyyy/MM/dd  HH:mm");
		SetMailLink(mail);
	}

	private void SetMailLink(ACT.Game.Data.Mail mail)
	{
		mailLinkButton.gameObject.SetActive(mail.LinkType != MailLinkType.None);
		if (mail.LinkType != MailLinkType.None)
		{
			_mailLinkText.text = mail.QuestionnaireTitle;
			mailLinkButton.SetBtnClick(() =>
			{
				OnMailLinkButtonClick(mail);
			});
		}
	}

	private static bool TryNormalizeMailUrl(string rawUrl, out string normalizedUrl)
	{
		normalizedUrl = string.Empty;
		if (string.IsNullOrWhiteSpace(rawUrl))
		{
			return false;
		}
		if (!Uri.TryCreate(rawUrl.Trim(), UriKind.Absolute, out var result) || (result.Scheme != Uri.UriSchemeHttp && result.Scheme != Uri.UriSchemeHttps))
		{
			return false;
		}
		normalizedUrl = result.AbsoluteUri;
		return true;
	}

	public void OnMailLinkButtonClick(ACT.Game.Data.Mail mail)
	{
		if (mail.LinkType == MailLinkType.Inner)
		{
			if (!TryNormalizeMailUrl(mail.QuestionnaireUrl, out var normalizedUrl))
			{
				LogInvalidMailUrl(mail.QuestionnaireUrl);
				return;
			}
			UIUtility.OpenWebView(normalizedUrl, isPortrait: true);
			HyperLinkClick(mail, normalizedUrl);
		}
		else if (mail.LinkType == MailLinkType.Outer)
		{
			if (!TryNormalizeMailUrl(mail.QuestionnaireUrl, out var normalizedUrl2))
			{
				LogInvalidMailUrl(mail.QuestionnaireUrl);
				return;
			}
			Application.OpenURL(normalizedUrl2);
			HyperLinkClick(mail, normalizedUrl2);
		}
		else
		{
			if (mail.LinkType != MailLinkType.GameContent)
			{
				return;
			}
			int link = mail.Link;
			if (link != 0)
			{
				RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(link);
				JumpResult result = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
				if (result.ShowType == JumpResult.JumpShowType.Forbidden || result.ShowType == JumpResult.JumpShowType.Hide)
				{
					GameUtility.OpenJumpResultTips(result);
					result.Release();
				}
				else
				{
					Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
					result.Release();
				}
			}
		}
	}

	private static void LogInvalidMailUrl(string rawUrl)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning("邮件链接格式无效，忽略打开: " + rawUrl);
		}
	}

	private void HyperLinkClick(ACT.Game.Data.Mail mail, string normalizedUrl)
	{
		HyperlinkClick evt = EventTrackSolver.Instance.GetEvt<HyperlinkClick>();
		evt.title = mail.QuestionnaireTitle;
		evt.link = normalizedUrl;
		evt.systemId = 7004;
		evt.mailId = mail.Id;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private void SetDetailLayout()
	{
		Vector2 sizeDelta = detailScrollRect.content.sizeDelta;
		sizeDelta.y = Mathf.Abs(detailContentRectTransform.anchoredPosition.y) + detailContentRectTransform.sizeDelta.y + detailEndRectTransform.sizeDelta.y;
		detailScrollRect.content.sizeDelta = sizeDelta;
	}

	private void SetCollectBtnImage(MailTag mailTag)
	{
		switch (mailTag)
		{
		case MailTag.Notag:
			collectBtn.gameObject.SetActive(value: true);
			collectedBtn.gameObject.SetActive(value: false);
			break;
		case MailTag.Collect:
			collectBtn.gameObject.SetActive(value: false);
			collectedBtn.gameObject.SetActive(value: true);
			break;
		}
	}

	private void SetGetRewardBtnOrDeleteBtn(ACT.Game.Data.Mail mail)
	{
		if (mail.Rewards.Count > 0)
		{
			if (mail.State == 2)
			{
				deleteBtn.gameObject.SetActive(value: true);
				getRewardBtn.gameObject.SetActive(value: false);
			}
			else if (mail.State == 0 || mail.State == 1)
			{
				getRewardBtn.gameObject.SetActive(value: true);
				deleteBtn.gameObject.SetActive(value: false);
			}
		}
		else
		{
			deleteBtn.gameObject.SetActive(value: true);
			getRewardBtn.gameObject.SetActive(value: false);
		}
	}

	public void OnRewardShow(ILoopScrollDataSource iLoopDataSource)
	{
		if (iLoopDataSource is ItemUIComponentBase itemUIComponentBase)
		{
			ItemUIComponentBase itemUIComponentBase2 = itemUIComponentBase;
			if (itemUIComponentBase2.Index <= rewardList.Count - 1 && itemUIComponentBase2.Index >= 0)
			{
				ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(rewardList[itemUIComponentBase.Index].Id, rewardList[itemUIComponentBase.Index].Count);
				itemUIComponentBase2.SetData(item, long.MinValue, (GetMailByIndex(curSelectMailIndex).State == 2) ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
				itemUIComponentBase2.UpdatePerformance();
				itemUIComponentBase2.gameObject.SetActive(value: true);
			}
		}
	}

	private void OpenDeleteSingleMailPopUp()
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
		{
			commonId = 636,
			OnConfirm = () =>
			{
				DeleteSingleMail(GetMailByIndex(curSelectMailIndex));
			}
		}).Forget();
	}

	public void OpenDeleteAllReadMailPopUp()
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
		{
			commonId = 635,
			OnConfirm = () =>
			{
				DeleteAllReadMail();
			}
		}).Forget();
	}

	public void OpenMailboxInfoPopUp()
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_MAILBOXPOPUPINFOPANEL, new MonoMailboxPopUpInfoViewData
		{
			view = this,
			enterType = MonoMailboxPopUpInfoView.MailboxPopUpInfoEnterType.mailBoxInfo,
			curDisplayableMailCount = orderedDisplayMailList.Count
		}).Forget();
	}

	public void ReadSingleMail(ACT.Game.Data.Mail targetMail)
	{
		if (targetMail != null && targetMail.State <= 0)
		{
			if (!unReadToReadIdList.Contains(targetMail.Id))
			{
				unReadToReadIdList.Add(targetMail.Id);
			}
			orderedDisplayMailList.Find((ACT.Game.Data.Mail m) => m.Id == targetMail.Id).State = 1;
			curSelectMailItem.ChangeMailStateToRead(targetMail);
			Singleton<MailboxCacheManager>.instance.ChangeSingleMailState(targetMail.Id, MailState.Read);
		}
	}

	public async void ReadAllCachedMail()
	{
		if (unReadToReadIdList == null || unReadToReadIdList.Count == 0)
		{
			return;
		}
		List<int> list = new List<int>();
		foreach (int unReadToReadId in unReadToReadIdList)
		{
			if (GetMailById(unReadToReadId) != null && !list.Contains(unReadToReadId))
			{
				list.Add(unReadToReadId);
			}
		}
		if (list.Count != 0)
		{
			MailChangeStateReq data = new MailChangeStateReq
			{
				Ids = { (IEnumerable<int>)list },
				ToState = MailState.Read
			};
			_ = (await Singleton<NetManager>.instance.RequestAsync(data)) is MailChangeStateAck;
		}
	}

	public async void GetRewardSingleMail(ACT.Game.Data.Mail targetMail)
	{
		if (targetMail == null || targetMail.Rewards.Count == 0)
		{
			return;
		}
		if (MailboxCacheManager.IsExpiredMail(targetMail))
		{
			GameUtility.OpenToolTip(648);
			Refresh();
			return;
		}
		MailChangeStateReq data = new MailChangeStateReq
		{
			Ids = { targetMail.Id },
			ToState = MailState.Reward
		};
		if (!(await Singleton<NetManager>.instance.RequestAsync(data) is MailChangeStateAck mailChangeStateAck))
		{
			return;
		}
		foreach (int mailId in mailChangeStateAck.Ids)
		{
			orderedDisplayMailList.Find((ACT.Game.Data.Mail m) => m.Id == mailId).State = 2;
		}
		SetGetRewardBtnOrDeleteBtn(targetMail);
		GameUtility.OpenPopReward(mailChangeStateAck.GotItems);
		await UniTask.Delay(TimeSpan.FromSeconds(1.0));
		rewardLoopScrollRect.RefillCells();
		if (mailChangeStateAck.Ids.Contains(targetMail.Id))
		{
			curSelectMailItem.ChangeMailStateToGetReward();
			Singleton<MailboxCacheManager>.instance.ChangeSingleMailState(targetMail.Id, MailState.Reward);
			if (unReadToReadIdList.Contains(targetMail.Id))
			{
				unReadToReadIdList.Remove(targetMail.Id);
			}
		}
	}

	public async void GetRewardAllMail()
	{
		if (orderedDisplayMailList.Count == 0)
		{
			return;
		}
		List<ACT.Game.Data.Mail> list = orderedDisplayMailList.FindAll((ACT.Game.Data.Mail m) => m.State < 2 && m.Rewards.Count > 0 && !MailboxCacheManager.IsExpiredMail(m));
		if (list.Count == 0)
		{
			GameUtility.OpenToolTip(647);
			if (orderedDisplayMailList.Any((ACT.Game.Data.Mail m) => MailboxCacheManager.IsExpiredMail(m)))
			{
				Refresh();
			}
			return;
		}
		List<int> values = list.ConvertAll((ACT.Game.Data.Mail m) => m.Id);
		MailChangeStateReq data = new MailChangeStateReq
		{
			Ids = { (IEnumerable<int>)values },
			ToState = MailState.Reward
		};
		if (!(await Singleton<NetManager>.instance.RequestAsync(data) is MailChangeStateAck mailChangeStateAck))
		{
			return;
		}
		foreach (int mailId in mailChangeStateAck.Ids)
		{
			orderedDisplayMailList.Find((ACT.Game.Data.Mail m) => m.Id == mailId).State = 2;
		}
		SetGetRewardBtnOrDeleteBtn(GetMailByIndex(curSelectMailIndex));
		GameUtility.OpenPopReward(mailChangeStateAck.GotItems);
		await UniTask.Delay(TimeSpan.FromSeconds(1.0));
		rewardLoopScrollRect.RefillCells();
		foreach (int id in mailChangeStateAck.Ids)
		{
			MailItem mailItem = mailLoopScrollRect.GetItem(GetIndexById(id)) as MailItem;
			if (mailItem != null)
			{
				mailItem.ChangeMailStateToGetReward();
			}
		}
		Singleton<MailboxCacheManager>.instance.ChangeMultipleMailState(mailChangeStateAck.Ids.ToList(), MailState.Reward);
		foreach (int id2 in mailChangeStateAck.Ids)
		{
			if (unReadToReadIdList.Contains(id2))
			{
				unReadToReadIdList.Remove(id2);
			}
		}
	}

	public async void DeleteSingleMail(ACT.Game.Data.Mail targetMail)
	{
		if (targetMail.Rewards.Count > 0)
		{
			if (targetMail.State != 2)
			{
				return;
			}
		}
		else if (targetMail.State != 1)
		{
			return;
		}
		if (MailboxCacheManager.IsExpiredMail(targetMail))
		{
			GameUtility.OpenToolTip(648);
			Refresh();
			return;
		}
		MailChangeStateReq data = new MailChangeStateReq
		{
			Ids = { targetMail.Id },
			ToState = MailState.Delete
		};
		if ((await Singleton<NetManager>.instance.RequestAsync(data)) is MailChangeStateAck)
		{
			Singleton<MailboxCacheManager>.instance.ChangeSingleMailState(targetMail.Id, MailState.Delete);
			curSelectMailIndex = -1;
			curSelectMailItem = null;
			Refresh();
		}
	}

	public async void DeleteAllReadMail()
	{
		if (curSelectMailItem == null)
		{
			return;
		}
		List<ACT.Game.Data.Mail> list = orderedDisplayMailList.FindAll((ACT.Game.Data.Mail m) => ((m.Rewards.Count > 0 && m.State == 2) || (m.Rewards.Count == 0 && m.State == 1)) && !MailboxCacheManager.IsExpiredMail(m) && m.Tag != 1);
		if (list.Count == 0)
		{
			GameUtility.OpenToolTip(713);
			if (orderedDisplayMailList.Any((ACT.Game.Data.Mail m) => MailboxCacheManager.IsExpiredMail(m)))
			{
				Refresh();
			}
			return;
		}
		List<int> allReadMailId = list.ConvertAll((ACT.Game.Data.Mail m) => m.Id);
		MailChangeStateReq data = new MailChangeStateReq
		{
			Ids = { (IEnumerable<int>)allReadMailId },
			ToState = MailState.Delete
		};
		if ((await Singleton<NetManager>.instance.RequestAsync(data)) is MailChangeStateAck)
		{
			Singleton<MailboxCacheManager>.instance.ChangeMultipleMailState(allReadMailId, MailState.Delete);
			curSelectMailIndex = -1;
			curSelectMailItem = null;
			Refresh();
		}
	}

	public void ChangeMailTag()
	{
		ChangeTagSingleMail(GetMailByIndex(curSelectMailIndex));
	}

	private async void ChangeTagSingleMail(ACT.Game.Data.Mail targetMail)
	{
		if (targetMail == null)
		{
			return;
		}
		if (MailboxCacheManager.IsExpiredMail(targetMail))
		{
			GameUtility.OpenToolTip(648);
			Refresh();
			return;
		}
		MailTag toMailTag = ((targetMail.Tag == 0) ? MailTag.Collect : MailTag.Notag);
		MailChangeTagReq data = new MailChangeTagReq
		{
			Id = targetMail.Id,
			ToTag = toMailTag
		};
		if ((await Singleton<NetManager>.instance.RequestAsync(data)) is MailChangeTagAck)
		{
			orderedDisplayMailList.Find((ACT.Game.Data.Mail m) => m.Id == targetMail.Id).Tag = (int)toMailTag;
			SetCollectBtnImage(toMailTag);
			curSelectMailItem.ChangeMailTag(toMailTag);
			Singleton<MailboxCacheManager>.instance.ChangeSingleMailTag(targetMail.Id, toMailTag);
		}
	}

	private void OnMailLoaded(ILoopScrollDataSource item)
	{
		if (item is MailItem mailItem)
		{
			mailItem.view = this;
		}
	}

	public ACT.Game.Data.Mail GetMailByIndex(int index)
	{
		if (orderedDisplayMailList.Count > index)
		{
			return orderedDisplayMailList[index];
		}
		return null;
	}

	public ACT.Game.Data.Mail GetMailById(int id)
	{
		return orderedDisplayMailList.Find((ACT.Game.Data.Mail m) => m.Id == id);
	}

	public int GetIndexById(int id)
	{
		return orderedDisplayMailList.IndexOf(GetMailById(id));
	}

	private void CheckNoCount()
	{
		if (orderedDisplayMailList.Count == 0)
		{
			noCountBackGround.SetActive(value: true);
			leftRoot.SetActive(value: false);
			middleRoot.SetActive(value: false);
			buttonRoot.SetActive(value: false);
		}
		else
		{
			noCountBackGround.SetActive(value: false);
			leftRoot.SetActive(value: true);
			middleRoot.SetActive(value: true);
			buttonRoot.SetActive(value: true);
		}
	}

	public void PlayAnim(string animName)
	{
		betterAnimation?.GetSequence(animName).Play();
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		SetGamePadTipsActive(mode == DeviceInputMode.Gamepad);
	}

	public void SetGamePadTipsActive(bool active)
	{
		MonoMailBoxViewInputController controller = GetController();
		if (controller == null || !active || !AllInputIcons.ContainsKey(controller.ControllerType) || MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
		{
			return;
		}
		if (ViewControlLayers.TryGetValue(controller.ControllerType, out var value))
		{
			value.ReFocus();
		}
		foreach (List<GameObject> value2 in AllInputIcons.Values)
		{
			foreach (GameObject item in value2)
			{
				item.SetActive(value: false);
			}
		}
		foreach (GameObject item2 in AllInputIcons[controller.ControllerType])
		{
			item2.SetActive(value: true);
		}
		GamePadTipsStatusChange(controller.ControllerType);
	}

	public void GamePadTipsStatusChange(MailSubController subController)
	{
		gamePadTips.ClearAllPrompts();
		_tipsActions.Clear();
		switch (subController)
		{
		case MailSubController.SelectItem:
			_tipsActions.Add(actionDic["UI/Back"]);
			if (detailScrollRect.content.rect.height > detailScrollRect.viewport.rect.height)
			{
				_tipsActions.Add(actionDic["UI/RSUpDownSelect"]);
			}
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		case MailSubController.main:
			if (curSelectMailItem == null)
			{
				_tipsActions.Add(actionDic["UI/Back"]);
				gamePadTips.RegisterInputActions(_tipsActions);
				break;
			}
			_tipsActions.Add(actionDic["UI/Back"]);
			if (detailScrollRect.content.rect.height > detailScrollRect.viewport.rect.height)
			{
				_tipsActions.Add(actionDic["UI/RSUpDownSelect"]);
			}
			gamePadTips.RegisterInputActions(_tipsActions);
			break;
		}
	}

	public void ChangeToGamePadInputState(MailSubController type, bool needFocusLayer = true)
	{
		MonoMailBoxViewInputController controller = GetController();
		if (controller == null || curSelectMailItem == null || controller.ControllerType == type)
		{
			return;
		}
		controller.ControllerType = type;
		if (ViewControlLayers.TryGetValue(type, out var value))
		{
			if (needFocusLayer)
			{
				value.ReFocus();
			}
			else
			{
				value.Focus();
			}
		}
		if (!AllInputIcons.ContainsKey(type) || MonoECS.instance.InputMode != DeviceInputMode.Gamepad)
		{
			return;
		}
		foreach (List<GameObject> value2 in AllInputIcons.Values)
		{
			foreach (GameObject item in value2)
			{
				item.SetActive(value: false);
			}
		}
		foreach (GameObject item2 in AllInputIcons[type])
		{
			item2.SetActive(value: true);
		}
		GamePadTipsStatusChange(type);
	}

	public void HandleGamePadSelectButtonInput(MailSubController type)
	{
		switch (type)
		{
		case MailSubController.main:
			GamePadCommonConfirm();
			break;
		case MailSubController.SelectItem:
			if (!(curSelectMailItem == null) && (bool)EventSystemHelper.CurrentSelected)
			{
				ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
				{
					handler.OnSubmit(data);
				});
			}
			break;
		}
	}

	public void HandleGamePadReturnButtonInput(MailSubController type)
	{
		switch (type)
		{
		case MailSubController.main:
			Close();
			break;
		case MailSubController.SelectItem:
			ChangeToGamePadInputState(MailSubController.main);
			break;
		}
	}

	public void GamePadCommonConfirm()
	{
		if (!(curSelectMailItem == null))
		{
			if (getRewardBtn.gameObject.activeSelf)
			{
				getRewardBtn.OnClick?.Invoke();
			}
			else if (deleteBtn.gameObject.activeSelf)
			{
				deleteBtn.OnClick?.Invoke();
			}
		}
	}
}
