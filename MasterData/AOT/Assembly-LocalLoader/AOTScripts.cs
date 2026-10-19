using System;
using AOT;
using FMOD;
using FMOD.Studio;

public class AOTScripts
{
	public static Action<EventInstance> SoundReleaseCallBack;

	public static Action<EVENT_CALLBACK_TYPE, IntPtr, IntPtr> CGAudioCallback;

	[MonoPInvokeCallback(typeof(EVENT_CALLBACK))]
	public static RESULT EventCallback(EVENT_CALLBACK_TYPE type, IntPtr instancePtr, IntPtr parameterPtr)
	{
		EventInstance obj = new EventInstance(instancePtr);
		if (!obj.isValid())
		{
			return RESULT.ERR_DSP_INUSE;
		}
		SoundReleaseCallBack?.Invoke(obj);
		if (obj.isValid())
		{
			obj.release();
			obj.clearHandle();
		}
		return RESULT.OK;
	}

	[MonoPInvokeCallback(typeof(EVENT_CALLBACK))]
	public static RESULT CGAudioEventCallback(EVENT_CALLBACK_TYPE type, IntPtr instancePtr, IntPtr parameterPtr)
	{
		CGAudioCallback?.Invoke(type, instancePtr, parameterPtr);
		return RESULT.OK;
	}
}
