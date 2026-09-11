using Config;
using UnityEngine;
using UnityEngine.UI;

public class P08QTEButtonUILogic : P08ButtonUILogic, IButtonUILogic
{
	public const int QTE_CD_INDEX = 4;

	public float startAmount;

	public GameObject qteEffect;

	public Image uniqueBar;

	private bool _lastActiveStatus;

	private NAgent currentAgent;

	private int _currentEnergy;

	private int _maxEnergy;

	private bool useableEnergy;

	private bool _useable = true;

	public void UpdateUIContent(NAgent agent)
	{
		if (!(agent == null))
		{
			if (agent == currentAgent)
			{
				OnUpdate(agent);
			}
			else
			{
				OnAgentChanged(agent);
			}
		}
	}

	private void SetQTEBar(int current, int max)
	{
		max = ((max <= 0) ? 1 : max);
		if (_currentEnergy != current || _maxEnergy != max || !Mathf.Approximately(uniqueBar.fillAmount, (float)((double)startAmount + (double)current * 1.0 / (double)max * (double)(1f - startAmount))))
		{
			_currentEnergy = current;
			_maxEnergy = max;
			if (uniqueBar != null)
			{
				uniqueBar.fillAmount = (float)((double)startAmount + (double)current * 1.0 / (double)max * (double)(1f - startAmount));
			}
			if (current >= max)
			{
				useableEnergy = true;
			}
			else
			{
				useableEnergy = false;
			}
		}
	}

	public P08QTEButtonUILogic(float startAmount, Image abilityIcon, Text cdText, Image cdMaskImage, GameObject qteEffect, Image uniqueBar, GameObject disableGo, EffectLevel chargingController)
	{
		this.startAmount = startAmount;
		base.abilityIcon = abilityIcon;
		base.cdText = cdText;
		base.cdMaskImage = cdMaskImage;
		this.qteEffect = qteEffect;
		this.uniqueBar = uniqueBar;
		base.disableGo = disableGo;
		ChargingController = chargingController;
		_lastActiveStatus = false;
	}

	private void SetEnable(bool enable)
	{
		if (disableGo != null && disableGo.activeSelf == enable)
		{
			disableGo.SetActive(!enable);
		}
		bool flag = (useableCD && useableEnergy) & enable;
		if (flag == _useable && (qteEffect == null || qteEffect.activeSelf == flag))
		{
			return;
		}
		_useable = flag;
		if (qteEffect != null)
		{
			qteEffect.SetActive(flag);
		}
		if (!(abilityIcon == null))
		{
			if (flag)
			{
				Color color = abilityIcon.color;
				color.a = 1f;
				abilityIcon.color = color;
			}
			else
			{
				Color color2 = abilityIcon.color;
				color2.a = 8f / 85f;
				abilityIcon.color = color2;
			}
		}
	}

	private void OnUpdate(NAgent agent)
	{
		BBHumanoid bBHumanoid = agent.Blackboard as BBHumanoid;
		if (bBHumanoid == null || bBHumanoid.m_NextSimFrameData == null || bBHumanoid.m_NextSimFrameData.AbilityStateDict == null || !bBHumanoid.m_NextSimFrameData.AbilityStateDict.TryGetValue(7, out var value))
		{
			return;
		}
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (worldStateManager != null && !worldStateManager.m_cooperateUniqueSkillIsActive && _lastActiveStatus != worldStateManager.m_cooperateUniqueSkillIsActive)
		{
			_lastActiveStatus = worldStateManager.m_cooperateUniqueSkillIsActive;
			InitQteIcon();
		}
		if (worldStateManager != null && worldStateManager.m_cooperateUniqueSkillIsActive && battleScene != null && ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(battleScene.ready.SceneDataForExcehange.CooperateUniqueSkillID, out var config) && config.CooperateRoleIds.Contains(bBHumanoid.RoleLogicConfig.ID))
		{
			if (_lastActiveStatus != worldStateManager.m_cooperateUniqueSkillIsActive)
			{
				_lastActiveStatus = worldStateManager.m_cooperateUniqueSkillIsActive;
				if (_lastActiveStatus)
				{
					string iconPath = config.IconPath;
					if (!string.IsNullOrEmpty(iconPath) && abilityIcon != null)
					{
						abilityIcon.sprite = AtlasManager.GetSpriteWithoutAtlas(iconPath);
					}
				}
			}
			SetCD(worldStateManager.m_cooperateUniqueSkillCD, worldStateManager.m_cooperateUniqueSkillMaxCD, value.ChargingCount);
			SetQTEBar(worldStateManager.m_cooperateUniqueSkillEnergyValue, worldStateManager.m_cooperateUniqueSkillEnergyMaxValue);
			SetEnable(worldStateManager.m_cooperateUniqueSkillVaild);
		}
		else
		{
			SetCD(value.CD, value.MaxCD, value.ChargingCount);
			SetQTEBar(bBHumanoid.m_NextSimFrameData.mUniqueValue, bBHumanoid.m_NextSimFrameData.mUniqueMaxValue);
			SetEnable(bBHumanoid.m_NextSimFrameData.ValidQTE);
		}
	}

	public void InitQteIcon()
	{
		if (!(currentAgent == null) && !(currentAgent.Blackboard as BBHumanoid == null))
		{
			RoleConfig roleLogicConfig = (currentAgent.Blackboard as BBHumanoid).RoleLogicConfig;
			if (roleLogicConfig != null && !(abilityIcon == null) && ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(roleLogicConfig.ID, out var config) && config.AbilityId.Count > 0)
			{
				abilityIcon.sprite = AtlasManager.GetSprite("Atlas/" + roleLogicConfig.ID, config.AbilityId.get_Item(0).ToString());
				_lastActiveStatus = false;
			}
		}
	}

	private void OnAgentChanged(NAgent agent)
	{
		currentAgent = agent;
		InitQteIcon();
	}
}
