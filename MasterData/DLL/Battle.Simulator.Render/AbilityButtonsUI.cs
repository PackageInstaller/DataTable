using System;
using System.Collections.Generic;
using Config;
using UnityEngine;

public class AbilityButtonsUI : MonoBehaviour
{
	private const int AVOID_BUTTON_INDEX = 5;

	public const int QTE_BUTTON_INDEX = 4;

	private const int MAX_ABILITY_BUTTON_COUNT = 3;

	public AbilityButton QTEButton;

	public AbilityButton MeleeButton;

	public AbilityButton AvoidButton;

	public AbilityButton[] AbilityButtons = new AbilityButton[3];

	private int[] _abilityIDs = new int[3];

	private int[] _abilityConsume = new int[3] { 1852392284, 1667329381, 1701734760 };

	private int[] _lastAbilityCDs = new int[3];

	private bool[] _lastAbilityEnable = new bool[3];

	private int[] _lastChargingCount = new int[3];

	private bool _enableQTE = true;

	private int _qteCD = -1;

	private int _uniqueValue = -1;

	private NAgent _agent;

	private BBHumanoid _blackboard;

	private ComponentHealth _componentHealth;

	private string _atlasName = string.Empty;

	private Sprite _qteIconOrgSprite;

	public Action AbilityButtonsUIInit;

	public Action<int> OnBeginCD;

	public Action<int> OnCompleteCD;

	public Action<int, int, int> OnAbilityChargingCountChange;

	public Action<int, int, int> OnAbilityChange;

	public Action<int, bool> OnAbilityEnable;

	public Action<bool> OnValidQTE;

	public Action<int, int> OnUniqueValueChanged;

	private void OnDestroy()
	{
		_qteIconOrgSprite = null;
	}

	public void SetQteIcon(Sprite sprite)
	{
		if (QTEButton != null)
		{
			QTEButton.SetIcon(sprite);
		}
	}

	public void RevertQteIcon()
	{
		if (_qteIconOrgSprite != null && QTEButton != null)
		{
			QTEButton.SetIcon(_qteIconOrgSprite);
		}
	}

	public void OnMainPlayerUpdate(NAgent agent)
	{
		_agent = agent;
		_blackboard = agent.Blackboard as BBHumanoid;
		_componentHealth = _agent.GetComponent<ComponentHealth>();
		RoleConfig roleLogicConfig = (_agent.Blackboard as BBHumanoid).RoleLogicConfig;
		_atlasName = "Atlas/" + roleLogicConfig.ID;
		for (int i = 0; i < roleLogicConfig.Ability.Count && i < _abilityIDs.Length; i++)
		{
			UpdateAbilityButton(i, roleLogicConfig.Ability.get_Item(i));
		}
		if (QTEButton != null && ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(roleLogicConfig.ID, out var config) && config.AbilityId.Count > 0)
		{
			_qteIconOrgSprite = AtlasManager.GetSprite(_atlasName, config.AbilityId.get_Item(0).ToString());
			QTEButton.SetIcon(_qteIconOrgSprite);
		}
		if (MeleeButton != null && roleLogicConfig.Melees.Count > 0)
		{
			MeleeButton.SetIcon(AtlasManager.GetSprite(_atlasName, roleLogicConfig.Melees.get_Item(0).ToString()));
		}
		if (AbilityButtonsUIInit != null)
		{
			AbilityButtonsUIInit();
		}
	}

	private void Update()
	{
		UpdateUI();
	}

	private void OnEnable()
	{
		UpdateUI();
	}

	private void UpdateAbilityButton(int index, int abilityID)
	{
		_abilityIDs[index] = abilityID;
		_lastAbilityCDs[index] = 0;
		_lastChargingCount[index] = -1;
		if (AbilityButtons[index] != null)
		{
			AbilityButtons[index].SetIcon(AtlasManager.GetSprite(_atlasName, abilityID.ToString()));
		}
	}

	private void UpdateAbilityConsume(int index, int consume)
	{
		if (consume < 0)
		{
			AbilityButtons[index].ShowConsume(visible: true);
			AbilityButtons[index].UpdateConsume(CommonString.Numbers[Mathf.Abs(consume)]);
		}
		else
		{
			AbilityButtons[index].ShowConsume(visible: false);
		}
		_abilityConsume[index] = consume;
	}

	private void UpdateUI()
	{
		if (null == _blackboard || _blackboard.m_NextSimFrameData == null || _blackboard.m_LastSimFrameData == null || _blackboard.m_LastSimFrameData.AbilityStateDict == null)
		{
			return;
		}
		if (null != _componentHealth)
		{
			AvoidButton.Setendurance(_componentHealth.EnduranceValue, _componentHealth.MaxEnduranceValue);
		}
		Dictionary<int, AbilityStatueInfo> abilityStateDict = _blackboard.m_NextSimFrameData.AbilityStateDict;
		if (abilityStateDict.TryGetValue(6, out var value))
		{
			AvoidButton.SetCD(value.CD, value.MaxCD);
			AvoidButton.SetCharge(value.ChargingCount);
			AvoidButton.ShowDisable(!value.Enable);
			if (value.CD == 0 || value.ChargingCount > 0)
			{
				AvoidButton.Enable = true;
				OnTriggerAbilityEnable(6, enable: true);
				if (OnCompleteCD != null)
				{
					OnCompleteCD(6);
				}
			}
			else
			{
				AvoidButton.Enable = false;
				OnTriggerAbilityEnable(6, enable: false);
			}
		}
		if (QTEButton != null)
		{
			WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (worldStateManager != null && worldStateManager.m_cooperateUniqueSkillIsActive && battleScene != null && ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(battleScene.ready.SceneDataForExcehange.CooperateUniqueSkillID, out var config) && config.CooperateRoleIds.Contains(_blackboard.RoleLogicConfig.ID))
			{
				if (_qteCD != worldStateManager.m_cooperateUniqueSkillCD)
				{
					QTEButton.SetCD(worldStateManager.m_cooperateUniqueSkillCD, worldStateManager.m_cooperateUniqueSkillMaxCD);
					_qteCD = worldStateManager.m_cooperateUniqueSkillCD;
				}
				if (_qteCD <= 0 && _enableQTE != worldStateManager.m_cooperateUniqueSkillVaild)
				{
					QTEButton.ShowDisable(!worldStateManager.m_cooperateUniqueSkillVaild);
					_enableQTE = worldStateManager.m_cooperateUniqueSkillVaild;
				}
			}
			else
			{
				if (abilityStateDict.TryGetValue(7, out var value2) && _qteCD != value2.CD)
				{
					QTEButton.SetCD(value2.CD, value2.MaxCD);
					_qteCD = value2.CD;
				}
				if (_qteCD <= 0 && _enableQTE != _blackboard.m_NextSimFrameData.ValidQTE)
				{
					QTEButton.ShowDisable(!_blackboard.m_NextSimFrameData.ValidQTE);
					_enableQTE = _blackboard.m_NextSimFrameData.ValidQTE;
				}
			}
		}
		SimFrameData nextSimFrameData = _blackboard.m_NextSimFrameData;
		if (_uniqueValue != nextSimFrameData.mUniqueValue && OnUniqueValueChanged != null)
		{
			OnUniqueValueChanged(nextSimFrameData.mUniqueValue, nextSimFrameData.mUniqueMaxValue);
		}
		if (OnValidQTE != null)
		{
			OnValidQTE(_enableQTE && _qteCD <= 0);
		}
		for (int i = 0; i < AbilityButtons.Length; i++)
		{
			if (i >= AbilityButtons.Length || _blackboard.m_NextSimFrameData.AbilityStateDict == null || _blackboard.m_LastSimFrameData.AbilityStateDict == null)
			{
				continue;
			}
			AbilityButton abilityButton = AbilityButtons[i];
			if (abilityButton == null)
			{
				continue;
			}
			int iD = _blackboard.m_NextSimFrameData.AbilityStateDict[i].ID;
			if (_blackboard.m_NextSimFrameData.AbilityStateDict[i].ID != _abilityIDs[i])
			{
				if (OnAbilityChange != null)
				{
					OnAbilityChange(i, _abilityIDs[i], _blackboard.m_NextSimFrameData.AbilityStateDict[i].ID);
				}
				UpdateAbilityButton(i, iD);
			}
			if (_blackboard.m_NextSimFrameData.AbilityStateDict[i].CD != _lastAbilityCDs[i])
			{
				if (_blackboard.m_NextSimFrameData.AbilityStateDict[i].CD <= 0 && _blackboard.m_LastSimFrameData.AbilityStateDict[i].CD > 0 && OnCompleteCD != null)
				{
					OnCompleteCD(i);
				}
				if (_blackboard.m_NextSimFrameData.AbilityStateDict[i].CD > 0 && _blackboard.m_LastSimFrameData.AbilityStateDict[i].CD <= 0 && OnBeginCD != null)
				{
					OnBeginCD(i);
				}
				_lastAbilityCDs[i] = _blackboard.m_NextSimFrameData.AbilityStateDict[i].CD;
			}
			if (_blackboard.m_NextSimFrameData.AbilityStateDict[i].ChargingCount != _lastChargingCount[i])
			{
				abilityButton.SetCharge(_blackboard.m_NextSimFrameData.AbilityStateDict[i].ChargingCount);
				_lastChargingCount[i] = _blackboard.m_NextSimFrameData.AbilityStateDict[i].ChargingCount;
			}
			if (_blackboard.m_NextSimFrameData.AbilityStateDict[i].Consume != _abilityConsume[i])
			{
				UpdateAbilityConsume(i, _blackboard.m_NextSimFrameData.AbilityStateDict[i].Consume);
			}
			if (_blackboard.m_NextSimFrameData.AbilityStateDict[i].Enable != _lastAbilityEnable[i])
			{
				OnTriggerAbilityEnable(i, _blackboard.m_NextSimFrameData.AbilityStateDict[i].Enable);
				_lastAbilityEnable[i] = _blackboard.m_NextSimFrameData.AbilityStateDict[i].Enable;
			}
			int maxCD = _blackboard.m_NextSimFrameData.AbilityStateDict[i].MaxCD;
			int cD = _blackboard.m_NextSimFrameData.AbilityStateDict[i].CD;
			bool enable = _blackboard.m_NextSimFrameData.AbilityStateDict[i].Enable;
			abilityButton.SetCD(cD, maxCD);
			abilityButton.Enable = cD <= 0;
			abilityButton.ShowDisable(!enable);
		}
		for (int j = 0; j < AbilityButtons.Length; j++)
		{
			AbilityButton abilityButton2 = AbilityButtons[j];
			if (!(abilityButton2 == null) && abilityButton2.Enable && abilityButton2.OperatorType == EOperatorType.JoyStic)
			{
				AbilityButtons[j].Enable = ((_blackboard.m_NextSimFrameData.mAbilityOriginalCanUse >> j) & 1) == 1;
			}
		}
	}

	private void OnTriggerAbilityEnable(int id, bool enable)
	{
		if (OnAbilityEnable != null)
		{
			OnAbilityEnable(id, enable);
		}
	}

	public SubStickController ChangeAbilityButtonType2SubJoystick(int index)
	{
		return AbilityButtons[index].ChangeType2SubJoystick();
	}

	public bool InterruptSubJoystick(int index)
	{
		AbilityButtons[index].Interrupt();
		return true;
	}
}
