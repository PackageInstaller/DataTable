using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class GameHeroGuideViewModel : OptionBase
{
	private List<MapPointItemData> pointItemDataList;

	private Dictionary<int, Dictionary<string, bool>> redPointSaveDic;

	private MapPointItemData curHeroPoint;

	public List<MapPointItemData> PointItemDataList => pointItemDataList;

	public GameHeroGuideViewModel(OptionBase parent)
	{
		base.parent = parent;
		redPointSaveDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetHeroRedPoint();
		LoadPoint();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is MapPointItemData mapPointItemData && "OnClick".Equals(optionArg.OptionName))
			{
				OpenGameHeroInfoWindow(mapPointItemData.ID);
				curHeroPoint = mapPointItemData;
			}
		}
		else
		{
			if (!(obj is GameHeroInfoViewModel gameHeroInfoViewModel))
			{
				return;
			}
			curHeroPoint.RedPoint = false;
			foreach (TabItemNormalData tag in gameHeroInfoViewModel.TagList)
			{
				if (tag.RedPoint)
				{
					curHeroPoint.RedPoint = true;
					break;
				}
			}
		}
	}

	private void OpenGameHeroInfoWindow(int id)
	{
		GameHeroInfoViewModel userData = new GameHeroInfoViewModel(this, id);
		openWindowRequest.Raise(new OpenViewArg(typeof(GameHeroInfoWindow), userData));
	}

	private void LoadPoint()
	{
		pointItemDataList = new List<MapPointItemData>();
		DRHeroNote[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRHeroNote>();
		Dictionary<int, HeroModel> allHeroData = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetAllHeroData();
		DRHeroNote[] array = allDataRow;
		foreach (DRHeroNote dRHeroNote in array)
		{
			Vector2 pos = default(Vector2);
			if (dRHeroNote.Position.Count >= 2)
			{
				pos = new Vector2(dRHeroNote.Position[0], dRHeroNote.Position[1]);
			}
			else
			{
				Toast.ShowError($"HeroNote表格ID:{dRHeroNote.Id}对应的Position数据错误");
			}
			bool flag = !allHeroData.ContainsKey(dRHeroNote.Id);
			MapPointItemData mapPointItemData = new MapPointItemData(this, dRHeroNote.Id, 8, dRHeroNote.Head, dRHeroNote.Name, pos, flag);
			bool redPoint = false;
			if (!flag)
			{
				redPoint = GetIsNew(dRHeroNote.Id);
			}
			mapPointItemData.SetRedPoint(redPoint);
			pointItemDataList.Add(mapPointItemData);
		}
	}

	private bool GetIsNew(int heroId)
	{
		if (redPointSaveDic.TryGetValue(heroId, out var value))
		{
			foreach (KeyValuePair<string, bool> item in value)
			{
				if (item.Value)
				{
					return true;
				}
			}
			HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(heroId);
			if (new HeroVoiceViewModel(null, heroById).CheckRed())
			{
				return true;
			}
		}
		return false;
	}

	public override void Close()
	{
		parent?.ItemOnClick(new OptionArg(this, "RedPoint"));
		base.Close();
	}
}
