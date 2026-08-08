using System;
using Config;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

public class P08SkillButtonUILogic : P08ButtonUILogic, IButtonUILogic
{
	public ButtonType buttonType;

	public Text consumeText;

	public Image consumeLine;

	public GameObject effectExtensionalSkill;

	public PlayableDirector effectSwitchAbility;

	public PlayableDirector effectCDRefresh;

	private NAgent currentAgent;

	private string _atlasName;

	private int _currentAbilityID;

	private bool useEffect;

	private int _currentConsume = int.MaxValue;

	private bool useableOther = true;

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

	private void OnAgentChanged(NAgent agent)
	{
		currentAgent = agent;
		if (!(agent.Blackboard as BBHumanoid == null))
		{
			RoleConfig roleLogicConfig = (agent.Blackboard as BBHumanoid).RoleLogicConfig;
			if (roleLogicConfig != null)
			{
				_atlasName = "Atlas/" + roleLogicConfig.ID;
			}
		}
	}

	private void OnUpdate(NAgent agent)
	{
		BBHumanoid bBHumanoid = agent.Blackboard as BBHumanoid;
		if (!(bBHumanoid == null) && bBHumanoid.m_NextSimFrameData != null && bBHumanoid.m_NextSimFrameData.AbilityStateDict != null && bBHumanoid.m_NextSimFrameData.AbilityStateDict.TryGetValue((int)buttonType, out var value))
		{
			Action<int> modifySkillButtonUIDataEvent = AgentManager.GetAgentManager().ModifySkillButtonUIDataEvent;
			if (modifySkillButtonUIDataEvent != null)
			{
				agent.TempAbilityStatus = value;
				modifySkillButtonUIDataEvent(agent.AgentID);
				value = agent.TempAbilityStatus;
			}
			if (value.CD <= 0 && !useableCD)
			{
				PlayTimeline(effectCDRefresh);
			}
			SetIcon(value.ID);
			SetCD(value.CD, value.MaxCD, value.ChargingCount);
			SetConsume(value.Consume);
			SetEnable(value.Enable);
			UpdateEffect();
		}
	}

	private void SetIcon(int abilityID)
	{
		if (_currentAbilityID == abilityID || string.IsNullOrEmpty(_atlasName))
		{
			return;
		}
		_currentAbilityID = abilityID;
		if (!(abilityIcon == null))
		{
			abilityIcon.sprite = AtlasManager.GetSprite(_atlasName, abilityID.ToString());
			PlayTimeline(effectSwitchAbility);
			if (ConfigHelper.GetInstance().TryGetConfig<AbilityConfig>(abilityID, out var config) && config.IsExtensionalSkill)
			{
				useEffect = true;
			}
			else
			{
				useEffect = false;
			}
		}
	}

	public void SetConsume(int consume)
	{
		if (consume == _currentConsume)
		{
			return;
		}
		_currentConsume = consume;
		if (consume < 0)
		{
			if (consumeText != null && !consumeText.enabled)
			{
				consumeText.enabled = true;
			}
			if (consumeLine != null && !consumeLine.enabled)
			{
				consumeLine.enabled = true;
			}
			if (consumeText != null)
			{
				consumeText.text = CommonString.Numbers[Mathf.Abs(consume)];
			}
		}
		else
		{
			if (consumeText != null && consumeText.enabled)
			{
				consumeText.enabled = false;
			}
			if (consumeLine != null && consumeLine.enabled)
			{
				consumeLine.enabled = false;
			}
		}
	}

	public void SetEnable(bool enable)
	{
		if (disableGo != null && disableGo.activeSelf == enable)
		{
			disableGo.SetActive(!enable);
		}
		bool flag = useableCD & enable;
		if (flag == useableOther)
		{
			return;
		}
		useableOther = flag;
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

	public void SetEffect(bool flag)
	{
		useEffect = flag;
		UpdateEffect();
	}

	private void UpdateEffect()
	{
		if (!(effectExtensionalSkill == null))
		{
			bool flag = useEffect && useableCD && useableOther;
			if (flag && !effectExtensionalSkill.activeSelf)
			{
				effectExtensionalSkill.SetActive(value: true);
			}
			else if (!flag && effectExtensionalSkill.activeSelf)
			{
				effectExtensionalSkill.SetActive(value: false);
			}
		}
	}

	private void StopTimeline(PlayableDirector playableDirector)
	{
		playableDirector.Stop();
		playableDirector.gameObject.SetActive(value: false);
	}

	private void OnTimelineStop(PlayableDirector playableDirector)
	{
		playableDirector.gameObject.SetActive(value: false);
	}

	private void PlayTimeline(PlayableDirector playableDirector)
	{
		if (!(playableDirector == null))
		{
			playableDirector.gameObject.SetActive(value: true);
			playableDirector.time = 0.0;
			playableDirector.Play();
		}
	}

	public void PlayEffectOfSwitchAbility()
	{
		PlayTimeline(effectSwitchAbility);
	}

	public P08SkillButtonUILogic(ButtonType buttonType, Image abilityIcon, Text cdText, Image cdMaskImage, Text consumeText, Image consumeLine, GameObject effectExtensionalSkill, GameObject effectSwitchAbility, GameObject effectCDRefresh, GameObject disableGo, EffectLevel chargingController)
	{
		base.abilityIcon = abilityIcon;
		base.cdText = cdText;
		base.cdMaskImage = cdMaskImage;
		base.disableGo = disableGo;
		this.consumeText = consumeText;
		this.consumeLine = consumeLine;
		this.effectExtensionalSkill = effectExtensionalSkill;
		if (effectSwitchAbility != null)
		{
			PlayableDirector componentInChildren = effectSwitchAbility.GetComponentInChildren<PlayableDirector>(includeInactive: true);
			if (componentInChildren != null)
			{
				StopTimeline(componentInChildren);
				componentInChildren.stopped += OnTimelineStop;
				this.effectSwitchAbility = componentInChildren;
			}
		}
		if (effectCDRefresh != null)
		{
			PlayableDirector componentInChildren2 = effectCDRefresh.GetComponentInChildren<PlayableDirector>(includeInactive: true);
			if (componentInChildren2 != null)
			{
				StopTimeline(componentInChildren2);
				componentInChildren2.stopped += OnTimelineStop;
				this.effectCDRefresh = componentInChildren2;
			}
		}
		this.buttonType = buttonType;
		ChargingController = chargingController;
	}
}
