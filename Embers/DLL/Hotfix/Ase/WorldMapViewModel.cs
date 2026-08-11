using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Ase;

public class WorldMapViewModel : OptionBase
{
	private Scene _worldMapScene;

	private MapSceneController _mapManager;

	private DRWorldMap _drWorldMap;

	private InteractionRequest _refreshMapDataRequest;

	private InteractionRequest closeMapWorldSceneRequest = new InteractionRequest();

	private SimpleCommand<OptionArg> _openWindowCmd;

	private string mapAssetPath;

	private int worldId;

	public float RadialBlurDuration;

	public float CameraFovDiff;

	public MapSceneController MapManager => _mapManager;

	public DRWorldMap DrWorldMap { get; private set; }

	public InteractionRequest RefreshMapDataRequest => _refreshMapDataRequest;

	public InteractionRequest CloseMapWorldSceneRequest => closeMapWorldSceneRequest;

	public WorldMapViewModel()
	{
	}

	public WorldMapViewModel(OptionBase parent, int worldId)
	{
		base.parent = parent;
		_refreshMapDataRequest = new InteractionRequest();
		_openWindowCmd = new SimpleCommand<OptionArg>(OpenWindow);
		this.worldId = worldId;
		Refresh(worldId);
	}

	public void Refresh(int worldMapId, bool force = false)
	{
		if (force || DrWorldMap == null || !DrWorldMap.Id.Equals(worldMapId))
		{
			DrWorldMap = GameEntry.DataTable.GetDataRow<DRWorldMap>(worldMapId);
			RefreshWorldMapScene(DrWorldMap, delegate
			{
				RefreshMapDataRequest.Raise();
			});
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is DRSectionMap drSectionMap)
		{
			OpenLevelMapWindow(drSectionMap);
		}
		else if (obj is BattleSelectResult obj2)
		{
			parent?.ItemOnClick(obj2);
		}
		else if (obj.Equals("CloseMapWorldScene"))
		{
			closeMapWorldSceneRequest.Raise();
		}
	}

	public void OpenTaskMainWindow()
	{
		List<TaskDataViewModel> allTask = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetAllTask();
		TaskRedPointData redPoint = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetRedPoint();
		TaskMainViewModel obj = new TaskMainViewModel(this, redPoint, allTask);
		_openWindowCmd.Execute(new OptionArg(obj, "OpenWindow"));
	}

	private void OpenLevelMapWindow(DRSectionMap drSectionMap)
	{
		IMapService service = Singleton<ServiceSystem>.Instance.GetService<IMapService>();
		if (!service.GetSectionOpenState(drSectionMap.Id))
		{
			Toast.ShowInfo("章节未解锁");
			return;
		}
		int latestLevelInSection = service.GetLatestLevelInSection(drSectionMap.Id);
		MapViewModel mapViewModel = new MapViewModel(this, MapMode.Outer, latestLevelInSection);
		_mapManager.StartRadialBlur(RadialBlurDuration, CameraFovDiff, delegate
		{
			_openWindowCmd.Execute(new OptionArg(mapViewModel, null));
		});
	}

	public void Back2MainWindow()
	{
		OptionBase optionBase = this;
		while (optionBase != null && !(optionBase is MainViewModel))
		{
			optionBase.Close();
			optionBase = optionBase.Parent;
		}
	}

	private void OpenWindow(OptionArg optionArg)
	{
		_openWindowCmd.Enabled = false;
		if (optionArg.Obj is MapViewModel userData)
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(MapWindow), userData), delegate
			{
				if (_mapManager != null)
				{
					_mapManager.Refresh();
				}
				_openWindowCmd.Enabled = true;
			});
		}
		else if (optionArg.Obj is TaskMainViewModel userData2)
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(TaskMainWindow), userData2), delegate
			{
				_openWindowCmd.Enabled = true;
			});
		}
	}

	private async void RefreshWorldMapScene(DRWorldMap drWorldMap, Action callback = null)
	{
		_mapManager = UnityEngine.Object.FindObjectOfType<MapSceneController>();
		if (!(_mapManager == null))
		{
			_mapManager.Init(drWorldMap);
			callback?.Invoke();
		}
	}

	public async void ClearWorldMapScene(string sceneName = null)
	{
		if (_mapManager != null)
		{
			_mapManager.Dispose();
			_mapManager = null;
		}
	}
}
