using UnityEngine;

namespace P08.Quiz;

public class QuizStickController : IStickControllerGameLogic
{
	public Vector2 InputVec { get; private set; }

	public void UpdateLogic(Vector2 joystickForwardVector)
	{
		InputVec = joystickForwardVector;
	}
}
