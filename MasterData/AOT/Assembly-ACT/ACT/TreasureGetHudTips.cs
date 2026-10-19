using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.InputSystem.DualShock;
using UnityEngine.Localization.Components;

namespace ACT;

public class TreasureGetHudTips : SubUIView<TreasureGetHudTipsInputController>, IBattleMainComponent
{
	[SerializeField]
	private LiteItemUIComponent _treasureItem;

	[SerializeField]
	private TextMeshProUGUI _treasureName;

	[SerializeField]
	private ActButton _btnArea;

	[SerializeField]
	private GameObject _attributeRoot;

	[SerializeField]
	private GameObject _globalAttributeRoot;

	[SerializeField]
	private CommonCharacterHead _commonCharacterHead;

	[SerializeField]
	private AttributeTab _attributeTab;

	[SerializeField]
	private GameObject _specialTreasureRoot;

	[SerializeField]
	private TextMeshProUGUI _specialTreasureName;

	[SerializeField]
	private TextMeshProUGUI _globalText;

	[SerializeField]
	private TextMeshProUGUI _specialTreasureLeftTxt;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private LocalizeStringEvent Tips;

	private int _treasureId = -1;

	private readonly List<AttributeTab> _spawnedAttributeTabs = new List<AttributeTab>();

	private ImageAssetStation _station;

	private CancellationTokenSource _cts;

	private CancellationToken _ct;

	private TreasureModel _model;

	private bool _queueDequeued;

	private const int globalTextID = 2733;

	private const int specialTreasureLeftTxtID = 2732;

	private const string LEFT_SHOULDER = "<sprite name=gamepad_leftshoulder>";

	private const string SONY_LEFT_SHOULDER = "<sprite name=gamepad_Sony_leftshoulder>";

	private const string RIGHT_SHOULDER = "<sprite name=gamepad_rightshoulder>";

	private const string SONY_RIGHT_SHOULDER = "<sprite name=gamepad_Sony_rightshoulder>";

	public bool IsShowing { get; private set; }

	public int CurrentTreasureId => _treasureId;

	public void SetTreasureId(int treasureId)
	{
		_treasureId = treasureId;
	}

	public void Init(int treasureId)
	{
		_treasureId = treasureId;
		Init();
	}

	public void Init()
	{
		if (_treasureId <= 0)
		{
			gameObject.SetActive(value: false);
			return;
		}
		ItemTreasureData data = CoreUtils.GetData(_treasureId, RuntimeConfigs.data.itemTreasureDatas);
		if (data == null)
		{
			gameObject.SetActive(value: false);
			return;
		}
		ItemData data2 = CoreUtils.GetData(data.itemId, RuntimeConfigs.data.itemDatas);
		if (data2 == null)
		{
			gameObject.SetActive(value: false);
			return;
		}
		bool flag = Model<TreasureModel>.Interface.HasGain(_treasureId);
		bool flag2 = Model<TreasureModel>.Interface.IsSpecialTreasure(_treasureId);
		bool flag3 = Model<TreasureModel>.Interface.IsGlobalTreasure(_treasureId);
		InitTreasureItem(data.itemId);
		_treasureName.SetText(flag ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data2.nameLocal) : "???");
		_globalText.SetText(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2733));
		_specialTreasureLeftTxt.SetText(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2732));
		_attributeRoot?.SetActive(flag && !flag2);
		_globalAttributeRoot?.SetActive(flag & flag3);
		_specialTreasureRoot?.SetActive(flag & flag2);
		_commonCharacterHead?.SetActive(flag && !flag3 && !flag2 && data.characterId > 0);
		if (flag && !flag3 && !flag2 && data.characterId > 0)
		{
			_commonCharacterHead?.Init(data.characterId, GetStation());
		}
		if (flag && !flag2)
		{
			RefreshAttributeTabs(data);
		}
		else
		{
			ClearAttributeTabs();
		}
		if (flag & flag2)
		{
			SystemOpen data3 = CoreUtils.GetData(data.functionId, RuntimeConfigs.data.systemOpens);
			_specialTreasureName.SetText(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data3.localNameId));
		}
		else
		{
			_specialTreasureName.SetText(string.Empty);
		}
		_btnArea.SetBtnClick(OnClickJumpTreasureCenter);
		RereshTips(MonoECS.instance.InputMode);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		RereshTips(type);
	}

	private void RereshTips(DeviceInputMode deviceInputMode)
	{
		Tips.SetTable(LocalizationUtility.localizeTableName_Common);
		switch (deviceInputMode)
		{
		case DeviceInputMode.KeyboardAndMouse:
			Tips.StringReference.TableEntryReference = 2697L;
			Tips.GetVariable<string>("0").Value = "<sprite name=keyboard_equal>";
			break;
		case DeviceInputMode.Gamepad:
			Tips.StringReference.TableEntryReference = 2696L;
			Tips.GetVariable<string>("0").Value = ((MonoECS.instance.activeInputDevice is DualShockGamepad) ? "<sprite name=gamepad_Sony_leftshoulder>" : "<sprite name=gamepad_leftshoulder>");
			Tips.GetVariable<string>("1").Value = ((MonoECS.instance.activeInputDevice is DualShockGamepad) ? "<sprite name=gamepad_Sony_rightshoulder>" : "<sprite name=gamepad_rightshoulder>");
			break;
		default:
			Tips.StringReference.TableEntryReference = 2695L;
			break;
		}
	}

	private void InitTreasureItem(int itemId)
	{
		if (!(_treasureItem == null))
		{
			Item item = new Item
			{
				Id = itemId
			};
			_treasureItem.Station = GetStation();
			_treasureItem.SetData(item, 0L);
			_treasureItem.showDetailPanel = false;
			_treasureItem.IsHighLight = false;
			_treasureItem.UpdatePerformance();
		}
	}

	private void RefreshAttributeTabs(ItemTreasureData itemTreasureData)
	{
		ClearAttributeTabs();
		if (_attributeTab == null || itemTreasureData.attrId == null || itemTreasureData.attrIncreaseNum == null)
		{
			return;
		}
		int num = Mathf.Min(itemTreasureData.attrId.Length, itemTreasureData.attrIncreaseNum.Length);
		for (int i = 0; i < num; i++)
		{
			PropertyData data = CoreUtils.GetData(itemTreasureData.attrId[i], RuntimeConfigs.data.propertyDatas);
			if (data != null)
			{
				AttributeTab attributeTab = UnityEngine.Object.Instantiate(_attributeTab, _attributeTab.transform.parent);
				attributeTab.gameObject.SetActive(value: true);
				attributeTab.UpdateTabView(data, itemTreasureData.attrIncreaseNum[i]);
				_spawnedAttributeTabs.Add(attributeTab);
			}
		}
		_attributeTab.gameObject.SetActive(value: false);
	}

	private void ClearAttributeTabs()
	{
		for (int i = 0; i < _spawnedAttributeTabs.Count; i++)
		{
			if (_spawnedAttributeTabs[i] != null)
			{
				UnityEngine.Object.Destroy(_spawnedAttributeTabs[i].gameObject);
			}
		}
		_spawnedAttributeTabs.Clear();
		if (_attributeTab != null)
		{
			_attributeTab.gameObject.SetActive(value: false);
		}
	}

	private void OnClickJumpTreasureCenter()
	{
		if (_treasureId > 0)
		{
			ItemTreasureData data = CoreUtils.GetData(_treasureId, RuntimeConfigs.data.itemTreasureDatas);
			if (data != null)
			{
				ItemTreasureCenterViewData uiData = new ItemTreasureCenterViewData
				{
					OpenType = data.type,
					JumpTargetTreasureId = _treasureId,
					ShouldJumpToSpecificTreasure = true
				};
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ITEMTREASURECENTER, uiData);
			}
		}
	}

	private ImageAssetStation GetStation()
	{
		if (_station == null)
		{
			IBaseUIView componentInParent = GetComponentInParent<IBaseUIView>();
			_station = ((componentInParent != null) ? componentInParent.Station : ImageManager.instance.GetAssetStation());
		}
		return _station;
	}

	private void OnDestroy()
	{
		ClearAttributeTabs();
	}

	public void Show(TreasureGetHudTipsData data, ImageAssetStation station, Action openFail)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Collection/Tips");
		_queueDequeued = false;
		onClose = () =>
		{
			if (!_queueDequeued)
			{
				_queueDequeued = true;
				Model<BattleMainModel>.Interface.HudPositionUIDequeue(UIPosition.LeftBottom);
			}
		};
		try
		{
			_model = Model<TreasureModel>.Interface;
			gameObject.SetActive(value: true);
			if (data.Id == 0)
			{
				return;
			}
			Init(data.Id);
			IsShowing = true;
			_cts = new CancellationTokenSource();
			_ct = _cts.Token;
			PlayShowAnimation();
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"藏品Hud提示打开失败：{arg}");
			}
			openFail?.Invoke();
			Hide();
		}
		FocusIn();
	}

	private void Hide()
	{
		if (this == null)
		{
			return;
		}
		_cts?.Cancel();
		_cts?.Dispose();
		_cts = null;
		GameObject go = gameObject;
		if (_betterAnimation == null)
		{
			if (!(go == null))
			{
				go.SetActive(value: false);
				IsShowing = false;
				onClose?.Invoke();
				onClose = null;
			}
			return;
		}
		_ = _treasureId;
		_betterAnimation.GetSequence("Hide")?.OnComplete((AnimationBuilder _) =>
		{
			if (!(this == null) && !(go == null))
			{
				go.SetActive(value: false);
				IsShowing = false;
				onClose?.Invoke();
				onClose = null;
			}
		}).Play();
		FocusOut();
	}

	private void PlayShowAnimation()
	{
		if (_betterAnimation == null)
		{
			gameObject.SetActive(value: true);
			AutoHideAfterDelay(_ct).Forget();
			return;
		}
		_betterAnimation.GetSequence("Show")?.OnComplete((AnimationBuilder _) =>
		{
			if (!(this == null))
			{
				AutoHideAfterDelay(_ct).Forget();
			}
		}).Play();
	}

	private async UniTaskVoid AutoHideAfterDelay(CancellationToken token)
	{
		try
		{
			await UniTask.Delay(TimeSpan.FromSeconds(7.0), ignoreTimeScale: false, PlayerLoopTiming.Update, token);
			Hide();
		}
		catch (OperationCanceledException)
		{
		}
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
	}

	public void UnInitialize()
	{
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
		Hide();
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}

	private new void OnDisable()
	{
		_cts?.Cancel();
		_cts?.Dispose();
		_cts = null;
		IsShowing = false;
		onClose?.Invoke();
		onClose = null;
	}

	public void JumpTreasure()
	{
		if (_btnArea.gameObject.activeSelf && _btnArea.IsInteractable())
		{
			_btnArea.OnSubmit(null);
		}
	}
}
