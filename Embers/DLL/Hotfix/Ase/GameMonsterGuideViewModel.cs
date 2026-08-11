using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class GameMonsterGuideViewModel : OptionBase
{
	private List<MapPointItemData> pointItemDataList;

	private Dictionary<string, RedPointSave> redPointSaveDic;

	public List<MapPointItemData> PointItemDataList => pointItemDataList;

	public GameMonsterGuideViewModel(OptionBase parent)
	{
		base.parent = parent;
		redPointSaveDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetRedPointService(4);
		LoadPoint();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg { Obj: MapPointItemData obj2 } optionArg && "OnClick".Equals(optionArg.OptionName))
		{
			OpenGameMonsterInfoWindow(obj2.ID);
			obj2.SetRedPoint();
		}
	}

	private void OpenGameMonsterInfoWindow(int id)
	{
		GameMonsterInfoViewModel userData = new GameMonsterInfoViewModel(this, id);
		openWindowRequest.Raise(new OpenViewArg(typeof(GameMonsterInfoWindow), userData));
	}

	private void LoadPoint()
	{
		pointItemDataList = new List<MapPointItemData>();
		DRMonsterNote[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRMonsterNote>();
		List<long> monsterList = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetMonsterList();
		DRMonsterNote[] array = allDataRow;
		foreach (DRMonsterNote drMonster in array)
		{
			Vector2 pos = default(Vector2);
			if (drMonster.Position.Count >= 2)
			{
				pos = new Vector2(drMonster.Position[0], drMonster.Position[1]);
			}
			else
			{
				Toast.ShowError($"MonsterNote表格ID:{drMonster.Id}对应的Position数据错误");
			}
			DRMonsterInfo[] dataRows = GameEntry.DataTable.GetDataRows((DRMonsterInfo p) => p.GuideId == drMonster.Id);
			string icon = ((dataRows.Length != 0) ? dataRows[0].MonsterHead : "empty");
			bool isLock = monsterList == null || monsterList.Find((long n) => n.Equals(drMonster.Id)) <= 0;
			MapPointItemData mapPointItemData = new MapPointItemData(this, drMonster.Id, 4, icon, drMonster.Name, pos, isLock);
			bool isNew = GetIsNew(4, drMonster.Id);
			mapPointItemData.SetRedPoint(isNew);
			mapPointItemData.HideName();
			pointItemDataList.Add(mapPointItemData);
		}
	}

	private bool GetIsNew(int type, int id)
	{
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
		string key = $"{uid}_GameNoteRedPoint_{type}_{id}";
		redPointSaveDic.TryGetValue(key, out var value);
		return value?.isNew ?? true;
	}

	public override void Close()
	{
		foreach (MapPointItemData pointItemData in pointItemDataList)
		{
			pointItemData.SetRedPoint();
		}
		parent?.ItemOnClick(new OptionArg(this, "RedPoint"));
		base.Close();
	}
}
