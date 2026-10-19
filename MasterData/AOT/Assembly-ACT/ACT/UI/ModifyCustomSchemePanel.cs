using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Model;
using ACT.Utility;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UI.CommonComponent.UIComponentEx;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class ModifyCustomSchemePanel : LuminSerializedMonoBehaviour
{
	[SerializeReference]
	private ActButton closeBtn;

	[SerializeReference]
	private BetterAnimation sidebarAnimation;

	[SerializeReference]
	private GameObject sideBarObj;

	[SerializeReference]
	private Button openBarBtn;

	[SerializeReference]
	private Button closeBarBtn;

	[SerializeReference]
	private SchemeBarClickBtn selectSchemeBtn;

	[SerializeReference]
	private ActSlider diameterSlider;

	[SerializeReference]
	private GameObject diameterTextRoot;

	[SerializeReference]
	private GameObject recommendRoot;

	[SerializeReference]
	private TextMeshProUGUI diameterText;

	[SerializeReference]
	private ActButton modifyPosBtnUp;

	[SerializeReference]
	private ActButton modifyPosBtnDown;

	[SerializeReference]
	private ActButton modifyPosBtnLeft;

	[SerializeReference]
	private ActButton modifyPosBtnRight;

	[SerializeField]
	private float posModifyStepValue = 5f;

	[SerializeReference]
	private SchemeSelectBar _schemeSelectBar;

	[SerializeReference]
	private GameObject _operateRoot;

	[SerializeReference]
	private ActButton saveBtn;

	[SerializeReference]
	private LocalizeStringEvent saveBtnTxt;

	[SerializeReference]
	private ActButton resetBtn;

	public List<ModifyPanelCompBase> _compRoot;

	private ModifyPanelData _data;

	private ModifyPanelCompBase _selectComp;

	private bool _hasCompOverlap;

	private readonly Dictionary<ModifyPanelCompBase, int> _compOriginalSiblingIndexes = new Dictionary<ModifyPanelCompBase, int>();

	private Action _onHide;

	private bool _operateBarIsOpen;

	private bool _schemeSelectBarIsOpen;

	private CustomUICompType _modifyDiameterCompType;

	private int _saveAsSourceSchemeId;

	private int _saveAsSchemeId;

	private string _saveAsOriginalName;

	private float _posModifyStep
	{
		get
		{
			if (!(posModifyStepValue > 0f))
			{
				return Model<CustomUIModel>.Interface.Scheme.Standard.PosModifyStep;
			}
			return posModifyStepValue;
		}
	}

	public void Show(Action onHide)
	{
		gameObject.SetActive(value: true);
		_onHide = onHide;
		closeBtn?.SetBtnClick(Hide);
		selectSchemeBtn?.SetBtnClick(TriggerSchemeSelectBar);
		saveBtn?.SetBtnClick(SaveAsOrSaveModify);
		resetBtn?.SetBtnClick(ResetScheme);
		openBarBtn?.SetBtnClick(() =>
		{
			ShowSidebar();
			sidebarAnimation?.GetSequence("Expend").Play();
		});
		closeBarBtn?.SetBtnClick(HideSidebar);
		_schemeSelectBar?.Init(this);
		UpdateSchemeSelectBtn();
		CacheCompOriginalSiblingIndexes();
		SelectDefaultScheme();
		ShowSidebar();
		sidebarAnimation?.GetSequence("Show").Play();
	}

	public void Hide()
	{
		if (_data != null && _data.Dirty)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPTEXTPANEL_LITE_, new PopUpTextPanel_Lite_Data
			{
				commonId = (_data.CanSaveAs ? 2648 : 1582),
				cancelBtnDes = (_data.CanSaveAs ? 2647 : 14),
				confirmBtnDes = (_data.CanSaveAs ? 1604 : 13),
				OnConfirm = () =>
				{
					if (!BlockSaveWhenOverlap())
					{
						if (_data.CanSaveAs)
						{
							if (Model<CustomUIModel>.Interface.Scheme.CanAddCustomScheme())
							{
								SaveCurSchemeModifyAsNew();
							}
							else
							{
								GameUtility.OpenToolTip(1598);
							}
						}
						else if (_data.CanSave)
						{
							SaveSchemeModify();
						}
						HideImply();
					}
				},
				OnCancel = HideImply
			});
		}
		else
		{
			HideImply();
		}
	}

	private void HideImply()
	{
		try
		{
			sidebarAnimation?.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				gameObject.SetActive(value: false);
			}).Play();
		}
		catch (Exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("Hide动效播放失败");
			}
			gameObject.SetActive(value: false);
		}
		ClearSelectComp();
		closeBtn?.OnClick.RemoveAllListeners();
		diameterSlider.onValueChanged.RemoveAllListeners();
		_schemeSelectBar?.UnInit();
		selectSchemeBtn?.SetOpenState(open: false);
		_schemeSelectBarIsOpen = false;
		SetModifyPosBtnInActive();
		SetDiameterSliderDeActive();
		_onHide?.Invoke();
	}

	private void SaveAsOrSaveModify()
	{
		if (_data != null && !BlockSaveWhenOverlap() && _data.Dirty)
		{
			if (_data.CanSaveAs)
			{
				SaveCurSchemeModifyAsNew();
			}
			else if (_data.CanSave)
			{
				SaveSchemeModify();
			}
		}
	}

	public void ResetScheme()
	{
		if (_data.Dirty)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPTEXTPANEL_LITE_, new PopUpTextPanel_Lite_Data
			{
				commonId = 2642,
				OnConfirm = ResetSchemeImply
			});
		}
		else
		{
			ResetSchemeImply();
		}
	}

	private void SelectDefaultScheme()
	{
		int value = SettingsManager.Instance.RuntimeSettings.GetSettingInt("Other.BtnScheme").GetValue();
		SelectScheme((DeviceCustomUISchemeId.IsValidMobileFixedId(value) || DeviceCustomUISchemeId.IsValidMobileCustomId(value)) ? value : DeviceCustomUISchemeId.GetDefaultMobileFixedId());
	}

	private void SelectScheme(int schemeId)
	{
		Model<CustomUIModel>.Interface.SetMobileCurScheme(schemeId);
		ClearSelectComp();
		LoadScheme(schemeId);
	}

	private void ResetSchemeImply()
	{
		ClearSelectComp();
		LoadScheme(_data.Id, _data.CanResetToTemplate);
	}

	private void LoadScheme(int schemeId, bool useResetTemplate = false)
	{
		if (!Model<CustomUIModel>.Interface.TryGetScheme(schemeId, out var scheme))
		{
			return;
		}
		_data = new ModifyPanelData(scheme, useResetTemplate);
		foreach (ModifyPanelCompBase item in _compRoot)
		{
			List<ModifyPanelCompData> list = new List<ModifyPanelCompData>();
			item.GetTypes(out var types);
			foreach (CustomUICompType item2 in types)
			{
				list.Add(_data.GetCompData(item2));
			}
			item.Init(new ModifyPanelCompInitData(list, SelectComp, RecordCompPosData, RecordCompPosDeltaData, RecordCompDiameterData, RefreshCompOverlapState, ResetComp));
		}
		RefreshCompOverlapState(null);
		InitSaveBtn();
		UpdateSaveBtn();
		UpdateSchemeSelectBtn();
		_schemeSelectBar?.RefreshSelectedPlanDisPlay(schemeId);
	}

	private void RecordCompPosData(CustomUICompType type, Vector2 newPos)
	{
		if (_data.RecordCompPos(type, newPos))
		{
			UpdateSaveBtn();
		}
	}

	private void RecordCompPosDeltaData(CustomUICompType type, Vector2 posDelta)
	{
		if (_data.RecordCompPosDelta(type, posDelta))
		{
			UpdateSaveBtn();
		}
	}

	private void RecordCompDiameterData(CustomUICompType type, float newDiameter)
	{
		if (_data.RecordCompDiameter(type, newDiameter))
		{
			UpdateSaveBtn();
		}
	}

	private void RecordEdgeOffsetData(float newOffset)
	{
		_data.RecordEdgeOffset(newOffset);
		UpdateSaveBtn();
	}

	private void SelectComp(ModifyPanelCompBase compBase)
	{
		if (!(_selectComp == compBase))
		{
			if (_selectComp != null)
			{
				_selectComp.ChangeState(ModifyPanelCompState.Normal);
			}
			_selectComp = compBase;
			_selectComp.ChangeState(ModifyPanelCompState.Select);
			SetSelectedCompHighestSibling(_selectComp);
			RefreshCompOverlapState(_selectComp);
			InitDiameterSlider();
			InitModifyPosBtn();
			RefreshOperateRoot();
		}
	}

	private void ClearSelectComp()
	{
		if (_selectComp != null)
		{
			_selectComp.ChangeState(ModifyPanelCompState.Normal);
			_selectComp = null;
		}
		RestoreCompSiblingIndexes();
		SetModifyPosBtnInActive();
		RefreshOperateRoot();
	}

	private void CacheCompOriginalSiblingIndexes()
	{
		_compOriginalSiblingIndexes.Clear();
		if (_compRoot == null)
		{
			return;
		}
		foreach (ModifyPanelCompBase item in _compRoot)
		{
			if (!(item == null) && !_compOriginalSiblingIndexes.ContainsKey(item))
			{
				_compOriginalSiblingIndexes.Add(item, item.transform.GetSiblingIndex());
			}
		}
	}

	private void SetSelectedCompHighestSibling(ModifyPanelCompBase selectedComp)
	{
		RestoreCompSiblingIndexes();
		selectedComp?.transform.SetAsLastSibling();
	}

	private void RestoreCompSiblingIndexes()
	{
		if (_compOriginalSiblingIndexes.Count == 0)
		{
			return;
		}
		foreach (KeyValuePair<ModifyPanelCompBase, int> item in _compOriginalSiblingIndexes.OrderBy((KeyValuePair<ModifyPanelCompBase, int> _) => _.Value))
		{
			if (!(item.Key == null))
			{
				item.Key.transform.SetSiblingIndex(item.Value);
			}
		}
	}

	private void ResetComp(ModifyPanelCompBase comp)
	{
		comp.GetTypes(out var types);
		List<ModifyPanelCompData> list = new List<ModifyPanelCompData>();
		foreach (CustomUICompType item in types)
		{
			list.Add(_data.GetCompData(item));
		}
		comp.SetTransform(list);
		if (comp.UseDiameter)
		{
			InitDiameterSlider();
		}
		RefreshCompOverlapState(comp);
	}

	public void ShowSidebar()
	{
		HideSchemeSelectBar();
		sideBarObj.SetActive(value: true);
		openBarBtn.gameObject.SetActive(value: false);
	}

	public void HideSidebar()
	{
		if (_schemeSelectBarIsOpen)
		{
			HideSchemeSelectBar();
		}
		try
		{
			sidebarAnimation?.GetSequence("Retract").OnComplete((AnimationBuilder _) =>
			{
				sideBarObj.SetActive(value: false);
			}).Play();
		}
		catch (Exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("Retract动效播放失败");
			}
			sideBarObj.SetActive(value: false);
		}
		openBarBtn.gameObject.SetActive(value: true);
	}

	private void UpdateSchemeSelectBtn()
	{
		if (Model<CustomUIModel>.Interface.Scheme.CurScheme != null)
		{
			selectSchemeBtn?.SetBtnText(Model<CustomUIModel>.Interface.Scheme.CurScheme.GetName());
		}
	}

	public void RefreshOperateRoot()
	{
		_operateRoot?.SetActive(_selectComp != null);
	}

	public int GetCurrentSchemeId()
	{
		return Model<CustomUIModel>.Interface.Scheme.CurScheme?.Id ?? 0;
	}

	public void SelectSchemePlanCell(int schemeId)
	{
		if (schemeId == GetCurrentSchemeId())
		{
			_schemeSelectBar?.RefreshSelectedPlanDisPlay(schemeId);
		}
		else if (_data != null && _data.Dirty)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPTEXTPANEL_LITE_, new PopUpTextPanel_Lite_Data
			{
				commonId = (_data.CanSaveAs ? 2648 : 1582),
				cancelBtnDes = (_data.CanSaveAs ? 2647 : 14),
				confirmBtnDes = (_data.CanSaveAs ? 1604 : 13),
				OnConfirm = () =>
				{
					if (_data.CanSaveAs)
					{
						if (Model<CustomUIModel>.Interface.Scheme.CanAddCustomScheme())
						{
							SaveCurSchemeModifyAsNew();
						}
						else
						{
							GameUtility.OpenToolTip(1598);
						}
					}
					else
					{
						SaveSchemeModify();
						SelectScheme(schemeId);
					}
				},
				OnCancel = () =>
				{
					SelectScheme(schemeId);
				}
			});
		}
		else
		{
			SelectScheme(schemeId);
		}
	}

	public void AddNewSchemePlan()
	{
		if (!Model<CustomUIModel>.Interface.Scheme.CanAddCustomScheme())
		{
			GameUtility.OpenToolTip(1598);
		}
		else
		{
			SaveAsNewBySchemeId(_data?.Id ?? 0);
		}
	}

	public void DeleteCustomSchemePlan(int schemeId)
	{
		if (DeviceCustomUISchemeId.IsValidMobileCustomId(schemeId) && schemeId != GetCurrentSchemeId() && Model<CustomUIModel>.Interface.Scheme.TryGetScheme(schemeId, out var scheme) && scheme.CanDelete)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPTEXTPANEL_LITE_, new PopUpTextPanel_Lite_Data
			{
				commonId = 2643,
				cancelBtnDes = 14,
				confirmBtnDes = 13,
				OnConfirm = () =>
				{
					Model<CustomUIModel>.Interface.Scheme.DeleteCustomScheme(schemeId);
					_schemeSelectBar?.DestroyCustomSchemeCell(schemeId);
					UpdateSchemeSelectBtn();
					GameUtility.OpenToolTip(2644);
				}
			});
		}
	}

	private void TriggerSchemeSelectBar()
	{
		if (_schemeSelectBarIsOpen)
		{
			HideSchemeSelectBar();
			return;
		}
		_schemeSelectBarIsOpen = true;
		_schemeSelectBar?.Show();
		sidebarAnimation?.GetSequence("PlanShow").Play();
		selectSchemeBtn?.SetOpenState(open: true);
	}

	public void HideSchemeSelectBar()
	{
		if (!_schemeSelectBarIsOpen)
		{
			return;
		}
		try
		{
			sidebarAnimation?.GetSequence("PlanHide").OnComplete((AnimationBuilder _) =>
			{
				_schemeSelectBar?.Hide();
			}).Play();
		}
		catch (Exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("PlanHide动效播放失败");
			}
			_schemeSelectBar?.Hide();
		}
		_schemeSelectBarIsOpen = false;
		selectSchemeBtn?.SetOpenState(open: false);
	}

	public void OpenCustomSchemeRenamePanel(int customSchemeId)
	{
		if (TryGetCustomSchemeCanRename(customSchemeId, out var customScheme))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPCHANGENAME, new MonoNameChangeView.MonoNameChangeData
			{
				name = customScheme.GetName(),
				changeNameEvent = (string newName, Action<bool> callback) =>
				{
					RenameCustomScheme(customSchemeId, newName, callback);
				},
				cancelLocalizeData = new LocalizeStringData(LocalizeTable.Common, 14),
				confirmLocalizeData = new LocalizeStringData(LocalizeTable.Common, 13)
			});
		}
	}

	private void RenameCustomScheme(int customSchemeId, string newName, Action<bool> callback)
	{
		if (!TryGetCustomSchemeCanRename(customSchemeId, out var _))
		{
			callback(obj: false);
			return;
		}
		Model<CustomUIModel>.Interface.Scheme.RenameCustomScheme(customSchemeId, newName, () =>
		{
			if (_data != null && _data.Id == customSchemeId)
			{
				_data.SetSavedName(newName);
				UpdateSchemeSelectBtn();
			}
			_schemeSelectBar?.RefreshSchemeNames();
			callback(obj: true);
		}, () =>
		{
			if (_data != null && _data.Id == customSchemeId)
			{
				UpdateSchemeSelectBtn();
			}
			_schemeSelectBar?.RefreshSchemeNames();
			callback(obj: false);
		});
	}

	private bool TryGetCustomSchemeCanRename(int customSchemeId, out CustomUIScheme customScheme)
	{
		if (DeviceCustomUISchemeId.IsValidMobileCustomId(customSchemeId) && Model<CustomUIModel>.Interface.Scheme.TryGetScheme(customSchemeId, out customScheme) && customScheme.CanRename)
		{
			return true;
		}
		customScheme = null;
		return false;
	}

	private void InitDeleteSchemeBtn()
	{
	}

	private void InitDiameterSlider()
	{
		_modifyDiameterCompType = CustomUICompType.None;
		ModifyPanelCompBase selectComp = _selectComp;
		if ((object)selectComp != null && selectComp.UseDiameter)
		{
			SetDiameterSliderActive();
		}
		else
		{
			SetDiameterSliderDeActive();
		}
	}

	private void SetDiameterSliderActive()
	{
		diameterSlider.interactable = true;
		Image component = diameterSlider.fillRect.GetComponent<Image>();
		if (component != null)
		{
			component.color = Color.white;
		}
		diameterSlider.minValue = Model<CustomUIModel>.Interface.Scheme.Standard.CompDiameterMin;
		diameterSlider.maxValue = Model<CustomUIModel>.Interface.Scheme.Standard.CompDiameterMax;
		_selectComp.GetTypes(out var types);
		_modifyDiameterCompType = types[0];
		int num = Mathf.RoundToInt(_data.GetCompData(_modifyDiameterCompType).Diameter / Model<CustomUIModel>.Interface.Scheme.Standard.GetOriginalSize(_modifyDiameterCompType) * 100f);
		diameterSlider.SetValueWithoutNotify(num);
		diameterTextRoot?.SetActive(value: true);
		recommendRoot?.SetActive(value: true);
		diameterText.text = diameterSlider.value.FastToString();
		diameterSlider.onValueChanged.RemoveAllListeners();
		diameterSlider.OnPointUp.RemoveAllListeners();
		diameterSlider.onValueChanged.AddListener(OnDiameterSliderValChange);
		diameterSlider.OnPointUp.AddListener(OnDiameterSliderUp);
	}

	private void SetDiameterSliderDeActive()
	{
		diameterSlider.onValueChanged.RemoveAllListeners();
		diameterSlider.OnPointUp.RemoveAllListeners();
		diameterSlider.interactable = false;
		Image component = diameterSlider.fillRect.GetComponent<Image>();
		if (component != null && ColorUtility.TryParseHtmlString("#A6A6A7", out var color))
		{
			component.color = color;
		}
		diameterTextRoot?.SetActive(value: false);
		recommendRoot?.SetActive(value: false);
		diameterSlider.minValue = 0f;
		diameterSlider.maxValue = 2f;
		diameterSlider.SetValueWithoutNotify(Mathf.RoundToInt((diameterSlider.minValue + diameterSlider.maxValue) / 2f));
	}

	private void OnDiameterSliderValChange(float val)
	{
		int num = Mathf.RoundToInt(val);
		diameterSlider.SetValueWithoutNotify(num);
		diameterText.text = num.FastToString();
		float newDiameter = Model<CustomUIModel>.Interface.Scheme.Standard.GetOriginalSize(_modifyDiameterCompType) * (float)num / 100f;
		_selectComp.OnDiameterSliderValChange(newDiameter);
	}

	private void OnDiameterSliderUp()
	{
		_selectComp.OnDiameterSliderUp();
	}

	private bool RefreshCompOverlapState(ModifyPanelCompBase checkCompBase)
	{
		if (checkCompBase == null)
		{
			return false;
		}
		HashSet<ModifyPanelCompBase> hashSet = HashSetPool<ModifyPanelCompBase>.Get();
		bool hasCompOverlap = false;
		if (_compRoot != null)
		{
			foreach (ModifyPanelCompBase item in _compRoot)
			{
				if (!(item == null) && !(item == checkCompBase) && checkCompBase.CheckOverLap(item))
				{
					hasCompOverlap = true;
					hashSet.Add(checkCompBase);
					hashSet.Add(item);
				}
			}
			foreach (ModifyPanelCompBase item2 in _compRoot)
			{
				if (!(item2 == null))
				{
					if (hashSet.Contains(item2))
					{
						item2.ChangeState(ModifyPanelCompState.Conflict);
					}
					else
					{
						item2.ChangeState((!(item2 == _selectComp)) ? ModifyPanelCompState.Normal : ModifyPanelCompState.Select);
					}
				}
			}
		}
		_hasCompOverlap = hasCompOverlap;
		HashSetPool<ModifyPanelCompBase>.Release(hashSet);
		return _hasCompOverlap;
	}

	private void InitModifyPosBtn()
	{
		if (_selectComp != null)
		{
			SetModifyPosBtnActive();
		}
		else
		{
			SetModifyPosBtnInActive();
		}
	}

	private void SetModifyPosBtnActive()
	{
		modifyPosBtnUp.interactable = true;
		modifyPosBtnDown.interactable = true;
		modifyPosBtnLeft.interactable = true;
		modifyPosBtnRight.interactable = true;
		ClearModifyPosBtnLongPressListeners();
		modifyPosBtnUp.OnLongPressUpdate.AddListener(() =>
		{
			OnModifyPosBtnClick(Vector2.up);
		});
		modifyPosBtnDown.OnLongPressUpdate.AddListener(() =>
		{
			OnModifyPosBtnClick(Vector2.down);
		});
		modifyPosBtnLeft.OnLongPressUpdate.AddListener(() =>
		{
			OnModifyPosBtnClick(Vector2.left);
		});
		modifyPosBtnRight.OnLongPressUpdate.AddListener(() =>
		{
			OnModifyPosBtnClick(Vector2.right);
		});
		modifyPosBtnUp.SetBtnClick(PosModifyUp);
		modifyPosBtnDown.SetBtnClick(PosModifyDown);
		modifyPosBtnLeft.SetBtnClick(PosModifyLeft);
		modifyPosBtnRight.SetBtnClick(PosModifyRight);
	}

	private void SetModifyPosBtnInActive()
	{
		modifyPosBtnUp.interactable = false;
		modifyPosBtnDown.interactable = false;
		modifyPosBtnLeft.interactable = false;
		modifyPosBtnRight.interactable = false;
		ClearModifyPosBtnLongPressListeners();
	}

	private void ClearModifyPosBtnLongPressListeners()
	{
		modifyPosBtnUp.OnLongPressUpdate.RemoveAllListeners();
		modifyPosBtnDown.OnLongPressUpdate.RemoveAllListeners();
		modifyPosBtnLeft.OnLongPressUpdate.RemoveAllListeners();
		modifyPosBtnRight.OnLongPressUpdate.RemoveAllListeners();
	}

	private void OnModifyPosBtnClick(Vector2 dir)
	{
		_selectComp.OnPosModifyBtnLongClick(dir * _posModifyStep);
	}

	public void PosModifyUp()
	{
		OnModifyPosBtnClick(Vector2.up);
		OnPosModifyBtnUp();
	}

	public void PosModifyDown()
	{
		OnModifyPosBtnClick(Vector2.down);
		OnPosModifyBtnUp();
	}

	public void PosModifyLeft()
	{
		OnModifyPosBtnClick(Vector2.left);
		OnPosModifyBtnUp();
	}

	public void PosModifyRight()
	{
		OnModifyPosBtnClick(Vector2.right);
		OnPosModifyBtnUp();
	}

	public void OnPosModifyBtnUp()
	{
		if (_selectComp == null)
		{
			GameUtility.OpenToolTip(41000023);
		}
		else
		{
			_selectComp.OnPosModifyBtnUp();
		}
	}

	private void InitSaveBtn()
	{
		saveBtn.gameObject.SetActive(_data.CanSave || _data.CanSaveAs);
		saveBtnTxt.SetReference(LocalizeTable.Common, _data.CanSave ? 1581 : (_data.CanSaveAs ? 1604 : 0));
		resetBtn.gameObject.SetActive(value: true);
	}

	private void UpdateSaveBtn()
	{
		saveBtn.Interactable(_data.Dirty);
		resetBtn.Interactable(_data.Dirty || _data.CanResetToTemplate);
	}

	private bool BlockSaveWhenOverlap()
	{
		RefreshCompOverlapState(_selectComp);
		if (!_hasCompOverlap)
		{
			return false;
		}
		GameUtility.OpenToolTip(2646);
		return true;
	}

	public void SaveSchemeModify()
	{
		if (_data.CanSave && !BlockSaveWhenOverlap())
		{
			Model<CustomUIModel>.Interface.Scheme.ModifyCustomScheme(_data.GetSelfModifyData());
			ClearSelectComp();
			UpdateSaveBtn();
			GameUtility.OpenToolTip(2645);
		}
	}

	public void SaveCurSchemeModifyAsNew()
	{
		if (_data != null && _data.CanSaveAs && !BlockSaveWhenOverlap())
		{
			SaveAsNewBySchemeId(_data.Id);
		}
	}

	private void SaveAsNewBySchemeId(int sourceSchemeId)
	{
		if (_data != null && Model<CustomUIModel>.Interface.Scheme.TryGetScheme(sourceSchemeId, out var _) && !BlockSaveWhenOverlap())
		{
			if (!Model<CustomUIModel>.Interface.Scheme.CanAddCustomScheme())
			{
				GameUtility.OpenToolTip(1598);
				return;
			}
			_saveAsSourceSchemeId = sourceSchemeId;
			_saveAsSchemeId = 0;
			_saveAsOriginalName = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 1605) + (Model<CustomUIModel>.Interface.Scheme.GetCustomSchemeNum() + 1).FastToString();
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPCHANGENAME, new MonoNameChangeView.MonoNameChangeData
			{
				name = _saveAsOriginalName,
				changeNameEvent = SaveAsImply,
				changeNameRule = MonoNameChangeView.MonoNameChangeData.ChangeNameRule.AllowSameName,
				cancelLocalizeData = new LocalizeStringData(LocalizeTable.Common, 14),
				confirmLocalizeData = new LocalizeStringData(LocalizeTable.Common, 13)
			});
		}
	}

	private void SaveAsImply(string newName, Action<bool> callback)
	{
		CustomUIScheme customScheme;
		if (_saveAsSchemeId != 0)
		{
			if (TryGetCustomSchemeCanRename(_saveAsSchemeId, out customScheme))
			{
				int saveAsSchemeId = _saveAsSchemeId;
				Model<CustomUIModel>.Interface.Scheme.RenameCustomScheme(_saveAsSchemeId, newName, () =>
				{
					OnSaveAsSucceed(saveAsSchemeId, callback);
				}, () =>
				{
					OnSaveAsFilled(callback);
				});
				return;
			}
			_saveAsSchemeId = 0;
		}
		if (!Model<CustomUIModel>.Interface.Scheme.TryGetScheme(_saveAsSourceSchemeId, out customScheme))
		{
			_saveAsSourceSchemeId = 0;
			_saveAsSchemeId = 0;
			_saveAsOriginalName = null;
			callback(obj: false);
		}
		else if (Model<CustomUIModel>.Interface.Scheme.AddCustomScheme(_data.GetModifyDataById(_saveAsSourceSchemeId, newName), _saveAsOriginalName, (int id) =>
		{
			OnSaveAsSucceed(id, callback);
		}, (int id) =>
		{
			_saveAsSchemeId = id;
			OnSaveAsFilled(callback);
		}) == 0)
		{
			callback(obj: false);
		}
	}

	private void OnSaveAsSucceed(int schemeId, Action<bool> callback)
	{
		_saveAsSourceSchemeId = 0;
		_saveAsSchemeId = 0;
		_saveAsOriginalName = null;
		_schemeSelectBar?.LoadCustomSchemeCells();
		SelectScheme(schemeId);
		callback(obj: true);
	}

	private void OnSaveAsFilled(Action<bool> callback)
	{
		UpdateSchemeSelectBtn();
		_schemeSelectBar?.RefreshSchemeNames();
		callback(obj: false);
	}
}
