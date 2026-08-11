#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine.Pool;

namespace Ase;

public class AnnouncementViewModel : OptionBase
{
	private List<AnnouncementItemData> announcementItemList = new List<AnnouncementItemData>();

	private List<AnnouncementItemData> announcementItemListShow = new List<AnnouncementItemData>();

	private List<AnnouncementTabData> announcementTabDatas = new List<AnnouncementTabData>();

	private AnnouncementDetailViewModel detail;

	private AnnouncementTabData tabData;

	private AnnouncementItemData itemData;

	private bool hasAnn;

	private InteractionRequest refreshItemRequest = new InteractionRequest();

	private float duration;

	private Timer timer;

	private bool userOpen;

	private int _defaultId;

	public int DefaultId => _defaultId;

	public List<AnnouncementItemData> ItemListShow => announcementItemListShow;

	public AnnouncementTabData TabData
	{
		get
		{
			return tabData;
		}
		private set
		{
			Set(ref tabData, value, "TabData");
		}
	}

	public bool HasAnn
	{
		get
		{
			return hasAnn;
		}
		set
		{
			Set(ref hasAnn, value, "HasAnn");
		}
	}

	public AnnouncementDetailViewModel Detail => detail;

	public List<AnnouncementTabData> TabDatas => announcementTabDatas;

	public IInteractionRequest RefreshItemRequest => refreshItemRequest;

	public override void ItemOnClick(object obj)
	{
		if (obj is AnnouncementTabData announcementTabData)
		{
			if (!announcementTabData.IsSelected)
			{
				TabItemOnClick(announcementTabData);
			}
		}
		else if (obj is AnnouncementItemData data)
		{
			AnnouncementItemOnClick(data);
		}
	}

	public AnnouncementViewModel()
	{
	}

	public AnnouncementViewModel(OptionBase parent, int defaultType, int defaultId = 0, bool userOpen = true)
	{
		base.parent = parent;
		this.userOpen = userOpen;
		_defaultId = defaultId;
		detail = new AnnouncementDetailViewModel(this);
		announcementTabDatas = new List<AnnouncementTabData>
		{
			new AnnouncementTabData(this, 1),
			new AnnouncementTabData(this, 2),
			new AnnouncementTabData(this, 3)
		};
		switch (defaultType)
		{
		case 1:
			TabItemOnClick(announcementTabDatas[0]);
			break;
		case 2:
			TabItemOnClick(announcementTabDatas[1]);
			break;
		default:
			TabItemOnClick(announcementTabDatas[2]);
			break;
		}
		RequestAllNoticeInfo();
	}

	public new async Task<bool> OnOpen()
	{
		try
		{
			timer = Timer.Register(1f, delegate
			{
				duration++;
			}, null, isLooped: true, useRealTime: true);
		}
		catch (Exception)
		{
			Log.Error("ShopWindow：开启计时器失败");
			return false;
		}
		return true;
	}

	private async void RequestAllNoticeInfo()
	{
		announcementItemList.Clear();
		foreach (AnnouncementData announcementDatum in Singleton<ServiceSystem>.Instance.GetService<IAnnouncementService>().GetAnnouncementData())
		{
			announcementItemList.Add(new AnnouncementItemData(this, announcementDatum));
		}
		AnnouncementData oldData = null;
		if (detail != null && detail.Data != null && detail.Data.Data != null)
		{
			oldData = detail.Data.Data;
		}
		SetAnnouncementItemList("公告数据更新", oldData);
	}

	private void TabItemOnClick(AnnouncementTabData data)
	{
		userOpen = false;
		if (TabData == null || TabData.Type != data.Type)
		{
			AnnouncementData oldData = null;
			if (detail?.Data?.Data != null)
			{
				oldData = detail.Data.Data;
			}
			if (TabData != null)
			{
				TabData.IsSelected = false;
			}
			TabData = data;
			TabData.IsSelected = true;
			SetAnnouncementItemList("切换公告类型", oldData);
		}
	}

	private void SetAnnouncementItemList(string reason, AnnouncementData oldData = null)
	{
		if (announcementItemList == null)
		{
			HasAnn = false;
			return;
		}
		announcementItemListShow = announcementItemList.Where((AnnouncementItemData p) => p.Data.Type == TabData.Type).ToList();
		if (announcementItemListShow.Count > 0)
		{
			announcementItemListShow.Sort((AnnouncementItemData a, AnnouncementItemData b) => (a.Data.Priority != b.Data.Priority) ? a.Data.Priority.CompareTo(b.Data.Priority) : a.Data.StartTime.CompareTo(b.Data.StartTime));
			int num = 0;
			if (_defaultId > 0)
			{
				num = announcementItemListShow.FindIndex((AnnouncementItemData p) => p.Data.Id == _defaultId);
				_defaultId = 0;
			}
			AnnouncementItemOnClick(announcementItemListShow[(num >= 0) ? num : 0]);
			HasAnn = true;
		}
		else
		{
			if (oldData != null)
			{
				AddTDA(oldData.Id, oldData.Type, userOpen, duration, reason);
			}
			duration = 0f;
		}
		HasAnn = announcementItemListShow != null && announcementItemListShow.Count > 0;
		refreshItemRequest.Raise();
	}

	private void AnnouncementItemOnClick(AnnouncementItemData data)
	{
		userOpen = false;
		AnnouncementItemData announcementItemData = null;
		if (itemData != null)
		{
			announcementItemData = itemData;
			itemData.IsSelected = false;
		}
		itemData = data;
		itemData.IsSelected = true;
		detail.Data = itemData;
		if (announcementItemData != null && announcementItemData.Data.Id != itemData.Data.Id)
		{
			AddTDA(announcementItemData.Data.Id, announcementItemData.Data.Type, userOpen, duration, "下一条公告");
			duration = 0f;
		}
		Singleton<ServiceSystem>.Instance.GetService<IAnnouncementService>().SetRead(data.Data.Id);
	}

	public AnnouncementItemData GetAnnouncementItemData(int index)
	{
		if (index >= 0 && index < announcementItemList.Count)
		{
			return announcementItemList[index];
		}
		return null;
	}

	public override void Close()
	{
		if (detail != null && detail.Data != null && detail.Data.Data != null)
		{
			AnnouncementData data = detail.Data.Data;
			AddTDA(data.Id, data.Type, userOpen, duration, "关闭弹窗");
		}
		base.Close();
	}

	public override void Dispose()
	{
		if (timer != null)
		{
			timer.Cancel();
			timer = null;
		}
		base.Dispose();
	}

	private void AddTDA(long id, int type, bool active, float duration, string reason)
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		string value = "";
		switch (type)
		{
		case 1:
			value = "系统公告";
			break;
		case 2:
			value = "活动公告";
			break;
		case 3:
			value = "玩家攻略";
			break;
		}
		dictionary.Add("billboard_id", $"{id}");
		dictionary.Add("billboard_type", value);
		dictionary.Add("if_active", active);
		dictionary.Add("duration", duration);
		dictionary.Add("end_reason", reason);
		TDAHandler.Instance.SendUserEvent("billboard_view", dictionary);
		dictionary.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}
}
