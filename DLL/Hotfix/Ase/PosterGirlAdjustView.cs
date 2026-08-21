using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public class PosterGirlAdjustView : UGuiView
{
	private enum AdjustMode
	{
		None,
		Scale,
		Rotation,
		Flip
	}

	private sealed class SliderHoldBlocker : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler, IBeginDragHandler, IEndDragHandler
	{
		private PosterGirlAdjustView _owner;

		public void Bind(PosterGirlAdjustView owner)
		{
			_owner = owner;
		}

		public void OnPointerDown(PointerEventData eventData)
		{
			if (_owner != null)
			{
				_owner._sliderHolding = true;
				_owner.RefreshLongPressDetectGate();
				_owner.SetSpineAnimPaused(paused: true);
			}
		}

		public void OnBeginDrag(PointerEventData eventData)
		{
			if (_owner != null)
			{
				_owner._sliderHolding = true;
				_owner.RefreshLongPressDetectGate();
				_owner.SetSpineAnimPaused(paused: true);
			}
		}

		public void OnPointerUp(PointerEventData eventData)
		{
			if (_owner != null)
			{
				_owner._sliderHolding = false;
				_owner.RefreshLongPressDetectGate();
				_owner.SetSpineAnimPaused(paused: false);
			}
		}

		public void OnEndDrag(PointerEventData eventData)
		{
			if (_owner != null)
			{
				_owner._sliderHolding = false;
				_owner.RefreshLongPressDetectGate();
				_owner.SetSpineAnimPaused(paused: false);
			}
		}
	}

	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private Button resetBtn;

	[SerializeField]
	private Button rotateBtn;

	[SerializeField]
	private Button scaleBtn;

	[SerializeField]
	private Button reverseBtn;

	[SerializeField]
	private Button previewBtn;

	[SerializeField]
	private GameObject rotateSelect;

	[SerializeField]
	private GameObject scaleSelect;

	[SerializeField]
	private GameObject reverseSelect;

	[SerializeField]
	private GameObject heroSpineLayoutPanel;

	[SerializeField]
	private Slider slider;

	[SerializeField]
	private TextMeshProUGUI curSlider;

	[SerializeField]
	private TextMeshProUGUI sliderMin;

	[SerializeField]
	private TextMeshProUGUI sliderMax;

	[SerializeField]
	private Button btnSliderRed;

	[SerializeField]
	private Button btnSliderAdd;

	[SerializeField]
	private GameObject sliderRedMask;

	[SerializeField]
	private GameObject sliderAddMask;

	[SerializeField]
	private Button btnResetSlider;

	[SerializeField]
	private Button saveBtn;

	[SerializeField]
	private GameObject saveBtnMask;

	[SerializeField]
	private float scaleMin;

	[SerializeField]
	private float scaleMax;

	[SerializeField]
	private float scaleInit;

	[SerializeField]
	private float scaleParameter;

	[SerializeField]
	private float rotationMin;

	[SerializeField]
	private float rotationMax;

	[SerializeField]
	private float rotationInit;

	[SerializeField]
	private float rotationParameter;

	private PosterGirlAdjustViewModel viewModel;

	private BoardHeroChangeView parentView;

	private AdjustMode _mode;

	private bool _ignoreSliderCallback;

	private readonly List<GameObject> _dragHideObjects = new List<GameObject>();

	private readonly HashSet<GameObject> _dragHideObjectSet = new HashSet<GameObject>();

	private bool[] _dragHidePrevActive;

	private bool _inputLocked;

	private Selectable[] _cachedSelectables;

	private bool[] _cachedInteractable;

	private bool _adjustViewOpen;

	private bool _sliderHolding;

	private const float SaveEpsilon = 0.0001f;

	private readonly Dictionary<int, float> _pendingScale = new Dictionary<int, float>();

	private readonly Dictionary<int, float> _pendingRotation = new Dictionary<int, float>();

	private readonly Dictionary<int, bool> _pendingFlipY = new Dictionary<int, bool>();

	private readonly Dictionary<int, Vector2> _pendingAnchoredPos = new Dictionary<int, Vector2>();

	public float RotationInitValue => rotationInit;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<PosterGirlAdjustViewModel>(userData);
		this.CreateBindingSet(viewModel).Build();
		resetBtn.onClick.AddListener(OnResetAllToDefaultClick);
		previewBtn.onClick.AddListener(PreviewHeroSpine);
		backBtn.onClick.AddListener(OnClickExitAdjustConfirm);
		scaleBtn.onClick.AddListener(delegate
		{
			SwitchMode(AdjustMode.Scale);
		});
		rotateBtn.onClick.AddListener(delegate
		{
			SwitchMode(AdjustMode.Rotation);
		});
		reverseBtn.onClick.AddListener(delegate
		{
			SwitchMode(AdjustMode.Flip);
			ToggleFlipY();
		});
		saveBtn.onClick.AddListener(OnSaveBtnClick);
		InitSharedSlider();
		EnterAdjustView();
	}

	private void OnSaveBtnClick()
	{
		int curBoardHeroIdSafe = GetCurBoardHeroIdSafe();
		PersistScale(curBoardHeroIdSafe, GetCurrentScaleForUI(curBoardHeroIdSafe));
		PersistRotation(curBoardHeroIdSafe, GetCurrentRotationForUI(curBoardHeroIdSafe));
		PersistFlipY(curBoardHeroIdSafe, GetCurrentFlipYForUI(curBoardHeroIdSafe));
		PersistAnchoredPos(curBoardHeroIdSafe, GetCurrentAnchoredPosForUI(curBoardHeroIdSafe));
		ClearPendingAdjust(curBoardHeroIdSafe);
		PlayerPrefs.Save();
		AdjustViewActive();
	}

	private void OnResetAllToDefaultClick()
	{
		IAsyncResult<int> result = AlertDialog.Show("", "确定将所有参数恢复默认？", "确定", "取消");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				DRBoardHeroList dRBoardHeroList = ((parentView != null) ? parentView.GetCurrentBoardHeroConfig() : null);
				RectTransform rectTransform = ((parentView != null) ? parentView.GetSpineRoot() : null);
				if (dRBoardHeroList != null && !(rectTransform == null))
				{
					int id = dRBoardHeroList.Id;
					Vector2 defaultAnchoredPos = GetDefaultAnchoredPos(dRBoardHeroList);
					SetPendingScale(id, scaleInit);
					SetPendingRotation(id, rotationInit);
					SetPendingFlipY(id, value: false);
					SetPendingAnchoredPos(id, defaultAnchoredPos);
					rectTransform.anchoredPosition = defaultAnchoredPos;
					ApplyRotation(rectTransform, rotationInit, flipY: false);
					UpdateSpineScale(scaleInit);
					EnterAdjustView();
				}
			}
		});
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		_adjustViewOpen = true;
		_sliderHolding = false;
		RefreshLongPressDetectGate();
		EnterAdjustView();
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		_adjustViewOpen = false;
		_sliderHolding = false;
		RefreshLongPressDetectGate();
		SetSpineAnimPaused(paused: false);
	}

	public void SetParentView(BoardHeroChangeView parentView)
	{
		this.parentView = parentView;
	}

	public void RefreshAdjustSliderForCurrentHero()
	{
		if (_mode == AdjustMode.Scale)
		{
			RefreshScaleSliderForCurrentHero();
		}
		else if (_mode == AdjustMode.Rotation)
		{
			RefreshRotationSliderForCurrentHero();
		}
	}

	private void EnterAdjustView()
	{
		_mode = AdjustMode.None;
		ApplyButtonVisual(_mode);
		if (heroSpineLayoutPanel != null)
		{
			heroSpineLayoutPanel.SetActive(value: false);
		}
	}

	private void SwitchMode(AdjustMode mode)
	{
		if (_mode == mode)
		{
			ApplyPanelVisibleByMode(_mode);
			ApplyButtonVisual(_mode);
			return;
		}
		_mode = mode;
		ApplyButtonVisual(_mode);
		ApplyPanelVisibleByMode(_mode);
		if (_mode == AdjustMode.Scale)
		{
			RefreshScaleSliderForCurrentHero();
		}
		else if (_mode == AdjustMode.Rotation)
		{
			RefreshRotationSliderForCurrentHero();
		}
	}

	private void ApplyPanelVisibleByMode(AdjustMode mode)
	{
		if (!(heroSpineLayoutPanel == null))
		{
			bool active = mode == AdjustMode.Scale || mode == AdjustMode.Rotation;
			heroSpineLayoutPanel.SetActive(active);
		}
	}

	private void ApplyButtonVisual(AdjustMode mode)
	{
		SetSelected(scaleSelect, mode == AdjustMode.Scale);
		SetSelected(rotateSelect, mode == AdjustMode.Rotation);
		SetSelected(reverseSelect, mode == AdjustMode.Flip);
	}

	private static void SetSelected(GameObject selectObj, bool selected)
	{
		if (selectObj != null)
		{
			selectObj.SetActive(selected);
		}
	}

	private void PreviewHeroSpine()
	{
		parentView?.RequestEnterMainPreview();
	}

	private void OnClickExitAdjustConfirm()
	{
		int id = GetCurBoardHeroIdSafe();
		if (id <= 0 || !HasPendingAdjust(id))
		{
			AdjustViewActive();
			return;
		}
		IAsyncResult<int> result = AlertDialog.Show("确认退出", "本次调整未保存，是否放弃修改？", "确定", "取消");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				RevertUnsavedAdjustToSaved(id);
				AdjustViewActive();
			}
		});
	}

	private void RevertUnsavedAdjustToSaved(int boardHeroId)
	{
		DRBoardHeroList obj = ((parentView != null) ? parentView.GetCurrentBoardHeroConfig() : null);
		RectTransform rectTransform = ((parentView != null) ? parentView.GetSpineRoot() : null);
		if (obj != null && !(rectTransform == null))
		{
			ClearPendingAdjust(boardHeroId);
			Vector2 savedAnchoredPos = GetSavedAnchoredPos(boardHeroId);
			float savedScale = GetSavedScale(boardHeroId);
			float savedRotation = GetSavedRotation(boardHeroId);
			bool savedFlipY = GetSavedFlipY(boardHeroId);
			rectTransform.anchoredPosition = savedAnchoredPos;
			UpdateSpineScale(savedScale);
			ApplyRotation(rectTransform, savedRotation, savedFlipY);
			if (_mode == AdjustMode.Scale)
			{
				SetScaleSlider(scaleMin, scaleMax, savedScale);
			}
			else if (_mode == AdjustMode.Rotation)
			{
				SetRotationSlider(rotationMin, rotationMax, savedRotation);
			}
		}
	}

	private void AdjustViewActive()
	{
		_sliderHolding = false;
		RefreshLongPressDetectGate();
		base.gameObject.SetActive(value: false);
		parentView.ShowViewLeftAndRightRoot();
	}

	public void SetSpineAnimPaused(bool paused)
	{
		RectTransform rectTransform = ((parentView != null) ? parentView.GetSpineRoot() : null);
		if (!(rectTransform == null))
		{
			SpineFusion componentInChildren = rectTransform.GetComponentInChildren<SpineFusion>(includeInactive: true);
			if (!((UnityEngine.Object)(object)componentInChildren == null) && !((UnityEngine.Object)(object)componentInChildren.SkeletonGraphic == null))
			{
				componentInChildren.SkeletonGraphic.freeze = paused;
			}
		}
	}

	private void InitSharedSlider()
	{
		if (slider != null)
		{
			slider.onValueChanged.AddListener(OnAdjustSliderChanged);
		}
		if (btnSliderRed != null)
		{
			btnSliderRed.onClick.AddListener(OnSliderRedClick);
		}
		if (btnSliderAdd != null)
		{
			btnSliderAdd.onClick.AddListener(OnSliderAddClick);
		}
		if (btnResetSlider != null)
		{
			btnResetSlider.onClick.AddListener(OnSliderResetClick);
		}
		if (slider != null)
		{
			SliderHoldBlocker sliderHoldBlocker = slider.gameObject.GetComponent<SliderHoldBlocker>();
			if (sliderHoldBlocker == null)
			{
				sliderHoldBlocker = slider.gameObject.AddComponent<SliderHoldBlocker>();
			}
			sliderHoldBlocker.Bind(this);
			_sliderHolding = false;
			RefreshLongPressDetectGate();
		}
	}

	private void OnAdjustSliderChanged(float value)
	{
		if (!_ignoreSliderCallback)
		{
			if (_mode == AdjustMode.Scale)
			{
				OnScaleSliderChanged(value);
			}
			else if (_mode == AdjustMode.Rotation)
			{
				OnRotationSliderChanged(value);
			}
		}
	}

	private void OnSliderRedClick()
	{
		if (!(slider == null))
		{
			float num = ((_mode == AdjustMode.Rotation) ? rotationParameter : scaleParameter);
			slider.value = Math.Max(slider.minValue, slider.value - num);
		}
	}

	private void OnSliderAddClick()
	{
		if (!(slider == null))
		{
			float num = ((_mode == AdjustMode.Rotation) ? rotationParameter : scaleParameter);
			slider.value = Math.Min(slider.maxValue, slider.value + num);
		}
	}

	private void OnSliderResetClick()
	{
		if (slider == null || _mode == AdjustMode.None)
		{
			return;
		}
		float init = ((_mode == AdjustMode.Rotation) ? rotationInit : scaleInit);
		IAsyncResult<int> result = AlertDialog.Show("确认框", "确定将参数恢复默认？", "确认", "取消");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				slider.value = ((init < slider.minValue || init > slider.maxValue) ? ((slider.maxValue - slider.minValue) / 2f) : init);
			}
		});
	}

	public void RefreshScaleSliderForCurrentHero()
	{
		DRBoardHeroList dRBoardHeroList = ((parentView != null) ? parentView.GetCurrentBoardHeroConfig() : null);
		if (dRBoardHeroList == null)
		{
			if (heroSpineLayoutPanel != null)
			{
				heroSpineLayoutPanel.SetActive(value: false);
			}
		}
		else
		{
			float currentScaleForUI = GetCurrentScaleForUI(dRBoardHeroList.Id);
			SetScaleSlider(scaleMin, scaleMax, currentScaleForUI);
		}
	}

	private void SetScaleSlider(float min, float max, float cur)
	{
		if (!(slider == null) && !(max < min))
		{
			if (float.IsNaN(cur) || float.IsInfinity(cur))
			{
				cur = scaleInit;
			}
			if (cur < min || cur > max)
			{
				cur = (max - min) / 2f;
			}
			_ignoreSliderCallback = true;
			slider.minValue = min;
			slider.maxValue = max;
			slider.SetValueWithoutNotify(cur);
			_ignoreSliderCallback = false;
			if ((UnityEngine.Object)(object)sliderMin != null)
			{
				((TMP_Text)sliderMin).text = $"{min}x";
			}
			if ((UnityEngine.Object)(object)sliderMax != null)
			{
				((TMP_Text)sliderMax).text = $"{max}x";
			}
			if ((UnityEngine.Object)(object)curSlider != null)
			{
				((TMP_Text)curSlider).text = $"当前大小:{Math.Round(cur, 1)}x";
			}
			UpdateSpineScale(cur);
			UpdateSliderBtnState();
		}
	}

	private void OnScaleSliderChanged(float value)
	{
		if ((UnityEngine.Object)(object)curSlider != null)
		{
			((TMP_Text)curSlider).text = $"当前大小:{Math.Round(value, 1)}x";
		}
		UpdateSpineScale(value);
		UpdateSliderBtnState();
		DRBoardHeroList dRBoardHeroList = ((parentView != null) ? parentView.GetCurrentBoardHeroConfig() : null);
		if (dRBoardHeroList != null)
		{
			SetPendingScale(dRBoardHeroList.Id, value);
		}
	}

	private void UpdateSpineScale(float curScale)
	{
		DRBoardHeroList dRBoardHeroList = ((parentView != null) ? parentView.GetCurrentBoardHeroConfig() : null);
		RectTransform rectTransform = ((parentView != null) ? parentView.GetSpineRoot() : null);
		if (dRBoardHeroList != null && !(rectTransform == null))
		{
			Vector3 localScale = new Vector3((dRBoardHeroList.Scale.Count > 0) ? dRBoardHeroList.Scale[0] : 1f, (dRBoardHeroList.Scale.Count > 1) ? dRBoardHeroList.Scale[1] : 1f, (dRBoardHeroList.Scale.Count > 2) ? dRBoardHeroList.Scale[2] : 1f) * curScale;
			if (GetCurrentFlipYForUI(dRBoardHeroList.Id))
			{
				localScale.x = 0f - localScale.x;
			}
			rectTransform.localScale = localScale;
		}
	}

	private void UpdateSliderBtnState()
	{
		if (!(slider == null))
		{
			if (btnSliderRed != null)
			{
				btnSliderRed.enabled = slider.value > slider.minValue;
			}
			if (sliderRedMask != null)
			{
				sliderRedMask.SetActive(slider.value <= slider.minValue);
			}
			if (btnSliderAdd != null)
			{
				btnSliderAdd.enabled = slider.value < slider.maxValue;
			}
			if (sliderAddMask != null)
			{
				sliderAddMask.SetActive(slider.value >= slider.maxValue);
			}
		}
	}

	public void RefreshRotationSliderForCurrentHero()
	{
		DRBoardHeroList dRBoardHeroList = ((parentView != null) ? parentView.GetCurrentBoardHeroConfig() : null);
		if (dRBoardHeroList == null)
		{
			if (heroSpineLayoutPanel != null)
			{
				heroSpineLayoutPanel.SetActive(value: false);
			}
		}
		else
		{
			float currentRotationForUI = GetCurrentRotationForUI(dRBoardHeroList.Id);
			SetRotationSlider(rotationMin, rotationMax, currentRotationForUI);
		}
	}

	private void SetRotationSlider(float min, float max, float cur)
	{
		if (!(slider == null) && !(max < min))
		{
			if (float.IsNaN(cur) || float.IsInfinity(cur))
			{
				cur = rotationInit;
			}
			if (cur < min || cur > max)
			{
				cur = (max - min) / 2f;
			}
			_ignoreSliderCallback = true;
			slider.minValue = min;
			slider.maxValue = max;
			slider.SetValueWithoutNotify(cur);
			_ignoreSliderCallback = false;
			if ((UnityEngine.Object)(object)sliderMin != null)
			{
				((TMP_Text)sliderMin).text = $"{min}°";
			}
			if ((UnityEngine.Object)(object)sliderMax != null)
			{
				((TMP_Text)sliderMax).text = $"{max}°";
			}
			if ((UnityEngine.Object)(object)curSlider != null)
			{
				((TMP_Text)curSlider).text = $"当前角度:{Math.Round(cur, 1)}°";
			}
			UpdateSpineRotation(cur);
			UpdateSliderBtnState();
		}
	}

	private void OnRotationSliderChanged(float value)
	{
		if ((UnityEngine.Object)(object)curSlider != null)
		{
			((TMP_Text)curSlider).text = $"当前角度:{Math.Round(value, 1)}°";
		}
		UpdateSpineRotation(value);
		UpdateSliderBtnState();
		DRBoardHeroList dRBoardHeroList = ((parentView != null) ? parentView.GetCurrentBoardHeroConfig() : null);
		if (dRBoardHeroList != null)
		{
			SetPendingRotation(dRBoardHeroList.Id, value);
		}
	}

	private void UpdateSpineRotation(float rotZ)
	{
		DRBoardHeroList dRBoardHeroList = ((parentView != null) ? parentView.GetCurrentBoardHeroConfig() : null);
		RectTransform rectTransform = ((parentView != null) ? parentView.GetSpineRoot() : null);
		if (dRBoardHeroList != null && !(rectTransform == null))
		{
			bool currentFlipYForUI = GetCurrentFlipYForUI(dRBoardHeroList.Id);
			ApplyRotation(rectTransform, rotZ, currentFlipYForUI);
		}
	}

	private void ToggleFlipY()
	{
		DRBoardHeroList dRBoardHeroList = ((parentView != null) ? parentView.GetCurrentBoardHeroConfig() : null);
		RectTransform rectTransform = ((parentView != null) ? parentView.GetSpineRoot() : null);
		if (dRBoardHeroList != null && !(rectTransform == null))
		{
			bool flag = !GetCurrentFlipYForUI(dRBoardHeroList.Id);
			SetPendingFlipY(dRBoardHeroList.Id, flag);
			float currentRotationForUI = GetCurrentRotationForUI(dRBoardHeroList.Id);
			float currentScaleForUI = GetCurrentScaleForUI(dRBoardHeroList.Id);
			ApplyRotation(rectTransform, currentRotationForUI, flag);
			UpdateSpineScale(currentScaleForUI);
		}
	}

	private float GetSavedRotationZ(int boardHeroId)
	{
		return PlayerPrefs.GetFloat(GetBoardSpineRotationPrefKey(boardHeroId), rotationInit);
	}

	private bool GetSavedFlipY(int boardHeroId)
	{
		return PlayerPrefs.GetInt(GetBoardSpineFlipYPrefKey(boardHeroId), 0) == 1;
	}

	private static void ApplyRotation(RectTransform spineRoot, float rotZ, bool flipY)
	{
		spineRoot.localRotation = Quaternion.Euler(0f, 0f, rotZ);
	}

	public int GetCurrentBoardHeroId()
	{
		return ((parentView != null) ? parentView.GetCurrentBoardHeroConfig() : null)?.Id ?? 0;
	}

	public void OnSpineAnchoredPosChanged(Vector2 anchoredPos)
	{
		int curBoardHeroIdSafe = GetCurBoardHeroIdSafe();
		if (curBoardHeroIdSafe > 0)
		{
			SetPendingAnchoredPos(curBoardHeroIdSafe, anchoredPos);
		}
	}

	public static void SaveBoardHeroSpineAnchoredPos(int boardHeroId, Vector2 anchoredPos)
	{
		PlayerPrefs.SetFloat(GetBoardSpinePosXPrefKey(boardHeroId), anchoredPos.x);
		PlayerPrefs.SetFloat(GetBoardSpinePosYPrefKey(boardHeroId), anchoredPos.y);
	}

	public static bool TryLoadBoardHeroSpineAnchoredPos(int boardHeroId, out Vector2 anchoredPos)
	{
		string boardSpinePosXPrefKey = GetBoardSpinePosXPrefKey(boardHeroId);
		string boardSpinePosYPrefKey = GetBoardSpinePosYPrefKey(boardHeroId);
		if (!PlayerPrefs.HasKey(boardSpinePosXPrefKey) || !PlayerPrefs.HasKey(boardSpinePosYPrefKey))
		{
			anchoredPos = default(Vector2);
			return false;
		}
		anchoredPos = new Vector2(PlayerPrefs.GetFloat(boardSpinePosXPrefKey), PlayerPrefs.GetFloat(boardSpinePosYPrefKey));
		return true;
	}

	public RectTransform GetSpineRootForAdjust()
	{
		if (!(parentView != null))
		{
			return null;
		}
		return parentView.GetSpineRoot();
	}

	private void CacheDragHideObjectsIfNeeded()
	{
		if (_dragHideObjects.Count <= 0)
		{
			AddSelectable(backBtn);
			AddSelectable(resetBtn);
			AddSelectable(rotateBtn);
			AddSelectable(scaleBtn);
			AddSelectable(reverseBtn);
			AddSelectable(previewBtn);
			AddGO(heroSpineLayoutPanel);
			AddGO(rotateSelect);
			AddGO(scaleSelect);
			AddGO(reverseSelect);
			AddSelectable(saveBtn);
			AddGO(saveBtnMask);
		}
		void AddGO(GameObject go)
		{
			if (!(go == null) && !_dragHideObjectSet.Contains(go))
			{
				_dragHideObjectSet.Add(go);
				_dragHideObjects.Add(go);
			}
		}
		void AddSelectable(Selectable s)
		{
			if (!(s == null))
			{
				AddGO(s.gameObject);
			}
		}
	}

	private void SetAdjustControlsVisibleForDrag(bool visible)
	{
		CacheDragHideObjectsIfNeeded();
		if (visible)
		{
			if (_dragHidePrevActive == null)
			{
				return;
			}
			for (int i = 0; i < _dragHideObjects.Count; i++)
			{
				GameObject gameObject = _dragHideObjects[i];
				if (!(gameObject == null))
				{
					gameObject.SetActive(_dragHidePrevActive[i]);
				}
			}
			_dragHidePrevActive = null;
			return;
		}
		_dragHidePrevActive = new bool[_dragHideObjects.Count];
		for (int j = 0; j < _dragHideObjects.Count; j++)
		{
			GameObject gameObject2 = _dragHideObjects[j];
			if (gameObject2 == null)
			{
				_dragHidePrevActive[j] = false;
				continue;
			}
			_dragHidePrevActive[j] = gameObject2.activeSelf;
			gameObject2.SetActive(value: false);
		}
	}

	public void SetInputLocked(bool locked)
	{
		if (_inputLocked == locked)
		{
			return;
		}
		_inputLocked = locked;
		if (_cachedSelectables == null)
		{
			_cachedSelectables = GetComponentsInChildren<Selectable>(includeInactive: true);
		}
		if (locked)
		{
			SetAdjustControlsVisibleForDrag(visible: false);
			_cachedInteractable = new bool[_cachedSelectables.Length];
			for (int i = 0; i < _cachedSelectables.Length; i++)
			{
				Selectable selectable = _cachedSelectables[i];
				if (!(selectable == null))
				{
					_cachedInteractable[i] = selectable.interactable;
					selectable.interactable = false;
				}
			}
			if (EventSystem.current != null)
			{
				EventSystem.current.SetSelectedGameObject(null);
			}
			return;
		}
		SetAdjustControlsVisibleForDrag(visible: true);
		if (_cachedInteractable != null)
		{
			for (int j = 0; j < _cachedSelectables.Length; j++)
			{
				Selectable selectable2 = _cachedSelectables[j];
				if (!(selectable2 == null))
				{
					selectable2.interactable = _cachedInteractable[j];
				}
			}
		}
		_cachedInteractable = null;
	}

	private static string GetAccountKeyPrefix()
	{
		long num = (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData())?.Uid ?? 0;
		return $"ACC_{num}_";
	}

	private BoardHeroSpineLongPressDrag GetLongPressDrag()
	{
		RectTransform rectTransform = ((parentView != null) ? parentView.GetSpineRoot() : null);
		if (rectTransform == null)
		{
			return null;
		}
		return rectTransform.GetComponent<BoardHeroSpineLongPressDrag>() ?? rectTransform.GetComponentInChildren<BoardHeroSpineLongPressDrag>(includeInactive: true);
	}

	private void RefreshLongPressDetectGate()
	{
		BoardHeroSpineLongPressDrag longPressDrag = GetLongPressDrag();
		if (!(longPressDrag == null))
		{
			longPressDrag.SetLongPressDetectEnabled(_adjustViewOpen && !_sliderHolding);
		}
	}

	private int GetCurBoardHeroIdSafe()
	{
		return ((parentView != null) ? parentView.GetCurrentBoardHeroConfig() : null)?.Id ?? 0;
	}

	private float GetSavedScale(int boardHeroId)
	{
		return PlayerPrefs.GetFloat(GetBoardSpineScalePrefKey(boardHeroId), scaleInit);
	}

	private float GetSavedRotation(int boardHeroId)
	{
		return PlayerPrefs.GetFloat(GetBoardSpineRotationPrefKey(boardHeroId), rotationInit);
	}

	private bool GetCurrentFlipYForUI(int boardHeroId)
	{
		if (!_pendingFlipY.TryGetValue(boardHeroId, out var value))
		{
			return GetSavedFlipY(boardHeroId);
		}
		return value;
	}

	private Vector2 GetCurrentAnchoredPosForUI(int boardHeroId)
	{
		if (!_pendingAnchoredPos.TryGetValue(boardHeroId, out var value))
		{
			return GetSavedAnchoredPos(boardHeroId);
		}
		return value;
	}

	private float GetCurrentScaleForUI(int boardHeroId)
	{
		if (!_pendingScale.TryGetValue(boardHeroId, out var value))
		{
			return GetSavedScale(boardHeroId);
		}
		return value;
	}

	private float GetCurrentRotationForUI(int boardHeroId)
	{
		if (!_pendingRotation.TryGetValue(boardHeroId, out var value))
		{
			return GetSavedRotation(boardHeroId);
		}
		return value;
	}

	private void SetPendingScale(int boardHeroId, float value)
	{
		float savedScale = GetSavedScale(boardHeroId);
		if (Math.Abs(value - savedScale) <= 0.0001f)
		{
			_pendingScale.Remove(boardHeroId);
		}
		else
		{
			_pendingScale[boardHeroId] = value;
		}
	}

	private void SetPendingRotation(int boardHeroId, float value)
	{
		float savedRotation = GetSavedRotation(boardHeroId);
		if (Math.Abs(value - savedRotation) <= 0.0001f)
		{
			_pendingRotation.Remove(boardHeroId);
		}
		else
		{
			_pendingRotation[boardHeroId] = value;
		}
	}

	private void SetPendingFlipY(int boardHeroId, bool value)
	{
		bool savedFlipY = GetSavedFlipY(boardHeroId);
		if (value == savedFlipY)
		{
			_pendingFlipY.Remove(boardHeroId);
		}
		else
		{
			_pendingFlipY[boardHeroId] = value;
		}
	}

	private void SetPendingAnchoredPos(int boardHeroId, Vector2 value)
	{
		Vector2 savedAnchoredPos = GetSavedAnchoredPos(boardHeroId);
		if (IsSameVector2(value, savedAnchoredPos))
		{
			_pendingAnchoredPos.Remove(boardHeroId);
		}
		else
		{
			_pendingAnchoredPos[boardHeroId] = value;
		}
	}

	private bool HasPendingAdjust(int boardHeroId)
	{
		if (!_pendingScale.ContainsKey(boardHeroId) && !_pendingRotation.ContainsKey(boardHeroId) && !_pendingFlipY.ContainsKey(boardHeroId))
		{
			return _pendingAnchoredPos.ContainsKey(boardHeroId);
		}
		return true;
	}

	private void ClearPendingAdjust(int boardHeroId)
	{
		_pendingScale.Remove(boardHeroId);
		_pendingRotation.Remove(boardHeroId);
		_pendingFlipY.Remove(boardHeroId);
		_pendingAnchoredPos.Remove(boardHeroId);
	}

	private void PersistScale(int boardHeroId, float value)
	{
		SaveFloatOrDelete(GetBoardSpineScalePrefKey(boardHeroId), value, scaleInit);
	}

	private void PersistRotation(int boardHeroId, float value)
	{
		SaveFloatOrDelete(GetBoardSpineRotationPrefKey(boardHeroId), value, rotationInit);
	}

	private void PersistFlipY(int boardHeroId, bool value)
	{
		if (!value)
		{
			PlayerPrefs.DeleteKey(GetBoardSpineFlipYPrefKey(boardHeroId));
		}
		else
		{
			PlayerPrefs.SetInt(GetBoardSpineFlipYPrefKey(boardHeroId), 1);
		}
	}

	private void PersistAnchoredPos(int boardHeroId, Vector2 value)
	{
		Vector2 defaultAnchoredPos = GetDefaultAnchoredPos(boardHeroId);
		if (IsSameVector2(value, defaultAnchoredPos))
		{
			DeleteBoardHeroSpineAnchoredPos(boardHeroId);
		}
		else
		{
			SaveBoardHeroSpineAnchoredPos(boardHeroId, value);
		}
	}

	private Vector2 GetSavedAnchoredPos(int boardHeroId)
	{
		if (TryLoadBoardHeroSpineAnchoredPos(boardHeroId, out var anchoredPos))
		{
			return anchoredPos;
		}
		return GetDefaultAnchoredPos(boardHeroId);
	}

	private Vector2 GetDefaultAnchoredPos(int boardHeroId)
	{
		return GetDefaultAnchoredPos(GetBoardHeroConfigById(boardHeroId));
	}

	private static Vector2 GetDefaultAnchoredPos(DRBoardHeroList drHero)
	{
		if (drHero == null)
		{
			return Vector2.zero;
		}
		return new Vector2((drHero.Position.Count > 0) ? drHero.Position[0] : 0f, (drHero.Position.Count > 1) ? drHero.Position[1] : 0f);
	}

	private DRBoardHeroList GetBoardHeroConfigById(int boardHeroId)
	{
		DRBoardHeroList dRBoardHeroList = ((parentView != null) ? parentView.GetCurrentBoardHeroConfig() : null);
		if (dRBoardHeroList != null && dRBoardHeroList.Id == boardHeroId)
		{
			return dRBoardHeroList;
		}
		return GameEntry.DataTable.GetDataRow<DRBoardHeroList>(boardHeroId);
	}

	private static void SaveFloatOrDelete(string key, float value, float defaultValue)
	{
		if (Math.Abs(value - defaultValue) <= 0.0001f)
		{
			PlayerPrefs.DeleteKey(key);
		}
		else
		{
			PlayerPrefs.SetFloat(key, value);
		}
	}

	private static void DeleteBoardHeroSpineAnchoredPos(int boardHeroId)
	{
		PlayerPrefs.DeleteKey(GetBoardSpinePosXPrefKey(boardHeroId));
		PlayerPrefs.DeleteKey(GetBoardSpinePosYPrefKey(boardHeroId));
	}

	private static bool IsSameVector2(Vector2 left, Vector2 right)
	{
		if (Math.Abs(left.x - right.x) <= 0.0001f)
		{
			return Math.Abs(left.y - right.y) <= 0.0001f;
		}
		return false;
	}

	private static string WithAccountPrefix(string rawKey)
	{
		return GetAccountKeyPrefix() + rawKey;
	}

	public static string GetBoardSpineScalePrefKey(int boardHeroId)
	{
		return WithAccountPrefix($"Spine_Scale_{boardHeroId}");
	}

	public static string GetBoardSpineRotationPrefKey(int boardHeroId)
	{
		return WithAccountPrefix($"Spine_Rotation_{boardHeroId}");
	}

	public static string GetBoardSpineFlipYPrefKey(int boardHeroId)
	{
		return WithAccountPrefix($"Spine_FlipY_{boardHeroId}");
	}

	public static string GetBoardSpinePosXPrefKey(int boardHeroId)
	{
		return WithAccountPrefix($"Spine_PosX_{boardHeroId}");
	}

	public static string GetBoardSpinePosYPrefKey(int boardHeroId)
	{
		return WithAccountPrefix($"Spine_PosY_{boardHeroId}");
	}
}
