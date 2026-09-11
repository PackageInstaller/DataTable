using UnityEngine;

public interface IStickControllerGameLogic
{
	void UpdateLogic(Vector2 joystickForwardVector, float normalizedStrength, bool useGamePad);

	void ResetFastRushState();
}
