#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using Sirenix.Utilities;

namespace Ase;

public class MyGuildData : GuildData
{
	protected int dailyMaxActivePoint;

	protected List<int> buff;

	protected int applyCount;

	protected int maxApplyCount;

	protected Dictionary<int, GuildTaskData> dailyTasks = new Dictionary<int, GuildTaskData>();

	protected string dailyActiveRewardState = "";

	protected int viceMasterCount;

	protected int excellentMemberCount;

	protected int normalMemberCount;

	protected List<GuildMemberData> members = new List<GuildMemberData>();

	protected List<PlayerDataBase> applyDatas = new List<PlayerDataBase>();

	protected List<PlayerDataBase> recommendDatas = new List<PlayerDataBase>();

	private List<GuildEventMsgData> eventMsgDatas = new List<GuildEventMsgData>();

	protected GuildDefinition.GuildPositions position;

	protected int money;

	protected int myActivePoint;

	protected int myWeeklyActivePoint;

	protected int myDailyActivePoint;

	private Timer recruitTimer;

	public float LeftRecruitTime;

	public GuildDefinition.GuildPositions Position
	{
		get
		{
			return position;
		}
		private set
		{
			Set(ref position, value, "Position");
		}
	}

	public int Money
	{
		get
		{
			return money;
		}
		set
		{
			Set(ref money, value, "Money");
			Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetMoneyData()?.SetMoney(MoneyEnum.GuildMoney, value);
		}
	}

	public int MyActivePoint
	{
		get
		{
			return myActivePoint;
		}
		set
		{
			Set(ref myActivePoint, value, "MyActivePoint");
		}
	}

	public int MyWeeklyActivePoint
	{
		get
		{
			return myWeeklyActivePoint;
		}
		set
		{
			Set(ref myWeeklyActivePoint, value, "MyWeeklyActivePoint");
		}
	}

	public int MyDailyActivePoint
	{
		get
		{
			return myDailyActivePoint;
		}
		private set
		{
			Set(ref myDailyActivePoint, value, "MyDailyActivePoint");
		}
	}

	public int ApplyCount
	{
		get
		{
			return applyCount;
		}
		set
		{
			Set(ref applyCount, value, "ApplyCount");
		}
	}

	public int MaxApplyCount
	{
		get
		{
			return maxApplyCount;
		}
		set
		{
			Set(ref maxApplyCount, value, "MaxApplyCount");
		}
	}

	public List<int> Buff
	{
		get
		{
			return buff;
		}
		set
		{
			Set(ref buff, value, "Buff");
		}
	}

	public Dictionary<int, GuildTaskData> DailyTasks => dailyTasks;

	public string DailyActiveRewardState
	{
		get
		{
			return dailyActiveRewardState;
		}
		protected set
		{
			Set(ref dailyActiveRewardState, value, "DailyActiveRewardState");
		}
	}

	public int ViceMasterCount
	{
		get
		{
			return viceMasterCount;
		}
		protected set
		{
			Set(ref viceMasterCount, value, "ViceMasterCount");
		}
	}

	public int ExcellentMemberCount
	{
		get
		{
			return excellentMemberCount;
		}
		protected set
		{
			Set(ref excellentMemberCount, value, "ExcellentMemberCount");
		}
	}

	public int NormalMemberCount
	{
		get
		{
			return normalMemberCount;
		}
		protected set
		{
			Set(ref normalMemberCount, value, "NormalMemberCount");
		}
	}

	public List<GuildMemberData> Members
	{
		get
		{
			return members;
		}
		protected set
		{
			Set(ref members, value, "Members");
		}
	}

	public List<PlayerDataBase> ApplyDatas
	{
		get
		{
			return applyDatas;
		}
		protected set
		{
			Set(ref applyDatas, value, "ApplyDatas");
		}
	}

	public List<PlayerDataBase> RecommendDatas
	{
		get
		{
			return recommendDatas;
		}
		protected set
		{
			Set(ref recommendDatas, value, "RecommendDatas");
		}
	}

	public List<GuildEventMsgData> EventMsgDatas => eventMsgDatas;

	public MyGuildData()
	{
		MaxApplyCount = 30;
	}

	public new static MyGuildData Create(PbUnionBaseInfo baseInfo)
	{
		MyGuildData myGuildData = new MyGuildData();
		myGuildData.SetBaseInfo(baseInfo);
		myGuildData.LoadEventMsgDatas();
		return myGuildData;
	}

	public new static MyGuildData Create(PbUnionInfo pbUnionInfo)
	{
		MyGuildData myGuildData = new MyGuildData();
		myGuildData.SetInfo(pbUnionInfo);
		myGuildData.LoadEventMsgDatas();
		return myGuildData;
	}

	public void SetUserInfo(PbUserUnionInfo pbUserUnionInfo)
	{
		MyDailyActivePoint = pbUserUnionInfo.ActivePoint;
		Money = pbUserUnionInfo.Money;
		Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.PublishMessage(GuildMessageEnum.GuildAssetChange, this);
	}

	public override void SetUpdateInfo(PbUnionUpdateInfo updateInfo)
	{
		base.SetUpdateInfo(updateInfo);
		Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.PublishMessage(GuildMessageEnum.GuildAssetChange, this);
	}

	public override void AddNewActivePoint(int newActivePoint)
	{
		base.AddNewActivePoint(newActivePoint);
		Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.PublishMessage(GuildMessageEnum.GuildAssetChange, this);
	}

	public void SetFunds(int count)
	{
		base.Funds = count;
		Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.PublishMessage(GuildMessageEnum.GuildAssetChange, this);
	}

	public override void SetLevel(int level)
	{
		base.SetLevel(level);
		Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.PublishMessage(GuildMessageEnum.GuildLevelChange, level);
	}

	public void SetName(string newName)
	{
		base.Name = newName;
	}

	public void SetDescription(string content)
	{
		base.Description = content;
	}

	public void SetFlag(GuildDefinition.Flag newFlag)
	{
		base.Flag = newFlag;
		base.FlagIcon = $"GuildFlag_{(int)base.Flag}";
	}

	public void SetAuditInfo(GuildDefinition.AuditType newAuditType, int newLevelThreshold)
	{
		base.AuditType = newAuditType;
		base.ApplyLevelThreshold = newLevelThreshold;
	}

	public void SetMyPosition(GuildDefinition.GuildPositions newPosition)
	{
		if (Position != newPosition)
		{
			GuildDefinition.GuildPositions guildPositions = Position;
			Position = newPosition;
			Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.PublishMessage(GuildMessageEnum.GuildPermissionChange, guildPositions);
		}
	}

	public void AddMyNewActivePoint(int myNewActivePoint)
	{
		MyDailyActivePoint += myNewActivePoint;
		MyWeeklyActivePoint += myNewActivePoint;
		MyActivePoint += myNewActivePoint;
		SetMemberAssetByMyData();
	}

	private void RefreshMyDataByMembers()
	{
		long selfUid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetPlayerData()
			.Uid;
		if (Members != null)
		{
			GuildMemberData guildMemberData = Members.Find((GuildMemberData p) => p.Uid == selfUid);
			if (guildMemberData == null)
			{
				MyActivePoint = 0;
				MyWeeklyActivePoint = 0;
				Log.Error("MyGuildData中没有自己的成员数据");
			}
			else
			{
				SetMyPosition(guildMemberData.Position);
				MyActivePoint = guildMemberData.TotalActivePoint;
				MyWeeklyActivePoint = guildMemberData.WeeklyActivePoint;
			}
		}
	}

	private void SetMemberAssetByMyData()
	{
		long selfUid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetPlayerData()
			.Uid;
		if (Members != null)
		{
			GuildMemberData guildMemberData = Members.Find((GuildMemberData p) => p.Uid == selfUid);
			if (guildMemberData != null)
			{
				guildMemberData.TotalActivePoint = MyActivePoint;
				guildMemberData.WeeklyActivePoint = MyWeeklyActivePoint;
			}
		}
	}

	public void SetMembers(List<GuildMemberData> list)
	{
		if (list != null)
		{
			Members = list;
			RefreshMaster();
			RefreshMyDataByMembers();
			RefreshMemberCount();
			SortMembersData();
		}
	}

	public void SetMembers(List<PbUnionMemberInfo> pbMembers)
	{
		Members.Clear();
		if (pbMembers == null)
		{
			return;
		}
		foreach (PbUnionMemberInfo pbMember in pbMembers)
		{
			Members.Add(GuildMemberData.Create(pbMember));
		}
		RefreshMaster();
		RefreshMyDataByMembers();
		RefreshMemberCount();
		SortMembersData();
	}

	public void AddMember(GuildMemberData newMember)
	{
		Members.RemoveAll((GuildMemberData p) => p.Uid.Equals(newMember.Uid));
		Members.Add(newMember);
		RefreshMyDataByMembers();
		RefreshMemberCount();
		SortMembersData();
	}

	public void RemoveMember(long userId)
	{
		Members.RemoveAll((GuildMemberData p) => p.Uid == userId);
		RefreshMaster();
		SortMembersData();
	}

	public bool ModifyMemberPosition(long memberUid, int newPosition)
	{
		GuildMemberData guildMemberData = Members.Find((GuildMemberData p) => p.Uid.Equals(memberUid));
		if (guildMemberData == null)
		{
			return false;
		}
		if (guildMemberData.ModifyPosition(newPosition))
		{
			long num = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetPlayerData()
				.Uid;
			if (memberUid == num)
			{
				SetMyPosition(guildMemberData.Position);
			}
			SortMembersData();
			return true;
		}
		return false;
	}

	public bool KickMember(long memberUid)
	{
		int num = Members.RemoveAll((GuildMemberData p) => p.Uid.Equals(memberUid));
		if (num > 0)
		{
			RefreshMemberCount();
			SortMembersData();
		}
		return num > 0;
	}

	public void TransMaster(long newMasterUid, long oldMasterUid)
	{
		Members.Find((GuildMemberData p) => p.Uid.Equals(newMasterUid))?.ModifyPosition(GuildDefinition.GuildPositions.Master);
		Members.Find((GuildMemberData p) => p.Uid.Equals(oldMasterUid))?.ModifyPosition(GuildDefinition.GuildPositions.NormalMember);
		RefreshMaster();
		RefreshMemberCount();
		SortMembersData();
	}

	private void RefreshMaster()
	{
		if (Members == null)
		{
			base.Master = null;
			return;
		}
		base.Master = Members.Find((GuildMemberData p) => p.Position == GuildDefinition.GuildPositions.Master);
	}

	private void RefreshMemberCount()
	{
		base.MemberCount = Members.Count;
		ViceMasterCount = Members.FindAll((GuildMemberData p) => p.Position == GuildDefinition.GuildPositions.ViceMaster).Count;
		ExcellentMemberCount = Members.FindAll((GuildMemberData p) => p.Position == GuildDefinition.GuildPositions.ExcellentMember).Count;
		NormalMemberCount = Members.FindAll((GuildMemberData p) => p.Position == GuildDefinition.GuildPositions.NormalMember).Count;
	}

	private void SortMembersData()
	{
		long selfUid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetPlayerData()
			.Uid;
		Members.Sort(delegate(GuildMemberData a, GuildMemberData b)
		{
			int num = ((!a.Uid.Equals(selfUid)) ? 1 : (-1));
			int value = ((!b.Uid.Equals(selfUid)) ? 1 : (-1));
			int num2 = ((a.State == 4) ? 1 : (-1));
			int value2 = ((b.State == 4) ? 1 : (-1));
			return num.CompareTo(value) * 1000 + num2.CompareTo(value2) * 100 + a.Position.CompareTo(b.Position) * 10 + a.EnterTime.CompareTo(b.EnterTime);
		});
	}

	public void SetApplications(List<PbUnionApplicationInfo> pbInfos)
	{
		ApplyDatas.Clear();
		if (pbInfos == null)
		{
			return;
		}
		foreach (PbUnionApplicationInfo pbInfo in pbInfos)
		{
			ApplyDatas.Add(PlayerDataBase.Create(pbInfo.UserId, pbInfo.Name, pbInfo.Level, pbInfo.Icon, pbInfo.IconFrame));
		}
	}

	public bool RemoveApplication(long userId)
	{
		return ApplyDatas.RemoveAll((PlayerDataBase p) => p.Uid == userId) > 0;
	}

	public void RemoveApplications(List<long> userIds)
	{
		if (userIds == null)
		{
			return;
		}
		foreach (long userId in userIds)
		{
			RemoveApplication(userId);
		}
	}

	public void RemoveAllApplication()
	{
		ApplyDatas.Clear();
	}

	public void SetRecommendPlayers(List<PlayerDataBase> list)
	{
		RecommendDatas = list;
	}

	public bool InvitePlayer(long playerUid)
	{
		return recommendDatas.RemoveAll((PlayerDataBase p) => p.Uid == playerUid) > 0;
	}

	public bool InviteAllPlayer()
	{
		recommendDatas.Clear();
		return true;
	}

	public void InitDailyTasks(List<int> dailyTaskIds, List<PbState> pbStates = null, int activeRewardState = 0)
	{
		DailyActiveRewardState = GuildDefinition.GetStateString(activeRewardState);
		if (dailyTaskIds == null || dailyTaskIds.Count <= 0)
		{
			return;
		}
		int i;
		for (i = 0; i < dailyTaskIds.Count; i++)
		{
			DRGuildActiveTask dataRow = GameEntry.DataTable.GetDataRow<DRGuildActiveTask>(dailyTaskIds[i]);
			if (dataRow != null)
			{
				PbState pbState = pbStates?.FindLast((PbState p) => p.Id == dailyTaskIds[i]) ?? null;
				GuildTaskData value = new GuildTaskData(dataRow, pbState);
				dailyTasks.Add(dailyTaskIds[i], value);
			}
		}
	}

	public bool SetDailyTaskProcess(int taskId, int value)
	{
		if (dailyTasks.TryGetValue(taskId, out var value2))
		{
			return value2.UpdateProgress(value);
		}
		return false;
	}

	public void SetDailyTaskState(int taskId, GuildTaskState state)
	{
		if (dailyTasks.TryGetValue(taskId, out var value))
		{
			value.State = state;
		}
	}

	public bool UpdateDailyTaskProgress()
	{
		bool flag = false;
		if (dailyTasks != null)
		{
			foreach (GuildTaskData value in dailyTasks.Values)
			{
				flag = (value?.UpdateProgress() ?? false) | flag;
			}
		}
		return flag;
	}

	public void SetDailyActiveRewardState(int rewardIndex, bool got)
	{
		if (DailyActiveRewardState.Length < rewardIndex)
		{
			DailyActiveRewardState = DailyActiveRewardState.PadRight(rewardIndex, '0');
		}
		DailyActiveRewardState = DailyActiveRewardState.Remove(rewardIndex - 1, 1);
		DailyActiveRewardState = DailyActiveRewardState.Insert(rewardIndex - 1, got ? "1" : "0");
		Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.PublishMessage(GuildMessageEnum.ActiveRewardStateChange, DailyActiveRewardState);
	}

	public void SetAllDailyActiveRewardState(bool got)
	{
		DRGuildActiveReward[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRGuildActiveReward>();
		if (allDataRow == null)
		{
			return;
		}
		DRGuildActiveReward[] array = allDataRow;
		for (int i = 0; i < array.Length; i++)
		{
			int id = array[i].Id;
			if (DailyActiveRewardState.Length < id)
			{
				DailyActiveRewardState = DailyActiveRewardState.PadRight(id, '0');
			}
			DailyActiveRewardState = DailyActiveRewardState.Remove(id - 1, 1);
			DailyActiveRewardState = DailyActiveRewardState.Insert(id - 1, got ? "1" : "0");
		}
		Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.PublishMessage(GuildMessageEnum.ActiveRewardStateChange, DailyActiveRewardState);
	}

	private void LoadEventMsgDatas()
	{
		GuildEventMsgJsonData guildEventMsgJsonData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.LoadEventMsgDatas(base.Uid);
		if (guildEventMsgJsonData?.datas != null)
		{
			SetEventMsgDatas(guildEventMsgJsonData.datas);
		}
	}

	public void SetEventMsgDatas(List<GuildEventMsgData> datas)
	{
		eventMsgDatas = datas;
		eventMsgDatas.Sort((GuildEventMsgData a, GuildEventMsgData b) => a.Time.CompareTo(b.Time));
	}

	public void AddEventMsgDatas(GuildEventMsgData newEventMsgData)
	{
		eventMsgDatas.Add(newEventMsgData);
		eventMsgDatas.Sort((GuildEventMsgData a, GuildEventMsgData b) => a.Time.CompareTo(b.Time));
	}

	public async Task StartRecruitTimer()
	{
		CancelTimer();
		try
		{
			LeftRecruitTime = 10f;
			recruitTimer = Timer.Register(1f, OnComplete, null, isLooped: true, useRealTime: true);
		}
		catch (Exception ex)
		{
			Log.Error("MyGuildData：开启计时器失败:" + ex?.ToString() + ex.StackTrace);
		}
	}

	private void OnComplete()
	{
		LeftRecruitTime--;
		if (LeftRecruitTime <= 0f)
		{
			LeftRecruitTime = 0f;
			CancelTimer();
		}
	}

	private void CancelTimer()
	{
		if (recruitTimer != null)
		{
			recruitTimer.Cancel();
			recruitTimer = null;
		}
	}

	protected override void Dispose(bool disposing)
	{
		CancelTimer();
		base.Dispose(disposing);
	}

	public int GetDailyMaxActivePoint()
	{
		if (dailyMaxActivePoint <= 0)
		{
			DRGuildActiveReward[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRGuildActiveReward>();
			if (allDataRow != null && allDataRow.Length != 0)
			{
				allDataRow.ForEach(delegate(DRGuildActiveReward p)
				{
					dailyMaxActivePoint = Math.Max(dailyMaxActivePoint, p.ActiveLev);
				});
			}
		}
		return dailyMaxActivePoint;
	}
}
