#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class IndicatorSetView : UGuiView
{
	[SerializeField]
	private RectTransform subTabRoot;

	[SerializeField]
	private TabItem subTabTpl;

	[SerializeField]
	private LoopGridView loopGridView;

	[SerializeField]
	private TextMeshProUGUI selectNameText;

	[SerializeField]
	private TextMeshProUGUI selectTimeText;

	[SerializeField]
	private GameObject selectTimeImg;

	[SerializeField]
	private TextMeshProUGUI selectDescText;

	[SerializeField]
	private Button saveBtn;

	[SerializeField]
	private GameObject btnMask;

	[SerializeField]
	private GameObject btnRoot;

	[SerializeField]
	private Button btnJump;

	[SerializeField]
	private string jumpWindow;

	[SerializeField]
	private List<int> jumpParams;

	[SerializeField]
	private Button leftBtn;

	[SerializeField]
	private Button rightBtn;

	[SerializeField]
	private Button previewIndexBtn;

	[SerializeField]
	private TextMeshProUGUI previewIndexText;

	[SerializeField]
	private int previewHeroId = 1104;

	[SerializeField]
	private Camera previewCamera;

	[SerializeField]
	private RawImage previewRawImage;

	[SerializeField]
	private Transform modelRoot;

	[SerializeField]
	private Transform indicatorRingRoot;

	[SerializeField]
	private List<string> previewActionStates = new List<string>();

	[SerializeField]
	private List<string> previewActionNames = new List<string>();

	private GameObject _previewModelObj;

	private Animator _previewAnimator;

	private int _previewActionIndex = -1;

	private int _previewLoadToken;

	private bool _previewCameraInserted;

	private bool _previewCameraMaskCached;

	private int _previewCameraOriginalMask;

	private string _previewAssetFullPath;

	private GameObject _previewIndicatorFxObj;

	private string _previewIndicatorFxAssetFullPath;

	private int _previewIndicatorEffectId = -1;

	private int _previewIndicatorLoadToken;

	private bool _previewForceLoop = true;

	private GameObjectPool _subTabItemPool;

	private IndicatorSetViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		_subTabItemPool = new GameObjectPool(subTabTpl.gameObject, subTabRoot);
		base.OnInit(userData);
		_viewModel = GetUserData<IndicatorSetViewModel>(userData);
		BindingSet<IndicatorSetView, IndicatorSetViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((IndicatorSetView v) => v.OnSubTabChanged).To((IndicatorSetViewModel vm) => vm.SubTabChangedRst);
		bindingSet.Bind().For((IndicatorSetView v) => v.OnDataListChanged).To((IndicatorSetViewModel vm) => vm.DataListChangeRst);
		bindingSet.Bind().For((IndicatorSetView v) => v.RefreshSelectInfo).To((IndicatorSetViewModel vm) => vm.CurSelectChangedRst);
		bindingSet.Bind(saveBtn).For((Button v) => v.onClick).To((IndicatorSetViewModel vm) => vm.ApplyCmd);
		bindingSet.Bind(btnMask).For((GameObject v) => v.activeSelf).To((IndicatorSetViewModel vm) => vm.CurSelectIsUse);
		bindingSet.Bind(btnRoot).For((GameObject v) => v.activeSelf).To((IndicatorSetViewModel vm) => vm.CurSelectGot);
		bindingSet.Build();
		BindPreviewButtonsForActionSwitch();
		InitPreviewRuntime();
		LoadPreviewHeroAsync(previewHeroId);
		if (btnJump != null)
		{
			JumpWindowParams param = new JumpWindowParams(jumpWindow, jumpParams);
			btnJump.onClick.AddListener(delegate
			{
				_viewModel.ItemOnClick(param);
			});
		}
		InitSubTabs();
		loopGridView.InitGridView(_viewModel.GetDisplayDataCount(), OnGetItemByIndex);
		RefreshSelectInfo();
	}

	private void InitSubTabs()
	{
		for (int i = 0; i < _viewModel.SubTabItemDataList.Count; i++)
		{
			TabItemData tabItemData = _viewModel.SubTabItemDataList[i];
			TabItem component = _subTabItemPool.Allocate(out var newCreate).GetComponent<TabItem>();
			if (newCreate)
			{
				component.Init(tabItemData);
			}
			else
			{
				component.SetDataContext(tabItemData);
			}
			component.transform.SetSiblingIndex(subTabRoot.childCount - 1);
			component.GetComponent<UIRedPoint>()?.Dispose();
			component.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.Indicator).SetFuncOnMessage((RedPointMessage msg) => (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.Indicator) ?? new List<RoleDecorateData>()).Exists((RoleDecorateData p) => p.isNew))
				.Invoke();
		}
	}

	private LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int dataIndex, int row, int column)
	{
		if (_viewModel.CurSubTabEnum == IndicatorSetViewModel.SubTabEnum.Indicator)
		{
			return GetFrameItem(arg1, dataIndex, row, column);
		}
		return null;
	}

	private LoopGridViewItem GetFrameItem(LoopGridView arg1, int dataIndex, int row, int column)
	{
		List<IndicatorItemData> indicatorItemDataList = _viewModel.IndicatorItemDataList;
		if (dataIndex < 0 || dataIndex >= indicatorItemDataList.Count)
		{
			return null;
		}
		IndicatorItemData data = indicatorItemDataList[dataIndex];
		if (data == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = loopGridView.NewListViewItem("IndicatorItem");
		IndicatorItem component = loopGridViewItem.GetComponent<IndicatorItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(data);
		}
		else
		{
			component.RefreshData(data);
		}
		if (_viewModel.CurSelectIndicatorData != null)
		{
			data.IsSelected = data.Data.id == _viewModel.CurSelectIndicatorData.id;
		}
		else if (dataIndex == 0)
		{
			data.OnItemClick();
		}
		loopGridViewItem.GetComponent<UIRedPoint>()?.Dispose();
		loopGridViewItem.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.Indicator).SetFuncOnMessage((RedPointMessage msg) => (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.Indicator) ?? new List<RoleDecorateData>()).Find((RoleDecorateData p) => p.id == data.Data.id)?.isNew ?? false)
			.Invoke();
		return loopGridViewItem;
	}

	private void OnSubTabChanged(object sender, InteractionEventArgs e)
	{
		loopGridView.SetListItemCount(_viewModel.GetDisplayDataCount());
		loopGridView.RefreshAllShownItem();
		RefreshSelectInfo();
	}

	private void OnDataListChanged(object sender, InteractionEventArgs e)
	{
		IndicatorSetViewModel.SubTabEnum subTabEnum = (IndicatorSetViewModel.SubTabEnum)e.Context;
		if (_viewModel.CurSubTabEnum == subTabEnum)
		{
			loopGridView.SetListItemCount(_viewModel.GetDisplayDataCount());
			loopGridView.RefreshAllShownItem();
		}
	}

	private void RefreshSelectInfo(object sender = null, InteractionEventArgs e = null)
	{
		if (_viewModel.CurSubTabEnum == IndicatorSetViewModel.SubTabEnum.Indicator && _viewModel.CurSelectIndicatorData != null)
		{
			DRIndicatorRing dataRow = GameEntry.DataTable.GetDataRow<DRIndicatorRing>(_viewModel.CurSelectIndicatorData.id);
			if (dataRow != null)
			{
				((TMP_Text)selectNameText).text = dataRow.Name;
				((TMP_Text)selectDescText).text = dataRow.BgsTxt.Replace("\\n", "\n");
				long expireTime = _viewModel.CurSelectIndicatorData.expireTime;
				if (expireTime < 0)
				{
					((TMP_Text)selectTimeText).text = "未获取";
					selectTimeImg.SetActive(value: false);
					((TMP_Text)selectDescText).text = dataRow.AppTxt;
				}
				else if (expireTime == 0L)
				{
					((TMP_Text)selectTimeText).text = "永久";
					selectTimeImg.SetActive(value: false);
				}
				else
				{
					DateTime curServerDateTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerDateTime();
					DateTime dateTime = Utility.DateTime.UnixTimestampToDateTime(expireTime);
					if (DateTime.Compare(curServerDateTime, dateTime) >= 0)
					{
						((TMP_Text)selectTimeText).text = "未获取";
						selectTimeImg.SetActive(value: false);
						((TMP_Text)selectDescText).text = dataRow.AppTxt;
					}
					else
					{
						TimeSpan timeSpan = dateTime - curServerDateTime;
						((TMP_Text)selectTimeText).text = $"剩余时间：{timeSpan.Days}天{timeSpan.Hours}小时";
						selectTimeImg.SetActive(value: true);
					}
				}
			}
		}
		RefreshPreviewIndicatorEffect();
	}

	private void BindPreviewButtonsForActionSwitch()
	{
		if (leftBtn != null)
		{
			leftBtn.onClick.AddListener(OnPreviewPrevActionClicked);
		}
		if (rightBtn != null)
		{
			rightBtn.onClick.AddListener(OnPreviewNextActionClicked);
		}
		if (previewIndexBtn != null)
		{
			previewIndexBtn.onClick.AddListener(OnPreviewNextActionClicked);
		}
	}

	private void InitPreviewRuntime()
	{
		if (previewRawImage != null && previewRawImage.texture == null)
		{
			previewRawImage.texture = previewCamera.targetTexture;
		}
		if (!_previewCameraInserted)
		{
			_previewCameraInserted = true;
			_previewCameraOriginalMask = previewCamera.cullingMask;
			_previewCameraMaskCached = true;
		}
	}

	private async void LoadPreviewHeroAsync(int heroId)
	{
		if (modelRoot == null || previewCamera == null)
		{
			return;
		}
		_previewLoadToken++;
		int loadToken = _previewLoadToken;
		ClearPreviewModel();
		string text = ResolveHeroEntityPath(heroId);
		if (string.IsNullOrEmpty(text))
		{
			Log.Error($"IndicatorSetView: 未找到 heroId={heroId} 的实体路径");
			return;
		}
		string fullPath = (_previewAssetFullPath = AssetUtility.GetEntityAsset(text));
		try
		{
			GameObject gameObject = await GameEntry.Resource.LoadAssetAsync<GameObject>(fullPath);
			if (loadToken != _previewLoadToken)
			{
				if (!string.IsNullOrEmpty(fullPath))
				{
					GameEntry.Resource.UnloadAsset(fullPath);
				}
				return;
			}
			if (gameObject == null)
			{
				Log.Error("IndicatorSetView: 加载模型失败 " + fullPath);
				return;
			}
			_previewModelObj = UnityEngine.Object.Instantiate(gameObject, modelRoot, worldPositionStays: false);
			_previewModelObj.transform.localPosition = Vector3.zero;
			_previewModelObj.transform.localRotation = Quaternion.Euler(0f, 180f, 0f);
			_previewModelObj.transform.localScale = Vector3.one;
			int num = LayerMask.NameToLayer("UI");
			if (num >= 0)
			{
				SetLayerRecursively(_previewModelObj.transform, num);
				previewCamera.cullingMask = 1 << num;
			}
			RefreshPreviewIndicatorEffect(forceReload: true);
			_previewAnimator = _previewModelObj.GetComponentInChildren<Animator>(includeInactive: true);
			if ((UnityEngine.Object)(object)_previewAnimator == null)
			{
				Log.Error("IndicatorSetView: 预览模型未找到 Animator");
				RefreshPreviewActionIndexText();
				return;
			}
			_previewActionIndex = ((previewActionStates.Count <= 0) ? (-1) : 0);
			RefreshPreviewActionIndexText();
			FitPreviewCameraToModel();
			if (previewActionStates.Count > 0)
			{
				PlayPreviewActionAt(0);
			}
			else
			{
				RefreshPreviewActionIndexText();
			}
		}
		catch (Exception ex)
		{
			Log.Error("IndicatorSetView: 加载预览模型异常 " + ex.Message + " / " + ex.StackTrace);
		}
	}

	private string ResolveHeroEntityPath(int heroId)
	{
		DRHero dataRow = GameEntry.DataTable.GetDataRow<DRHero>(heroId);
		if (dataRow == null)
		{
			return string.Empty;
		}
		HeroModel heroModel = Singleton<ServiceSystem>.Instance.GetService<IHeroService>()?.GetHeroById(heroId, emptyCreateNew: true, saveNew: false);
		if (heroModel != null && heroModel.IsSkin)
		{
			DRHeroSkin dataRow2 = GameEntry.DataTable.GetDataRow<DRHeroSkin>(heroModel.SkinConfigId);
			if (dataRow2 != null && !string.IsNullOrEmpty(dataRow2.AssetPath))
			{
				return dataRow2.AssetPath;
			}
		}
		return dataRow.AssetPath;
	}

	private void OnPreviewPrevActionClicked()
	{
		PlayPreviewActionAt(_previewActionIndex - 1);
	}

	private void OnPreviewNextActionClicked()
	{
		PlayPreviewActionAt(_previewActionIndex + 1);
	}

	private void PlayPreviewActionAt(int targetIndex)
	{
		int count = previewActionStates.Count;
		if ((UnityEngine.Object)(object)_previewAnimator == null || count <= 0)
		{
			RefreshPreviewActionIndexText();
			return;
		}
		_previewActionIndex = (targetIndex % count + count) % count;
		string text = previewActionStates[_previewActionIndex];
		if (text == "MovementTree")
		{
			_previewAnimator.Play("MovementTree", 0, 0f);
			_previewAnimator.Update(0f);
		}
		else
		{
			int num = Animator.StringToHash(text);
			if (_previewAnimator.HasState(0, num))
			{
				_previewAnimator.Play(num, 0, 0f);
			}
			else
			{
				_previewAnimator.Play(text, 0, 0f);
			}
		}
		RefreshPreviewActionIndexText();
	}

	private void LateUpdate()
	{
		//IL_0079: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		if (!_previewForceLoop || (UnityEngine.Object)(object)_previewAnimator == null || _previewActionIndex < 0 || _previewActionIndex >= previewActionStates.Count || _previewAnimator.IsInTransition(0))
		{
			return;
		}
		string text = previewActionStates[_previewActionIndex];
		string text2 = ((text == "MovementTree") ? "Base Layer.MovementTree" : text);
		int num = Animator.StringToHash(text2);
		AnimatorStateInfo currentAnimatorStateInfo = _previewAnimator.GetCurrentAnimatorStateInfo(0);
		if (((AnimatorStateInfo)(ref currentAnimatorStateInfo)).fullPathHash != num && !((AnimatorStateInfo)(ref currentAnimatorStateInfo)).IsName(text2) && !((AnimatorStateInfo)(ref currentAnimatorStateInfo)).IsName(text))
		{
			if (_previewAnimator.HasState(0, num))
			{
				_previewAnimator.Play(num, 0, 0f);
			}
			else
			{
				_previewAnimator.Play(text2, 0, 0f);
			}
		}
		else if (text == "MovementTree" && ((AnimatorStateInfo)(ref currentAnimatorStateInfo)).normalizedTime >= 0.98f)
		{
			if (_previewAnimator.HasState(0, num))
			{
				_previewAnimator.Play(num, 0, 0f);
			}
			else
			{
				_previewAnimator.Play(text2, 0, 0f);
			}
		}
		else if (!((AnimatorStateInfo)(ref currentAnimatorStateInfo)).loop && ((AnimatorStateInfo)(ref currentAnimatorStateInfo)).normalizedTime >= 0.98f)
		{
			if (_previewAnimator.HasState(0, num))
			{
				_previewAnimator.Play(num, 0, 0f);
			}
			else
			{
				_previewAnimator.Play(text2, 0, 0f);
			}
		}
	}

	private void RefreshPreviewActionIndexText()
	{
		if (!((UnityEngine.Object)(object)previewIndexText == null))
		{
			int count = previewActionStates.Count;
			((TMP_Text)previewIndexText).text = ((count <= 0 || _previewActionIndex < 0) ? "0/0" : $"({_previewActionIndex + 1}/{count}){previewActionNames[_previewActionIndex]}");
		}
	}

	private void FitPreviewCameraToModel()
	{
		if (_previewModelObj == null || previewCamera == null)
		{
			return;
		}
		Renderer[] componentsInChildren = _previewModelObj.GetComponentsInChildren<Renderer>(includeInactive: true);
		if (componentsInChildren != null && componentsInChildren.Length != 0)
		{
			Bounds bounds = componentsInChildren[0].bounds;
			for (int i = 1; i < componentsInChildren.Length; i++)
			{
				bounds.Encapsulate(componentsInChildren[i].bounds);
			}
		}
	}

	private void ClearPreviewModel()
	{
		if (_previewModelObj != null)
		{
			UnityEngine.Object.Destroy(_previewModelObj);
			_previewModelObj = null;
		}
		_previewAnimator = null;
		_previewActionIndex = -1;
		RefreshPreviewActionIndexText();
		_previewIndicatorLoadToken++;
		ClearPreviewIndicatorEffect();
		_previewIndicatorEffectId = -1;
		if (!string.IsNullOrEmpty(_previewAssetFullPath))
		{
			GameEntry.Resource.UnloadAsset(_previewAssetFullPath);
			_previewAssetFullPath = null;
		}
	}

	private static Transform FindChildRecursive(Transform root, string childName)
	{
		if (root == null)
		{
			return null;
		}
		for (int i = 0; i < root.childCount; i++)
		{
			Transform child = root.GetChild(i);
			if (child.name == childName)
			{
				return child;
			}
			Transform transform = FindChildRecursive(child, childName);
			if (transform != null)
			{
				return transform;
			}
		}
		return null;
	}

	private static void SetLayerRecursively(Transform root, int layer)
	{
		if (!(root == null))
		{
			root.gameObject.layer = layer;
			for (int i = 0; i < root.childCount; i++)
			{
				SetLayerRecursively(root.GetChild(i), layer);
			}
		}
	}

	private int GetCurrentSelectIndicatorEffectId()
	{
		if (_viewModel == null)
		{
			return 0;
		}
		int indicatorId = _viewModel.CurSelectIndicatorData?.id ?? _viewModel.CurAppliedIndicatorId;
		return (_viewModel.IndicatorItemDataList?.Find((IndicatorItemData p) => p != null && p.Data != null && p.Data.id == indicatorId))?.IndicatorEffectId ?? GameEntry.DataTable.GetDataRow<DRIndicatorRing>(indicatorId)?.ResPath ?? 0;
	}

	private async void RefreshPreviewIndicatorEffect(bool forceReload = false)
	{
		int currentSelectIndicatorEffectId = GetCurrentSelectIndicatorEffectId();
		if (!forceReload && currentSelectIndicatorEffectId == _previewIndicatorEffectId && _previewIndicatorFxObj != null)
		{
			return;
		}
		_previewIndicatorEffectId = currentSelectIndicatorEffectId;
		_previewIndicatorLoadToken++;
		int loadToken = _previewIndicatorLoadToken;
		ClearPreviewIndicatorEffect();
		if (_previewModelObj == null || currentSelectIndicatorEffectId <= 0)
		{
			return;
		}
		DREffect dataRow = GameEntry.DataTable.GetDataRow<DREffect>(currentSelectIndicatorEffectId);
		if (dataRow == null || string.IsNullOrEmpty(dataRow.MidLevelAssetPath))
		{
			return;
		}
		string effectFullPath = AssetUtility.GetEntityAsset(dataRow.MidLevelAssetPath);
		GameObject gameObject = await GameEntry.Resource.LoadAssetAsync<GameObject>(effectFullPath);
		if (loadToken != _previewIndicatorLoadToken)
		{
			if (!string.IsNullOrEmpty(effectFullPath))
			{
				GameEntry.Resource.UnloadAsset(effectFullPath);
			}
			return;
		}
		if (gameObject == null)
		{
			Log.Error("IndicatorSetView: 指示器特效加载失败 " + effectFullPath);
			return;
		}
		_previewIndicatorFxAssetFullPath = effectFullPath;
		_previewIndicatorFxObj = UnityEngine.Object.Instantiate(gameObject, indicatorRingRoot, worldPositionStays: false);
		_previewIndicatorFxObj.transform.localPosition = Vector3.zero;
		_previewIndicatorFxObj.transform.localRotation = Quaternion.identity;
		_previewIndicatorFxObj.transform.localScale = Vector3.one;
		SetLayerRecursively(_previewIndicatorFxObj.transform, _previewModelObj.layer);
	}

	private static Vector3 CalcModelFootLocalPos(GameObject model, Transform ignoreRoot = null)
	{
		Renderer[] componentsInChildren = model.GetComponentsInChildren<Renderer>(includeInactive: true);
		if (componentsInChildren == null || componentsInChildren.Length == 0)
		{
			return Vector3.zero;
		}
		Bounds bounds = componentsInChildren[0].bounds;
		for (int i = 1; i < componentsInChildren.Length; i++)
		{
			bounds.Encapsulate(componentsInChildren[i].bounds);
		}
		Vector3 position = new Vector3(bounds.center.x, bounds.min.y, bounds.center.z);
		return model.transform.InverseTransformPoint(position);
	}

	private void ClearPreviewIndicatorEffect()
	{
		if (_previewIndicatorFxObj != null)
		{
			UnityEngine.Object.Destroy(_previewIndicatorFxObj);
			_previewIndicatorFxObj = null;
		}
		if (!string.IsNullOrEmpty(_previewIndicatorFxAssetFullPath))
		{
			GameEntry.Resource.UnloadAsset(_previewIndicatorFxAssetFullPath);
			_previewIndicatorFxAssetFullPath = null;
		}
	}

	protected override void OnDestroy()
	{
		_previewLoadToken++;
		ClearPreviewModel();
		if (_previewCameraInserted && previewCamera != null)
		{
			if (_previewCameraMaskCached)
			{
				previewCamera.cullingMask = _previewCameraOriginalMask;
			}
			_previewCameraInserted = false;
		}
		if (leftBtn != null)
		{
			leftBtn.onClick.RemoveListener(OnPreviewPrevActionClicked);
		}
		if (rightBtn != null)
		{
			rightBtn.onClick.RemoveListener(OnPreviewNextActionClicked);
		}
		if (previewIndexBtn != null)
		{
			previewIndexBtn.onClick.RemoveListener(OnPreviewNextActionClicked);
		}
		base.OnDestroy();
	}
}
