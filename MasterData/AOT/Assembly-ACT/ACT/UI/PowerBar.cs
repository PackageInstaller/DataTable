using System;
using ACT.Battle;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using Runtime.Model.PowerModel;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class PowerBar : MonoBehaviour, IUIFrameElement
{
	public TMP_Text curCount;

	public TMP_Text totalCount;

	public OperateBtnPrompt operateBtnPrompt;

	public ActButton addPowerBtn;

	private bool m_isShow;

	private int m_totalCount;

	private bool m_isDirty;

	private void Start()
	{
		m_isShow = false;
		m_totalCount = RuntimeConfigs.data.game.powerLimit;
		curCount.SetText("{0:0}", Model<PowerModel>.Interface.PowerCount);
		totalCount.SetText("{0:0}", m_totalCount);
		PowerModel powerModel = Model<PowerModel>.Interface;
		powerModel.OnPowerChanged = (Action)Delegate.Combine(powerModel.OnPowerChanged, new Action(OnPowerChanged));
		addPowerBtn?.SetBtnClick(OpenAddPower);
		MonoECS.instance.onInputModeChange.AddListener(SetPromptActive);
		SetPromptActive(MonoECS.instance.InputMode);
	}

	private void OnPowerChanged()
	{
		curCount.SetText("{0:0}", Model<PowerModel>.Interface.PowerCount);
	}

	private void OnDestroy()
	{
		m_isShow = false;
		PowerModel powerModel = Model<PowerModel>.Interface;
		powerModel.OnPowerChanged = (Action)Delegate.Remove(powerModel.OnPowerChanged, new Action(OnPowerChanged));
		MonoECS.instance.onInputModeChange.RemoveListener(SetPromptActive);
	}

	public void OnClick()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
		{
			Id = 96,
			Count = Model<PowerModel>.Interface.PowerCount
		});
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Instance/Click");
	}

	public void ClosePanel()
	{
		if (m_isShow)
		{
			m_isShow = false;
		}
	}

	private void Update()
	{
		Model<PowerModel>.Interface.Tick();
	}

	public void OpenAddPower()
	{
		TextPanel.Param param = new TextPanel.Param();
		param.titleId = 0;
		param.commonId = 0;
		param.OnCancel = () =>
		{
			gameObject.SetActive(value: true);
		};
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ADDPOWER, param);
		gameObject.SetActive(value: false);
	}

	private void SetPromptActive(DeviceInputMode mode)
	{
		operateBtnPrompt?.SetVisible(mode == DeviceInputMode.Gamepad);
	}
}
