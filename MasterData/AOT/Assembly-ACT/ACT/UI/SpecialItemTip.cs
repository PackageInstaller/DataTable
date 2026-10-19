using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using Bamboo.Chronos;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.InputSystem.DualShock;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class SpecialItemTip : BaseUIComponent
{
	public ItemUIComponentBase item;

	public ActButton self;

	public BetterAnimation anim;

	public LocalizeStringEvent nameLocalize;

	public LocalizeStringEvent typeLocalize;

	public LocalizeStringEvent systemTipDesLocalize;

	public LocalizeStringEvent operationLocalize;

	private int _curItemSystemType;

	private float _duration = 2f;

	private float _openTime;

	private bool _openFinish;

	private Tweener _tweener;

	private Dictionary<string, object> _promptTMPVariables;

	private SpecialShow _curShowTableData;

	public bool isShowing { get; private set; }

	public async UniTask Show(ItemAchieveinfo info, CancellationToken ct = default(CancellationToken))
	{
		if (!info.IsSpecial)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"道具{info.itemName},不是特殊掉落类型的，如果是，检查SpeicalShow表");
			}
			return;
		}
		SpecialShow specialShow = (_curShowTableData = RuntimeConfigs.data.specialShows[info.Type]);
		_curItemSystemType = info.Type;
		if (specialShow == null)
		{
			return;
		}
		isShowing = true;
		_openTime = Time.unscaledTime;
		self.SetBtnClick(OpenTargetView);
		_promptTMPVariables = DictionaryPool<string, object>.Get();
		MonoECS.instance.onInputModeChange.AddListener(OnActiveInputDeviceChanged);
		nameLocalize.StringReference.TableEntryReference = info.itemName;
		typeLocalize.SetTable("shortcommon");
		typeLocalize.StringReference.TableEntryReference = CoreUtils.GetData(info.itemId, RuntimeConfigs.data.itemDatas).typeLocal;
		systemTipDesLocalize.SetTable("shortcommon");
		systemTipDesLocalize.StringReference.TableEntryReference = CoreUtils.GetData(info.Type, RuntimeConfigs.data.specialShows).describe;
		if (MonoECS.instance.InputMode != DeviceInputMode.TouchScreen && MonoECS.instance.InputMode != DeviceInputMode.Unknown)
		{
			operationLocalize.gameObject.SetActive(value: true);
			SetOperationTipVariables(specialShow);
		}
		else
		{
			operationLocalize.gameObject.SetActive(value: false);
		}
		ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get<Item>(info.itemId, 0L);
		item.SetData(itemUnifierProxy, long.MinValue, ItemUIComponentBase.InitType.RewardItem);
		item.UpdatePerformance();
		gameObject.SetActive(value: true);
		if (anim != null)
		{
			anim.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				Hide();
			}).Play();
		}
		else if (!_tweener.IsValid())
		{
			_tweener = UpdateTimer.Default.TweenMs((int)(_duration * 1000f), (int t) =>
			{
			}, (bool _) =>
			{
				Uninit();
			});
		}
		_openFinish = true;
		await UniTask.WaitUntil(() => !isShowing, PlayerLoopTiming.Update, ct);
	}

	private void OnActiveInputDeviceChanged(DeviceInputMode arg0)
	{
		if (operationLocalize.gameObject.activeInHierarchy && _curShowTableData != null)
		{
			SetOperationTipVariables(_curShowTableData);
		}
	}

	public void OpenTargetView()
	{
		if (_curItemSystemType == 0)
		{
			return;
		}
		object uiData = null;
		switch (_curItemSystemType)
		{
		case 15:
		case 16:
			uiData = new MonoInventoryData
			{
				inventoryTab = InventoryTab.HealingPotion
			};
			break;
		}
		SpecialShow specialShow = RuntimeConfigs.data.specialShows[_curItemSystemType];
		foreach (KeyValuePair<UI_TYPE, UIData> dICT_UI_DATum in CommonUIData.DICT_UI_DATA)
		{
			if (dICT_UI_DATum.Value == null || !dICT_UI_DATum.Value.mobilePath.Equals(specialShow.path))
			{
				continue;
			}
			if (specialShow.path == "UI/TeamView")
			{
				if (MonoECS.instance.playState == PlayState.UnBattle || MonoECS.instance.IsInTrainingground)
				{
					Singleton<NewUIManager>.instance.OpenUI(dICT_UI_DATum.Key, new TeamViewData
					{
						source = TeamProfileSource.World
					});
				}
				else
				{
					GameUtility.OpenToolTip(479);
				}
			}
			else
			{
				Singleton<NewUIManager>.instance.OpenUI(dICT_UI_DATum.Key, uiData);
			}
		}
	}

	private void Hide()
	{
		if (anim != null)
		{
			anim.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				Uninit();
			}).Play();
		}
		else
		{
			Uninit();
		}
	}

	public void Uninit()
	{
		if (isShowing)
		{
			if (_tweener.IsValid())
			{
				_tweener.Cancel();
			}
			isShowing = false;
			gameObject.SetActive(value: false);
			DictionaryPool<string, object>.Release(_promptTMPVariables);
			item.Release();
			MonoECS.instance.onInputModeChange.RemoveListener(OnActiveInputDeviceChanged);
			_curShowTableData = null;
		}
	}

	private void SetOperationTipVariables(SpecialShow tableData)
	{
		_promptTMPVariables.Clear();
		string actionName = tableData.actionName;
		string bindingKeyName3;
		if (MonoECS.instance.TryGetInputActionKeyBindingInfo(actionName, out var bindingInfo) && bindingInfo.GetMode() == MonoECS.CompositeMode.OneModifier)
		{
			string bindingKeyName = bindingInfo.GetKeyBinding(0);
			if (KeyNameTransferToTMPVariableName(ref bindingKeyName))
			{
				_promptTMPVariables[0.FastToString()] = bindingKeyName;
			}
			string bindingKeyName2 = bindingInfo.GetKeyBinding(-1);
			if (KeyNameTransferToTMPVariableName(ref bindingKeyName2))
			{
				_promptTMPVariables[1.FastToString()] = bindingKeyName2;
			}
		}
		else if (MonoECS.instance.GetInputDeviceButtonBindingKeyName(actionName, out bindingKeyName3))
		{
			if (!KeyNameTransferToTMPVariableName(ref bindingKeyName3))
			{
				_ = LuminApplication.LogEnabled;
				return;
			}
			_promptTMPVariables[0.FastToString()] = bindingKeyName3;
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
		Model<GuideTipModel>.Interface.SetVariables(operationLocalize, _promptTMPVariables);
		operationLocalize.SetTable("shortcommon");
		operationLocalize.StringReference.TableEntryReference = (MonoECS.instance.IsGamePadMode() ? tableData.PadKeyTip : tableData.KeyTip);
	}

	private bool KeyNameTransferToTMPVariableName(ref string bindingKeyName)
	{
		if (!string.IsNullOrEmpty(bindingKeyName))
		{
			bindingKeyName = bindingKeyName.Replace("/", "_");
			if (MonoECS.instance.activeInputDevice is DualShockGamepad)
			{
				bindingKeyName = bindingKeyName.Replace("gamepad", "gamepad_Sony");
			}
			return true;
		}
		return false;
	}

	private void OnDestroy()
	{
		if (isShowing)
		{
			MonoECS.instance.onInputModeChange.RemoveListener(OnActiveInputDeviceChanged);
			_curShowTableData = null;
			if (_tweener.IsValid())
			{
				_tweener.Cancel();
			}
			isShowing = false;
		}
	}
}
