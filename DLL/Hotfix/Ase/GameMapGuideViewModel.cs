using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class GameMapGuideViewModel : OptionBase
{
	private List<MapPointItemData> pointItemDataList;

	private List<GameStoryGuideItemData> timeLineDataListl;

	private Dictionary<string, RedPointSave> redPointSaveDic;

	public List<MapPointItemData> PointItemDataList => pointItemDataList;

	public GameMapGuideViewModel(OptionBase parent, List<GameStoryGuideItemData> timeLineDataList)
	{
		base.parent = parent;
		timeLineDataListl = timeLineDataList;
		redPointSaveDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetRedPointService(6);
		LoadPoint();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is MapPointItemData mapPointItemData && "OnClick".Equals(optionArg.OptionName))
			{
				OpenGameMapInfoWindow(mapPointItemData.ID, timeLineDataListl);
			}
		}
		else
		{
			if (!(obj is GameMapInfoViewModel gameMapInfoViewModel))
			{
				return;
			}
			foreach (MapPointItemData pointItemData in pointItemDataList)
			{
				if (pointItemData.ID == gameMapInfoViewModel.MapId)
				{
					pointItemData.RedPoint = false;
					break;
				}
			}
		}
	}

	private void OpenGameMapInfoWindow(int mapId, List<GameStoryGuideItemData> timeLineDataList)
	{
		GameMapInfoViewModel userData = new GameMapInfoViewModel(this, mapId, timeLineDataList);
		openWindowRequest.Raise(new OpenViewArg(typeof(GameMapInfoWindow), userData));
	}

	private void LoadPoint()
	{
		pointItemDataList = new List<MapPointItemData>();
		DRMapNote[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRMapNote>();
		long maxCopyOpenIndex = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().MaxCopyOpenIndex;
		DRMapNote[] array = allDataRow;
		foreach (DRMapNote dRMapNote in array)
		{
			if (dRMapNote.MapOpen < maxCopyOpenIndex)
			{
				Vector2 pos = default(Vector2);
				if (dRMapNote.Position.Count >= 2)
				{
					pos = new Vector2(dRMapNote.Position[0], dRMapNote.Position[1]);
				}
				else
				{
					Toast.ShowError($"MapNote表格ID:{dRMapNote.Id}对应的Position数据错误");
				}
				MapPointItemData mapPointItemData = new MapPointItemData(this, dRMapNote.Id, 6, dRMapNote.MapIcon, dRMapNote.Name, pos);
				bool isNew = GetIsNew(6, dRMapNote.Id);
				mapPointItemData.SetRedPoint(isNew);
				pointItemDataList.Add(mapPointItemData);
			}
		}
	}

	private bool GetIsNew(int type, int id)
	{
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
		long maxCopyOpenIndex = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().MaxCopyOpenIndex;
		DRSceneryNote[] dataRows = GameEntry.DataTable.GetDataRows((DRSceneryNote p) => p.MapId == id);
		foreach (DRSceneryNote dRSceneryNote in dataRows)
		{
			if (dRSceneryNote.OpenType == 1 && maxCopyOpenIndex >= dRSceneryNote.OpenNum)
			{
				string key = $"{uid}_GameNoteRedPoint_{type}_{dRSceneryNote.Id}";
				redPointSaveDic.TryGetValue(key, out var value);
				if (value != null && value.isNew)
				{
					return true;
				}
			}
		}
		return false;
	}

	public override void Close()
	{
		foreach (MapPointItemData pointItemData in pointItemDataList)
		{
			foreach (GameMapInfoData gameMapInfoData in new GameMapInfoViewModel(this, pointItemData.ID, timeLineDataListl).GameMapInfoDataList)
			{
				Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().SaveRedPoint(6, gameMapInfoData.SceneryId);
				foreach (int npcId in gameMapInfoData.NpcIdList)
				{
					Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().SaveRedPoint(6, npcId);
				}
			}
		}
		parent?.ItemOnClick(new OptionArg(this, "RedPoint"));
		base.Close();
	}
}
