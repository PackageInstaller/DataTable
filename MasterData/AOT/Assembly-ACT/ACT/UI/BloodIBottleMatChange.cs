using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.ItemDetail;
using ACT.UI.ItemDetail.Interface;
using ACT.UI.ItemDetail.Styles;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.Pool;

namespace ACT.UI;

public class BloodIBottleMatChange : SubUIView<BottleMatChangeSubController>, IBottleSubPanelBase, ISubUIView, IBaseUIComponent
{
	protected int pageIndex = -1;

	protected BloodBottleView _parentView;

	protected ImageAssetStation _station;

	[SerializeField]
	private BloodBottleDetail _bloodBottleDetail;

	[SerializeField]
	private CommonItemDetail _materialDetail;

	[SerializeField]
	private LocalizeStringEvent _leftTopTitle;

	[SerializeField]
	private BImage _matTypeIcon;

	[SerializeField]
	private GameObject matEmptyTips;

	[SerializeField]
	private CommonScrollBagComponent _materialsScrollBag;

	public ViewControlLayer materialsLayer;

	private List<ItemUnifierProxy> _matFillData;

	private BloodBottleMaterial _curSlotLastSelectedMat;

	private BottleMaterialCell _lastSelect;

	private bool _chagneSaved;

	private StringBuilder _sb;

	private List<int> beforeMatIds;

	private List<int> curOperationMatIds;

	private const int BOTTLEMATCAHGNECONTEXT = 2212;

	protected BloodBottleHandler _handler => Singleton<BloodBottleHandler>.instance;

	protected BloodBottleModel _model => Model<BloodBottleModel>.Interface;

	protected BloodBottleBuffHandler _buffHandler => Singleton<BloodBottleBuffHandler>.instance;

	public void Init()
	{
		pageIndex = 1;
		_parentView = GetComponentInParent<BloodBottleView>();
		if (_parentView != null)
		{
			_station = _parentView.Station;
		}
		_sb = new StringBuilder();
		beforeMatIds = CollectionPool<List<int>, int>.Get();
		curOperationMatIds = CollectionPool<List<int>, int>.Get();
		_matFillData = CollectionPool<List<ItemUnifierProxy>, ItemUnifierProxy>.Get();
	}

	public void Refresh()
	{
		gameObject.SetActive(value: true);
		FocusIn();
		if (_parentView != null && _parentView.animFinish)
		{
			_parentView.animFinish = false;
			try
			{
				_parentView.betterAnimation?.GetSequence("MaterialChangeShow").OnAnimationPlay((AnimationBuilder _) =>
				{
					Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/BloodBottle/Window_Open");
				}).OnComplete((AnimationBuilder _) =>
				{
					_parentView.animFinish = true;
				})
					.Play();
			}
			catch (Exception value)
			{
				_parentView.animFinish = true;
				Console.WriteLine(value);
				throw;
			}
		}
		foreach (BottleMaterialCell slot in _bloodBottleDetail.slots)
		{
			slot.OnCellSelected = null;
			slot.OnCellSelected = () =>
			{
				OnSelectSlot(slot);
			};
		}
		if (_model.curOperationBottle != null)
		{
			_bloodBottleDetail.Refresh(_model.curOperationBottle, _sb, _station);
			beforeMatIds.Clear();
			curOperationMatIds.Clear();
			curOperationMatIds.AddRange(_model.curOperationBottle.materialIds);
			beforeMatIds.AddRange(_model.curOperationBottle.materialIds);
			OnSelectSlot(_bloodBottleDetail.slots[0]);
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError("选中的血瓶为空，可能被清空了");
		}
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.BloodBottleClickGoToChangeMaterial);
	}

	private void SaveChanges(Action callback = null)
	{
		_handler.UpdateBottleMaterial(_model.curOperationBottle, curOperationMatIds, () =>
		{
			List<int> list = CollectionPool<List<int>, int>.Get();
			foreach (int curOperationMatId in curOperationMatIds)
			{
				if (curOperationMatId > 0)
				{
					list.Add(curOperationMatId);
				}
			}
			List<int> list2 = CollectionPool<List<int>, int>.Get();
			foreach (int beforeMatId in beforeMatIds)
			{
				if (beforeMatId > 0)
				{
					list2.Add(beforeMatId);
				}
			}
			foreach (int item in list2)
			{
				if (!list.Contains(item))
				{
					BloodBottleMaterial bottleMatById = _model.GetBottleMatById(item);
					if (bottleMatById != null)
					{
						bottleMatById.ResetEquipState(state: false);
						bottleMatById.SetBelongBottle(0);
						ItemChangeEvt evt = Singleton<EventManager>.instance.GetEvt<ItemChangeEvt>();
						evt.ItemProxies = ListPool<ItemUnifierProxy>.Get();
						evt.ItemProxies.Add(ItemUnifierProxy.ItemUnifierPool.Get(bottleMatById));
						Singleton<EventManager>.instance.EventDispatch(ClientEvent.BagItemChange, evt);
						Singleton<EventManager>.instance.ReleaseEvt(evt);
					}
				}
			}
			foreach (int item2 in list)
			{
				if (!list2.Contains(item2))
				{
					BloodBottleMaterial bottleMatById2 = _model.GetBottleMatById(item2);
					if (bottleMatById2 != null)
					{
						if (bottleMatById2.belongBottle > 0 && bottleMatById2.belongBottle != _model.curOperationBottle.uid)
						{
							BloodBottleData bloodBottleById = _model.GetBloodBottleById(bottleMatById2.belongBottle);
							if (bloodBottleById != null)
							{
								int num = bloodBottleById.materialIds.IndexOf(item2);
								if (num != -1)
								{
									bloodBottleById.SetWineMatOnSolt(0, num);
								}
							}
						}
						bottleMatById2.ResetEquipState(state: true);
						bottleMatById2.SetBelongBottle(_model.curOperationBottle.uid);
						ItemChangeEvt evt2 = Singleton<EventManager>.instance.GetEvt<ItemChangeEvt>();
						evt2.ItemProxies = ListPool<ItemUnifierProxy>.Get();
						evt2.ItemProxies.Add(ItemUnifierProxy.ItemUnifierPool.Get(bottleMatById2));
						Singleton<EventManager>.instance.EventDispatch(ClientEvent.BagItemChange, evt2);
						Singleton<EventManager>.instance.ReleaseEvt(evt2);
					}
				}
			}
			_model.curOperationBottle.SetWineMatList(curOperationMatIds);
			beforeMatIds.Clear();
			beforeMatIds.AddRange(_model.curOperationBottle.materialIds);
			curOperationMatIds.Clear();
			curOperationMatIds.AddRange(_model.curOperationBottle.materialIds);
			CollectionPool<List<int>, int>.Release(list2);
			CollectionPool<List<int>, int>.Release(list);
			callback?.Invoke();
		});
	}

	public void UnInit()
	{
		ResetDataAndClosePanel();
	}

	private void ResetDataAndClosePanel()
	{
		if (_parentView != null && _parentView.animFinish)
		{
			_parentView.lastPageIndex = pageIndex;
			_parentView.animFinish = false;
			_parentView.betterAnimation?.GetSequence("MaterialChangeHide").OnComplete((AnimationBuilder _) =>
			{
				_parentView.animFinish = true;
				_lastSelect = null;
				_curSlotLastSelectedMat = null;
				FocusOut();
				gameObject.SetActive(value: false);
			}).OnAnimationPlay((AnimationBuilder _) =>
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/BloodBottle/Window_Close");
			})
				.Play();
		}
		else
		{
			_lastSelect = null;
			_curSlotLastSelectedMat = null;
			FocusOut();
			gameObject.SetActive(value: false);
		}
	}

	private bool CheckBottleMatDef()
	{
		if (curOperationMatIds.Count != beforeMatIds.Count)
		{
			return true;
		}
		for (int i = 0; i < curOperationMatIds.Count; i++)
		{
			if (curOperationMatIds[i] != beforeMatIds[i])
			{
				return true;
			}
		}
		return false;
	}

	public void OnSelectSlot(BottleMaterialCell cell)
	{
		if (!(_lastSelect != null) || _lastSelect.index != cell.index)
		{
			RefreshOnSelectSolt();
		}
		void RefreshOnSelectSolt()
		{
			_station.LoadImage(157, (int)cell.slotData.types[0], _matTypeIcon);
			_leftTopTitle.StringReference.TableEntryReference = CoreUtils.GetData((int)cell.slotData.types[0], RuntimeConfigs.data.potionTypes).tpyeName;
			if (_lastSelect != null)
			{
				_lastSelect.OnUnSelected();
			}
			_lastSelect = cell;
			int type = (int)cell.slotData.types[0];
			List<BloodBottleMaterial> list = _model.bottleMaterials.Values.Where((BloodBottleMaterial x) => x.type == type).ToList();
			list.Sort(SortUtility.SortBottleMatInChangePanel);
			_matFillData.Clear();
			foreach (BloodBottleMaterial item2 in list)
			{
				ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get(item2);
				_matFillData.Add(item);
			}
			cell.OnSelected();
			FillRightMaterialBag(_lastSelect);
		}
	}

	private void FillRightMaterialBag(BottleMaterialCell curSelectedCell)
	{
		_materialDetail.gameObject.SetActive(value: false);
		_curSlotLastSelectedMat = null;
		if (_matFillData.Count == 0)
		{
			_materialsScrollBag.ClearBag();
			matEmptyTips.SetActive(value: true);
			UpdateEquipBtn(null, null);
			return;
		}
		matEmptyTips.SetActive(value: false);
		_materialsScrollBag.ItemSource = _matFillData;
		_materialsScrollBag.Station = _parentView.Station;
		_materialsScrollBag.SelectMode = CommonScrollBagComponent.SelectModeType.Single;
		_materialsScrollBag.ItemShowType = ItemUIComponentBase.InitType.BloodBottleMaterialInCangePanel;
		_materialsScrollBag.OnItemShow = null;
		CommonScrollBagComponent materialsScrollBag = _materialsScrollBag;
		materialsScrollBag.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(materialsScrollBag.OnItemShow, (Action<ItemUIComponentBase>)((ItemUIComponentBase l) =>
		{
			if (l is BloodBottleMaterialUIComponent bloodBottleMaterialUIComponent)
			{
				BloodBottleMaterial bloodBottleMaterial = l.ItemUnifier.As<BloodBottleMaterial>();
				bloodBottleMaterialUIComponent.m_BelongBottleIcon.BloodBottleData = null;
				if (l.Index == 0)
				{
					_materialDetail.gameObject.SetActive(value: true);
					_materialDetail.Context = bloodBottleMaterial;
					_curSlotLastSelectedMat = bloodBottleMaterial;
					UpdateEquipBtn(bloodBottleMaterial, bloodBottleMaterialUIComponent);
				}
				if (curOperationMatIds.Contains(bloodBottleMaterial.uid))
				{
					bloodBottleMaterialUIComponent.ChangeCurBottleEquipedDisplay(active: true);
				}
				else if (bloodBottleMaterial.isEquip && !beforeMatIds.Contains(bloodBottleMaterial.uid))
				{
					bloodBottleMaterialUIComponent.ChangeCurBottleEquipedDisplay(active: false);
				}
				else
				{
					bloodBottleMaterialUIComponent.HideAllEquipedDisplay();
				}
			}
		}));
		_materialsScrollBag.OnItemSelect = null;
		CommonScrollBagComponent materialsScrollBag2 = _materialsScrollBag;
		materialsScrollBag2.OnItemSelect = (Action<ItemUIComponentBase>)Delegate.Combine(materialsScrollBag2.OnItemSelect, (Action<ItemUIComponentBase>)((ItemUIComponentBase l) =>
		{
			BloodBottleMaterial bloodBottleMaterial = (_curSlotLastSelectedMat = l.ItemUnifier.As<BloodBottleMaterial>());
			_materialDetail.gameObject.SetActive(value: true);
			_materialDetail.Context = bloodBottleMaterial;
			if (l is BloodBottleMaterialUIComponent bloodBottleMaterialUIComponent)
			{
				UpdateEquipBtn(bloodBottleMaterial, bloodBottleMaterialUIComponent);
				if (curOperationMatIds.Contains(bloodBottleMaterial.uid))
				{
					bloodBottleMaterialUIComponent.ChangeCurBottleEquipedDisplay(active: true);
				}
				else if (bloodBottleMaterial.isEquip && !beforeMatIds.Contains(bloodBottleMaterial.uid))
				{
					bloodBottleMaterialUIComponent.ChangeCurBottleEquipedDisplay(active: false);
				}
				else
				{
					bloodBottleMaterialUIComponent.HideAllEquipedDisplay();
				}
			}
		}));
		_materialsScrollBag.SelectedModels.Clear();
		_materialsScrollBag.SelectedModels.Add(_matFillData.First());
		_materialsScrollBag.ForceUpdatePerformance();
	}

	private void RefreshDisplayAfterEquipOpeation(BloodBottleMaterialUIComponent cp, BloodBottleMaterial matData, bool refreshDetail = true)
	{
		if (curOperationMatIds.Contains(matData.uid))
		{
			cp.ChangeCurBottleEquipedDisplay(active: true);
		}
		else
		{
			cp.HideAllEquipedDisplay();
		}
		if (!refreshDetail)
		{
			return;
		}
		_materialDetail.BottomStylePostProcess = null;
		CommonItemDetail materialDetail = _materialDetail;
		materialDetail.BottomStylePostProcess = (Action<IStyle>)Delegate.Combine(materialDetail.BottomStylePostProcess, (Action<IStyle>)((IStyle style) =>
		{
			if (style is BloodBottleMaterialStyle bloodBottleMaterialStyle)
			{
				bloodBottleMaterialStyle.OtherWaySetBelongRootActive(() => curOperationMatIds.Contains(matData.uid));
			}
		}));
		_materialDetail.UpdateContent();
	}

	private bool CheckMatBelongBottleIsCurrent(BloodBottleMaterial mat)
	{
		if (mat == null)
		{
			return true;
		}
		return mat.belongBottle == _model.curOperationBottle.uid;
	}

	public void OnParentViewClose()
	{
		CollectionPool<List<int>, int>.Release(beforeMatIds);
		CollectionPool<List<int>, int>.Release(curOperationMatIds);
		if (_matFillData != null)
		{
			ItemUnifierProxy.ItemUnifierPool.Release(_matFillData);
			CollectionPool<List<ItemUnifierProxy>, ItemUnifierProxy>.Release(_matFillData);
			_matFillData = null;
		}
		Station.UnloadSprite(GameLoader.meta.itemAtlasNameAssetID);
	}

	private void UpdateEquipBtn(BloodBottleMaterial mat, BloodBottleMaterialUIComponent cell)
	{
		if (mat == null)
		{
			_bloodBottleDetail.changeMatBtn.interactable = false;
			_bloodBottleDetail.changeMatBtnPrompt.SetVisible(vis: false);
			_bloodBottleDetail._changeMatBtnText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.BottleEquip;
			_bloodBottleDetail.changeMatBtn.OnClick.RemoveAllListeners();
			_bloodBottleDetail.changeMatBtn.OnUnInteractableClick.RemoveAllListeners();
			_bloodBottleDetail.changeMatBtn.OnUnInteractableClick.AddListener(() =>
			{
				GameUtility.OpenToolTip((_lastSelect.slotData.curState == SlotState.IsLock) ? LocalizationCommonData.CommonString.CurSlotIsLock : LocalizationCommonData.CommonString.CurSoltMatIsEmpty);
			});
		}
		else if (_lastSelect.slotData.curState == SlotState.IsLock)
		{
			_bloodBottleDetail.changeMatBtn.Interactable(active: false);
			_bloodBottleDetail.changeMatBtnPrompt.SetVisible(vis: false);
			_bloodBottleDetail.changeMatBtn.OnUnInteractableClick.RemoveAllListeners();
			_bloodBottleDetail.changeMatBtn.OnUnInteractableClick.AddListener(() =>
			{
				GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CurSlotIsLock);
			});
			_bloodBottleDetail._changeMatBtnText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.BottleEquip;
		}
		else if (curOperationMatIds[_lastSelect.index] == 0)
		{
			_bloodBottleDetail.changeMatBtn.interactable = true;
			_bloodBottleDetail.changeMatBtnPrompt.SetVisible(vis: true);
			_bloodBottleDetail._changeMatBtnText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.BottleEquip;
			_bloodBottleDetail.changeMatBtn.SetBtnClick(() =>
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/BloodBottle/Click_2");
				GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.BloodBottleClickEquipMaterial);
				EquipWhenSlotEmpty(mat, cell);
				SaveChanges();
			});
		}
		else
		{
			if (curOperationMatIds[_lastSelect.index] == 0)
			{
				return;
			}
			if (mat.uid == curOperationMatIds[_lastSelect.index])
			{
				_bloodBottleDetail.changeMatBtn.interactable = true;
				_bloodBottleDetail.changeMatBtnPrompt.SetVisible(vis: true);
				_bloodBottleDetail._changeMatBtnText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.Unload;
				_bloodBottleDetail.changeMatBtn.SetBtnClick(() =>
				{
					Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/BloodBottle/Click_2");
					UnloadMat(mat, cell);
					SaveChanges();
				});
				return;
			}
			_bloodBottleDetail.changeMatBtn.interactable = true;
			_bloodBottleDetail.changeMatBtnPrompt.SetVisible(vis: true);
			_bloodBottleDetail._changeMatBtnText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.Exchange;
			_bloodBottleDetail.changeMatBtn.SetBtnClick(() =>
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/BloodBottle/Click_2");
				if (mat.isEquip && mat.belongBottle != _model.curOperationBottle.id)
				{
					EquipWhenMatHasOtherBelongBottle(mat, cell);
				}
				else if (mat.isEquip)
				{
					GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CurBottleIsEquipThisMat);
				}
				else
				{
					ReplaceMat(mat, cell);
					SaveChanges();
				}
			});
		}
	}

	private void EquipWhenSlotEmpty(BloodBottleMaterial targetMat, BloodBottleMaterialUIComponent curCell)
	{
		if (targetMat.belongBottle == _model.curOperationBottle.id)
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.CurBottleIsEquipThisMat);
			return;
		}
		if (targetMat.isEquip && targetMat.belongBottle != _model.curOperationBottle.id)
		{
			EquipWhenMatHasOtherBelongBottle(targetMat, curCell);
			return;
		}
		curOperationMatIds[_lastSelect.index] = targetMat.uid;
		_bloodBottleDetail.RefreshUnlockSlotDisplayByIndex(_lastSelect.index, targetMat);
		UpdateEquipBtn(targetMat, curCell);
		RefreshDisplayAfterEquipOpeation(curCell, targetMat);
	}

	private void EquipWhenMatHasOtherBelongBottle(BloodBottleMaterial targetMat, BloodBottleMaterialUIComponent curCell)
	{
		int nameLocal = CoreUtils.GetData(_model.curSceneBloodBottleInfo._allBottles[targetMat.belongBottle].id, RuntimeConfigs.data.itemDatas).nameLocal;
		TextPanel.Param param = new TextPanel.Param();
		param.spriteAsset = GameLoader.meta.bottleTMPSa;
		param.commonId = 2212;
		param.texts = new string[2]
		{
			targetMat.belongBottle.FastToString(),
			LocalizationUtility.GetLocalizeString("shortcommon", nameLocal)
		};
		param.OnConfirm = () =>
		{
			BloodBottleMaterial bottleMatById = _model.GetBottleMatById(curOperationMatIds[_lastSelect.index]);
			ItemUnifierProxy itemUnifierProxy = _matFillData.Find((ItemUnifierProxy x) => x.As<BloodBottleMaterial>().uid == curOperationMatIds[_lastSelect.index]);
			curOperationMatIds[_lastSelect.index] = targetMat.uid;
			if (bottleMatById != null && itemUnifierProxy != null && itemUnifierProxy.Context is BloodBottleMaterialUIComponent cp)
			{
				RefreshDisplayAfterEquipOpeation(cp, bottleMatById, refreshDetail: false);
			}
			_bloodBottleDetail.RefreshUnlockSlotDisplayByIndex(_lastSelect.index, targetMat);
			UpdateEquipBtn(targetMat, curCell);
			RefreshDisplayAfterEquipOpeation(curCell, targetMat);
			SaveChanges();
		};
		TextPanel.Param uiData = param;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, uiData);
	}

	private void ReplaceMat(BloodBottleMaterial targetMat, BloodBottleMaterialUIComponent curCell)
	{
		BloodBottleMaterial bottleMatById = _model.GetBottleMatById(curOperationMatIds[_lastSelect.index]);
		ItemUnifierProxy itemUnifierProxy = _matFillData.Find((ItemUnifierProxy x) => x.As<BloodBottleMaterial>().uid == curOperationMatIds[_lastSelect.index]);
		curOperationMatIds[_lastSelect.index] = targetMat.uid;
		if (itemUnifierProxy.Context is BloodBottleMaterialUIComponent cp)
		{
			RefreshDisplayAfterEquipOpeation(cp, bottleMatById, refreshDetail: false);
		}
		_bloodBottleDetail.RefreshUnlockSlotDisplayByIndex(_lastSelect.index, targetMat);
		UpdateEquipBtn(targetMat, curCell);
		RefreshDisplayAfterEquipOpeation(curCell, targetMat);
	}

	private void UnloadMat(BloodBottleMaterial targetMat, BloodBottleMaterialUIComponent curCell)
	{
		curOperationMatIds[_lastSelect.index] = 0;
		_bloodBottleDetail.RefreshUnlockSlotDisplayByIndex(_lastSelect.index, null);
		UpdateEquipBtn(targetMat, curCell);
		RefreshDisplayAfterEquipOpeation(curCell, targetMat);
	}

	public ACT.ViewControl.SelectableEx GetCurMaterialCellSelectable()
	{
		List<ItemUnifierProxy> matFillData = _matFillData;
		if (matFillData == null || matFillData.Count <= 0 || _curSlotLastSelectedMat == null)
		{
			return null;
		}
		int id = _matFillData.IndexOf(ItemUnifierProxy.ItemUnifierPool.Get(_curSlotLastSelectedMat));
		ItemUIComponentBase item = _materialsScrollBag.GetItem(id);
		if (!(item != null))
		{
			return null;
		}
		return item.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
	}

	public void SelectSlotUp()
	{
		SelectSlot(-1);
	}

	public void SelectSlotDown()
	{
		SelectSlot(1);
	}

	private void SelectSlot(int offset)
	{
		if (_bloodBottleDetail == null || _bloodBottleDetail.slots == null || _bloodBottleDetail.slots.Count == 0)
		{
			return;
		}
		List<BottleMaterialCell> slots = _bloodBottleDetail.slots;
		int num = ((_lastSelect != null) ? slots.IndexOf(_lastSelect) : (-1));
		if (num < 0)
		{
			BottleMaterialCell bottleMaterialCell = slots.Find((BottleMaterialCell slot) => slot != null && slot.gameObject.activeInHierarchy);
			if (bottleMaterialCell != null)
			{
				OnSelectSlot(bottleMaterialCell);
			}
			return;
		}
		for (int num2 = num + offset; num2 >= 0 && num2 < slots.Count; num2 += offset)
		{
			BottleMaterialCell bottleMaterialCell2 = slots[num2];
			if (bottleMaterialCell2 != null && bottleMaterialCell2.gameObject.activeInHierarchy)
			{
				OnSelectSlot(bottleMaterialCell2);
				break;
			}
		}
	}

	public void HandleGamePadSpecial2()
	{
		if (!(_bloodBottleDetail == null) && _bloodBottleDetail.slots != null && _bloodBottleDetail.slots.Count != 0 && _bloodBottleDetail.changeMatBtn.IsInteractable())
		{
			_bloodBottleDetail.changeMatBtn.OnClick?.Invoke();
		}
	}
}
