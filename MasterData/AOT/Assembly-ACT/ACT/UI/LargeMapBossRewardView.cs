using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class LargeMapBossRewardView : BaseUIView<LargeMapBossRewardViewController>
{
	public LoopScrollRect RewardItemLoopScrollRect;

	public RightStickScrollSupport rightStickScroll;

	[OdinSerialize]
	public Dictionary<SubControllerType, ViewControlLayer> ViewControlLayers;

	[OdinSerialize]
	public Dictionary<SubControllerType, List<GameObject>> ViewControlPrompt;

	private LargeMapBossRewardViewData m_data;

	private WildBossUse _wildBossUse;

	public WildBossUse WildBossUseData => _wildBossUse;

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = uiViewData as LargeMapBossRewardViewData;
	}

	protected override void Init()
	{
		base.Init();
		RefreshUI();
	}

	public void RefreshUI()
	{
		if (m_data != null)
		{
			int monsterId = m_data.monsterId;
			WildBossUse wildBossUse = null;
			foreach (KeyValuePair<int, WildBossUse> wildBossUse2 in RuntimeConfigs.data.wildBossUses)
			{
				if (wildBossUse2.Value.monsterID == monsterId)
				{
					wildBossUse = wildBossUse2.Value;
					break;
				}
			}
			if (wildBossUse != null)
			{
				_wildBossUse = wildBossUse;
				RewardItemLoopScrollRect.ClearCells();
				RewardItemLoopScrollRect.totalCount = wildBossUse.rewards.Length;
				int index = Mathf.Clamp(Model<WorldLevelModel>.Interface.GetCurWorldLevel() - 1, 0, wildBossUse.rewards.Length - 1);
				RewardItemLoopScrollRect.ScrollToCell(index, 0f);
			}
		}
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		GetController().InputState = SubControllerType.main;
		SetGamePadTipsActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	protected override void UnInit()
	{
		base.UnInit();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		SetGamePadTipsActive(mode == DeviceInputMode.Gamepad);
	}

	public void SetGamePadTipsActive(bool active)
	{
		LargeMapBossRewardViewController controller = GetController();
		if (controller != null && active && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && ViewControlLayers.TryGetValue(controller.InputState, out var value))
		{
			value?.ReFocus();
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				GamePadTipsStatusChange(controller.InputState);
			}
		}
	}

	public void ChangeToGamePadInputState(SubControllerType type, bool needReFocusLayer = false)
	{
		LargeMapBossRewardViewController controller = GetController();
		if (controller == null)
		{
			return;
		}
		controller.InputState = type;
		if (ViewControlLayers.TryGetValue(type, out var value))
		{
			if (needReFocusLayer)
			{
				value.ReFocus();
			}
			else
			{
				value.Focus();
			}
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				GamePadTipsStatusChange(controller.InputState);
			}
		}
	}

	public void GamePadTipsStatusChange(SubControllerType subController)
	{
		foreach (KeyValuePair<SubControllerType, List<GameObject>> item in ViewControlPrompt)
		{
			foreach (GameObject item2 in item.Value)
			{
				item2.SetActive(value: false);
			}
		}
		if (ViewControlPrompt.TryGetValue(subController, out var value))
		{
			foreach (GameObject item3 in value)
			{
				item3.SetActive(value: true);
			}
		}
		rightStickScroll?.SetForbidScroll(subController != SubControllerType.main);
	}

	public void HandleCommonSelectInput(SubControllerType subController)
	{
		if (subController != SubControllerType.main && subController == SubControllerType.sideBarSelectItem)
		{
			GetController().CommonSelect();
		}
	}

	public void HandleCommonBackInput(SubControllerType subController)
	{
		switch (subController)
		{
		case SubControllerType.main:
			Close();
			break;
		case SubControllerType.sideBarSelectItem:
			ChangeToGamePadInputState(SubControllerType.main, needReFocusLayer: true);
			break;
		}
	}
}
