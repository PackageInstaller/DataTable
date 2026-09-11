using System;
using LuaInterface;
using UnityEngine;

namespace P08.Quiz;

public static class QuizLuaBridge
{
	public static Action<long, int, int> OnQuizPlayerModelChanged;

	public static Action<long, int> OnQuizPlayerGestureChanged;

	private static QuizStickController s_QuizStickController = new QuizStickController();

	public static void Launcher(QuizDataForExchange data)
	{
		NScene.Load<QuizScene>().sceneName = data.sceneName;
	}

	[NoToLua]
	public static void CreateJoystick()
	{
		GameObject gameObject = GameObject.Find("UICamera/Canvas");
		if (gameObject != null)
		{
			GameObject gameObject2 = Asset.Instantiate("CharDorm/quiz/QuizStick");
			gameObject2.transform.SetParent(gameObject.transform, worldPositionStays: false);
			InitJoystick(gameObject2);
		}
	}

	public static void InitJoystick(GameObject stickGo)
	{
		P08JoystickController component = stickGo.GetComponent<P08JoystickController>();
		if (component != null)
		{
			component.Init(Vector3.zero, 0f, s_QuizStickController);
		}
	}

	[NoToLua]
	public static Vector2 GetJoystickInputVec()
	{
		return s_QuizStickController.InputVec;
	}
}
