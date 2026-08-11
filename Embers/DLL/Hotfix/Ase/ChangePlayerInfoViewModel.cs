using System;
using System.Collections.Generic;
using System.Globalization;
using GameFramework.Runtime;

namespace Ase;

public class ChangePlayerInfoViewModel : OptionBase
{
	private SimpleCommand optCommad;

	private InteractionRequest updateItemListRequest;

	private InteractionRequest updateDescRequest;

	private string desc;

	private string titleTimeLimitDesc;

	private int titleTimeLimitType;

	private int curTitleId;

	private string curIcon;

	private int curIconId;

	private int curIconFrame;

	private int curUsedTitleId;

	private int curUsedIconId;

	private int curUsedIconFrame;

	private RoleDecorateEnum state;

	private bool state1Lock;

	private bool state2Lock;

	private Dictionary<RoleDecorateEnum, List<RoleDecorateData>> itemList;

	private Dictionary<RoleDecorateEnum, List<RoleDecorateData>> allItems;

	private List<TitleItemViewModel> titleList;

	private List<AvatarItemViewModel> avatarList;

	private List<AvatarItemViewModel> avatarFrameList;

	private TitleItemViewModel curExpireTitleItem;

	private RoleDecorateData curSelDecorateData;

	private AvatarItemViewModel curAvatarItem;

	private AvatarItemViewModel curAvatarFrameItem;

	private int refreshHour = 4;

	public RoleDecorateEnum State
	{
		get
		{
			return state;
		}
		private set
		{
			Set(ref state, value, "State");
		}
	}

	public int CurTitleId
	{
		get
		{
			return curTitleId;
		}
		private set
		{
			Set(ref curTitleId, value, "CurTitleId");
		}
	}

	public int CurIconId
	{
		get
		{
			return curIconId;
		}
		private set
		{
			Set(ref curIconId, value, "CurIconId");
		}
	}

	public string CurIcon
	{
		get
		{
			return curIcon;
		}
		private set
		{
			Set(ref curIcon, value, "CurIcon");
		}
	}

	public int CurIconFrame
	{
		get
		{
			return curIconFrame;
		}
		private set
		{
			Set(ref curIconFrame, value, "CurIconFrame");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		private set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public string TitleTimeLimitDesc
	{
		get
		{
			return titleTimeLimitDesc;
		}
		private set
		{
			Set(ref titleTimeLimitDesc, value, "TitleTimeLimitDesc");
		}
	}

	public int TitleTimeLimitType
	{
		get
		{
			return titleTimeLimitType;
		}
		private set
		{
			Set(ref titleTimeLimitType, value, "TitleTimeLimitType");
		}
	}

	public List<TitleItemViewModel> TitleList => titleList;

	public List<AvatarItemViewModel> AvatarList => avatarList;

	public List<AvatarItemViewModel> AvatarFrameList => avatarFrameList;

	public InteractionRequest UpdateItemListRequest => updateItemListRequest;

	public InteractionRequest UpdateDescRequest => updateDescRequest;

	public ICommand OptCommad => optCommad;

	public override void ItemOnClick(object obj)
	{
		TitleTimeLimitDesc = "";
		TitleTimeLimitType = 1;
		if (obj is TitleItemViewModel title)
		{
			SelectTitle(title);
		}
		else if (obj is AvatarItemViewModel avatar)
		{
			SelectAvatar(avatar);
		}
	}

	private void SelectAvatar(AvatarItemViewModel avatar)
	{
		if (state == RoleDecorateEnum.HeadIcon)
		{
			for (int i = 0; i < avatarList.Count; i++)
			{
				if (avatarList[i].IconId != curIconId || (avatarList[i].IconId == curIconId && avatar != avatarList[i]))
				{
					avatarList[i].SetSelect(isSelect: false);
				}
			}
			CheckAddExpireTimer2(avatar);
			CurIconId = avatar.IconId;
			CurIcon = PlayerDataBase.GetIcon(avatar.IconId);
			avatar.SetSelect(isSelect: true);
			state1Lock = avatar.State == 1;
		}
		else if (state == RoleDecorateEnum.HeadFrame)
		{
			for (int j = 0; j < avatarFrameList.Count; j++)
			{
				if (avatarFrameList[j].IconFrameId != curIconFrame || (avatarFrameList[j].IconFrameId == curIconFrame && avatar != avatarFrameList[j]))
				{
					avatarFrameList[j].SetSelect(isSelect: false);
				}
			}
			CheckAddExpireTimer3(avatar);
			CurIconFrame = avatar.IconFrameId;
			avatar.SetSelect(isSelect: true);
			state2Lock = avatar.State == 1;
		}
		optCommad.Enabled = !state1Lock && !state2Lock;
		updateDescRequest.Raise();
		Desc = avatar.Desc;
	}

	private void SelectTitle(TitleItemViewModel title)
	{
		for (int i = 0; i < titleList.Count; i++)
		{
			if (titleList[i].TitleId != curTitleId || (titleList[i].TitleId == curTitleId && title != titleList[i]))
			{
				titleList[i].SetSelect(isSelect: false);
			}
		}
		CheckAddExpireTimer(title);
		CurTitleId = title.TitleId;
		title.SetSelect(isSelect: true);
		Desc = title.Desc;
		optCommad.Enabled = !title.IsLock;
		updateDescRequest.Raise();
	}

	public ChangePlayerInfoViewModel()
	{
	}

	public ChangePlayerInfoViewModel(OptionBase parent, int curTitleId, int curIconId, int curIconFrame, Dictionary<RoleDecorateEnum, List<RoleDecorateData>> itemList)
	{
		base.parent = parent;
		optCommad = new SimpleCommand(OnOptClick);
		updateItemListRequest = new InteractionRequest();
		updateDescRequest = new InteractionRequest();
		this.itemList = itemList;
		this.curTitleId = curTitleId;
		this.curIconId = curIconId;
		curIcon = PlayerDataBase.GetIcon(curIconId);
		this.curIconFrame = curIconFrame;
		curUsedTitleId = curTitleId;
		curUsedIconId = curIconId;
		curUsedIconFrame = curIconFrame;
		allItems = new Dictionary<RoleDecorateEnum, List<RoleDecorateData>>();
		DRTitle[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRTitle>();
		allItems[RoleDecorateEnum.Title] = new List<RoleDecorateData>();
		for (int i = 0; i < allDataRow.Length; i++)
		{
			AddAllItemFromItemList(RoleDecorateEnum.Title, allDataRow[i].Id, 0L);
		}
		DRHeadAvatar[] dataRows = GameEntry.DataTable.GetDataRows((DRHeadAvatar p) => p.IsOpen);
		allItems[RoleDecorateEnum.HeadIcon] = new List<RoleDecorateData>();
		for (int num = 0; num < dataRows.Length; num++)
		{
			AddAllItemFromItemList(RoleDecorateEnum.HeadIcon, dataRows[num].Id, 0L);
		}
		DRHeadDecorate[] allDataRow2 = GameEntry.DataTable.GetAllDataRow<DRHeadDecorate>();
		allItems[RoleDecorateEnum.HeadFrame] = new List<RoleDecorateData>();
		for (int num2 = 0; num2 < allDataRow2.Length; num2++)
		{
			AddAllItemFromItemList(RoleDecorateEnum.HeadFrame, allDataRow2[num2].Id, 0L);
		}
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>().AddNormalSecondUpdateAction(TitleExpireTimeChecker);
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>().AddNormalSecondUpdateAction(AvatarExpireTimeChecker);
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>().AddNormalSecondUpdateAction(AvatarFrameExpireTimeChecker);
	}

	private void AddAllItemFromItemList(RoleDecorateEnum decorateEnum, int id, long exprireTime)
	{
		RoleDecorateData roleDecorateData = null;
		for (int i = 0; i < itemList[decorateEnum].Count; i++)
		{
			if (itemList[decorateEnum][i].id == id)
			{
				roleDecorateData = new RoleDecorateData
				{
					DecorateType = decorateEnum,
					expireTime = itemList[decorateEnum][i].expireTime,
					id = id
				};
			}
		}
		if (roleDecorateData == null)
		{
			roleDecorateData = new RoleDecorateData
			{
				DecorateType = decorateEnum,
				expireTime = exprireTime,
				id = id
			};
		}
		allItems[decorateEnum].Add(roleDecorateData);
	}

	private void OnOptClick()
	{
		optCommad.Enabled = false;
		if (state == RoleDecorateEnum.Title)
		{
			if (curTitleId == curUsedTitleId)
			{
				optCommad.Enabled = true;
				Hide();
			}
			else
			{
				parent.ItemOnClick(new OptionArg(this, "ChangeTitle"));
			}
			return;
		}
		if (curIconId == curUsedIconId && curIconFrame == curUsedIconFrame)
		{
			optCommad.Enabled = true;
			Hide();
			return;
		}
		if (curIconId != curUsedIconId)
		{
			parent.ItemOnClick(new OptionArg(this, "ChangeIcon"));
		}
		if (curIconFrame != curUsedIconFrame)
		{
			parent.ItemOnClick(new OptionArg(this, "ChangeIconFrame"));
		}
	}

	public void SetCurInfo(int curIconId, int curIconFrame, int curTitleId)
	{
		this.curIconId = curIconId;
		CurIcon = PlayerDataBase.GetIcon(curIconId);
		CurIconFrame = curIconFrame;
		CurTitleId = curTitleId;
		curUsedTitleId = curTitleId;
		curUsedIconId = curIconId;
		curUsedIconFrame = curIconFrame;
		state1Lock = false;
		state2Lock = false;
		state = RoleDecorateEnum.None;
	}

	public void SetState(int state)
	{
		if (state == (int)this.state)
		{
			return;
		}
		State = (RoleDecorateEnum)state;
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		if (this.state == RoleDecorateEnum.Title && titleList == null)
		{
			titleList = new List<TitleItemViewModel>();
			titleList.Add(new TitleItemViewModel(this, 0, 1, "", "无", "Title/UserTitle0"));
			DRTitle[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRTitle>();
			for (int i = 0; i < allItems[RoleDecorateEnum.Title].Count; i++)
			{
				titleList.Add(new TitleItemViewModel(this, allItems[RoleDecorateEnum.Title][i].id, allDataRow[i].TimeLimited, allDataRow[i].Time, allDataRow[i].Source, allDataRow[i].Icon));
			}
			if (itemList.ContainsKey(RoleDecorateEnum.Title))
			{
				for (int j = 0; j < titleList.Count; j++)
				{
					if (titleList[j].TitleId != 0)
					{
						titleList[j].SetLock(isLock: true);
					}
					if (itemList[RoleDecorateEnum.Title].Count == 0 && titleList[j].TitleId == 0)
					{
						titleList[j].SetSelect(isSelect: true);
						Desc = titleList[j].Desc;
						CheckAddExpireTimer(titleList[j]);
						titleList[j].SetLock(isLock: false);
					}
					for (int k = 0; k < itemList[RoleDecorateEnum.Title].Count; k++)
					{
						if (titleList[j].TitleId == itemList[RoleDecorateEnum.Title][k].id)
						{
							long num = 0L;
							if (titleList[j].TitleTimeLimitType == 3)
							{
								num = GetNextDay3PmTimestamp(titleList[j].TitleTimeLimitVal) - curServerTime;
							}
							else
							{
								for (int l = 0; l < itemList[RoleDecorateEnum.Title].Count; l++)
								{
									RoleDecorateData roleDecorateData = itemList[RoleDecorateEnum.Title][l];
									if (roleDecorateData.id == titleList[j].TitleId)
									{
										num = roleDecorateData.expireTime - curServerTime;
										break;
									}
								}
							}
							if (num < 0 && titleList[j].TitleTimeLimitType != 1)
							{
								titleList[j].SetLock(isLock: true);
							}
							else
							{
								titleList[j].SetLock(isLock: false);
							}
						}
						if (titleList[j].TitleId == curTitleId)
						{
							titleList[j].SetSelect(isSelect: true);
							Desc = titleList[j].Desc;
							CheckAddExpireTimer(titleList[j]);
							titleList[j].SetLock(isLock: false);
						}
					}
				}
			}
			titleList.Sort(new CPSortTitle());
		}
		else if (this.state == RoleDecorateEnum.HeadIcon && avatarList == null)
		{
			avatarList = new List<AvatarItemViewModel>();
			for (int m = 0; m < allItems[RoleDecorateEnum.HeadIcon].Count; m++)
			{
				DRHeadAvatar dataRow = GameEntry.DataTable.GetDataRow<DRHeadAvatar>(allItems[RoleDecorateEnum.HeadIcon][m].id);
				avatarList.Add(new AvatarItemViewModel(this, allItems[RoleDecorateEnum.HeadIcon][m].id, curIconFrame, dataRow.Source, dataRow.TimeLimited, dataRow.Time));
			}
			foreach (AvatarItemViewModel avatar in avatarList)
			{
				if (avatar.IconId == curIconId)
				{
					CheckAddExpireTimer2(avatar);
				}
			}
			if (itemList.ContainsKey(RoleDecorateEnum.HeadIcon))
			{
				for (int n = 0; n < avatarList.Count; n++)
				{
					avatarList[n].SetState(1);
					for (int num2 = 0; num2 < itemList[RoleDecorateEnum.HeadIcon].Count; num2++)
					{
						if (avatarList[n].IconId == itemList[RoleDecorateEnum.HeadIcon][num2].id)
						{
							long num3 = 0L;
							if (avatarList[n].TitleTimeLimitType == 3)
							{
								num3 = GetNextDay3PmTimestamp(avatarList[n].TitleTimeLimitVal) - curServerTime;
							}
							else
							{
								for (int num4 = 0; num4 < itemList[RoleDecorateEnum.HeadIcon].Count; num4++)
								{
									RoleDecorateData roleDecorateData2 = itemList[RoleDecorateEnum.HeadIcon][num4];
									if (roleDecorateData2.id == avatarList[n].IconId)
									{
										num3 = roleDecorateData2.expireTime - curServerTime;
										break;
									}
								}
							}
							if (num3 < 0 && avatarList[n].TitleTimeLimitType != 1)
							{
								avatarList[n].SetState(1);
							}
							else
							{
								avatarList[n].SetState(0);
							}
						}
						if (avatarList[n].IconId == curIconId)
						{
							avatarList[n].SetSelect(isSelect: true);
							Desc = avatarList[n].Desc;
							CheckAddExpireTimer2(avatarList[n]);
							avatarList[n].SetState(0);
						}
					}
				}
			}
			avatarList.Sort(new CPSortAvatar());
		}
		else if (this.state == RoleDecorateEnum.HeadFrame && avatarFrameList == null)
		{
			DRHeadDecorate[] allDataRow2 = GameEntry.DataTable.GetAllDataRow<DRHeadDecorate>();
			avatarFrameList = new List<AvatarItemViewModel>();
			for (int num5 = 0; num5 < allItems[RoleDecorateEnum.HeadFrame].Count; num5++)
			{
				avatarFrameList.Add(new AvatarItemViewModel(this, curIconId, allItems[RoleDecorateEnum.HeadFrame][num5].id, allDataRow2[num5].Source, allDataRow2[num5].TimeLimited, allDataRow2[num5].Time));
			}
			foreach (AvatarItemViewModel avatarFrame in avatarFrameList)
			{
				if (avatarFrame.IconFrameId == curIconFrame)
				{
					CheckAddExpireTimer3(avatarFrame);
				}
			}
			if (itemList.ContainsKey(RoleDecorateEnum.HeadFrame))
			{
				for (int num6 = 0; num6 < avatarFrameList.Count; num6++)
				{
					avatarFrameList[num6].SetState(1);
					for (int num7 = 0; num7 < itemList[RoleDecorateEnum.HeadFrame].Count; num7++)
					{
						if (avatarFrameList[num6].IconFrameId == itemList[RoleDecorateEnum.HeadFrame][num7].id)
						{
							long num8 = 0L;
							if (avatarFrameList[num6].TitleTimeLimitType == 3)
							{
								num8 = GetNextDay3PmTimestamp(avatarFrameList[num6].TitleTimeLimitVal) - curServerTime;
							}
							else
							{
								for (int num9 = 0; num9 < itemList[RoleDecorateEnum.HeadFrame].Count; num9++)
								{
									RoleDecorateData roleDecorateData3 = itemList[RoleDecorateEnum.HeadFrame][num9];
									if (roleDecorateData3.id == avatarFrameList[num6].IconFrameId)
									{
										num8 = roleDecorateData3.expireTime - curServerTime;
										break;
									}
								}
							}
							if (num8 < 0 && avatarFrameList[num6].TitleTimeLimitType != 1)
							{
								avatarFrameList[num6].SetState(1);
							}
							else
							{
								avatarFrameList[num6].SetState(0);
							}
						}
						if (avatarFrameList[num6].IconFrameId == CurIconFrame)
						{
							avatarFrameList[num6].SetSelect(isSelect: true);
							Desc = avatarFrameList[num6].Desc;
							CheckAddExpireTimer3(avatarFrameList[num6]);
							avatarFrameList[num6].SetState(0);
						}
					}
				}
			}
			avatarFrameList.Sort(new CPSortAvatarFrame());
		}
		else if (this.state == RoleDecorateEnum.Title)
		{
			for (int num10 = 0; num10 < titleList.Count; num10++)
			{
				if (titleList[num10].TitleId == curTitleId)
				{
					SelectTitle(titleList[num10]);
					break;
				}
			}
		}
		else if (this.state == RoleDecorateEnum.HeadIcon)
		{
			for (int num11 = 0; num11 < avatarList.Count; num11++)
			{
				avatarList[num11].IconFrameId = curIconFrame;
				if (avatarList[num11].IconId == curIconId)
				{
					SelectAvatar(avatarList[num11]);
					Desc = avatarList[num11].Desc;
				}
			}
		}
		else if (this.state == RoleDecorateEnum.HeadFrame)
		{
			for (int num12 = 0; num12 < avatarFrameList.Count; num12++)
			{
				avatarFrameList[num12].SetIconId(curIconId);
				if (avatarFrameList[num12].IconFrameId == curIconFrame)
				{
					SelectAvatar(avatarFrameList[num12]);
					Desc = avatarFrameList[num12].Desc;
				}
			}
		}
		updateItemListRequest.Raise();
	}

	public void Refresh()
	{
		updateItemListRequest.Raise();
	}

	public int GetSelectedIndex()
	{
		if (state == RoleDecorateEnum.HeadIcon)
		{
			for (int i = 0; i < avatarList.Count; i++)
			{
				if (avatarList[i].IsSelect)
				{
					return i;
				}
			}
		}
		else if (state == RoleDecorateEnum.HeadFrame)
		{
			for (int j = 0; j < avatarFrameList.Count; j++)
			{
				if (avatarFrameList[j].IsSelect)
				{
					return j;
				}
			}
		}
		return 0;
	}

	private void CheckAddExpireTimer(TitleItemViewModel titleItem)
	{
		if (titleItem == curExpireTitleItem)
		{
			return;
		}
		TitleTimeLimitType = titleItem.TitleTimeLimitType;
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		long num = 0L;
		if (!titleItem.IsLock && (titleTimeLimitType == 2 || titleTimeLimitType == 3))
		{
			RoleDecorateData roleDecorateData = null;
			if (titleTimeLimitType == 3)
			{
				num = GetNextDay3PmTimestamp(titleItem.TitleTimeLimitVal);
			}
			else
			{
				for (int i = 0; i < itemList[RoleDecorateEnum.Title].Count; i++)
				{
					if (itemList[RoleDecorateEnum.Title][i].id == titleItem.TitleId)
					{
						roleDecorateData = itemList[RoleDecorateEnum.Title][i];
						num = roleDecorateData.expireTime;
						break;
					}
				}
			}
			if (num <= curServerTime)
			{
				LockExpireTitleItem(titleItem);
			}
			else
			{
				curExpireTitleItem = titleItem;
				curSelDecorateData = roleDecorateData;
			}
		}
		else
		{
			curSelDecorateData = null;
			curExpireTitleItem = null;
		}
		TitleTimeLimitDesc = titleItem.GetTimeLimitDesc(num - curServerTime);
	}

	private void LockExpireTitleItem(TitleItemViewModel titleItem)
	{
		titleItem.SetLock(isLock: true);
		optCommad.Enabled = !titleItem.IsLock;
		updateDescRequest.Raise();
		SelectDefaultTitleIfExpired();
	}

	private void TitleExpireTimeChecker(long curServerTime)
	{
		if (curExpireTitleItem != null)
		{
			long num = 0L;
			if (curExpireTitleItem.TitleTimeLimitType == 3)
			{
				num = GetNextDay3PmTimestamp(curExpireTitleItem.TitleTimeLimitVal) - curServerTime;
			}
			else if (curSelDecorateData != null)
			{
				num = curSelDecorateData.expireTime - curServerTime;
			}
			if (num < 0)
			{
				curExpireTitleItem.SetLock(isLock: true);
				LockExpireTitleItem(curExpireTitleItem);
				curSelDecorateData = null;
				TitleTimeLimitDesc = curExpireTitleItem.GetTimeLimitDesc(num);
				curExpireTitleItem = null;
				num = 0L;
			}
			else
			{
				TitleTimeLimitDesc = curExpireTitleItem.GetTimeLimitDesc(num);
			}
		}
		if (titleList == null)
		{
			return;
		}
		bool flag = false;
		for (int i = 0; i < titleList.Count; i++)
		{
			if (titleList[i].IsLock || (titleList[i].TitleTimeLimitType != 2 && titleList[i].TitleTimeLimitType != 3))
			{
				continue;
			}
			long num2 = 0L;
			if (titleList[i].TitleTimeLimitType == 3)
			{
				num2 = GetNextDay3PmTimestamp(titleList[i].TitleTimeLimitVal) - curServerTime;
			}
			else
			{
				for (int j = 0; j < itemList[RoleDecorateEnum.Title].Count; j++)
				{
					RoleDecorateData roleDecorateData = itemList[RoleDecorateEnum.Title][j];
					if (roleDecorateData.id == titleList[i].TitleId)
					{
						num2 = roleDecorateData.expireTime - curServerTime;
						break;
					}
				}
			}
			if (num2 < 0)
			{
				titleList[i].SetLock(isLock: true);
			}
			if (num2 < 0 && titleList[i].TitleId == curTitleId)
			{
				flag = true;
			}
		}
		if (flag)
		{
			SelectDefaultTitleIfExpired();
		}
	}

	private void SelectDefaultTitleIfExpired()
	{
	}

	private void CheckAddExpireTimer2(AvatarItemViewModel avatarHeadItem)
	{
		UpdateExpireTimer(avatarHeadItem, ref curAvatarItem, RoleDecorateEnum.HeadIcon);
	}

	private void LockExpireAvatarItem(AvatarItemViewModel avatarHeadItem)
	{
		avatarHeadItem.SetState(1);
		optCommad.Enabled = avatarHeadItem.State == 0;
		updateDescRequest.Raise();
		SelectDefaultAvatarIfExpired();
	}

	private void AvatarExpireTimeChecker(long curServerTime)
	{
		UpdateExpireTimeDisplay(curServerTime, curAvatarItem, RoleDecorateEnum.HeadIcon, ref curAvatarItem);
		if (avatarList != null)
		{
			CheckAllItemsExpiration(avatarList, RoleDecorateEnum.HeadIcon, curServerTime);
		}
	}

	private void CheckAddExpireTimer3(AvatarItemViewModel avatarFrameItem)
	{
		UpdateExpireTimer(avatarFrameItem, ref curAvatarFrameItem, RoleDecorateEnum.HeadFrame);
	}

	private void AvatarFrameExpireTimeChecker(long curServerTime)
	{
		UpdateExpireTimeDisplay(curServerTime, curAvatarFrameItem, RoleDecorateEnum.HeadFrame, ref curAvatarFrameItem);
		if (avatarFrameList != null)
		{
			CheckAllItemsExpiration(avatarFrameList, RoleDecorateEnum.HeadFrame, curServerTime);
		}
	}

	private void UpdateExpireTimer(AvatarItemViewModel item, ref AvatarItemViewModel currentItem, RoleDecorateEnum decorateType)
	{
		TitleTimeLimitType = item.TitleTimeLimitType;
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		long num = 0L;
		if (item.State == 0 && (titleTimeLimitType == 2 || titleTimeLimitType == 3))
		{
			RoleDecorateData roleDecorateData = null;
			if (titleTimeLimitType == 3)
			{
				num = GetNextDay3PmTimestamp(item.TitleTimeLimitVal);
			}
			else
			{
				for (int i = 0; i < itemList[decorateType].Count; i++)
				{
					if (itemList[decorateType][i].id == GetItemId(item, decorateType))
					{
						roleDecorateData = itemList[decorateType][i];
						num = roleDecorateData.expireTime;
						break;
					}
				}
			}
			if (num <= curServerTime)
			{
				LockExpireAvatarItem(item);
			}
			else
			{
				currentItem = item;
				curSelDecorateData = roleDecorateData;
			}
		}
		else
		{
			curSelDecorateData = null;
			currentItem = null;
		}
		TitleTimeLimitDesc = item.GetTimeLimitDesc(num - curServerTime);
	}

	private void UpdateExpireTimeDisplay(long curServerTime, AvatarItemViewModel currentItem, RoleDecorateEnum decorateType, ref AvatarItemViewModel itemField)
	{
		if (currentItem != null && State == decorateType)
		{
			long num = 0L;
			num = ((currentItem.TitleTimeLimitType != 3) ? (curSelDecorateData.expireTime - curServerTime) : (GetNextDay3PmTimestamp(currentItem.TitleTimeLimitVal) - curServerTime));
			if (num < 0)
			{
				currentItem.SetState(1);
				LockExpireAvatarItem(currentItem);
				curSelDecorateData = null;
				TitleTimeLimitDesc = currentItem.GetTimeLimitDesc(num);
				itemField = null;
				num = 0L;
			}
			else
			{
				TitleTimeLimitDesc = currentItem.GetTimeLimitDesc(num);
			}
		}
	}

	private void CheckAllItemsExpiration(List<AvatarItemViewModel> items, RoleDecorateEnum decorateType, long curServerTime)
	{
		bool flag = false;
		for (int i = 0; i < items.Count; i++)
		{
			if (items[i].State != 0 || (items[i].TitleTimeLimitType != 2 && items[i].TitleTimeLimitType != 3))
			{
				continue;
			}
			long num = 0L;
			if (items[i].TitleTimeLimitType == 3)
			{
				num = GetNextDay3PmTimestamp(items[i].TitleTimeLimitVal) - curServerTime;
			}
			else
			{
				for (int j = 0; j < itemList[decorateType].Count; j++)
				{
					RoleDecorateData roleDecorateData = itemList[decorateType][j];
					if (roleDecorateData.id == GetItemId(items[i], decorateType))
					{
						num = roleDecorateData.expireTime - curServerTime;
						break;
					}
				}
			}
			if (num < 0)
			{
				items[i].SetState(1);
			}
			if (num < 0 && (items[i].IconFrameId == CurIconFrame || items[i].IconId == CurIconId))
			{
				flag = true;
			}
		}
		if (flag)
		{
			SelectDefaultAvatarIfExpired();
		}
	}

	private int GetItemId(AvatarItemViewModel item, RoleDecorateEnum decorateType)
	{
		return decorateType switch
		{
			RoleDecorateEnum.HeadIcon => item.IconId, 
			RoleDecorateEnum.HeadFrame => item.IconFrameId, 
			_ => 0, 
		};
	}

	private void SelectDefaultAvatarIfExpired()
	{
		if (avatarList != null && avatarList.Count > 0)
		{
			AvatarItemViewModel avatarItemViewModel = avatarList.Find((AvatarItemViewModel a) => a.IconId == curIconId);
			if (avatarItemViewModel != null && avatarItemViewModel.State == 1 && avatarItemViewModel.TitleTimeLimitType != 1)
			{
				AvatarItemViewModel avatarItemViewModel2 = avatarList.Find((AvatarItemViewModel a) => a.IconId == 1104);
				if (avatarItemViewModel2 != null)
				{
					SelectAvatar(avatarItemViewModel2);
					OnOptClick();
				}
			}
		}
		if (avatarFrameList == null || avatarFrameList.Count <= 0)
		{
			return;
		}
		AvatarItemViewModel avatarItemViewModel3 = avatarFrameList.Find((AvatarItemViewModel f) => f.IconFrameId == curIconFrame);
		if (avatarItemViewModel3 != null && avatarItemViewModel3.State == 1 && avatarItemViewModel3.TitleTimeLimitType != 1)
		{
			AvatarItemViewModel avatarItemViewModel4 = avatarFrameList.Find((AvatarItemViewModel f) => f.IconFrameId == 10001);
			if (avatarItemViewModel4 != null)
			{
				SelectAvatar(avatarItemViewModel4);
				OnOptClick();
			}
		}
	}

	public int GetItemCount()
	{
		if (state == RoleDecorateEnum.HeadIcon && allItems.ContainsKey(RoleDecorateEnum.HeadIcon))
		{
			return allItems[RoleDecorateEnum.HeadIcon].Count;
		}
		if (state == RoleDecorateEnum.HeadFrame && allItems.ContainsKey(RoleDecorateEnum.HeadFrame))
		{
			return allItems[RoleDecorateEnum.HeadFrame].Count;
		}
		if (state == RoleDecorateEnum.Title && allItems.ContainsKey(RoleDecorateEnum.Title))
		{
			return allItems[RoleDecorateEnum.Title].Count + 1;
		}
		return 0;
	}

	public bool Enable()
	{
		return optCommad.Enabled;
	}

	public void EnableOpt()
	{
		optCommad.Enabled = true;
	}

	public void Hide()
	{
		base.IsVisible = false;
		parent.ItemOnClick(this);
	}

	public override void Close()
	{
		Singleton<ServiceSystem>.Instance?.GetService<ITimeService>()?.RemoveNormalSecondUpdateAction(TitleExpireTimeChecker);
		Singleton<ServiceSystem>.Instance?.GetService<ITimeService>()?.RemoveNormalSecondUpdateAction(AvatarExpireTimeChecker);
		Singleton<ServiceSystem>.Instance?.GetService<ITimeService>()?.RemoveNormalSecondUpdateAction(AvatarFrameExpireTimeChecker);
		base.Close();
	}

	private long GetNextDay3PmTimestamp(string dateString)
	{
		DateTime dateTime = DateTime.ParseExact(dateString, "yyyy.MM.dd", CultureInfo.InvariantCulture).AddDays(1.0).AddHours(refreshHour)
			.ToUniversalTime();
		DateTime dateTime2 = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
		return (long)(dateTime - dateTime2).TotalSeconds;
	}
}
