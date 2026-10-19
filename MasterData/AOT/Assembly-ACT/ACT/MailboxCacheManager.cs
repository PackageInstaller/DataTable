using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Net;
using ACT.UI;
using Fundamental;
using Pb;
using Runtime.WaitSort;
using UnityEngine;

namespace ACT;

public class MailboxCacheManager : Singleton<MailboxCacheManager>
{
	private struct OnceOverFlowResult
	{
		public List<ACT.Game.Data.Mail> overflowMails;

		public int remainDeleteNum;
	}

	private readonly int maxPriority = 1;

	private readonly int minPriority = 4;

	private const int ItemOverFlowMailTemplateId = 202504284;

	private const int ItemOverFlowCommonId = 2338;

	private readonly int maxDisplayableMailCount = RuntimeConfigs.data.game.maxNumberOfOrdinaryMailboxes;

	public List<ACT.Game.Data.Mail> allDisplayableMailList = new List<ACT.Game.Data.Mail>();

	private List<ACT.Game.Data.Mail> orderedDisplayableMailList = new List<ACT.Game.Data.Mail>();

	private List<ACT.Game.Data.Mail> orderedCollectDisplayableMailList = new List<ACT.Game.Data.Mail>();

	private List<ACT.Game.Data.Mail> orderedNoTagDisplayableMailList = new List<ACT.Game.Data.Mail>();

	private List<ACT.Game.Data.Mail> allUnDisplayableMailList = new List<ACT.Game.Data.Mail>();

	private List<ACT.Game.Data.Mail> trashMailList = new List<ACT.Game.Data.Mail>();

	private List<int> trashIdList = new List<int>();

	public override ContextType ContextType => ContextType.NET;

	public override void Init()
	{
		trashIdList.Clear();
		RefreshMailClassification();
		AddEventListener();
	}

	private void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.PreconditionFinsh, PlayerExpChange);
		SystemBlockManager systemBlockManager = Singleton<SystemBlockManager>.instance;
		systemBlockManager.OnBlockStatusChanged = (Action<SystemStatus>)Delegate.Combine(systemBlockManager.OnBlockStatusChanged, new Action<SystemStatus>(OnBlockStatusChanged));
	}

	public override void UnInit()
	{
		RemoveEventListener();
	}

	private void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.PreconditionFinsh, PlayerExpChange);
		SystemBlockManager systemBlockManager = Singleton<SystemBlockManager>.instance;
		systemBlockManager.OnBlockStatusChanged = (Action<SystemStatus>)Delegate.Remove(systemBlockManager.OnBlockStatusChanged, new Action<SystemStatus>(OnBlockStatusChanged));
	}

	private void OnBlockStatusChanged(SystemStatus obj)
	{
		CheckUnDisplayableMailUnLock();
	}

	public List<ACT.Game.Data.Mail> GetOrderedDisplayableMail()
	{
		RefreshMailClassification();
		return orderedDisplayableMailList;
	}

	private void RefreshMailClassification()
	{
		if (G.localPlayer == null)
		{
			return;
		}
		allDisplayableMailList.Clear();
		orderedDisplayableMailList.Clear();
		orderedCollectDisplayableMailList.Clear();
		orderedNoTagDisplayableMailList.Clear();
		allUnDisplayableMailList.Clear();
		trashMailList.Clear();
		foreach (ACT.Game.Data.Mail mailInfo in G.localPlayer.MailInfos)
		{
			if (mailInfo.State == 3 || trashIdList.Contains(mailInfo.Id) || TimeManager.ServerTime.NowTimestamp > mailInfo.ExpireTs)
			{
				trashMailList.Add(mailInfo);
			}
			else if (IsTemplateMail(mailInfo))
			{
				if (Singleton<SystemUnlockManager>.instance.IsUnlock(RuntimeConfigs.data.mails[mailInfo.TemplateID].playerPara))
				{
					allDisplayableMailList.Add(mailInfo);
				}
				else
				{
					allUnDisplayableMailList.Add(mailInfo);
				}
			}
			else
			{
				allDisplayableMailList.Add(mailInfo);
			}
		}
		List<ACT.Game.Data.Mail> unorderedMailList = allDisplayableMailList.FindAll((ACT.Game.Data.Mail m) => m.Tag == 1);
		List<ACT.Game.Data.Mail> unorderedMailList2 = allDisplayableMailList.FindAll((ACT.Game.Data.Mail m) => m.Tag == 0);
		orderedCollectDisplayableMailList.AddRange(UIDisplayRuleSorting(unorderedMailList).ToList());
		orderedNoTagDisplayableMailList.AddRange(UIDisplayRuleSorting(unorderedMailList2).ToList());
		orderedDisplayableMailList.AddRange(orderedCollectDisplayableMailList.ToList());
		orderedDisplayableMailList.AddRange(orderedNoTagDisplayableMailList.ToList());
	}

	private void DeleteDisplayableWhenOverflow(List<ACT.Game.Data.Mail> deleteRange, int deleteNum)
	{
		if (deleteRange.Count < deleteNum)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"删除范围总共 {deleteRange.Count} 封邮件，无法从中删除 {deleteNum} 封邮件");
			}
			return;
		}
		List<ACT.Game.Data.Mail> list = new List<ACT.Game.Data.Mail>();
		if (deleteNum > 0)
		{
			OnceOverFlowResult overFlowMail = GetOverFlowMail(deleteRange, deleteNum, minPriority, maxPriority + 1);
			list.AddRange(overFlowMail.overflowMails.ToList());
			deleteNum = overFlowMail.remainDeleteNum;
		}
		if (deleteNum > 0)
		{
			OnceOverFlowResult overFlowMail2 = GetOverFlowMail(deleteRange, deleteNum, maxPriority, maxPriority);
			list.AddRange(overFlowMail2.overflowMails.ToList());
			deleteNum = overFlowMail2.remainDeleteNum;
		}
		if (deleteNum != 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("能删的都删完了，deleteNum 还不是 0，请检查删除逻辑");
			}
			return;
		}
		foreach (ACT.Game.Data.Mail item in list)
		{
			trashIdList.Add(item.Id);
		}
	}

	private OnceOverFlowResult GetOverFlowMail(List<ACT.Game.Data.Mail> searchRange, int remainDeleteNum, int searchMinPriority, int searchMaxPriority = -1)
	{
		List<ACT.Game.Data.Mail> overflowMails = new List<ACT.Game.Data.Mail>();
		if (searchMinPriority == searchMaxPriority)
		{
			GetTargetLevelOverflowMails(searchMinPriority);
		}
		else
		{
			for (int num = searchMinPriority; num >= searchMaxPriority; num--)
			{
				GetTargetLevelOverflowMails(num);
				if (remainDeleteNum == 0)
				{
					break;
				}
			}
		}
		return new OnceOverFlowResult
		{
			overflowMails = overflowMails,
			remainDeleteNum = remainDeleteNum
		};
		void GetTargetLevelOverflowMails(int level)
		{
			List<ACT.Game.Data.Mail> list = searchRange.FindAll((ACT.Game.Data.Mail m) => m.Priority == level);
			int count = list.Count;
			if (count < remainDeleteNum)
			{
				overflowMails.AddRange(list);
				remainDeleteNum -= count;
			}
			else
			{
				for (int num2 = 1; num2 <= remainDeleteNum; num2++)
				{
					List<ACT.Game.Data.Mail> list2 = overflowMails;
					int num3 = num2;
					list2.Add(list[list.Count - num3]);
				}
				remainDeleteNum = 0;
			}
		}
	}

	public void ChangeSingleMailState(int mailId, MailState toMailState)
	{
		G.localPlayer.MailInfos.Find((ACT.Game.Data.Mail m) => m.Id == mailId).State = (int)toMailState;
		if (toMailState == MailState.Delete)
		{
			trashIdList.Add(mailId);
		}
		if (toMailState >= MailState.Read)
		{
			string nodeFullPath = string.Format(RedDotPathDefine.MailUnread, mailId);
			Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, active: false);
			Singleton<RedDotManager>.instance.RemoveNode(nodeFullPath);
		}
	}

	public void ChangeMultipleMailState(List<int> mailIdList, MailState toMailState)
	{
		foreach (int mailId in mailIdList)
		{
			G.localPlayer.MailInfos.Find((ACT.Game.Data.Mail m) => m.Id == mailId).State = (int)toMailState;
			if (toMailState == MailState.Delete)
			{
				trashIdList.Add(mailId);
			}
			if (toMailState >= MailState.Read)
			{
				string nodeFullPath = string.Format(RedDotPathDefine.MailUnread, mailId);
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, active: false);
				Singleton<RedDotManager>.instance.RemoveNode(nodeFullPath);
			}
		}
	}

	public void ChangeSingleMailTag(int mailId, MailTag toMailTag)
	{
		G.localPlayer.MailInfos.Find((ACT.Game.Data.Mail m) => m.Id == mailId).Tag = (int)toMailTag;
	}

	public void GetMailAfterCreateInstance(MailNtf mailNtf)
	{
		List<ACT.Game.Data.Mail> list = ListPool<ACT.Game.Data.Mail>.Get();
		foreach (KeyValuePair<int, ACT.Game.Data.Mail> mail in mailNtf.Mails)
		{
			list.Add(mail.Value);
			string nodeFullPath = string.Format(RedDotPathDefine.MailUnread, mail.Value.Id);
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath))
			{
				Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath, active: false, 7004);
			}
		}
		AddNewDisplayableMail(list);
		ListPool<ACT.Game.Data.Mail>.Release(list);
	}

	private void AddNewDisplayableMail(List<ACT.Game.Data.Mail> newDisplayableMailList)
	{
		int num = newDisplayableMailList.Count;
		foreach (ACT.Game.Data.Mail mail in newDisplayableMailList)
		{
			if (allDisplayableMailList.Find((ACT.Game.Data.Mail g) => g.Id == mail.Id) != null)
			{
				num--;
			}
		}
		num = ((num >= 0) ? num : 0);
		if (allDisplayableMailList.Count + num > maxDisplayableMailCount)
		{
			int deleteNum = allDisplayableMailList.Count + num - maxDisplayableMailCount;
			HashSet<int> hashSet = new HashSet<int>();
			List<ACT.Game.Data.Mail> list = new List<ACT.Game.Data.Mail>();
			foreach (ACT.Game.Data.Mail allDisplayableMail in allDisplayableMailList)
			{
				if (hashSet.Add(allDisplayableMail.Id))
				{
					list.Add(allDisplayableMail);
				}
			}
			foreach (ACT.Game.Data.Mail newDisplayableMail in newDisplayableMailList)
			{
				if (hashSet.Add(newDisplayableMail.Id))
				{
					list.Add(newDisplayableMail);
				}
			}
			list = OverflowDeleteRuleSorting(list);
			DeleteDisplayableWhenOverflow(list, deleteNum);
		}
		RefreshMailClassification();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_RefreshMailboxPanel, Singleton<EventManager>.instance.GetEvt<UIMailboxRefreshEvt>());
	}

	public void PlayerExpChange(BaseEventContent obj)
	{
		_ = (ExpChangesEvt)obj;
		CheckUnDisplayableMailUnLock();
	}

	private bool IsUnlock(SystemType systemId, List<ItemKv> itemKvs, bool withUI = false)
	{
		if (Singleton<SystemBlockManager>.instance.IsBlocked(systemId))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("GM block mail system");
			}
			return false;
		}
		return Singleton<SystemUnlockManager>.instance.IsUnlock(itemKvs, withUI);
	}

	private async void CheckUnDisplayableMailUnLock()
	{
		List<ACT.Game.Data.Mail> unlockMailList = new List<ACT.Game.Data.Mail>();
		foreach (int lockMailTemplateId in G.localPlayer.LockMailTemplateIDs)
		{
			ACT.Config.Mail data = CoreUtils.GetData(lockMailTemplateId, RuntimeConfigs.data.mails);
			if (data.timeInterval.Length != 0 && (TimeManager.ServerTime.NowTimestamp < data.timeInterval[0] || TimeManager.ServerTime.NowTimestamp > data.timeInterval[1]))
			{
				continue;
			}
			if (!RuntimeConfigs.data.mails.ContainsKey(lockMailTemplateId))
			{
				return;
			}
			if (IsUnlock(SystemType.Mailbox, RuntimeConfigs.data.mails[lockMailTemplateId].playerPara))
			{
				MailUnlockReq data2 = new MailUnlockReq
				{
					Id = lockMailTemplateId
				};
				if (await Singleton<NetManager>.instance.RequestAsync(data2) is MailUnlockAck mailUnlockAck)
				{
					G.localPlayer.LockMailTemplateIDs.Remove(lockMailTemplateId);
					G.localPlayer.MailInfos.Add(mailUnlockAck.Mail);
					unlockMailList.Add(mailUnlockAck.Mail);
				}
			}
		}
		if (unlockMailList.Count > 0)
		{
			AddNewDisplayableMail(unlockMailList);
		}
	}

	public static bool IsTemplateMail(ACT.Game.Data.Mail mail)
	{
		if (mail.Title == string.Empty && mail.Content == string.Empty)
		{
			if (RuntimeConfigs.data.mails.Any((KeyValuePair<int, ACT.Config.Mail> m) => m.Value.id == mail.TemplateID))
			{
				return true;
			}
			return false;
		}
		return false;
	}

	private static List<ACT.Game.Data.Mail> UIDisplayRuleSorting(List<ACT.Game.Data.Mail> unorderedMailList)
	{
		List<ACT.Game.Data.Mail> list = new List<ACT.Game.Data.Mail>();
		List<ACT.Game.Data.Mail> list2 = new List<ACT.Game.Data.Mail>();
		list2.AddRange(unorderedMailList.FindAll((ACT.Game.Data.Mail m) => m.Rewards.Count > 0 && m.State == 0));
		list2.Sort((ACT.Game.Data.Mail mail, ACT.Game.Data.Mail mail1) => -1 * mail.CreateTs.CompareTo(mail1.CreateTs));
		List<ACT.Game.Data.Mail> list3 = new List<ACT.Game.Data.Mail>();
		list3.AddRange(unorderedMailList.FindAll((ACT.Game.Data.Mail m) => m.Rewards.Count == 0 && m.State == 0));
		list3.Sort((ACT.Game.Data.Mail mail, ACT.Game.Data.Mail mail1) => -1 * mail.CreateTs.CompareTo(mail1.CreateTs));
		List<ACT.Game.Data.Mail> list4 = new List<ACT.Game.Data.Mail>();
		list4.AddRange(unorderedMailList.FindAll((ACT.Game.Data.Mail m) => m.Rewards.Count > 0 && m.State == 1));
		list4.Sort((ACT.Game.Data.Mail mail, ACT.Game.Data.Mail mail1) => -1 * mail.CreateTs.CompareTo(mail1.CreateTs));
		List<ACT.Game.Data.Mail> list5 = new List<ACT.Game.Data.Mail>();
		list5.AddRange(unorderedMailList.FindAll((ACT.Game.Data.Mail m) => m.Rewards.Count > 0 && m.State == 2));
		list5.Sort((ACT.Game.Data.Mail mail, ACT.Game.Data.Mail mail1) => -1 * mail.CreateTs.CompareTo(mail1.CreateTs));
		List<ACT.Game.Data.Mail> list6 = new List<ACT.Game.Data.Mail>();
		list6.AddRange(unorderedMailList.FindAll((ACT.Game.Data.Mail m) => m.Rewards.Count == 0 && m.State == 1));
		list6.Sort((ACT.Game.Data.Mail mail, ACT.Game.Data.Mail mail1) => -1 * mail.CreateTs.CompareTo(mail1.CreateTs));
		list.AddRange(list2);
		list.AddRange(list3);
		list.AddRange(list4);
		list.AddRange(list5);
		list.AddRange(list6);
		return list;
	}

	private static List<ACT.Game.Data.Mail> OverflowDeleteRuleSorting(List<ACT.Game.Data.Mail> unorderedMailList)
	{
		new List<ACT.Game.Data.Mail>();
		return unorderedMailList.OrderBy((ACT.Game.Data.Mail mail) => mail, Comparer<ACT.Game.Data.Mail>.Create(OverflowDeleteComparison)).ToList();
		static int OverflowDeleteComparison(ACT.Game.Data.Mail mail, ACT.Game.Data.Mail mail1)
		{
			if (mail.Tag == 1 && mail1.Tag == 0)
			{
				return -1;
			}
			if (mail.Tag == 0 && mail1.Tag == 1)
			{
				return 1;
			}
			if (mail.Rewards.Count > 0 && mail1.Rewards.Count == 0)
			{
				return -1;
			}
			if (mail.Rewards.Count == 0 && mail1.Rewards.Count > 0)
			{
				return 1;
			}
			if (mail.Priority != mail1.Priority)
			{
				if (mail.Priority >= mail1.Priority)
				{
					return 1;
				}
				return -1;
			}
			if (mail.Id == mail1.Id)
			{
				return 0;
			}
			if (mail.Id >= mail1.Id)
			{
				return -1;
			}
			return 1;
		}
	}

	private static List<ACT.Game.Data.Mail> GetDisplayableMail(List<ACT.Game.Data.Mail> sourceMailList)
	{
		List<ACT.Game.Data.Mail> list = new List<ACT.Game.Data.Mail>();
		foreach (ACT.Game.Data.Mail sourceMail in sourceMailList)
		{
			if (IsTemplateMail(sourceMail))
			{
				if (Singleton<SystemUnlockManager>.instance.IsUnlock(RuntimeConfigs.data.mails[sourceMail.TemplateID].playerPara))
				{
					list.Add(sourceMail);
				}
			}
			else
			{
				list.Add(sourceMail);
			}
		}
		return list;
	}

	public static bool IsExpiredMail(ACT.Game.Data.Mail mail)
	{
		return TimeManager.ServerTime.NowTimestamp > mail.ExpireTs;
	}
}
