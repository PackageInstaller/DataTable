using System.Collections.Generic;

namespace Ase;

public class MapAreaTabItemData : ItemOptionBase
{
	private int _id;

	private string _name;

	private DRSectionMap _drSectionMap;

	private DRMap _drMap;

	private DRCavern _drCavern;

	private string tagIcon = "";

	private bool playerLocationTag;

	private bool disableAllTags;

	private bool _isSelected;

	private int tabIndex;

	private bool taskTagAccurateLocate;

	private MapAreaListViewModel _mapAreaListViewModel;

	private MapCaveViewModel _mapCaveViewModel;

	public bool TaskTagAccurateLocate
	{
		get
		{
			return taskTagAccurateLocate;
		}
		set
		{
			taskTagAccurateLocate = value;
		}
	}

	public int Id
	{
		get
		{
			return _id;
		}
		set
		{
			Set(ref _id, value, "Id");
		}
	}

	public string Name
	{
		get
		{
			return _name;
		}
		set
		{
			Set(ref _name, value, "Name");
		}
	}

	public string TagIcon
	{
		get
		{
			return tagIcon;
		}
		set
		{
			Set(ref tagIcon, value, "TagIcon");
		}
	}

	public bool PlayerLocationTag
	{
		get
		{
			return playerLocationTag;
		}
		set
		{
			Set(ref playerLocationTag, value, "PlayerLocationTag");
		}
	}

	public bool IsSelected
	{
		get
		{
			return _isSelected;
		}
		set
		{
			Set(ref _isSelected, value, "IsSelected");
			DisableAllTags = (_drSectionMap != null) & value;
		}
	}

	public bool DisableAllTags
	{
		get
		{
			return disableAllTags;
		}
		private set
		{
			Set(ref disableAllTags, value, "DisableAllTags");
		}
	}

	public int TabIndex
	{
		get
		{
			return tabIndex;
		}
		private set
		{
			Set(ref tabIndex, value, "TabIndex");
		}
	}

	public DRCavern DrCavern => _drCavern;

	public DRMap DrMap => _drMap;

	public DRSectionMap DrSectionMap => _drSectionMap;

	public MapAreaTabItemData()
	{
	}

	public MapAreaTabItemData(MapAreaListViewModel parent, DRSectionMap drSectionMap, int tabIndex)
	{
		base.parent = parent;
		_mapAreaListViewModel = parent;
		_drSectionMap = drSectionMap;
		Id = drSectionMap.Id;
		Name = drSectionMap.Name;
		TabIndex = tabIndex;
		UpdateTags();
	}

	public MapAreaTabItemData(MapAreaListViewModel parent, DRMap drMap, int tabIndex)
	{
		base.parent = parent;
		_mapAreaListViewModel = parent;
		RefreshData(drMap, tabIndex);
	}

	public MapAreaTabItemData(MapCaveViewModel parent)
	{
		base.parent = parent;
		_mapCaveViewModel = parent;
	}

	public void RefreshData(DRCavern drCavern)
	{
		_drCavern = drCavern;
		Id = drCavern.Id;
		Name = drCavern.CavernName;
		TabIndex = drCavern.Id;
		UpdateTags();
	}

	public void RefreshData(DRMap drMap, int tabIndex)
	{
		_drMap = drMap;
		Id = drMap.Id;
		Name = drMap.Name;
		TabIndex = tabIndex;
		UpdateTags();
	}

	public void UpdateTags()
	{
		UpdateTaskTag();
		UpdatePlayerLocationTag();
	}

	private void UpdateTaskTag()
	{
		List<TaskDataViewModel> list = null;
		ITaskServices service = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>();
		if (_drMap != null)
		{
			list = service.FilterTrackingTask(service.GetDisplayLevelTask(_drMap.Id));
			if (TaskTagAccurateLocate)
			{
				list.RemoveAll((TaskDataViewModel p) => p.CaveId > 0);
			}
		}
		else if (_drSectionMap != null)
		{
			List<TaskDataViewModel> allUnFinishedDisplayTask = service.GetAllUnFinishedDisplayTask();
			list = service.FilterTrackingTask(allUnFinishedDisplayTask.FindAll((TaskDataViewModel p) => p.SectionId == _drSectionMap.Id));
		}
		else if (_drCavern != null)
		{
			list = service.FilterTrackingTask(service.GetDisplayTaskInCave(_drCavern.Id));
		}
		if (list == null || list.Count <= 0)
		{
			TagIcon = string.Empty;
			return;
		}
		int num = -1;
		foreach (TaskDataViewModel item in list)
		{
			if (item.TrackState)
			{
				List<TaskPosition> taskPosition = item.GetTaskPosition();
				if (taskPosition != null && taskPosition.Count > 0 && (num < 0 || item.TaskType < num))
				{
					num = item.TaskType;
				}
			}
		}
		switch (num)
		{
		case 1:
			TagIcon = "task_mark_1";
			break;
		case 2:
			TagIcon = "task_mark_2";
			break;
		case 3:
			TagIcon = "task_mark_3";
			break;
		default:
			TagIcon = string.Empty;
			break;
		}
	}

	private void UpdatePlayerLocationTag()
	{
		if (_mapAreaListViewModel == null)
		{
			return;
		}
		if (_mapAreaListViewModel.ParentMapViewModel.MapMode == MapMode.Outer)
		{
			PlayerLocationTag = false;
		}
		else if (_mapAreaListViewModel.ParentMapViewModel.MapMode == MapMode.Level)
		{
			int playerLevelId = _mapAreaListViewModel.ParentMapViewModel.PlayerLevelId;
			DRMap dataRow = GameEntry.DataTable.GetDataRow<DRMap>(playerLevelId);
			if (dataRow == null)
			{
				PlayerLocationTag = false;
			}
			else if (_drSectionMap != null)
			{
				PlayerLocationTag = dataRow.MapId == _drSectionMap.Id;
			}
			else if (_drMap != null)
			{
				PlayerLocationTag = dataRow.Id == _drMap.Id;
			}
		}
	}

	public void OnItemClick()
	{
		parent?.ItemOnClick(this);
	}
}
