using UnityEngine;
using UnityEngine.UI;

public class P08AvoidButtonUILogic : P08ButtonUILogic, IButtonUILogic
{
	public const int AVOID_CD_INDEX = 5;

	public Image endurance;

	private NAgent currentAgent;

	private int _currentEndurance;

	private int _maxEndurance;

	private bool _useable;

	private ComponentHealth componentHealth;

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

	private void OnUpdate(NAgent agent)
	{
		if (componentHealth != null)
		{
			SetEndurance(componentHealth.EnduranceValue, componentHealth.MaxEnduranceValue);
		}
		BBHumanoid bBHumanoid = agent.Blackboard as BBHumanoid;
		if (!(bBHumanoid == null) && bBHumanoid.m_NextSimFrameData != null && bBHumanoid.m_NextSimFrameData.AbilityStateDict != null && bBHumanoid.m_NextSimFrameData.AbilityStateDict.TryGetValue(6, out var value))
		{
			SetCD(value.CD, value.MaxCD, value.ChargingCount);
			SetEnable(value.Enable);
		}
	}

	private void SetEndurance(int current, int max)
	{
		if (current != _currentEndurance || _maxEndurance != max)
		{
			_currentEndurance = current;
			_maxEndurance = max;
			if (null != endurance)
			{
				endurance.fillAmount = (float)current / (float)max;
			}
		}
	}

	private void SetEnable(bool enable)
	{
		if (endurance != null && endurance.enabled != enable)
		{
			endurance.enabled = enable;
		}
		if (disableGo != null && disableGo.activeSelf == enable)
		{
			disableGo.SetActive(!enable);
		}
		bool flag = useableCD & enable;
		if (flag == _useable)
		{
			return;
		}
		_useable = flag;
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

	public P08AvoidButtonUILogic(Image abilityIcon, Text cdText, Image cdMaskImage, GameObject disableGo, Image endurance, EffectLevel chargingController)
	{
		base.abilityIcon = abilityIcon;
		base.cdText = cdText;
		base.cdMaskImage = cdMaskImage;
		this.endurance = endurance;
		base.disableGo = disableGo;
		ChargingController = chargingController;
	}

	private void OnAgentChanged(NAgent agent)
	{
		currentAgent = agent;
		componentHealth = agent.GetComponent<ComponentHealth>();
	}
}
