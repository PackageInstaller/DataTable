using System;
using Config;
using NetProcol;
using P08.Gamepad;
using UnityEngine;

public class SubStickController : SimStickController
{
	public int ThrownTimelineID;

	public int SourceTimelineID;

	private Vector3 m_aimPosition = Vector3.zero;

	public string RangeIndicatorPrefabPath = string.Empty;

	public GameObject RangeIndicatorGo;

	public RangeIndicator RangeIndicatorCom;

	public float RangeIndicatorRadius = 1f;

	public float DamageIndicatorRadius = 2f;

	public bool IsLockEnemy = true;

	public float ValueForSqrMoveIndicator = 10f;

	public float TimeForMoveIndicator = 0.3f;

	public float JoystickAreaRadius = 80f;

	public Transform ThumbBg;

	public bool Enable;

	public float m_moveSpeed = 0.02f;

	private float _subJoystickHorizontalValue;

	private float _subJoystickVerticalValue;

	private Vector3 m_firstPressPos = Vector3.forward;

	private bool m_pressOutRange;

	public float m_realTime = -1f;

	public Action OnDisableAction;

	protected override void UpdateTouchPos(Action<Vector3, int> updateFunc)
	{
		UpdateGamepad();
		if (!Input.GetMouseButton(0))
		{
			updateFunc?.Invoke(Vector3.zero, -1);
			return;
		}
		Vector3 mousePosition = Input.mousePosition;
		if (updateFunc != null)
		{
			if (PressFinger < 0 && SimStickController.CheckFingerValid(base.gameObject, JoystickIndex) && validPosFunc != null && validPosFunc(mousePosition))
			{
				updateFunc(TransformPos(mousePosition), JoystickIndex);
			}
			else if (PressFinger >= 0 && SimStickController.CheckFingerValid(base.gameObject, JoystickIndex))
			{
				updateFunc(TransformPos(mousePosition), JoystickIndex);
			}
			else
			{
				updateFunc(Vector3.zero, -1);
			}
		}
	}

	public override void UpdateThumb(Vector3 pressPos, int fingerId)
	{
		SimStickController.SetPressingFinger(base.gameObject, PressFinger, fingerId);
		PressFinger = fingerId;
		if (fingerId == -2 || fingerId == -1)
		{
			return;
		}
		Vector3 vector = pressPos - areaRect.localPosition;
		vector.z = 0f;
		if (vector.magnitude > JoystickAreaRadius)
		{
			Vector3 vector2 = vector.normalized * JoystickAreaRadius;
			Vector3 vector3 = pressPos - vector2;
			Vector3 vector4 = vector3 - _firstPos;
			if (vector4.magnitude > 0f)
			{
				vector3 = _firstPos + vector4 * (_followRange / vector4.magnitude);
			}
			areaRect.localPosition = vector3;
			thumbPosition.localPosition = vector2;
			if (ThumbBg != null)
			{
				ThumbBg.localPosition = thumbPosition.localPosition;
			}
		}
		else
		{
			thumbPosition.localPosition = pressPos - areaRect.localPosition;
			if (ThumbBg != null)
			{
				ThumbBg.localPosition = thumbPosition.localPosition;
			}
		}
		bool pOutRange = false;
		if (m_firstPressPos != Vector3.up)
		{
			pOutRange = (pressPos - m_firstPressPos).magnitude > ValueForSqrMoveIndicator;
		}
		DrawSceneIndicator(pressPos, areaRect.localPosition, JoystickAreaRadius, pOutRange);
	}

	protected override bool InArea(Vector3 pos)
	{
		if (null == touchAreaRect)
		{
			return false;
		}
		RectTransformUtility.ScreenPointToLocalPointInRectangle(touchAreaRect, pos, mainCamera, out var localPoint);
		if (localPoint.x > -1f * touchAreaRect.sizeDelta.x / 2f && localPoint.x < touchAreaRect.sizeDelta.x / 2f && localPoint.y > -1f * touchAreaRect.sizeDelta.y / 2f)
		{
			return localPoint.y < touchAreaRect.sizeDelta.y / 2f;
		}
		return false;
	}

	public void InitAimPosition()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (!(null == battleScene))
		{
			NAgent playerAgent = battleScene.GetAgentManager().GetPlayerAgent();
			if (!(playerAgent == null))
			{
				m_aimPosition = playerAgent.Position;
			}
		}
	}

	public void DrawSceneIndicator(Vector3 pressPos, Vector3 center, float joystickAreaRadius, bool pOutRange)
	{
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager == null)
		{
			return;
		}
		NAgent playerAgent = agentManager.GetPlayerAgent();
		if (playerAgent == null || !Enable)
		{
			return;
		}
		if (!m_pressOutRange)
		{
			if (m_firstPressPos == Vector3.up)
			{
				if (m_realTime == -1f)
				{
					m_realTime = Time.realtimeSinceStartup;
				}
				m_firstPressPos = pressPos;
				if (!IsLockEnemy)
				{
					int[] array = new int[3]
					{
						agentManager.GetAgentIDByMemberPosition(MemberPosition.First),
						agentManager.GetAgentIDByMemberPosition(MemberPosition.Second),
						agentManager.GetAgentIDByMemberPosition(MemberPosition.Third)
					};
					float num = float.MaxValue;
					int num2 = 0;
					for (int i = 0; i < array.Length; i++)
					{
						if (array[i] == 0 || array[i] == playerAgent.AgentID)
						{
							continue;
						}
						NAgent agent = agentManager.GetAgent(array[i]);
						if (agent != null)
						{
							float sqrMagnitude = (agent.Position - playerAgent.Position).sqrMagnitude;
							if (sqrMagnitude < num)
							{
								num = sqrMagnitude;
								num2 = array[i];
								m_aimPosition = agent.Position;
							}
						}
					}
					if (num2 == 0)
					{
						m_aimPosition = playerAgent.Position;
					}
				}
				else
				{
					int aimingTarget = (playerAgent.Blackboard as BBHumanoid).AimingTarget;
					NAgent agent2 = agentManager.GetAgent(aimingTarget);
					if (agent2 != null)
					{
						m_aimPosition = agent2.Position;
					}
					else
					{
						m_aimPosition = playerAgent.Position + playerAgent.Forward * (RangeIndicatorRadius * 0.5f);
					}
				}
				m_aimPosition = RangeIndicator.PoisitionConstraint(playerAgent.transform.position, m_aimPosition, SourceTimelineID);
			}
			else if (pOutRange && Time.realtimeSinceStartup - m_realTime > TimeForMoveIndicator)
			{
				m_aimPosition = RangeIndicator.LocalPositionConstraint(playerAgent.transform.position, PressPos2LocalPosition(pressPos, center, joystickAreaRadius, SourceTimelineID), SourceTimelineID);
				m_pressOutRange = true;
			}
		}
		else
		{
			m_aimPosition = RangeIndicator.LocalPositionConstraint(playerAgent.transform.position, PressPos2LocalPosition(pressPos, center, joystickAreaRadius, SourceTimelineID), SourceTimelineID);
		}
		SendSubJoystickCommand();
	}

	private void OnEnable()
	{
		ResetGamepad();
		Enable = true;
	}

	private void OnDisable()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null && battleScene.GetBattleSimulatorSystem() != null)
		{
			WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
			if (worldSatetManager != null && worldSatetManager.PressingFingers.ContainsKey(PressFinger))
			{
				worldSatetManager.PressingFingers.Remove(PressFinger);
			}
		}
		PressFinger = -1;
		m_pressOutRange = false;
		m_firstPressPos = Vector3.up;
		m_realTime = -1f;
		Enable = false;
		if (OnDisableAction != null)
		{
			OnDisableAction();
		}
		ResetGamepad();
	}

	public void SendLocalCommandend()
	{
		NAgent playerAgent = (NScene.GetCurrentScene() as BattleScene).GetPlayerAgent();
		if (playerAgent != null)
		{
			ThrowItemCommand throwItemCommand = CommandFactory.Create(NetprotoOperationCode.CmdThrowItem) as ThrowItemCommand;
			_ = playerAgent.Blackboard;
			throwItemCommand.SetData(playerAgent.AgentID, (Int3)m_aimPosition, Int3.forward, ThrownTimelineID, useCommon: true, SourceTimelineID);
			ClientSimulator.Instance.SendLocalCommand(throwItemCommand);
		}
	}

	private void SendSubJoystickCommand()
	{
		NAgent playerAgent = (NScene.GetCurrentScene() as BattleScene).GetPlayerAgent();
		if (playerAgent != null)
		{
			int code = SubJoystickCommand.PositionToCommandCode(new Int3(playerAgent.transform.position), new Int3(playerAgent.transform.forward).NormalizeTo(1000), new Int3(m_aimPosition), SourceTimelineID);
			SubJoystickCommand subJoystickCommand = CommandFactory.Create(NetprotoOperationCode.CmdSubJoystick) as SubJoystickCommand;
			subJoystickCommand.SetData(playerAgent.AgentID, code, SourceTimelineID);
			ClientSimulator.Instance.SendLocalCommand(subJoystickCommand);
		}
	}

	private Vector3 PressPos2LocalPosition(Vector3 pressPos, Vector3 center, float joystickAreaRadius, int sourceTimelineID)
	{
		float num = (float)ConfigHelper.GetInstance().GetConfig<public_skill>(sourceTimelineID).Range / 1000f;
		Vector3 vector = pressPos - center;
		vector = new Vector3(vector.x, 0f, vector.y);
		float num2 = vector.magnitude;
		if (num2 > joystickAreaRadius)
		{
			num2 = joystickAreaRadius;
		}
		float num3 = num2 / joystickAreaRadius * num;
		return vector.normalized * num3;
	}

	private void UpdateGamepad()
	{
		float num = 0f;
		float num2 = 0f;
		if (GamepadManager.Instance.IsUsingKeyboard())
		{
			if (GamepadManager.Instance.GetKeyValue(En_ButtonType.SubJoystickLeft) > 0f)
			{
				_subJoystickHorizontalValue -= m_moveSpeed;
				_subJoystickHorizontalValue = Mathf.Clamp(_subJoystickHorizontalValue, -1f, 1f);
			}
			if (GamepadManager.Instance.GetKeyValue(En_ButtonType.SubJoystickRight) > 0f)
			{
				_subJoystickHorizontalValue += m_moveSpeed;
				_subJoystickHorizontalValue = Mathf.Clamp(_subJoystickHorizontalValue, -1f, 1f);
			}
			if (GamepadManager.Instance.GetKeyValue(En_ButtonType.SubJoystickUp) > 0f)
			{
				_subJoystickVerticalValue += m_moveSpeed;
				_subJoystickVerticalValue = Mathf.Clamp(_subJoystickVerticalValue, -1f, 1f);
			}
			if (GamepadManager.Instance.GetKeyValue(En_ButtonType.SubJoystickDown) > 0f)
			{
				_subJoystickVerticalValue -= m_moveSpeed;
				_subJoystickVerticalValue = Mathf.Clamp(_subJoystickVerticalValue, -1f, 1f);
			}
			num = _subJoystickHorizontalValue;
			num2 = _subJoystickVerticalValue;
		}
		else
		{
			num = 0f - GamepadManager.Instance.GetKeyValue(En_ButtonType.SubJoystickLeft);
			num += GamepadManager.Instance.GetKeyValue(En_ButtonType.SubJoystickRight);
			num2 = GamepadManager.Instance.GetKeyValue(En_ButtonType.SubJoystickUp);
			num2 += 0f - GamepadManager.Instance.GetKeyValue(En_ButtonType.SubJoystickDown);
		}
		DrawSceneIndicator(new Vector3(num, num2, 0f), Vector3.zero, 1f, pOutRange: true);
	}

	private void ResetGamepad()
	{
		_subJoystickHorizontalValue = 0f;
		_subJoystickVerticalValue = 0f;
		GamepadManager.Instance.ResetSubStickController();
	}
}
