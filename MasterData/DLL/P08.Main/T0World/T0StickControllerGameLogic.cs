using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0StickControllerGameLogic : QWStickControllerGameLogic
{
	public new float startTime;

	public new float delayFastRush = 0.2f;

	public new void ResetFastRushState()
	{
		startTime = 0f;
	}

	public override void UpdateLogic(Vector2 joystickForwardVector, float normalizedStrength, bool useGamePad)
	{
		if (SceneDirector.Instance == null)
		{
			return;
		}
		T0WorldScene t0WorldScene = NScene.GetCurrentScene() as T0WorldScene;
		if (!(null == t0WorldScene))
		{
			T0WorldPlayer player = t0WorldScene.player;
			if (!(player == null))
			{
				Vector3 normalized = new Vector3(joystickForwardVector.x, 0f, joystickForwardVector.y).normalized;
				player.inputDirection.x = normalized.x;
				player.inputDirection.z = normalized.z;
			}
		}
	}
}
