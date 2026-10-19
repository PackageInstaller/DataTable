using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.ItemDetail;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class BloodbottleSelectBar : MonoBehaviour
{
	private enum EquipState
	{
		None,
		Equip,
		UnEquip,
		Switch
	}

	[SerializeField]
	private LoopVerticalScrollRect _scrollRect;

	[SerializeField]
	private CommonItemDetail bottleDetail;

	[SerializeField]
	private ActButton jumpToBottleView;

	[SerializeField]
	private ActButton equipBtn;

	[SerializeField]
	private OperateBtnPrompt equipBtnPrompt;

	[SerializeField]
	private LocalizeStringEvent equipBtnStrEvent;

	[SerializeField]
	[Header("关闭按钮")]
	private ActButton _closeBtn;

	[SerializeField]
	private LocalizeStringEvent _closeBtnStringEvent;

	[SerializeField]
	private GameObject emptyRoot;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private ActButton _maskBtn;

	private TeamView parentView;

	private BloodBottleData _lastChooseBottle;

	private List<BloodBottleData> bottleList;

	private EquipState _equipState;

	private bool _suppressClickSound;

	private CommonUILifeCycle _lifeCycle;

	public bool IsNormal => _lifeCycle == CommonUILifeCycle.Normal;

	private bool _dataFormMainWorld => Model<TeamModel>.Interface.source == TeamProfileSource.World;

	public Action OnClosed { get; set; }

	public ActButton jumpToBottleViewBtn => jumpToBottleView;

	public ActButton equipBottleBtn => equipBtn;

	public event Action<BloodBottleData, bool> OnEquipStateChange;

	public void InvokeEquip()
	{
		if (equipBtn != null && equipBtn.IsInteractable())
		{
			equipBtn.OnClick?.Invoke();
		}
	}

	public void InvokeJumpToBottleView()
	{
		if (!(jumpToBottleView == null))
		{
			if (jumpToBottleView.IsInteractable())
			{
				jumpToBottleView.OnClick?.Invoke();
			}
			else
			{
				jumpToBottleView.OnUnInteractableClick?.Invoke();
			}
		}
	}

	public void InitData(TeamView teamView)
	{
		parentView = teamView;
		_scrollRect.OnItemShow.RemoveAllListeners();
		_scrollRect.OnItemShow.AddListener(OnItemShow);
		bottleList = new List<BloodBottleData>();
		if (MonoECS.instance.sceneStatus == SceneStatus.Raid)
		{
			bottleList.AddRange(Model<BloodBottleModel>.Interface.GetMainAlreadyHaveBottles());
		}
		else
		{
			bottleList.AddRange(Model<BloodBottleModel>.Interface.alreadyHaveBottles);
		}
		bottleDetail.Station = parentView.Station;
		jumpToBottleView.SetBtnClick(HandleJumpToBottleViewClick);
		jumpToBottleView.OnUnInteractableClick.RemoveAllListeners();
		jumpToBottleView.OnUnInteractableClick.AddListener(HandleJumpToBottleViewClick);
		_maskBtn.SetBtnClick(CloseBar);
	}

	private void OnItemShow(ILoopScrollDataSource item)
	{
		TeamViewBottleCell teamViewBottleCell = item as TeamViewBottleCell;
		BloodBottleData curBottle = bottleList[teamViewBottleCell.index];
		teamViewBottleCell.Refresh(curBottle, parentView.Station, Model<TeamModel>.Interface.CurSelectedTeamProfile, parentView._sb);
		teamViewBottleCell.btn.SetBtnClick(() =>
		{
			if (!_suppressClickSound)
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/Buff/Left_Click");
			}
			_suppressClickSound = false;
			if (_lastChooseBottle.uid != curBottle.uid)
			{
				int id = bottleList.IndexOf(_lastChooseBottle);
				(_scrollRect.GetItem(id) as TeamViewBottleCell)?.SetSelectState(isSelect: false);
				_lastChooseBottle = curBottle;
				ChooseBottle(curBottle);
				UpdateEquipBtnState(_equipState);
			}
		});
		teamViewBottleCell.gameObject.SetActive(value: true);
	}

	private void HandleJumpToBottleViewClick()
	{
		if (_lastChooseBottle != null)
		{
			Singleton<BloodBottleHandler>.instance.JumpToBottleView(_lastChooseBottle.uid, needFuzzy: true, isFromTeam: true);
		}
	}

	public void Refresh()
	{
		bottleList.Sort(SortUtility.SortBloodBottleInTeamView);
		GameObject gameObject = emptyRoot;
		List<BloodBottleData> list = bottleList;
		gameObject.SetActive(list == null || list.Count <= 0);
		GameObject gameObject2 = bottleDetail.gameObject;
		list = bottleList;
		gameObject2.SetActive(list != null && list.Count > 0);
		list = bottleList;
		if (list != null && list.Count > 0)
		{
			_scrollRect.ClearCells();
			_scrollRect.totalCount = bottleList.Count;
			_scrollRect.RefillCells();
			_suppressClickSound = true;
			_lastChooseBottle = bottleList[0];
			ChooseBottle(bottleList[0]);
		}
		UpdateEquipBtnState(_equipState);
		_closeBtn.gameObject.SetActive(value: true);
		_closeBtnStringEvent.StringReference.TableEntryReference = LocalizationCommonData.CommonString.ChooseBloodbottle;
		_closeBtn.SetBtnClick(CloseBar, "event:/UI/Common/Return_Click");
		GameObject gameObject3 = equipBottleBtn.gameObject;
		list = bottleList;
		gameObject3.SetActive(list != null && list.Count > 0);
		GameObject gameObject4 = jumpToBottleView.gameObject;
		list = bottleList;
		gameObject4.SetActive(list != null && list.Count > 0);
		jumpToBottleViewBtn.Interactable(Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.BloodBottleCultivate));
		base.gameObject.SetActive(value: true);
		_lifeCycle = CommonUILifeCycle.Opening;
		MonoECS.instance.PushPauseAllInput();
		_betterAnimation?.GetSequence("show").OnComplete((AnimationBuilder _) =>
		{
			ShowEnd();
		}).Play();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/Buff/Window_Open");
	}

	public ACT.ViewControl.SelectableEx GetDefaultBottleSelectableEx()
	{
		List<BloodBottleData> list = bottleList;
		if (list == null || list.Count <= 0 || _lastChooseBottle == null)
		{
			return null;
		}
		int id = bottleList.IndexOf(_lastChooseBottle);
		TeamViewBottleCell teamViewBottleCell = _scrollRect.GetItem(id) as TeamViewBottleCell;
		if (!(teamViewBottleCell != null))
		{
			return null;
		}
		return teamViewBottleCell.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
	}

	public void CloseBar()
	{
		if (_lifeCycle != CommonUILifeCycle.Normal)
		{
			return;
		}
		_lifeCycle = CommonUILifeCycle.Closing;
		try
		{
			MonoECS.instance.PushPauseAllInput();
			_betterAnimation?.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				HideEnd();
			}).Play();
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/Buff/Window_Close");
		}
		catch (Exception ex)
		{
			HideEnd();
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("血瓶侧边栏关闭失败：" + ex.Message);
			}
		}
	}

	private void HideEnd()
	{
		MonoECS.instance.PopPauseAllInput();
		gameObject.SetActive(value: false);
		_lifeCycle = CommonUILifeCycle.Hidden;
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.BloodBottleBarClose);
		OnClosed?.Invoke();
	}

	private void ShowEnd()
	{
		MonoECS.instance.PopPauseAllInput();
		_lifeCycle = CommonUILifeCycle.Normal;
	}

	private void ChooseBottle(BloodBottleData bottle)
	{
		ItemUnifierProxy item = bottleDetail.Context as ItemUnifierProxy;
		ItemUnifierProxy.ItemUnifierPool.Release(ref item);
		ItemUnifierProxy context = ItemUnifierProxy.ItemUnifierPool.Get(bottle);
		if (bottleDetail != null)
		{
			bottleDetail.Context = context;
			(_scrollRect.GetItem(bottleList.IndexOf(bottle)) as TeamViewBottleCell)?.SetSelectState(isSelect: true);
		}
		if (!_dataFormMainWorld)
		{
			_equipState = ((Model<TeamModel>.Interface.CurSelectedTeamProfile.EquipPotionId == 0) ? EquipState.Equip : ((Model<TeamModel>.Interface.CurSelectedTeamProfile.EquipPotionId == bottle.id) ? EquipState.UnEquip : EquipState.Switch));
		}
		else if (Model<TeamModel>.Interface.CurSelectedTeamProfile.EquipPotionId == bottle.uid)
		{
			_equipState = EquipState.UnEquip;
		}
		else if (Model<TeamModel>.Interface.CurSelectedTeamProfile.EquipPotionId == 0)
		{
			_equipState = EquipState.Equip;
		}
		else
		{
			_equipState = EquipState.Switch;
		}
	}

	private void UpdateEquipBtnState(EquipState state)
	{
		if (parentView == null)
		{
			return;
		}
		bool arg = state != EquipState.Equip;
		OnEquipStateChange?.Invoke(_lastChooseBottle, arg);
		ActButton actButton = equipBtn;
		actButton.Interactable(state switch
		{
			EquipState.Equip => true, 
			EquipState.UnEquip => true, 
			EquipState.Switch => true, 
			_ => false, 
		});
		OperateBtnPrompt operateBtnPrompt = equipBtnPrompt;
		operateBtnPrompt.SetVisible(state switch
		{
			EquipState.Equip => true, 
			EquipState.UnEquip => true, 
			EquipState.Switch => true, 
			_ => false, 
		});
		LocalizedString stringReference = equipBtnStrEvent.StringReference;
		stringReference.TableEntryReference = state switch
		{
			EquipState.Equip => LocalizationCommonData.CommonString.EquipmentSubView, 
			EquipState.UnEquip => LocalizationCommonData.CommonString.Unload, 
			EquipState.Switch => LocalizationCommonData.CommonString.Exchange, 
			_ => LocalizationCommonData.CommonString.EquipmentSubView, 
		};
		equipBtn.SetBtnClick(() =>
		{
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.TeamBloodBottleEquip);
			BloodBottleData bloodBottleData = (_dataFormMainWorld ? Model<BloodBottleModel>.Interface.GetBloodBottleById(_lastChooseBottle.uid) : bottleList.FirstOrDefault((BloodBottleData x) => x.uid == _lastChooseBottle.uid));
			switch (state)
			{
			case EquipState.Equip:
			case EquipState.Switch:
			{
				BloodBottleData bloodBottleData2 = (_dataFormMainWorld ? Model<BloodBottleModel>.Interface.GetBloodBottleById(Model<TeamModel>.Interface.CurSelectedTeamProfile.EquipPotionId) : bottleList.FirstOrDefault((BloodBottleData x) => x.uid == Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId));
				Singleton<BloodBottleHandler>.instance.ChangeEquipBottle(bloodBottleData2, bloodBottleData);
				_equipState = EquipState.UnEquip;
				TeamViewBottleCell teamViewBottleCell = _scrollRect.GetItem(bottleList.IndexOf(_lastChooseBottle)) as TeamViewBottleCell;
				TeamViewBottleCell obj = _scrollRect.GetItem(bottleList.IndexOf(bloodBottleData2)) as TeamViewBottleCell;
				teamViewBottleCell?.SetEquipState(isEquip: true);
				obj?.SetEquipState(isEquip: false);
				break;
			}
			case EquipState.UnEquip:
				Singleton<BloodBottleHandler>.instance.BottleUnload(bloodBottleData);
				_equipState = EquipState.Equip;
				(_scrollRect.GetItem(bottleList.IndexOf(_lastChooseBottle)) as TeamViewBottleCell)?.SetEquipState(isEquip: false);
				break;
			}
			ItemChangeEvt evt = Singleton<EventManager>.instance.GetEvt<ItemChangeEvt>();
			evt.ItemProxies = ListPool<ItemUnifierProxy>.Get();
			evt.ItemProxies.Add(bottleDetail.Context as ItemUnifierProxy);
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.BagItemChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			ListPool<ItemUnifierProxy>.Release(evt.ItemProxies);
			UpdateEquipBtnState(_equipState);
		}, "event:/UI/Interface/Team/Buff/Equip");
	}

	private void OnDestroy()
	{
		Singleton<UIAtlasManager>.instance.UnloadSprite(GameLoader.meta.itemAtlasNameAssetID);
	}
}
