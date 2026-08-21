using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class MapCaveViewModel : OptionBase
{
	public enum LocationTypeEnum
	{
		ConfigLocation,
		Player,
		TrackTask
	}

	private MapViewModel parentViewModel;

	private MapMode mapMode;

	private DRCavern caveData;

	private Vector2 mapSizeDelta;

	private bool showTabs;

	private bool showCaveMap;

	private MapAreaTabItemData levelTabItemData;

	private MapAreaTabItemData caveTabItemData;

	private InteractionRequest _onCaveDataChanged = new InteractionRequest();

	private InteractionRequest<InteractivePointData> _onPointClickRequest = new InteractionRequest<InteractivePointData>();

	private InteractionRequest _resetSelectStateRst = new InteractionRequest();

	private InteractionRequest<Vector2> _mapTweenMoveRst = new InteractionRequest<Vector2>();

	private bool showPlayerMark;

	private Vector2 _heroMarkPos;

	private Quaternion _heroMarkRotation;

	private Vector3 _heroWorldPos;

	private List<LevelSaveService.MapItemData> _mapItemDatas = new List<LevelSaveService.MapItemData>();

	private LocationTypeEnum locationType;

	private int locationArg;

	public bool ShowPlayerMark
	{
		get
		{
			return showPlayerMark;
		}
		set
		{
			Set(ref showPlayerMark, value, "ShowPlayerMark");
		}
	}

	public Vector2 HeroMarkPos
	{
		get
		{
			return _heroMarkPos;
		}
		set
		{
			Set(ref _heroMarkPos, value, "HeroMarkPos");
		}
	}

	public Quaternion HeroMarkRotation
	{
		get
		{
			return _heroMarkRotation;
		}
		set
		{
			Set(ref _heroMarkRotation, value, "HeroMarkRotation");
		}
	}

	public List<LevelSaveService.MapItemData> MapItemDatas => _mapItemDatas;

	public LocationTypeEnum LocationType => locationType;

	public int LocationArg => locationArg;

	public MapMode MapMode
	{
		get
		{
			return mapMode;
		}
		private set
		{
			mapMode = value;
		}
	}

	public DRCavern CaveData
	{
		get
		{
			return caveData;
		}
		private set
		{
			Set(ref caveData, value, "CaveData");
			MapSizeDelta = new Vector2((value.MapSize.Count > 0) ? value.MapSize[0] : 0f, (value.MapSize.Count > 1) ? value.MapSize[1] : 0f);
		}
	}

	public Vector2 MapSizeDelta
	{
		get
		{
			return mapSizeDelta;
		}
		private set
		{
			mapSizeDelta = value;
		}
	}

	public bool ShowTabs
	{
		get
		{
			return showTabs;
		}
		set
		{
			Set(ref showTabs, value, "ShowTabs");
		}
	}

	public bool ShowCaveMap
	{
		get
		{
			return showCaveMap;
		}
		set
		{
			Set(ref showCaveMap, value, "ShowCaveMap");
		}
	}

	public MapAreaTabItemData LevelTabItemData => levelTabItemData;

	public MapAreaTabItemData CaveTabItemData => caveTabItemData;

	public InteractionRequest OnCaveDataChanged => _onCaveDataChanged;

	public InteractionRequest<InteractivePointData> OnPointClickRequest => _onPointClickRequest;

	public InteractionRequest ResetSelectStateRst => _resetSelectStateRst;

	public InteractionRequest<Vector2> MapTweenMoveRst => _mapTweenMoveRst;

	public MapCaveViewModel()
	{
	}

	public MapCaveViewModel(MapViewModel parent, MapMode mapMode)
	{
		base.parent = parent;
		parentViewModel = parent;
		MapMode = mapMode;
		levelTabItemData = new MapAreaTabItemData(this);
		levelTabItemData.TaskTagAccurateLocate = true;
		caveTabItemData = new MapAreaTabItemData(this);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is MapAreaTabItemData mapAreaTabItemData)
		{
			if (mapAreaTabItemData.DrMap != null)
			{
				HideMap();
			}
			else if (mapAreaTabItemData.DrCavern != null)
			{
				Show(mapAreaTabItemData.DrCavern);
			}
		}
		else if (obj is MapGuidePointData mapGuidePointData)
		{
			_mapTweenMoveRst.Raise(mapGuidePointData.PointInfo.Pos);
		}
		else if (obj is InteractivePointData context)
		{
			_onPointClickRequest.Raise(context);
		}
		else
		{
			parentViewModel.ItemOnClick(obj);
		}
	}

	private void RefreshData(DRCavern drData, bool forceRefresh = false)
	{
		if (forceRefresh || CaveData == null || CaveData.Id != drData.Id)
		{
			CaveData = drData;
			DRMap dataRow = GameEntry.DataTable.GetDataRow<DRMap>(drData.LevelId);
			if (dataRow != null)
			{
				levelTabItemData.RefreshData(dataRow, 1);
			}
			caveTabItemData.RefreshData(drData);
			_onCaveDataChanged.Raise();
		}
	}

	public void Show(DRCavern drData = null, bool forceRefresh = false)
	{
		if (drData != null)
		{
			RefreshData(drData, forceRefresh);
		}
		UpdateHeroMark();
		ShowTabs = true;
		ShowCaveMap = true;
		levelTabItemData.IsSelected = false;
		caveTabItemData.IsSelected = true;
	}

	public void HideMap()
	{
		ShowCaveMap = false;
		levelTabItemData.IsSelected = true;
		caveTabItemData.IsSelected = false;
	}

	public void Hide()
	{
		ShowTabs = false;
		ShowCaveMap = false;
		levelTabItemData.IsSelected = false;
		caveTabItemData.IsSelected = false;
	}

	public void OpenMonsterInfoView(InteractivePointData pointItemData)
	{
		parentViewModel.OpenMonsterInfoView(pointItemData);
	}

	public void UpdateTabItemTags()
	{
		levelTabItemData?.UpdateTags();
		caveTabItemData?.UpdateTags();
	}

	private void UpdateHeroMark()
	{
		_heroWorldPos = parentViewModel.HeroWorldPos;
		HeroMarkRotation = parentViewModel.HeroMarkRotation;
		int num = CaveData?.Id ?? 0;
		ShowPlayerMark = parentViewModel.PlayerCaveId > 0 && parentViewModel.PlayerCaveId == num;
		UpdateHeroMarkPos();
	}

	private void UpdateHeroMarkPos()
	{
		Vector2 vector = new Vector2((CaveData.Cavernpoint.Count > 0) ? CaveData.Cavernpoint[0] : 0f, (CaveData.Cavernpoint.Count > 1) ? CaveData.Cavernpoint[1] : 0f);
		Vector2 vector2 = (new Vector2(_heroWorldPos.x, _heroWorldPos.z) - vector) * CaveData.MapSenceScale;
		HeroMarkPos = new Vector2(vector2.x, vector2.y - MapSizeDelta.y / 2f);
	}

	public void SetLocation(LocationTypeEnum type, int arg = 0)
	{
		locationType = type;
		locationArg = arg;
	}
}
