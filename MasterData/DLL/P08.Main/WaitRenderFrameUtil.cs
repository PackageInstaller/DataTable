using System;
using UnityEngine;

public class WaitRenderFrameUtil
{
	public static WaitRenderFrame _waitFrame;

	public static WaitRenderFrameUtil _inst;

	private static UnityEngine.Object _lock = new UnityEngine.Object();

	public static WaitRenderFrameUtil inst
	{
		get
		{
			if (_inst == null)
			{
				lock (_lock)
				{
					_inst = new WaitRenderFrameUtil();
					GameObject gameObject = new GameObject("WaitFrame");
					UnityEngine.Object.DontDestroyOnLoad(gameObject);
					_waitFrame = gameObject.AddComponent<WaitRenderFrame>();
				}
			}
			return _inst;
		}
	}

	public static void StartScreenShot(Action func)
	{
		_waitFrame.StartWait(func);
	}
}
