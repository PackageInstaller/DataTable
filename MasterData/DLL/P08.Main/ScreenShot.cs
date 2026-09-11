using System;
using UnityEngine;

public static class ScreenShot
{
	private static bool ready;

	public static CutPicture cutTool;

	public static bool GetReady()
	{
		return ready;
	}

	public static void Initialize()
	{
		if (!ready && cutTool == null)
		{
			GameObject gameObject = new GameObject("ScreenShot");
			if (Application.isPlaying)
			{
				UnityEngine.Object.DontDestroyOnLoad(gameObject);
			}
			cutTool = gameObject.AddComponent<CutPicture>();
			ready = true;
		}
	}

	public static Sprite GetScreenSprite()
	{
		Initialize();
		return cutTool.sp;
	}

	public static void StartScreenShot(Action func)
	{
		Initialize();
		cutTool.StartCutPicture(func);
	}
}
