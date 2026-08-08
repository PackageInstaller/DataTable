using System;
using Config;
using UnityEngine;
using UnityEngine.UI;

public class TuneIndicatorHelper : MonoBehaviour
{
	public Image m_part1Bar;

	public Image m_part2Bar;

	public Text m_text;

	public GameObject m_fullEffect;

	private BBHumanoid _curPlayer;

	private BBHumanoid _role1;

	private BBHumanoid _role2;

	private bool _componetInited;

	public bool OnUpdate(bool pUseable)
	{
		int num = 0;
		int num2 = 0;
		if (_curPlayer != null)
		{
			num++;
			if (_curPlayer.m_NextSimFrameData.mPowerValue == _curPlayer.m_NextSimFrameData.mMaxPowerValue)
			{
				num2++;
			}
		}
		if (m_part1Bar != null && _role1 != null && _role1.m_NextSimFrameData != null)
		{
			num++;
			m_part1Bar.fillAmount = (float)_role1.m_NextSimFrameData.mPowerValue * 1f / (float)_role1.m_NextSimFrameData.mMaxPowerValue;
			if (_role1.m_NextSimFrameData.mPowerValue == _role1.m_NextSimFrameData.mMaxPowerValue)
			{
				num2++;
			}
		}
		if (m_part2Bar != null && _role2 != null && _role2.m_NextSimFrameData != null)
		{
			num++;
			m_part2Bar.fillAmount = (float)_role2.m_NextSimFrameData.mPowerValue * 1f / (float)_role2.m_NextSimFrameData.mMaxPowerValue;
			if (_role2.m_NextSimFrameData.mPowerValue == _role2.m_NextSimFrameData.mMaxPowerValue)
			{
				num2++;
			}
		}
		if (m_text != null)
		{
			m_text.text = CommonString.Numbers[num2];
		}
		bool flag = (num == num2) & pUseable;
		if (m_fullEffect != null && m_fullEffect.activeSelf != flag)
		{
			m_fullEffect.SetActive(flag);
		}
		return flag;
	}

	public void Init(MemberPosition mRolePosition, NAgent nAgent)
	{
		switch (mRolePosition)
		{
		case MemberPosition.First:
			if (!nAgent.IsLocalPlayer)
			{
				_role1 = nAgent.Blackboard as BBHumanoid;
			}
			else
			{
				_curPlayer = nAgent.Blackboard as BBHumanoid;
			}
			break;
		case MemberPosition.Second:
			if (!nAgent.IsLocalPlayer)
			{
				if (_role1 != null)
				{
					_role2 = nAgent.Blackboard as BBHumanoid;
				}
				else
				{
					_role1 = nAgent.Blackboard as BBHumanoid;
				}
			}
			else
			{
				_curPlayer = nAgent.Blackboard as BBHumanoid;
			}
			break;
		case MemberPosition.Third:
			if (!nAgent.IsLocalPlayer)
			{
				_role2 = nAgent.Blackboard as BBHumanoid;
			}
			else
			{
				_curPlayer = nAgent.Blackboard as BBHumanoid;
			}
			break;
		}
		InitComponent();
	}

	private void InitComponent()
	{
		if (!_componetInited)
		{
			_componetInited = true;
			if (m_part1Bar != null)
			{
				m_part1Bar.fillAmount = 0f;
			}
			if (m_part2Bar != null)
			{
				m_part2Bar.fillAmount = 0f;
			}
			if (m_fullEffect != null)
			{
				m_fullEffect.SetActive(value: false);
			}
		}
	}

	public void OnPlayerChange(NAgent from, NAgent to)
	{
		if (!(from == null) && !(to == null))
		{
			if (_role1.mAgent.AgentID == to.AgentID)
			{
				BBHumanoid obj = from.Blackboard as BBHumanoid;
				obj.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Remove(obj.ActionHandler, new BBCommom.AgentActionHandler(ActionHandler0));
				BBHumanoid obj2 = from.Blackboard as BBHumanoid;
				obj2.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Combine(obj2.ActionHandler, new BBCommom.AgentActionHandler(ActionHandler1));
				BBHumanoid obj3 = to.Blackboard as BBHumanoid;
				obj3.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Remove(obj3.ActionHandler, new BBCommom.AgentActionHandler(ActionHandler1));
				BBHumanoid obj4 = to.Blackboard as BBHumanoid;
				obj4.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Combine(obj4.ActionHandler, new BBCommom.AgentActionHandler(ActionHandler0));
				_role1 = from.Blackboard as BBHumanoid;
			}
			else if (_role2.mAgent.AgentID == to.AgentID)
			{
				BBHumanoid obj5 = from.Blackboard as BBHumanoid;
				obj5.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Remove(obj5.ActionHandler, new BBCommom.AgentActionHandler(ActionHandler0));
				BBHumanoid obj6 = from.Blackboard as BBHumanoid;
				obj6.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Combine(obj6.ActionHandler, new BBCommom.AgentActionHandler(ActionHandler2));
				BBHumanoid obj7 = to.Blackboard as BBHumanoid;
				obj7.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Remove(obj7.ActionHandler, new BBCommom.AgentActionHandler(ActionHandler2));
				BBHumanoid obj8 = to.Blackboard as BBHumanoid;
				obj8.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Combine(obj8.ActionHandler, new BBCommom.AgentActionHandler(ActionHandler0));
				_role2 = from.Blackboard as BBHumanoid;
			}
		}
	}

	private void ActionHandler0(AgentAction action)
	{
		if (action is AgentActionDead && m_part1Bar != null)
		{
			m_part1Bar.fillAmount = 0f;
		}
	}

	private void ActionHandler1(AgentAction action)
	{
		if (action is AgentActionDead && m_part1Bar != null)
		{
			m_part1Bar.fillAmount = 0f;
		}
	}

	private void ActionHandler2(AgentAction action)
	{
		if (action is AgentActionDead && m_part2Bar != null)
		{
			m_part2Bar.fillAmount = 0f;
		}
	}

	public static bool IsTuneRole(int roleID)
	{
		return ConfigHelper.GetInstance().GetConfig<charactor_param>(roleID).EnergyType == 5;
	}
}
