using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class GameMapInfoViewModel : OptionBase
{
	private int mapId;

	private string mapName;

	private string mapDesc;

	private int mapIndex;

	private InteractionRequest refreshNpcRequest;

	private List<string> mapImgList;

	private List<TabItemNormalData> npcDataList;

	private List<GameMapInfoData> gameMapInfoDataList;

	private RollingViewModel rollingViewModel;

	private long taskIndex;

	private List<GameStoryGuideItemData> timeLineDataList;

	private Dictionary<string, RedPointSave> mapRedPointDic;

	public int MapId => mapId;

	public string MapName
	{
		get
		{
			return mapName;
		}
		private set
		{
			Set(ref mapName, value, "MapName");
		}
	}

	public string MapDesc
	{
		get
		{
			return mapDesc;
		}
		private set
		{
			Set(ref mapDesc, value, "MapDesc");
		}
	}

	public List<TabItemNormalData> NpcDataList
	{
		get
		{
			return npcDataList;
		}
		private set
		{
			Set(ref npcDataList, value, "NpcDataList");
		}
	}

	public RollingViewModel RollingViewModel => rollingViewModel;

	public InteractionRequest RefreshNpcRequest => refreshNpcRequest;

	public List<GameMapInfoData> GameMapInfoDataList => gameMapInfoDataList;

	public GameMapInfoViewModel(OptionBase parent, int mapId, List<GameStoryGuideItemData> timeLineDataList)
	{
		base.parent = parent;
		this.mapId = mapId;
		mapImgList = new List<string>();
		npcDataList = new List<TabItemNormalData>();
		gameMapInfoDataList = new List<GameMapInfoData>();
		mapRedPointDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetRedPointService(6);
		this.timeLineDataList = timeLineDataList;
		refreshNpcRequest = new InteractionRequest();
		taskIndex = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().MaxCopyOpenIndex;
		SetMapData(mapId);
		rollingViewModel = new RollingViewModel(this, mapImgList, 2);
		if (gameMapInfoDataList.Count > 0)
		{
			SetSceneryData(gameMapInfoDataList[0]);
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemNormalData tabItemNormalData)
		{
			OpenNpcWindow(tabItemNormalData.ID);
		}
		else if (obj is RollingViewModel rollingViewModel)
		{
			mapIndex = rollingViewModel.Index;
			if (gameMapInfoDataList.Count > mapIndex)
			{
				SetSceneryData(gameMapInfoDataList[mapIndex]);
			}
			refreshNpcRequest.Raise();
		}
		else
		{
			if (!(obj is GameMapNpcViewModel gameMapNpcViewModel))
			{
				return;
			}
			foreach (TabItemNormalData npcData in npcDataList)
			{
				if (npcData.ID == gameMapNpcViewModel.CurNpc.ID)
				{
					npcData.RedPoint = false;
				}
			}
		}
	}

	public void Next()
	{
		rollingViewModel.Right();
	}

	public void Previous()
	{
		rollingViewModel.Left();
	}

	private void SetMapData(int mapId)
	{
		DRSceneryNote[] drSceneryNoteList = GameEntry.DataTable.GetDataRows((DRSceneryNote p) => p.MapId == mapId);
		int i;
		for (i = 0; i < drSceneryNoteList.Length; i++)
		{
			bool flag = true;
			if (drSceneryNoteList[i].OpenType == 1)
			{
				flag = taskIndex < drSceneryNoteList[i].OpenNum;
			}
			else if (drSceneryNoteList[i].OpenType == 2)
			{
				flag = timeLineDataList.FindAll((GameStoryGuideItemData p) => p.ID == drSceneryNoteList[i].OpenNum).Count <= 0;
			}
			if (flag)
			{
				continue;
			}
			GameMapInfoData item = new GameMapInfoData
			{
				SceneryId = drSceneryNoteList[i].Id,
				Name = drSceneryNoteList[i].Name,
				Desc = drSceneryNoteList[i].Desc
			};
			DRNPCNote[] dataRows = GameEntry.DataTable.GetDataRows((DRNPCNote p) => p.SceneryId == drSceneryNoteList[i].Id);
			item.NpcIdList = new List<int>();
			DRNPCNote[] array = dataRows;
			foreach (DRNPCNote drnpcNote in array)
			{
				bool flag2 = true;
				if (drnpcNote.OpenType == 1)
				{
					flag2 = taskIndex < drnpcNote.OpenNum;
				}
				else if (drnpcNote.OpenType == 2)
				{
					flag2 = timeLineDataList.FindAll((GameStoryGuideItemData p) => p.ID == drnpcNote.OpenNum).Count <= 0;
				}
				if (!flag2)
				{
					item.NpcIdList.Add(drnpcNote.NpcId);
				}
			}
			gameMapInfoDataList.Add(item);
			mapImgList.Add(drSceneryNoteList[i].PrePath + "/" + drSceneryNoteList[i].Icon);
		}
	}

	private void SetSceneryData(GameMapInfoData gameMapInfoData)
	{
		MapName = gameMapInfoData.Name;
		MapDesc = gameMapInfoData.Desc;
		NpcDataList.Clear();
		foreach (int npcId in gameMapInfoData.NpcIdList)
		{
			DRNPCNote dataRow = GameEntry.DataTable.GetDataRow((DRNPCNote p) => p.NpcId == npcId);
			TabItemNormalData tabItemNormalData = new TabItemNormalData(this, dataRow.Icon, npcId, isSelected: false, dataRow.Desc);
			tabItemNormalData.RedPoint = CheckNew(npcId);
			NpcDataList.Add(tabItemNormalData);
		}
	}

	private bool CheckNew(int npcId)
	{
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
		string key = $"{uid}_GameNoteRedPoint_{6}_{npcId}";
		mapRedPointDic.TryGetValue(key, out var value);
		return value?.isNew ?? false;
	}

	private void OpenNpcWindow(int npcId)
	{
		rollingViewModel.SetCanSlider(value: false);
		GameMapNpcViewModel userData = new GameMapNpcViewModel(this, npcId, NpcDataList, mapImgList[mapIndex]);
		openWindowRequest.Raise(new OpenViewArg(typeof(GameMapNpcWindow), userData), delegate
		{
			rollingViewModel.SetCanSlider(value: true);
		});
	}

	public override void Close()
	{
		ClearRedPoint();
		parent?.ItemOnClick(this);
		base.Close();
	}

	private void ClearRedPoint()
	{
		foreach (GameMapInfoData gameMapInfoData in gameMapInfoDataList)
		{
			Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().SaveRedPoint(6, gameMapInfoData.SceneryId);
			foreach (int npcId in gameMapInfoData.NpcIdList)
			{
				Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().SaveRedPoint(6, npcId);
			}
		}
	}
}
