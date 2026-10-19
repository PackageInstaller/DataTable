using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class EquipBuildSuccessView : BaseUIView<EquipBuildSuccessViewInputController>
{
	[Serializable]
	private struct PropertyStyle
	{
		public BImage propertyIcon;

		public LocalizeStringEvent propertyName;

		public TMP_Text propertyNumber;
	}

	private EquipBuildSuccessViewData m_data;

	[SerializeField]
	private EquipGemIsLockBtn m_LockComp;

	[SerializeField]
	private EquipItem m_EquipItem;

	[SerializeField]
	private LocalizeStringEvent m_EquipName;

	[SerializeField]
	private CommonEquipTypeComponent m_EquipTypeComp;

	[Header("属性面板")]
	[SerializeField]
	private PropertyStyle m_MainPropertyStyle;

	[SerializeField]
	private PropertyStyle m_Rand1PropertyStyle;

	[SerializeField]
	private PropertyStyle m_Rand2PropertyStyle;

	[Header("特性面板")]
	[SerializeField]
	private EquipBuffDetail m_EquipBuffDetailComp;

	public GamePadTipsComp gamePadGroup;

	[SerializeField]
	private GameObject m_HideInGamepadMode;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

	private Equip m_NewEquip;

	private EquipData m_EquipData;

	private ItemData m_ItemData;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		m_data = uiViewData as EquipBuildSuccessViewData;
		m_NewEquip = G.localPlayer.Inventory.GetEquip(m_data.newEquipUid);
		m_EquipData = CoreUtils.GetData(m_NewEquip.Id, RuntimeConfigs.data.equipDatas);
		m_ItemData = CoreUtils.GetData(m_NewEquip.Id, RuntimeConfigs.data.itemDatas);
		m_LockComp.Init(m_data.newEquipUid, m_NewEquip.IsLock);
		m_EquipItem.Init(m_NewEquip);
		m_EquipName.SetTable("shortcommon");
		m_EquipName.StringReference.TableEntryReference = m_ItemData?.nameLocal ?? 0;
		m_EquipTypeComp.Station = Station;
		m_EquipTypeComp.Init(m_NewEquip.TypeIndex);
		SetProperty(m_MainPropertyStyle, 0);
		SetProperty(m_Rand1PropertyStyle, 1);
		SetProperty(m_Rand2PropertyStyle, 2);
		m_NewEquip.Refresh();
		m_EquipBuffDetailComp.Init(m_NewEquip);
		OnGamePadInit();
		ReBindBtnPrompt();
		RefreshGamepadExclusiveObjects(MonoECS.instance.InputMode);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		RefreshGamepadExclusiveObjects(type);
	}

	private void RefreshGamepadExclusiveObjects(DeviceInputMode type)
	{
		if (m_HideInGamepadMode != null)
		{
			m_HideInGamepadMode.SetActive(type != DeviceInputMode.Gamepad);
		}
	}

	private void SetProperty(PropertyStyle style, int propertyIndex)
	{
		EquipAttr equipAttr = m_NewEquip.Attributes[propertyIndex];
		EquipAttrData data = CoreUtils.GetData(equipAttr.Id, RuntimeConfigs.data.equipAttrDatas);
		if (data != null)
		{
			PropertyData data2 = CoreUtils.GetData(data.attrId, RuntimeConfigs.data.propertyDatas);
			if (data2 != null)
			{
				Station.LoadImageAsync(146, data.attrId, style.propertyIcon).Forget();
				style.propertyName.StringReference.TableEntryReference = data2.descLocal;
				style.propertyNumber.SetText(equipAttr.Value.FastToString(data2.judge ? 1 : (-1), data2.judge));
			}
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation?.GetSequence("Show")?.Play();
		for (int i = 0; i < m_EquipBuffDetailComp.equipBuffItems.Count; i++)
		{
			m_EquipBuffDetailComp.equipBuffItems[i].GetComponent<BetterAnimation>().GetSequence("Show")?.Goto(0f).SetDelay(0.9f + 0.05f * (float)i).Play();
		}
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation?.GetSequence("Hide")?.Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>();
		_allInputPrompt["UI/Back"] = new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		};
	}

	private void ReBindBtnPrompt()
	{
		if (!(gamePadGroup == null) && _allInputPrompt != null)
		{
			List<GamePadTipsAction> tipsActions = _tipsActions;
			if (tipsActions == null || tipsActions.Count <= 0)
			{
				_tipsActions = new List<GamePadTipsAction>();
			}
			gamePadGroup.ClearAllPrompts();
			_tipsActions.Clear();
			_tipsActions.Add(_allInputPrompt["UI/Back"]);
			gamePadGroup.RegisterInputActions(_tipsActions);
		}
	}

	public void OnGamePadClose()
	{
		Close();
	}

	public void OnGamePadOpenBuffDetail()
	{
		m_EquipBuffDetailComp?.OpenBuffDetail();
	}

	public void OnGamePadToggleLock()
	{
		m_LockComp?.ClickLock();
	}
}
