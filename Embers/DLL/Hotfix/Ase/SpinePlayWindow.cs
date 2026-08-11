using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using FMOD.Studio;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SpinePlayWindow : UGuiWindow
{
	public enum TwoFingerGestureType
	{
		None,
		SameDirectionDrag,
		OppositeDirectionDrag
	}

	[SerializeField]
	private CanvasGroup mainPanel;

	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnReset;

	[SerializeField]
	private Button btnChangeSpine;

	[SerializeField]
	private CanvasGroup spineChangePanel;

	[SerializeField]
	private Button btnHideChangePanel;

	[SerializeField]
	private LoopListView2 spineListView;

	[SerializeField]
	private LoopListView2FastCenterSnapScale centerSnapScale;

	[SerializeField]
	private string normalPrefabName = "YourNormalItem";

	[SerializeField]
	private string spacerPrefabName = "YourSpacerItem";

	[SerializeField]
	private RectTransform spineRoot;

	[SerializeField]
	private int testData;

	private SpinePlayViewModel _viewModel;

	private bool _spineTransChanged;

	private Dictionary<string, GameObject> _loadedSpines = new Dictionary<string, GameObject>();

	private GameObject _curSpineGo;

	private SpineFusion _curSpineFusion;

	private DRSkinTheater _curConfig;

	private VoiceGroup _voiceGroup;

	private int _initBgmId;

	[Header("判定阈值")]
	[SerializeField]
	private float moveThreshold;

	[SerializeField]
	private float sameDirectionDotThreshold = 0.7f;

	[SerializeField]
	private float oppositeDirectionDotThreshold = -0.7f;

	[Header("Windows/Editor 鼠标模拟")]
	[SerializeField]
	private bool enableMouseSimulation = true;

	private float simulatedFingerHalfDistance = 100f;

	[Header("UI转换参数")]
	public Vector2 spineMoveRange;

	public Vector2 spineScaleRange;

	[SerializeField]
	private float moveTransParams = 1f;

	[SerializeField]
	private float scaleTransParams = 1f;

	private bool _hasLastMousePosition;

	private Vector2 _lastMousePosition;

	private float _spineTransLeftTime;

	public TwoFingerGestureType GestureType { get; private set; }

	public Vector2 SameDragStartDirection { get; private set; }

	public Vector2 SameDragVelocity { get; private set; }

	public float SameDragSpeed => SameDragVelocity.magnitude;

	public float SameDragProjectedSpeed { get; private set; }

	public float OppositeDragVelocity { get; private set; }

	public float OppositeDragSpeed => Mathf.Abs(OppositeDragVelocity);

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<SpinePlayViewModel>();
		BindingSet<SpinePlayWindow, SpinePlayViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((SpinePlayWindow v) => v.OnDismissRequest).To((SpinePlayViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((SpinePlayViewModel vm) => vm.Close);
		bindingSet.Build();
		for (int num = 0; num < testData; num++)
		{
			_viewModel.SpineList.AddRange(_viewModel.SpineList);
		}
		Init();
	}

	private void Init()
	{
		_initBgmId = Singleton<AudioSystem>.Instance.GetCurBgmId();
		_voiceGroup = Singleton<AudioSystem>.Instance.RegisterGroup(VoiceGroupEnum.SpinePlay);
		centerSnapScale.SetSpacerItemCount(2, 2);
		int loopItemCount = centerSnapScale.GetLoopItemCount(_viewModel.SpineList.Count);
		spineListView.InitListView(loopItemCount, OnGetItemByIndex);
		LoopListView2FastCenterSnapScale loopListView2FastCenterSnapScale = centerSnapScale;
		loopListView2FastCenterSnapScale.FinalCenterItemSettledEx = (Action<int, LoopListViewItem2>)Delegate.Combine(loopListView2FastCenterSnapScale.FinalCenterItemSettledEx, new Action<int, LoopListViewItem2>(OnFinalCenterSettledEx));
		btnReset.onClick.AddListener(ResetSpineTransform);
		btnChangeSpine.onClick.AddListener(OpenSpineChangePanel);
		btnHideChangePanel.onClick.AddListener(HideSpineChangePanel);
		UpdateSpineRootTrans();
		int num = _viewModel.SpineList.FindIndex((int p) => p.Equals(_viewModel.CurrSkinId));
		if (num >= 0)
		{
			centerSnapScale.SetInitFocusItem(enable: true, num);
		}
	}

	private void MoveSpine(Vector2 moveDir, float dirSpeed, float time, float transParams, Vector2 range)
	{
		Vector2 anchoredPosition = spineRoot.anchoredPosition + moveDir * dirSpeed * time * transParams;
		range *= spineRoot.localScale.x;
		if (anchoredPosition.x > range.x)
		{
			anchoredPosition.x = range.x;
		}
		else if (anchoredPosition.x < 0f - range.x)
		{
			anchoredPosition.x = 0f - range.x;
		}
		if (anchoredPosition.y > range.y)
		{
			anchoredPosition.y = range.y;
		}
		else if (anchoredPosition.y < 0f - range.y)
		{
			anchoredPosition.y = 0f - range.y;
		}
		spineRoot.anchoredPosition = anchoredPosition;
		if (!_spineTransChanged)
		{
			_spineTransChanged = true;
		}
	}

	private void ScaleSpine(float dragVelocity, float time, float transParams, Vector2 range)
	{
		Vector3 vector = Vector3.one * range.x;
		Vector3 vector2 = Vector3.one * range.y;
		Vector3 localScale = spineRoot.localScale + Vector3.one * dragVelocity * time * transParams / 1000f;
		if (localScale.x > vector2.x)
		{
			localScale.x = vector2.x;
		}
		else if (localScale.x < vector.x)
		{
			localScale.x = vector.x;
		}
		if (localScale.y > vector2.y)
		{
			localScale.y = vector2.y;
		}
		else if (localScale.y < vector.y)
		{
			localScale.y = vector.y;
		}
		if (localScale.z > vector2.z)
		{
			localScale.z = vector2.z;
		}
		else if (localScale.z < vector.z)
		{
			localScale.z = vector.z;
		}
		spineRoot.localScale = localScale;
		if (!_spineTransChanged)
		{
			_spineTransChanged = true;
		}
	}

	private void UpdateSpineRootTrans()
	{
		spineRoot.localScale = Vector3.one * _viewModel.SpineScale;
		spineRoot.anchoredPosition = _viewModel.SpinePosition;
	}

	private void SaveSpineTransform()
	{
		_viewModel.SetTransform(spineRoot.anchoredPosition, spineRoot.localScale.x);
	}

	private void ResetSpineTransform()
	{
		_viewModel.SetTransformDefault(localSave: true);
		spineRoot.anchoredPosition = _viewModel.SpinePosition;
		spineRoot.localScale = Vector3.one * _viewModel.SpineScale;
	}

	private void OpenSpineChangePanel()
	{
		spineChangePanel.alpha = 1f;
		spineChangePanel.blocksRaycasts = true;
		mainPanel.alpha = 0f;
		mainPanel.blocksRaycasts = false;
	}

	private void HideSpineChangePanel()
	{
		spineChangePanel.alpha = 0f;
		spineChangePanel.blocksRaycasts = false;
		mainPanel.alpha = 1f;
		mainPanel.blocksRaycasts = true;
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int loopIndex)
	{
		if (centerSnapScale.IsSpacerLoopIndex(loopIndex))
		{
			LoopListViewItem2 loopListViewItem = spineListView.NewListViewItem(spacerPrefabName);
			loopListViewItem.name = $"Spacer_{loopIndex}";
			return loopListViewItem;
		}
		int num = centerSnapScale.LoopIndexToDataIndex(loopIndex);
		LoopListViewItem2 loopListViewItem2 = spineListView.NewListViewItem(normalPrefabName);
		if (loopListViewItem2 != null)
		{
			SpinePlayItem component = loopListViewItem2.GetComponent<SpinePlayItem>();
			SpinePlayItemData userData = new SpinePlayItemData(_viewModel.Parent, num, _viewModel.SpineList[num]);
			if (!loopListViewItem2.IsInitHandlerCalled)
			{
				loopListViewItem2.IsInitHandlerCalled = true;
				component.Init(userData);
			}
			else
			{
				component.RefreshData(userData);
			}
			component.SetButtonClick(OnClickItem);
			component.CanvasGroup.alpha = 1f;
		}
		return loopListViewItem2;
	}

	public void OnClickItem(int itemIndex)
	{
		centerSnapScale.FocusItem(itemIndex);
	}

	private void OnFinalCenterSettledEx(int itemIndex, LoopListViewItem2 item)
	{
		if (item == null)
		{
			return;
		}
		spineListView.ItemList.ForEach(delegate(LoopListViewItem2 p)
		{
			SpinePlayItem component2 = p.GetComponent<SpinePlayItem>();
			if (component2 != null && component2.ViewModel != null)
			{
				component2.ViewModel.Selected = component2.ViewModel.ItemIndex == itemIndex;
			}
		});
		SpinePlayItem component = item.GetComponent<SpinePlayItem>();
		if (component != null && component.ViewModel != null && component.ViewModel.Config != null)
		{
			_viewModel.SetCurSkinId(component.ViewModel.Config.SkinId);
			UpdateSpineRootTrans();
			RefreshSpine(component.ViewModel.Config);
		}
	}

	private async void RefreshSpine(DRSkinTheater newConfig)
	{
		if (newConfig == null)
		{
			return;
		}
		string newResPath = newConfig.ResPath;
		if (_curConfig != null && _curConfig.ResPath.Equals(newResPath))
		{
			_curConfig = newConfig;
			return;
		}
		if ((UnityEngine.Object)(object)_curSpineFusion != null)
		{
			_curSpineFusion.StopAll();
		}
		if (_curSpineGo != null)
		{
			_curSpineGo.SetActive(value: false);
		}
		if (_curConfig != null)
		{
			UnloadBankGroups(_curConfig.BankGroupId);
		}
		_curConfig = newConfig;
		if (!_loadedSpines.TryGetValue(newResPath, out var value))
		{
			GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset("CharacterImagePrefabs/" + newResPath), spineRoot);
			if (gameObject == null)
			{
				return;
			}
			_loadedSpines.Add(newResPath, gameObject);
			value = gameObject;
		}
		_curSpineGo = value;
		_curSpineGo.SetActive(value: true);
		_curSpineFusion = value.GetComponentInChildren<SpineFusion>();
		if (!((UnityEngine.Object)(object)_curSpineFusion == null))
		{
			_curSpineFusion.Init(HandleBoardPartState);
			if (_curConfig != null)
			{
				await LoadBankGroups(_curConfig.BankGroupId);
			}
			TryPlayTransition(newConfig);
		}
	}

	private void TryPlayTransition(DRSkinTheater drSkinTheater)
	{
		//IL_00aa: Unknown result type (might be due to invalid IL or missing references)
		//IL_00af: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b2: Unknown result type (might be due to invalid IL or missing references)
		if (SpineHelper.PlayTransitionCheck(drSkinTheater, _curSpineGo.name))
		{
			SpineHelper.GetTransitionConfig(drSkinTheater, 1, out var aniName, out var voiceId, out var soundId);
			SpineHelper.SaveTransitionInfo(_curSpineGo.name, aniName);
			_spineTransLeftTime = _curSpineFusion.GetActionDuration(aniName);
			_curSpineFusion.PlayAction(aniName, new SpineDefaultTrackPlayCommand());
			if (drSkinTheater.RoomMusic > 0)
			{
				Singleton<AudioSystem>.Instance.PlayBgmWithIdCheck(drSkinTheater.RoomMusic, new FMOD_Define.BgmParameter(1f, null, canReturn: false, (STOP_MODE)0));
			}
			if (voiceId > 0)
			{
				_voiceGroup.Play(voiceId);
			}
			if (soundId > 0)
			{
				EventInstance val = Singleton<AudioSystem>.Instance.CreateInstance(soundId);
				((EventInstance)(ref val)).start();
			}
		}
	}

	private async UniTask LoadBankGroups(List<int> bankGroupIds)
	{
		if (StreamerMode.GetStreamerMode() || bankGroupIds == null || bankGroupIds.Count == 0)
		{
			return;
		}
		DRBankGroup[] dataRows = GameEntry.DataTable.GetDataRows((DRBankGroup data) => bankGroupIds.Contains(data.Id));
		if (dataRows != null)
		{
			DRBankGroup[] array = dataRows;
			for (int num = 0; num < array.Length; num++)
			{
				await AudioHelper.LoadBanksByGroup(array[num]);
			}
		}
	}

	private void UnloadBankGroups(List<int> bankGroupIds)
	{
		if (bankGroupIds == null || bankGroupIds.Count == 0)
		{
			return;
		}
		DRBankGroup[] dataRows = GameEntry.DataTable.GetDataRows((DRBankGroup data) => bankGroupIds.Contains(data.Id));
		if (dataRows != null)
		{
			DRBankGroup[] array = dataRows;
			for (int num = 0; num < array.Length; num++)
			{
				AudioHelper.UnloadBankByGroup(array[num]);
			}
		}
	}

	public bool HandleBoardPartState(BoardPartState state, bool checkFrequentlyUsed, ISpinePlayCommand spinePlayCommand)
	{
		if (state == null)
		{
			return false;
		}
		if (state.LastResolvedEntry == null || state.LastResolvedEntry.Actions == null || state.LastResolvedEntry.Actions.Count == 0)
		{
			return false;
		}
		string text = SelectBoardSpineConfig(state.ActionPoolCache, state.LastResolvedEntry.PlayMode);
		if (!string.IsNullOrEmpty(text))
		{
			state.RemoveActionFromActionPoolCache(text);
		}
		if (_curSpineFusion.PlayAction(text, spinePlayCommand))
		{
			state.AppendResolvedActions(text);
			_curSpineFusion.RecordAnimationPlayed(text);
		}
		return true;
	}

	private string SelectBoardSpineConfig(List<string> actionCaches, BoardPartPlayMode playMode)
	{
		if (actionCaches == null || actionCaches.Count == 0)
		{
			return null;
		}
		if (playMode == BoardPartPlayMode.Fixed || actionCaches.Count == 1)
		{
			return actionCaches[0];
		}
		int index = new System.Random().Next(actionCaches.Count);
		return actionCaches[index];
	}

	protected override void OnDestroy()
	{
		_voiceGroup?.Dispose();
		Singleton<AudioSystem>.Instance?.UnRegisterGroup(VoiceGroupEnum.SpinePlay);
		if (_loadedSpines != null)
		{
			foreach (GameObject value in _loadedSpines.Values)
			{
				UnityEngine.Object.Destroy(value);
			}
			_loadedSpines.Clear();
		}
		if (_initBgmId > 0)
		{
			Singleton<AudioSystem>.Instance?.PlayBgmWithIdCheck(_initBgmId, new FMOD_Define.BgmParameter(1f, null, canReturn: false, (STOP_MODE)0));
		}
		else
		{
			Singleton<AudioSystem>.Instance?.StopCurBgm((STOP_MODE)0);
		}
		base.OnDestroy();
	}

	private new void Awake()
	{
		Input.multiTouchEnabled = true;
	}

	private void Update()
	{
		if (_spineTransLeftTime > 0f)
		{
			_spineTransLeftTime -= Time.deltaTime;
			return;
		}
		ResetFrameState();
		if (!TryGetTwoPointers(out var p, out var p2, out var prev, out var prev2, out var _))
		{
			ResetGestureState();
			if (_spineTransChanged)
			{
				SaveSpineTransform();
				_spineTransChanged = false;
			}
			return;
		}
		DetectGesture(p, p2, prev, prev2);
		if (GestureType == TwoFingerGestureType.SameDirectionDrag)
		{
			Vector2 sameDragStartDirection = SameDragStartDirection;
			float sameDragSpeed = SameDragSpeed;
			MoveSpine(sameDragStartDirection, sameDragSpeed, Mathf.Max(Time.deltaTime, 0.0001f), moveTransParams, spineMoveRange);
		}
		else if (GestureType == TwoFingerGestureType.OppositeDirectionDrag)
		{
			_ = OppositeDragVelocity;
			ScaleSpine(OppositeDragVelocity, Mathf.Max(Time.deltaTime, 0.0001f), scaleTransParams, spineScaleRange);
		}
	}

	private void DetectGesture(Vector2 p0, Vector2 p1, Vector2 prev0, Vector2 prev1)
	{
		Vector2 vector = p0 - prev0;
		Vector2 vector2 = p1 - prev1;
		if (!(vector.sqrMagnitude < moveThreshold * moveThreshold) && !(vector2.sqrMagnitude < moveThreshold * moveThreshold))
		{
			float num = Mathf.Max(Time.deltaTime, 0.0001f);
			float num2 = Vector2.Dot(vector.normalized, vector2.normalized);
			Vector2 vector3 = (p0 + p1) * 0.5f;
			Vector2 vector4 = (prev0 + prev1) * 0.5f;
			Vector2 vector5 = vector3 - vector4;
			float num3 = Vector2.Distance(p0, p1);
			float num4 = Vector2.Distance(prev0, prev1);
			float num5 = num3 - num4;
			if (num2 >= sameDirectionDotThreshold)
			{
				GestureType = TwoFingerGestureType.SameDirectionDrag;
				SameDragVelocity = vector5 / num;
				SameDragStartDirection = vector5.normalized;
			}
			else if (num2 <= oppositeDirectionDotThreshold)
			{
				GestureType = TwoFingerGestureType.OppositeDirectionDrag;
				OppositeDragVelocity = num5 / num;
			}
		}
	}

	private bool TryGetTwoPointers(out Vector2 p0, out Vector2 p1, out Vector2 prev0, out Vector2 prev1, out bool gestureJustStarted)
	{
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0056: Invalid comparison between Unknown and I4
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0060: Invalid comparison between Unknown and I4
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		//IL_006a: Invalid comparison between Unknown and I4
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0074: Invalid comparison between Unknown and I4
		//IL_00c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d8: Invalid comparison between Unknown and I4
		p0 = (p1 = (prev0 = (prev1 = Vector2.zero)));
		gestureJustStarted = false;
		if (Input.touchSupported && Input.touchCount >= 2)
		{
			Touch touch = Input.GetTouch(0);
			Touch touch2 = Input.GetTouch(1);
			if ((int)((Touch)(ref touch)).phase == 3 || (int)((Touch)(ref touch2)).phase == 3 || (int)((Touch)(ref touch)).phase == 4 || (int)((Touch)(ref touch2)).phase == 4)
			{
				return false;
			}
			p0 = ((Touch)(ref touch)).position;
			p1 = ((Touch)(ref touch2)).position;
			prev0 = ((Touch)(ref touch)).position - ((Touch)(ref touch)).deltaPosition;
			prev1 = ((Touch)(ref touch2)).position - ((Touch)(ref touch2)).deltaPosition;
			gestureJustStarted = (int)((Touch)(ref touch)).phase == 0 || (int)((Touch)(ref touch2)).phase == 0;
			return true;
		}
		return false;
	}

	private void ResetFrameState()
	{
		GestureType = TwoFingerGestureType.None;
		SameDragVelocity = Vector2.zero;
		SameDragProjectedSpeed = 0f;
		OppositeDragVelocity = 0f;
	}

	private void ResetGestureState()
	{
		_hasLastMousePosition = false;
		SameDragStartDirection = Vector2.zero;
	}
}
