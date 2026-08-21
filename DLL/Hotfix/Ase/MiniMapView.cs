#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using Sirenix.Utilities;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MiniMapView : UGuiView
{
	[SerializeField]
	private Image mapBg;

	[SerializeField]
	private RectTransform mapItemRoot;

	[SerializeField]
	private RectTransform tpPointRoot;

	[SerializeField]
	private RectTransform cavePointRoot;

	[SerializeField]
	private RectTransform taskUnderMaskRoot;

	[SerializeField]
	private RectTransform taskRoot;

	[SerializeField]
	private RectTransform trackRoot;

	[SerializeField]
	private RectTransform overlayRoot;

	[SerializeField]
	protected RectTransform mapPrefabRoot;

	[SerializeField]
	private GameObject mapMarkItem;

	[SerializeField]
	private GameObject caveTrackMarkItem;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private RectTransform scrollRect;

	[SerializeField]
	private RectTransform map;

	private string mapPrefabAssetPath;

	private GameObject mapPrefab;

	private string mapMaskAssetPath;

	private string mapMaskAlphaAssetPath;

	[SerializeField]
	private RectTransform markRoot;

	[SerializeField]
	private RectTransform content;

	[SerializeField]
	private MapMarkItemViewBase captain;

	[SerializeField]
	private Image _heroIcon;

	[SerializeField]
	private Image _heroDir;

	[SerializeField]
	private MapMaskTest mapMask;

	[SerializeField]
	private Vector2 outline;

	[SerializeField]
	private Vector2 softMaskOutline;

	[SerializeField]
	private Image softMaskImage;

	[SerializeField]
	private Image scImage;

	[SerializeField]
	private Image vPImage;

	[SerializeField]
	private CanvasGroup mapCanvasGroup;

	[SerializeField]
	private CanvasGroup overlayCanvasGroup;

	[SerializeField]
	private CanvasGroup markRootCanvasGroup;

	[SerializeField]
	private CanvasGroup mapGridCanvasGroup;

	[SerializeField]
	private CanvasGroup mapPrefabCanvasGroup;

	[SerializeField]
	private GameObject emptyClick;

	private GameObjectPool tpMarkPool;

	private GameObjectPool bossMonsterMarkPool;

	private GameObjectPool mapItemPool;

	private GameObjectPool taskUnderMaskPool;

	private GameObjectPool taskMarkPool;

	private GameObjectPool cavePointMarkPool;

	private GameObjectPool trackMarkPool;

	private GameObjectPool caveTrackMarkPool;

	private Vector2 scrollRectSizeRadis;

	private Vector2 uvRatio;

	private MiniMapViewModel viewModel;

	private const string HeroIconPath = "MiniMap/player_mark.png";

	private const string HeroDirPath = "MiniMap/player_mark_dir.png";

	private string assetTag = "MiniMapView";

	public async Task Init(MiniMapViewModel viewModel)
	{
		tpMarkPool = new GameObjectPool(mapMarkItem, tpPointRoot);
		taskMarkPool = new GameObjectPool(mapMarkItem, taskRoot);
		taskUnderMaskPool = new GameObjectPool(mapMarkItem, taskUnderMaskRoot);
		bossMonsterMarkPool = new GameObjectPool(mapMarkItem, mapItemRoot);
		mapItemPool = new GameObjectPool(mapMarkItem, mapItemRoot);
		cavePointMarkPool = new GameObjectPool(mapMarkItem, cavePointRoot);
		trackMarkPool = new GameObjectPool(mapMarkItem, overlayRoot);
		caveTrackMarkPool = new GameObjectPool(caveTrackMarkItem, overlayRoot);
		this.viewModel = viewModel;
		BindingSet<MiniMapView, MiniMapViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(this).For((MiniMapView v) => v.OpenWindow).To((MiniMapViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(captain.RectTransform).For((RectTransform v) => v.rotation).To((MiniMapViewModel vm) => vm.CaptainRotation);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((MiniMapViewModel vm) => vm.OpenMapCmd);
		viewModel.UpdateContentPosAction = (Action)Delegate.Combine(viewModel.UpdateContentPosAction, new Action(UpdateContentPos));
		viewModel.UpdateMarkFollowPosAction = (Action)Delegate.Combine(viewModel.UpdateMarkFollowPosAction, new Action(UpdateMarkFollowPos));
		bindingSet.Bind().For((MiniMapView v) => v.RefreshAllMapItemMark).To((MiniMapViewModel vm) => vm.RefreshAllMapItemRst);
		bindingSet.Bind().For((MiniMapView v) => v.AddMapItemMark).To((MiniMapViewModel vm) => vm.AddMapItemRst);
		bindingSet.Bind().For((MiniMapView v) => v.RefreshTpMarks).To((MiniMapViewModel vm) => vm.RefreshTpMarkDatas);
		bindingSet.Bind().For((MiniMapView v) => v.RefreshTaskMarks).To((MiniMapViewModel vm) => vm.RefreshTaskMarkDatas);
		bindingSet.Bind().For((MiniMapView v) => v.RefreshTrackMarks).To((MiniMapViewModel vm) => vm.RefreshTrackMarkDatas);
		bindingSet.Bind().For((MiniMapView v) => v.RefreshBossMonsterMarks).To((MiniMapViewModel vm) => vm.RefreshBossMonsterMarkDatas);
		bindingSet.Bind().For((MiniMapView v) => v.RefreshCavePointMarks).To((MiniMapViewModel vm) => vm.RefreshCavePointMarks);
		bindingSet.Bind().For((MiniMapView v) => v.UpdateMapMaskData).To((MiniMapViewModel vm) => vm.UpdateMapMaskDataRst);
		bindingSet.Bind().For((MiniMapView v) => v.RefreshMap).To((MiniMapViewModel vm) => vm.RefreshMapDataRst);
		bindingSet.Build();
		mapMask.Init();
		captain.Init(viewModel.HeroMark, null, null);
		Image heroIcon = _heroIcon;
		heroIcon.sprite = await GameEntry.Resource.LoadSpriteAsync(AssetUtility.GetTextureIconSprite("MiniMap/player_mark.png"), assetTag);
		heroIcon = _heroDir;
		heroIcon.sprite = await GameEntry.Resource.LoadSpriteAsync(AssetUtility.GetTextureIconSprite("MiniMap/player_mark_dir.png"), assetTag);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		RefreshMap();
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		mapMask.SetMaskTexture(null);
		if (!string.IsNullOrEmpty(mapMaskAssetPath))
		{
			GameEntry.Resource.UnloadAsset(AssetUtility.GetTextureAsset(mapMaskAssetPath));
			mapMaskAssetPath = string.Empty;
		}
		if (!string.IsNullOrEmpty(mapMaskAlphaAssetPath))
		{
			GameEntry.Resource.UnloadAsset(AssetUtility.GetTextureAsset(mapMaskAlphaAssetPath));
			mapMaskAlphaAssetPath = string.Empty;
		}
	}

	private async void RefreshMap(object sender = null, InteractionEventArgs e = null)
	{
		if (viewModel?.mapConfig == null || string.IsNullOrEmpty(viewModel.mapConfig.MiniMapPath))
		{
			return;
		}
		MapConfigData mapConfigData = viewModel.mapConfig;
		Vector2 mapSize = new Vector2((mapConfigData.MapSize.Count > 0) ? mapConfigData.MapSize[0] : 0f, (mapConfigData.MapSize.Count > 1) ? mapConfigData.MapSize[1] : 0f);
		try
		{
			DisposeMapPrefab();
			mapPrefabAssetPath = mapConfigData.MapPrefabPath;
			GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIFormAsset(mapPrefabAssetPath), mapPrefabRoot);
			if (gameObject != null)
			{
				mapPrefab = gameObject;
			}
		}
		catch (Exception message)
		{
			Log.Error(message);
		}
		if (!string.IsNullOrEmpty(mapMaskAssetPath))
		{
			GameEntry.Resource.UnloadAsset(AssetUtility.GetTextureAsset(mapMaskAssetPath));
			mapMaskAssetPath = string.Empty;
		}
		mapMaskAssetPath = viewModel.mapConfig.MapMaskPath;
		if (!string.IsNullOrEmpty(mapMaskAlphaAssetPath))
		{
			GameEntry.Resource.UnloadAsset(AssetUtility.GetTextureAsset(mapMaskAlphaAssetPath));
			mapMaskAlphaAssetPath = string.Empty;
		}
		mapMaskAlphaAssetPath = viewModel.mapConfig.MaskAlphaPath;
		UpdateMapParam(mapSize, map.localScale, mapConfigData.MapSenceScale, mapConfigData.MapPosOffset);
		if (mapConfigData.MapType == MapConfigData.MapTypeEnum.LevelMap)
		{
			UpdateMapMask(mapSize);
		}
		else if (mapConfigData.MapType == MapConfigData.MapTypeEnum.CaveMap)
		{
			((Component)(object)mapMask).gameObject.SetActive(value: false);
		}
	}

	private void UpdateMapParam(Vector2 mapSize, Vector3 mapScale, float sceneToUiRatio, Vector2 mapOffset)
	{
		markRoot.sizeDelta = mapSize;
		markRoot.localScale = mapScale;
		overlayRoot.sizeDelta = mapSize;
		overlayRoot.localScale = mapScale;
		content.sizeDelta = mapSize * mapScale + scrollRect.rect.size + outline;
		scrollRectSizeRadis = Vector2.one * scrollRect.rect.size.x / 2f;
		viewModel.UpdateMapParam(mapSize, sceneToUiRatio, mapOffset);
		viewModel.UpdateMapMarks();
	}

	private async void UpdateMapMask(Vector2 mapSize)
	{
		Image maskImage = ((Component)(object)mapMask).GetComponent<Image>();
		if (maskImage != null)
		{
			Sprite sprite = await GameEntry.Resource.LoadSpriteAsync(AssetUtility.GetTextureAsset(mapMaskAssetPath), assetTag);
			if (sprite == null)
			{
				((Component)(object)mapMask).gameObject.SetActive(value: false);
				return;
			}
			maskImage.sprite = sprite;
			maskImage.rectTransform.sizeDelta = mapSize;
			mapBg.sprite = maskImage.sprite;
		}
		Texture texture = await GameEntry.Resource.LoadAssetAsync<Texture>(AssetUtility.GetTextureAsset(mapMaskAlphaAssetPath));
		if (texture == null)
		{
			((Component)(object)mapMask).gameObject.SetActive(value: false);
			return;
		}
		mapMask.SetMaskTexture(texture);
		mapMask.SetMatTexelSize(new Vector4(mapSize.x / 2f, mapSize.y / 2f, 1f, 1f));
		UpdateMapMaskData();
		((Component)(object)mapMask).gameObject.SetActive(value: true);
		CancelInvoke("SetMapMask");
		Invoke("SetMapMask", 0.1f);
	}

	private void SetMapMask()
	{
		((Component)(object)mapMask).gameObject.SetActive(value: false);
		StopCoroutine(RefreshMapMaskVisible());
		StartCoroutine(RefreshMapMaskVisible());
	}

	private IEnumerator RefreshMapMaskVisible()
	{
		yield return new WaitForEndOfFrame();
		((Component)(object)mapMask).gameObject.SetActive(value: false);
		((Component)(object)mapMask).gameObject.SetActive(value: true);
	}

	private void UpdateMapMaskData(object sender = null, InteractionEventArgs e = null)
	{
		int[,] mapMaskData = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetMapMaskData(viewModel.mapConfig.Id);
		if (mapMaskData != null)
		{
			mapMaskData.GetLength(0);
			mapMaskData.GetLength(1);
			mapMask.SetMaskData(mapMaskData);
		}
	}

	private void RefreshTpMarks(object sender, InteractionEventArgs e)
	{
		tpMarkPool.RecycleAll();
		if (viewModel.TpMarkViewModels == null)
		{
			return;
		}
		foreach (MapMarkItemViewModel tpMarkViewModel in viewModel.TpMarkViewModels)
		{
			MapMarkItemViewBase component = tpMarkPool.Allocate(out var newCreate).GetComponent<MapMarkItemViewBase>();
			if (newCreate)
			{
				component.Init(tpMarkViewModel, tpPointRoot, overlayRoot);
			}
			else
			{
				component.RefreshData(tpMarkViewModel);
			}
		}
	}

	private void RefreshTaskMarks(object sender = null, InteractionEventArgs e = null)
	{
		taskMarkPool.RecycleAll();
		taskUnderMaskPool.RecycleAll();
		ITaskServices service = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>();
		if (service == null || viewModel.TaskMarkViewModels == null || viewModel.TaskMarkViewModels.Count <= 0)
		{
			return;
		}
		foreach (MapMarkItemViewModel taskMarkViewModel in viewModel.TaskMarkViewModels)
		{
			TaskDataViewModel task = service.GetTask(taskMarkViewModel.Id);
			if (task == null)
			{
				continue;
			}
			bool flag = !task.IsShowInTaskUI();
			GameObject gameObject = (flag ? taskUnderMaskPool.Allocate(out var newCreate) : taskMarkPool.Allocate(out newCreate));
			if (gameObject.SafeIsUnityNull())
			{
				continue;
			}
			MapMarkItemViewBase component = gameObject.GetComponent<MapMarkItemViewBase>();
			if (!(component == null))
			{
				if (newCreate)
				{
					component.Init(taskMarkViewModel, flag ? taskUnderMaskRoot : taskRoot, overlayRoot);
				}
				else
				{
					component.RefreshData(taskMarkViewModel);
				}
			}
		}
	}

	private void RefreshTrackMarks(object sender = null, InteractionEventArgs e = null)
	{
		trackMarkPool.RecycleAll();
		caveTrackMarkPool.RecycleAll();
		if (viewModel.TrackMarkItemDatas == null || viewModel.TrackMarkItemDatas.Count <= 0)
		{
			return;
		}
		foreach (MapMarkItemViewModel trackMarkItemData in viewModel.TrackMarkItemDatas)
		{
			MapMarkItemViewBase mapMarkItemViewBase = null;
			bool newCreate = false;
			mapMarkItemViewBase = ((trackMarkItemData.MarkType != MapMarkItemViewModel.MarkTypeEnum.CavePoint) ? trackMarkPool.Allocate(out newCreate).GetComponent<MapMarkItemViewBase>() : caveTrackMarkPool.Allocate(out newCreate).GetComponent<MapMarkItemViewBase>());
			if (newCreate)
			{
				mapMarkItemViewBase.Init(trackMarkItemData, trackRoot, overlayRoot);
			}
			else
			{
				mapMarkItemViewBase.RefreshData(trackMarkItemData);
			}
		}
		UpdateMarkFollowPos();
	}

	private void RefreshBossMonsterMarks(object sender, InteractionEventArgs e)
	{
		bossMonsterMarkPool.RecycleAll();
		if (viewModel.BossMonsterViewModels == null)
		{
			return;
		}
		foreach (MapMarkItemViewModel bossMonsterViewModel in viewModel.BossMonsterViewModels)
		{
			MapMarkItemViewBase component = bossMonsterMarkPool.Allocate(out var newCreate).GetComponent<MapMarkItemViewBase>();
			if (newCreate)
			{
				component.Init(bossMonsterViewModel, mapItemRoot, overlayRoot);
			}
			else
			{
				component.RefreshData(bossMonsterViewModel);
			}
		}
	}

	private void RefreshCavePointMarks(object sender, InteractionEventArgs e)
	{
		cavePointMarkPool.RecycleAll();
		if (viewModel.CavePointViewModels == null)
		{
			return;
		}
		foreach (MapMarkItemViewModel cavePointViewModel in viewModel.CavePointViewModels)
		{
			MapMarkItemViewBase component = cavePointMarkPool.Allocate(out var newCreate).GetComponent<MapMarkItemViewBase>();
			if (newCreate)
			{
				component.Init(cavePointViewModel, cavePointRoot, overlayRoot);
			}
			else
			{
				component.RefreshData(cavePointViewModel);
			}
		}
	}

	private void UpdateContentPos()
	{
		Vector2 pos = viewModel.HeroMark.Pos;
		content.anchoredPosition = -pos;
		overlayRoot.anchoredPosition = -pos;
	}

	private void UpdateMarkFollowPos()
	{
		viewModel.UpdateMarkFollowPos(-content.anchoredPosition, scrollRectSizeRadis - softMaskOutline, markRoot.localScale);
	}

	private void RefreshAllMapItemMark(object sender = null, InteractionEventArgs e = null)
	{
		mapItemPool.RecycleAll();
		Dictionary<LevelSaveService.MapItemData, MapMarkItemViewModel> mapItemMarkViewModels = viewModel.MapItemMarkViewModels;
		if (mapItemMarkViewModels == null)
		{
			return;
		}
		foreach (MapMarkItemViewModel value in mapItemMarkViewModels.Values)
		{
			MapMarkItemViewBase component = mapItemPool.Allocate(out var _).GetComponent<MapMarkItemViewBase>();
			component.ClearAllBindings();
			component.Init(value, mapItemRoot, overlayRoot);
		}
	}

	private void AddMapItemMark(object sender, InteractionEventArgs e)
	{
		MapMarkItemViewModel mapMarkItemViewModel = (MapMarkItemViewModel)e.Context;
		MapMarkItemViewBase component = mapItemPool.Allocate(out var _).GetComponent<MapMarkItemViewBase>();
		component.ClearAllBindings();
		component.Init(mapMarkItemViewModel, mapItemRoot, overlayRoot);
	}

	private async void OpenWindow(object sender, InteractionEventArgs e)
	{
		Action callback = e.Callback;
		object context = e.Context;
		Window w = null;
		if (context is MapViewModel)
		{
			w = await GameEntry.UI.OpenWindow<MapWindow>("Battle/MapWindow", context);
		}
		if (w != null)
		{
			w.OnDismissed += Handler;
		}
		void Handler(object window, EventArgs args)
		{
			w.OnDismissed -= Handler;
			callback();
		}
	}

	private void DisposeMapPrefab()
	{
		if (mapPrefab != null)
		{
			UnityEngine.Object.DestroyImmediate(mapPrefab);
			mapPrefab = null;
		}
	}

	protected override void OnDestroy()
	{
		mapItemPool?.Dispose();
		mapItemPool = null;
		tpMarkPool?.Dispose();
		tpMarkPool = null;
		trackMarkPool?.Dispose();
		trackMarkPool = null;
		caveTrackMarkPool?.Dispose();
		caveTrackMarkPool = null;
		bossMonsterMarkPool?.Dispose();
		bossMonsterMarkPool = null;
		cavePointMarkPool?.Dispose();
		cavePointMarkPool = null;
		DisposeMapPrefab();
		MiniMapViewModel miniMapViewModel = viewModel;
		miniMapViewModel.UpdateContentPosAction = (Action)Delegate.Remove(miniMapViewModel.UpdateContentPosAction, new Action(UpdateContentPos));
		MiniMapViewModel miniMapViewModel2 = viewModel;
		miniMapViewModel2.UpdateMarkFollowPosAction = (Action)Delegate.Remove(miniMapViewModel2.UpdateMarkFollowPosAction, new Action(UpdateMarkFollowPos));
		_heroIcon.sprite = null;
		_heroDir.sprite = null;
		GameEntry.Resource.UnLoadSpriteGroup(assetTag);
		base.OnDestroy();
	}

	public void SetMininMapState(bool isShow)
	{
		softMaskImage.enabled = isShow;
		scImage.enabled = isShow;
		vPImage.enabled = isShow;
		float alpha = (isShow ? 1 : 0);
		mapCanvasGroup.alpha = alpha;
		overlayCanvasGroup.alpha = alpha;
		markRootCanvasGroup.alpha = alpha;
		mapGridCanvasGroup.alpha = alpha;
		mapPrefabCanvasGroup.alpha = alpha;
		emptyClick.SetActive(!isShow);
	}
}
