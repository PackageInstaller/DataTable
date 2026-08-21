using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.Pool;
using UnityEngine.UI;

namespace Ase;

public class BoardHeroChangeView : UGuiView
{
	[SerializeField]
	private TabItem tabHero;

	[SerializeField]
	private TabItem tabBg;

	[SerializeField]
	private LoopListView2 spineListView;

	[SerializeField]
	private LoopGridView heroGridView;

	[SerializeField]
	private BoardChangeItem bgDefaultItem;

	[SerializeField]
	private LoopGridView bgGridView;

	[SerializeField]
	private RectTransform outerRoot;

	private GameObject _outerBg;

	[SerializeField]
	private Transform innerRoot;

	private GameObject _innerBg;

	[SerializeField]
	private RectTransform spineRoot;

	[SerializeField]
	private Button btnSave;

	[SerializeField]
	private GameObject maskGrey;

	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private GameObject heroSpineLayoutPanel;

	[SerializeField]
	private Button previewBGBtn;

	[SerializeField]
	private GameObject previewViewRoot;

	[SerializeField]
	private GameObject viewLeftRoot;

	[SerializeField]
	private GameObject viewRightRoot;

	[SerializeField]
	private Button adjustBtn;

	[SerializeField]
	private PosterGirlAdjustView posterGirlAdjustView;

	[SerializeField]
	private GameObject posterGirlAdjustViewObj;

	private BoardHeroChangeData _viewModel;

	private string heroAssetPath;

	private string bgAssetPath;

	private int curBoardHeroIndex = -1;

	private int curSpineItemIndex = -1;

	private List<string> _loadedSpine;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		if (_loadedSpine == null)
		{
			_loadedSpine = CollectionPool<List<string>, string>.Get();
		}
		_loadedSpine.Clear();
		_viewModel = GetUserData<BoardHeroChangeData>(userData);
		BindingSet<BoardHeroChangeView, BoardHeroChangeData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((BoardHeroChangeView v) => v.OnDestroyRaised).To((BoardHeroChangeData vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((BoardHeroChangeView v) => ((UGuiView)v).OnVisibleChanged).To((BoardHeroChangeData vm) => vm.VisibleRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((BoardHeroChangeData vm) => vm.Hide);
		bindingSet.Bind(btnSave.gameObject).For((GameObject v) => v.activeSelf).To((BoardHeroChangeData vm) => vm.CanSave);
		bindingSet.Bind(maskGrey).For((GameObject v) => v.activeSelf).ToExpression((BoardHeroChangeData vm) => !vm.CanSave);
		bindingSet.Bind().For((BoardHeroChangeView v) => OnTabChanged).To((BoardHeroChangeData vm) => vm.ChangeTabRst);
		bindingSet.Bind().For((BoardHeroChangeView v) => RefreshHeroGridView).To((BoardHeroChangeData vm) => vm.RefreshHeroListRst);
		bindingSet.Bind().For((BoardHeroChangeView v) => RefreshSpineListView).To((BoardHeroChangeData vm) => vm.RefreshSpineListRst);
		bindingSet.Bind().For((BoardHeroChangeView v) => RefreshSpine).To((BoardHeroChangeData vm) => vm.RefreshSpineRst);
		bindingSet.Bind().For((BoardHeroChangeView v) => RefreshBg).To((BoardHeroChangeData vm) => vm.RefreshBgRst);
		bindingSet.Bind(btnSave).For((Button v) => v.onClick).To((BoardHeroChangeData vm) => vm.SaveCmd);
		bindingSet.Bind(adjustBtn).For((Button v) => v.onClick).To((BoardHeroChangeData vm) => vm.AdjustCmd);
		bindingSet.Bind().For((BoardHeroChangeView v) => v.AdjustViewAlpha).To((BoardHeroChangeData vm) => vm.AdjustViewBtnRst);
		bindingSet.Bind().For((BoardHeroChangeView v) => v.OnPreviewAlphaChanged).To((BoardHeroChangeData vm) => vm.PreviewAlphaRst);
		bindingSet.Bind().For((BoardHeroChangeView v) => v.OnRebindSpine).To((BoardHeroChangeData vm) => vm.RebindSpineRst);
		bindingSet.Build();
		bgDefaultItem.Init(_viewModel.BgDefaultModeItemData);
		previewBGBtn.onClick.AddListener(ShowBoardHeroChangeView);
		posterGirlAdjustView.Init(_viewModel.PosterGirlAdjustVM);
		posterGirlAdjustView.SetParentView(this);
		InitBgGridView();
		InitSpineListView();
		InitHeroGridView();
		tabHero.Init(new TabItemData(_viewModel, 1));
		tabBg.Init(new TabItemData(_viewModel, 2));
		tabHero.ViewModel.TabOnClick();
		RefreshBgAndHeroSpine();
		RefreshOuterPosAndScale();
		OnTabChanged();
	}

	public void RequestEnterMainPreview()
	{
		_viewModel?.SetPreviewTransformData(BuildCurrentPreviewTransformData());
		_viewModel?.Parent?.ItemOnClick(new OptionArg(_viewModel, "BoardHeroPreviewEnter"));
	}

	private void OnPreviewAlphaChanged(object sender, InteractionEventArgs e)
	{
		bool flag = default(bool);
		int num;
		if (e != null)
		{
			object context = e.Context;
			if (context is bool)
			{
				flag = (bool)context;
				num = 1;
			}
			else
			{
				num = 0;
			}
		}
		else
		{
			num = 0;
		}
		bool flag2 = (byte)((uint)num & (flag ? 1u : 0u)) != 0;
		if ((UnityEngine.Object)(object)CanvasGroup != null)
		{
			CanvasGroup.alpha = (flag2 ? 1f : 0f);
			CanvasGroup.blocksRaycasts = flag2;
		}
	}

	private void OnRebindSpine(object sender, InteractionEventArgs e)
	{
		SetHeroSpine();
		int num = GetCurrentBoardHeroConfig()?.Id ?? 0;
		if (num > 0 && _viewModel != null && _viewModel.TryGetPreviewTransformData(num, out var data))
		{
			ApplyPreviewTransformData(data);
			_viewModel.ClearPreviewTransformData();
		}
	}

	private void ShowBoardHeroChangeView()
	{
		previewViewRoot.SetActive(value: true);
		posterGirlAdjustViewObj.SetActive(value: true);
	}

	public void HideBoardHeroChangeView()
	{
		previewViewRoot.SetActive(value: false);
		posterGirlAdjustViewObj.SetActive(value: false);
	}

	private void AdjustViewAlpha(object sender = null, InteractionEventArgs e = null)
	{
		posterGirlAdjustViewObj.SetActive(value: true);
		viewLeftRoot.SetActive(value: false);
		viewRightRoot.SetActive(value: false);
		posterGirlAdjustView.RefreshAdjustSliderForCurrentHero();
	}

	public void ShowViewLeftAndRightRoot()
	{
		viewLeftRoot.SetActive(value: true);
		viewRightRoot.SetActive(value: true);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		RefreshList();
		RefreshBgAndHeroSpine();
	}

	protected override void OnVisibleChanged(object sender, InteractionEventArgs e)
	{
		bool flag = (bool)e.Context;
		if ((UnityEngine.Object)(object)CanvasGroup != null)
		{
			CanvasGroup.alpha = (flag ? 1 : 0);
			CanvasGroup.blocksRaycasts = flag;
		}
	}

	private void GetCurBoardHeroIndex()
	{
		BoardHeroData boardHeroData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().BoardHeroData;
		DRBoardHeroList drBoardHeroList = GameEntry.DataTable.GetDataRow<DRBoardHeroList>(boardHeroData.BoardHeroId);
		curBoardHeroIndex = ((drBoardHeroList != null) ? _viewModel.HeroIdList.FindIndex((int p) => p == drBoardHeroList.HeroId) : 0);
	}

	private void InitHeroGridView()
	{
		GetCurBoardHeroIndex();
		heroGridView.InitGridView(_viewModel.HeroIdList.Count, OnGetHeroItemByIndex);
		if (curBoardHeroIndex >= 0)
		{
			heroGridView.MovePanelToItemByIndex(curBoardHeroIndex);
		}
	}

	protected LoopGridViewItem OnGetHeroItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= _viewModel.HeroIdList.Count)
		{
			return null;
		}
		int num = _viewModel.HeroIdList[index];
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("BoardHeroItem");
		if (loopGridViewItem != null)
		{
			BoardHeroItemData boardHeroItemData = new BoardHeroItemData(_viewModel, num);
			BoardHeroItem component = loopGridViewItem.GetComponent<BoardHeroItem>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(boardHeroItemData);
			}
			else
			{
				component.RefreshData(boardHeroItemData);
			}
			if (curBoardHeroIndex >= 0 && index == curBoardHeroIndex)
			{
				boardHeroItemData.SetShowCustomTag(value: true);
			}
			if (_viewModel.CurSelectHeroItemData == null)
			{
				if (curBoardHeroIndex >= 0 && index == curBoardHeroIndex)
				{
					_viewModel.SetHeroItemSelected(boardHeroItemData);
				}
			}
			else
			{
				boardHeroItemData.SetSelected(num == _viewModel.CurSelectHeroItemData.HeroId);
			}
		}
		return loopGridViewItem;
	}

	private void RefreshHeroGridView(object sender, InteractionEventArgs e)
	{
		GetCurBoardHeroIndex();
		heroGridView.SetListItemCount(_viewModel.HeroIdList.Count);
		heroGridView.RefreshAllShownItem();
		if (curBoardHeroIndex >= 0)
		{
			heroGridView.MovePanelToItemByIndex(curBoardHeroIndex);
		}
	}

	private void GetCurSpineItemIndex()
	{
		curSpineItemIndex = 0;
		BoardHeroData curBoardData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().BoardHeroData;
		DRBoardHeroList dataRow = GameEntry.DataTable.GetDataRow<DRBoardHeroList>(curBoardData.BoardHeroId);
		if (dataRow == null)
		{
			return;
		}
		if (_viewModel.CurSelectHeroItemData != null && _viewModel.CurSelectHeroItemData.HeroId == dataRow.HeroId)
		{
			curSpineItemIndex = _viewModel.ScreenHeroDatas.FindIndex((BoardChangeItemData p) => p.DrHero.Id == curBoardData.BoardHeroId);
		}
		if (curSpineItemIndex < 0)
		{
			curSpineItemIndex = 0;
		}
	}

	private void InitSpineListView()
	{
		spineListView.InitListView(_viewModel.ScreenHeroDatas.Count, OnGetSpineListItemByIndex);
		if (curSpineItemIndex >= 0)
		{
			spineListView.MovePanelToItemIndex(curSpineItemIndex, 0f);
		}
	}

	private LoopListViewItem2 OnGetSpineListItemByIndex(LoopListView2 arg1, int itemIndex)
	{
		if (itemIndex < 0 || itemIndex > _viewModel.ScreenHeroDatas.Count)
		{
			return null;
		}
		BoardChangeItemData boardChangeItemData = _viewModel.ScreenHeroDatas[itemIndex];
		if (boardChangeItemData == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = arg1.NewListViewItem("BoardChangeItem");
		BoardChangeItem component = loopListViewItem.GetComponent<BoardChangeItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(boardChangeItemData);
		}
		else
		{
			component.RefreshData(boardChangeItemData);
		}
		if (itemIndex == curSpineItemIndex)
		{
			_viewModel.SetSpineItemSelected(boardChangeItemData);
		}
		return loopListViewItem;
	}

	private void RefreshSpineListView(object sender, InteractionEventArgs e)
	{
		GetCurSpineItemIndex();
		spineListView.SetListItemCount(_viewModel.ScreenHeroDatas.Count);
		spineListView.RefreshAllShownItem();
		if (curSpineItemIndex >= 0)
		{
			spineListView.MovePanelToItemIndex(curSpineItemIndex, 0f);
		}
	}

	private void InitBgGridView()
	{
		bgGridView.InitGridView(_viewModel.ScreenBgDatas.Count, OnGetBgItemByIndex);
	}

	private void RefreshBgAndHeroSpine()
	{
		if (_viewModel != null)
		{
			innerRoot.gameObject.SetActive(_viewModel.CurSelectSpineItemData == null || _viewModel.CurSelectSpineItemData.DrHero.StateType == 0);
			SetHeroSpine();
			RefreshBg();
		}
	}

	private void RefreshList()
	{
		if (_viewModel != null)
		{
			if (heroGridView.MListViewInited)
			{
				heroGridView.SetListItemCount(_viewModel.ScreenHeroDatas.Count);
				heroGridView.RefreshAllShownItem();
			}
			if (bgGridView.MListViewInited)
			{
				bgGridView.SetListItemCount(_viewModel.ScreenBgDatas.Count);
				bgGridView.RefreshAllShownItem();
			}
		}
	}

	private void OnTabChanged(object sender = null, InteractionEventArgs e = null)
	{
		if (_viewModel.CurTabData != null)
		{
			heroGridView.gameObject.SetActive(_viewModel.CurTabData.TabIndex == 1);
			bgGridView.gameObject.SetActive(_viewModel.CurTabData.TabIndex == 2);
			heroSpineLayoutPanel.SetActive(_viewModel.CurTabData.TabIndex == 1);
		}
	}

	protected LoopGridViewItem OnGetBgItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= _viewModel.ScreenBgDatas.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("BoardChangeItem");
		if (loopGridViewItem != null)
		{
			BoardChangeItemData data = _viewModel.ScreenBgDatas[index];
			BoardChangeItem component = loopGridViewItem.GetComponent<BoardChangeItem>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(data);
			}
			else
			{
				component.RefreshData(data);
			}
		}
		return loopGridViewItem;
	}

	private async void RefreshSpine(object sender, InteractionEventArgs e)
	{
		innerRoot.gameObject.SetActive(_viewModel.CurSelectSpineItemData == null || _viewModel.CurSelectSpineItemData.DrHero.StateType == 0);
		if (_viewModel.CurSelectSpineItemData == null)
		{
			return;
		}
		DRBoardHeroList drHero = _viewModel.CurSelectSpineItemData.DrHero;
		string text = heroAssetPath;
		if (!string.IsNullOrEmpty(text))
		{
			AddLoadedSpinePath(AssetUtility.GetUIItemAsset(BoardHeroData.GetSpineAssetPath(text)));
		}
		heroAssetPath = drHero.AssetPath;
		if (!string.IsNullOrEmpty(heroAssetPath))
		{
			string uIItemAsset = AssetUtility.GetUIItemAsset(BoardHeroData.GetSpineAssetPath(heroAssetPath));
			AddLoadedSpinePath(uIItemAsset);
			GameObject gameObject = await InstantiateAsync(uIItemAsset, spineRoot);
			if (!(gameObject == null))
			{
				GameObject heroSpine = _viewModel.HeroSpine;
				DisposeHeroSpine(heroSpine);
				_viewModel.HeroSpine = gameObject;
				SetHeroSpine();
				RefreshOuterPosAndScale();
				StreamerMode.ApplySpineSkin(gameObject);
			}
		}
	}

	private async void RefreshBg(object sender = null, InteractionEventArgs e = null)
	{
		if (_viewModel.CurSelectBgItemData == null)
		{
			return;
		}
		string text = bgAssetPath;
		if (!string.IsNullOrEmpty(text))
		{
			AddLoadedSpinePath(AssetUtility.GetUIItemAsset(text));
		}
		bgAssetPath = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetBackground(_viewModel.CurSelectBgItemData.Id)
			.AssetPath;
		if (!string.IsNullOrEmpty(bgAssetPath))
		{
			string uIItemAsset = AssetUtility.GetUIItemAsset(bgAssetPath);
			AddLoadedSpinePath(uIItemAsset);
			GameObject go = null;
			try
			{
				go = await InstantiateAsync(uIItemAsset, outerRoot);
			}
			catch (Exception)
			{
			}
			if (!(go == null))
			{
				GameObject outerBg = _outerBg;
				DisposeBg(outerBg);
				_outerBg = go;
				RefreshOuterPosAndScale();
			}
		}
	}

	private void SetHeroSpine()
	{
		if (_viewModel.CurSelectSpineItemData != null && !(_viewModel.HeroSpine == null))
		{
			DRBoardHeroList drHero = _viewModel.CurSelectSpineItemData.DrHero;
			spineRoot.anchoredPosition = new Vector2((drHero.Position.Count > 0) ? drHero.Position[0] : 0f, (drHero.Position.Count > 1) ? drHero.Position[1] : 0f);
			ApplySavedSpineScale();
			ApplySavedSpineRotation();
			ApplySavedSpinePosIfAny();
			AddLoadedSpinePath(AssetUtility.GetUIItemAsset(BoardHeroData.GetSpineAssetPath(drHero.AssetPath)));
			_viewModel.HeroSpine.transform.SetParent(spineRoot, worldPositionStays: false);
			_viewModel.HeroSpine.transform.localPosition = Vector3.zero;
			_viewModel.HeroSpine.transform.localRotation = Quaternion.identity;
			_viewModel.HeroSpine.transform.localScale = Vector3.one;
			SpineFusion componentInChildren = _viewModel.HeroSpine.transform.GetComponentInChildren<SpineFusion>();
			if (!((UnityEngine.Object)(object)componentInChildren == null) && !((UnityEngine.Object)(object)componentInChildren.SkeletonGraphic == null))
			{
				((Behaviour)(object)componentInChildren).enabled = true;
				((Graphic)(object)componentInChildren.SkeletonGraphic).raycastTarget = false;
				componentInChildren.SkeletonGraphic.freeze = false;
				SpineHelper.SetSpineInteractivity(_viewModel.HeroSpine.transform, interactivity: false);
			}
		}
	}

	public DRBoardHeroList GetCurrentBoardHeroConfig()
	{
		return _viewModel?.CurSelectSpineItemData?.DrHero;
	}

	public RectTransform GetSpineRoot()
	{
		return spineRoot;
	}

	private BoardHeroPreviewTransformData BuildCurrentPreviewTransformData()
	{
		DRBoardHeroList currentBoardHeroConfig = GetCurrentBoardHeroConfig();
		if (currentBoardHeroConfig == null || spineRoot == null)
		{
			return null;
		}
		return new BoardHeroPreviewTransformData(currentBoardHeroConfig.Id, spineRoot.anchoredPosition, spineRoot.localScale, spineRoot.localRotation);
	}

	private void ApplyPreviewTransformData(BoardHeroPreviewTransformData transformData)
	{
		if (transformData != null && !(spineRoot == null))
		{
			spineRoot.anchoredPosition = transformData.AnchoredPosition;
			spineRoot.localScale = transformData.LocalScale;
			spineRoot.localRotation = transformData.LocalRotation;
		}
	}

	private void ApplySavedSpinePosIfAny()
	{
		DRBoardHeroList dRBoardHeroList = _viewModel?.CurSelectSpineItemData?.DrHero;
		if (dRBoardHeroList != null && PosterGirlAdjustView.TryLoadBoardHeroSpineAnchoredPos(dRBoardHeroList.Id, out var anchoredPos))
		{
			spineRoot.anchoredPosition = anchoredPos;
		}
	}

	private void ApplySavedSpineScale()
	{
		DRBoardHeroList dRBoardHeroList = _viewModel?.CurSelectSpineItemData?.DrHero;
		if (dRBoardHeroList != null)
		{
			float num = PlayerPrefs.GetFloat(PosterGirlAdjustView.GetBoardSpineScalePrefKey(dRBoardHeroList.Id), 1f);
			Vector3 vector = new Vector3((dRBoardHeroList.Scale.Count > 0) ? dRBoardHeroList.Scale[0] : 1f, (dRBoardHeroList.Scale.Count > 1) ? dRBoardHeroList.Scale[1] : 1f, (dRBoardHeroList.Scale.Count > 2) ? dRBoardHeroList.Scale[2] : 1f);
			bool flag = PlayerPrefs.GetInt(PosterGirlAdjustView.GetBoardSpineFlipYPrefKey(dRBoardHeroList.Id), 0) == 1;
			Vector3 localScale = vector * num;
			localScale.x = (flag ? (0f - Mathf.Abs(localScale.x)) : Mathf.Abs(localScale.x));
			spineRoot.localScale = localScale;
		}
	}

	private void ApplySavedSpineRotation()
	{
		DRBoardHeroList dRBoardHeroList = _viewModel?.CurSelectSpineItemData?.DrHero;
		if (dRBoardHeroList != null)
		{
			float defaultValue = ((posterGirlAdjustView != null) ? posterGirlAdjustView.RotationInitValue : 0f);
			float z = PlayerPrefs.GetFloat(PosterGirlAdjustView.GetBoardSpineRotationPrefKey(dRBoardHeroList.Id), defaultValue);
			PlayerPrefs.GetInt(PosterGirlAdjustView.GetBoardSpineFlipYPrefKey(dRBoardHeroList.Id), 0);
			spineRoot.localRotation = Quaternion.Euler(0f, 0f, z);
		}
	}

	private void RefreshOuterPosAndScale()
	{
		if (_viewModel.CurSelectBgItemData == null || _viewModel.CurSelectSpineItemData == null)
		{
			outerRoot.anchoredPosition = Vector2.zero;
			outerRoot.localScale = Vector3.one;
			return;
		}
		DRBoardBackGround background = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetBackground(_viewModel.CurSelectBgItemData.Id);
		DRBoardHeroList dataRow = GameEntry.DataTable.GetDataRow<DRBoardHeroList>(_viewModel.CurSelectSpineItemData.Id);
		if (background != null && dataRow != null)
		{
			float num = 0f;
			List<float> list = ((dataRow.StateType == 0) ? background.FgimagePosition : background.OriginalPosition);
			List<float> list2 = ((dataRow.StateType == 0) ? background.FgimageScale : background.OriginalScale);
			float x = ((list.Count > 0) ? list[0] : 0f);
			float y = ((list.Count > 1) ? list[1] : 0f);
			float z = ((list.Count > 2) ? list[2] : 0f);
			float x2 = ((list2.Count > 0) ? list2[0] : 1f);
			float y2 = ((list2.Count > 1) ? list2[1] : 1f);
			num = ((list2.Count > 2) ? list2[2] : 1f);
			outerRoot.anchoredPosition = new Vector3(x, y, z);
			outerRoot.localScale = new Vector3(x2, y2, num);
		}
	}

	private void AddLoadedSpinePath(string path)
	{
		if (_loadedSpine != null && !_loadedSpine.Contains(path))
		{
			_loadedSpine.Add(path);
		}
	}

	private void DisposeHeroSpine(GameObject spineObj)
	{
		if (spineObj != null)
		{
			SpineFusion componentInChildren = spineObj.transform.GetComponentInChildren<SpineFusion>();
			if ((UnityEngine.Object)(object)componentInChildren != null)
			{
				componentInChildren.ResetToIdle();
			}
			UnityEngine.Object.Destroy(spineObj);
		}
	}

	private void DisposeBg(GameObject bgObj)
	{
		if (bgObj != null)
		{
			UnityEngine.Object.Destroy(bgObj);
		}
	}

	private void OnDestroyRaised(object sender, InteractionEventArgs e)
	{
		BoardHeroData boardHeroData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().BoardHeroData;
		if (_viewModel.CurSelectSpineItemData == null || _viewModel.CurSelectSpineItemData.DrHero.Id != boardHeroData.BoardHeroId)
		{
			DisposeHeroSpine(_viewModel.HeroSpine);
		}
		if (_viewModel.CurSelectBgItemData == null || _viewModel.CurSelectBgItemData.DrBg.Id != boardHeroData.BackgroundId)
		{
			DisposeBg(_outerBg);
		}
		this.ClearAllBindings();
		base.ClearViewInfoInWindow?.Invoke(this);
		UnityEngine.Object.Destroy(base.gameObject);
		DRBoardHeroList[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRBoardHeroList>();
		DRBoardBackGround[] allDataRow2 = GameEntry.DataTable.GetAllDataRow<DRBoardBackGround>();
		string value = "";
		for (int i = 0; i < allDataRow2.Length; i++)
		{
			if (boardHeroData.BackgroundId == allDataRow2[i].Id)
			{
				value = AssetUtility.GetUIItemAsset(allDataRow2[i].AssetPath);
				break;
			}
		}
		string value2 = "";
		for (int j = 0; j < allDataRow.Length; j++)
		{
			if (boardHeroData.BoardHeroId == allDataRow[j].Id)
			{
				value2 = AssetUtility.GetUIItemAsset(BoardHeroData.GetSpineAssetPath(allDataRow[j].AssetPath));
				break;
			}
		}
		for (int k = 0; k < _loadedSpine.Count; k++)
		{
			if (!_loadedSpine[k].Equals(value))
			{
				_loadedSpine[k].Equals(value2);
			}
		}
		_loadedSpine.Clear();
		CollectionPool<List<string>, string>.Release(_loadedSpine);
		_loadedSpine = null;
	}
}
