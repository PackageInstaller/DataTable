#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using GameFramework.WebRequest;
using Newtonsoft.Json;
using UnityEngine;

namespace Ase;

public class AnnouncementService : IAnnouncementService
{
	private const string PrefName = "AnnouncementReadData";

	private AnnouncementJsonData readData;

	private List<long> unReadIdList = new List<long>();

	private Dictionary<long, AnnouncementData> datas = new Dictionary<long, AnnouncementData>();

	private IMessenger messenger;

	private ISubscription<G2C_NoticeChangeNotify> G2C_NoticeChangeNotify;

	public IMessenger GetMessager()
	{
		return messenger;
	}

	public AnnouncementService()
	{
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		G2C_NoticeChangeNotify = Singleton<NetworkSystem>.Instance.Subscribe<G2C_NoticeChangeNotify>(OnNoticeChangeNotify);
		Load();
	}

	public async UniTask<bool> RequestNoticeData()
	{
		string webRequestUri = "http://" + GameEntry.BuiltinData.PlatformUrl + "/game_api/notice";
		string channel = GameEntry.BuiltinData.Channel;
		try
		{
			WWWForm val = new WWWForm();
			val.AddField("channel", channel);
			WebRequestResponse webRequestResponse = await GameEntry.WebRequest.AddWebRequest(webRequestUri, val);
			if (webRequestResponse == null)
			{
				return false;
			}
			datas?.Clear();
			List<NoticeInfo> obj = webRequestResponse.GetResponseData<List<NoticeInfo>>().Item1 ?? new List<NoticeInfo>();
			List<long> list = readData?.GetUnReadIds() ?? new List<long>();
			foreach (NoticeInfo item in obj)
			{
				datas?.Add(item.id, AnnouncementData.Create(item, list.Contains(item.id)));
			}
			UpdateReadData();
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
			return false;
		}
		return true;
	}

	public async UniTask<bool> RequestAllNoticeData()
	{
		return await RequestNoticeData();
	}

	private void OnNoticeChangeNotify(G2C_NoticeChangeNotify notify)
	{
		List<long> list = readData?.GetUnReadIds() ?? new List<long>();
		foreach (PbNotice pbNotice in notify.PbNotices)
		{
			if (pbNotice.Delete && datas.ContainsKey(pbNotice.Id))
			{
				datas.Remove(pbNotice.Id);
			}
			else if (datas.ContainsKey(pbNotice.Id))
			{
				datas[pbNotice.Id] = AnnouncementData.Create(pbNotice, list.Contains(pbNotice.Id));
			}
			else
			{
				datas.Add(pbNotice.Id, AnnouncementData.Create(pbNotice, list.Contains(pbNotice.Id)));
			}
		}
		UpdateReadData();
	}

	public AnnouncementData GetAnnouncementById(long id)
	{
		AnnouncementData value = null;
		datas.TryGetValue(id, out value);
		return value;
	}

	public List<AnnouncementData> GetAnnouncementData()
	{
		if (datas == null)
		{
			return null;
		}
		List<AnnouncementData> list = new List<AnnouncementData>();
		foreach (AnnouncementData value in datas.Values)
		{
			list.Add(value);
		}
		return list;
	}

	public List<long> GetUnReadList()
	{
		return unReadIdList;
	}

	public bool SetRead(long id)
	{
		if (readData.GetUnReadIds().Contains(id) || !datas.ContainsKey(id))
		{
			return false;
		}
		readData.ReadDatas.Add(new AnnouncementJsonItemData
		{
			channel = GameEntry.BuiltinData.Channel,
			id = id
		});
		datas[id].IsRead = true;
		Save();
		UpdateUnReadData();
		return true;
	}

	private void UpdateReadData()
	{
		if (readData == null)
		{
			UpdateUnReadData();
			return;
		}
		string channel = GameEntry.BuiltinData.Channel;
		for (int num = readData.ReadDatas.Count - 1; num >= 0; num--)
		{
			if (!(readData.ReadDatas[num].channel != channel) && !datas.ContainsKey(readData.ReadDatas[num].id))
			{
				readData.ReadDatas.RemoveAt(num);
			}
		}
		Save();
		UpdateUnReadData();
	}

	private void UpdateUnReadData()
	{
		if (readData == null)
		{
			unReadIdList = datas.Keys.ToList();
		}
		else
		{
			unReadIdList.Clear();
			List<long> unReadIds = readData.GetUnReadIds();
			foreach (long key in datas.Keys)
			{
				if (!unReadIds.Contains(key))
				{
					unReadIdList.Add(key);
				}
			}
		}
		messenger.Publish(new AnnouncementMsg(this, unReadIdList));
	}

	private void Load()
	{
		readData = JsonConvert.DeserializeObject<AnnouncementJsonData>(PlayerPrefs.GetString("AnnouncementReadData")) ?? new AnnouncementJsonData();
	}

	private void Save()
	{
		string value = JsonConvert.SerializeObject(readData);
		PlayerPrefs.SetString("AnnouncementReadData", value);
	}
}
