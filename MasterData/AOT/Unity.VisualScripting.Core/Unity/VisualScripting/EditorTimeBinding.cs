using System;
using UnityEngine;

namespace Unity.VisualScripting;

public static class EditorTimeBinding
{
	public static Func<int> frameBinding;

	public static Func<float> timeBinding;

	public static int frame
	{
		get
		{
			if (frameBinding == null || !UnityThread.allowsAPI)
			{
				return 0;
			}
			return frameBinding();
		}
	}

	public static float time
	{
		get
		{
			if (timeBinding == null || !UnityThread.allowsAPI)
			{
				return 0f;
			}
			return timeBinding();
		}
	}

	static EditorTimeBinding()
	{
		frameBinding = () => Time.frameCount;
		timeBinding = () => Time.time;
	}
}
