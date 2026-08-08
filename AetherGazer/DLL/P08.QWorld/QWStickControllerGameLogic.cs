using System;
using P08.Gamepad;
using UnityEngine;

[Serializable]
public class QWStickControllerGameLogic : IStickControllerGameLogic
{
	public float startTime;

	public float delayFastRush = 0.2f;

	public void ResetFastRushState()
	{
		startTime = 0f;
	}

	public virtual void UpdateLogic(Vector2 joystickForwardVector, float normalizedStrength, bool useGamePad)
	{
		if (SceneDirector.Instance == null)
		{
			return;
		}
		QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
		if (null == qWorldScene)
		{
			return;
		}
		QWCharacterAgent agent = qWorldScene.Agent;
		if (agent == null)
		{
			return;
		}
		bool disableMoveInput = agent.Blackboard.disableMoveInput;
		Vector3 vector = new Vector3(joystickForwardVector.x, 0f, joystickForwardVector.y);
		float num = normalizedStrength;
		bool flag = Time.time - startTime <= delayFastRush && agent.GetIsInFastRush();
		if (GamepadManager.Instance.GetKey(En_ButtonType.KeepMove))
		{
			if (useGamePad && agent.GetIsInRush())
			{
				agent.ChangeRush();
			}
		}
		else if (GamepadManager.Instance.IsUsingJoystick())
		{
			if ((num >= 0.8f && !agent.GetIsInRush()) || (num < 0.8f && agent.GetIsInRush()))
			{
				agent.ChangeRush();
			}
		}
		else if (GamepadManager.Instance.GetKeyDown(En_ButtonType.QWWalkRunSwitch) && useGamePad)
		{
			agent.ChangeRush();
		}
		if (vector.sqrMagnitude <= Mathf.Epsilon)
		{
			if (disableMoveInput)
			{
				agent.CharacterBlackboard.hasMoveInput = false;
			}
			else
			{
				agent.CharacterBlackboard.inputMovement = new QWCharacterMovement(vector, 0f);
			}
			return;
		}
		if (disableMoveInput)
		{
			agent.CharacterBlackboard.hasMoveInput = true;
			return;
		}
		Vector3 forward = QWorldCameraManager.Instance.MainCamera.transform.forward;
		forward.y = 0f;
		Vector3 vector2 = Quaternion.LookRotation(forward.normalized) * vector;
		if (normalizedStrength > 0.8f && agent.GetIsInFastRush())
		{
			startTime = Time.time;
		}
		if ((normalizedStrength < 0.8f) & flag)
		{
			normalizedStrength = 0.85f;
		}
		agent.CharacterBlackboard.inputMovement = new QWCharacterMovement(vector2.normalized, normalizedStrength, useGamePad);
	}
}
