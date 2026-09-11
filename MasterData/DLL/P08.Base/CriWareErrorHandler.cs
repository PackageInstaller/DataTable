using System;
using System.Collections.Concurrent;
using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.Diagnostics;

[AddComponentMenu("CRIWARE/Error Handler")]
public class CriWareErrorHandler : CriMonoBehaviour
{
	public delegate void Callback(string message);

	private static class NativeMethod
	{
		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern IntPtr CRIWARE9B3928F9();
	}

	public bool enableDebugPrintOnTerminal;

	public bool enableForceCrashOnError;

	public bool dontDestroyOnLoad = true;

	public static readonly string logPrefix = "[CRIWARE]";

	[Obsolete("CriWareErrorHandler.callback is deprecated. Use CriWareErrorHandler.OnCallback event", false)]
	public static Callback callback = null;

	public uint messageBufferCounts = 8u;

	private ConcurrentQueue<string> unThreadSafeMessages = new ConcurrentQueue<string>();

	private static bool _enableDebugPrintOnTerminal = false;

	private static int initializationCount = 0;

	public static string errorMessage { get; set; }

	private static event Callback _onCallback = null;

	public static event Callback OnCallback
	{
		add
		{
			bool num = IsEnableNativePrintMessageFunc();
			_onCallback += value;
			if (num && !IsEnableNativePrintMessageFunc())
			{
				RegisterErrorCallback();
			}
		}
		remove
		{
			_onCallback -= value;
			RegisterErrorCallback();
		}
	}

	private void Awake()
	{
		initializationCount++;
		if (initializationCount != 1)
		{
			UnityEngine.Object.Destroy(this);
			return;
		}
		if (!CriErrorNotifier.IsRegistered(HandleMessage))
		{
			CriErrorNotifier.OnCallbackThreadUnsafe += HandleMessage;
		}
		if (dontDestroyOnLoad)
		{
			UnityEngine.Object.DontDestroyOnLoad(base.transform.gameObject);
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		_enableDebugPrintOnTerminal = enableDebugPrintOnTerminal;
		RegisterErrorCallback();
		if (!CriErrorNotifier.IsRegistered(HandleMessage))
		{
			CriErrorNotifier.OnCallbackThreadUnsafe += HandleMessage;
		}
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		if (CriErrorNotifier.IsRegistered(HandleMessage))
		{
			CriErrorNotifier.OnCallbackThreadUnsafe -= HandleMessage;
		}
	}

	public override void CriInternalUpdate()
	{
		DequeueErrorMessages();
	}

	public override void CriInternalLateUpdate()
	{
	}

	private void OnDestroy()
	{
		initializationCount--;
		if (initializationCount == 0)
		{
			if (CriErrorNotifier.IsRegistered(HandleMessage))
			{
				CriErrorNotifier.OnCallbackThreadUnsafe -= HandleMessage;
			}
			CriErrorNotifier.SetCallbackNative(IntPtr.Zero);
		}
	}

	private static bool IsEnableNativePrintMessageFunc()
	{
		if (!Application.isEditor && _onCallback == null && callback == null)
		{
			return _enableDebugPrintOnTerminal;
		}
		return false;
	}

	private static void RegisterErrorCallback()
	{
		if (IsEnableNativePrintMessageFunc())
		{
			CriErrorNotifier.SetCallbackNative(IntPtr.Zero);
			CriErrorNotifier.SetCallbackNative(NativeMethod.CRIWARE9B3928F9());
		}
		else
		{
			CriErrorNotifier.SetCallbackNative(IntPtr.Zero);
			CriErrorNotifier.SetCallbackNative(CriErrorNotifier.GetManagedPluginFunc());
		}
	}

	private void DequeueErrorMessages()
	{
		while (unThreadSafeMessages.Count != 0)
		{
			if (unThreadSafeMessages.TryDequeue(out var result))
			{
				if (_onCallback != null)
				{
					_onCallback(result);
				}
				if (callback != null)
				{
					callback(result);
				}
			}
		}
	}

	private void HandleMessage(string errmsg)
	{
		if (errmsg != null)
		{
			if (_onCallback == null && callback == null)
			{
				OutputDefaultLog(errmsg);
			}
			else
			{
				unThreadSafeMessages.Enqueue(errmsg);
			}
			if (enableForceCrashOnError)
			{
				Utils.ForceCrash(ForcedCrashCategory.Abort);
			}
		}
	}

	private static void OutputDefaultLog(string errmsg)
	{
		if (errmsg.StartsWith("E"))
		{
			Debug.LogError(logPrefix + " Error:" + errmsg);
		}
		else if (errmsg.StartsWith("W"))
		{
			Debug.LogWarning(logPrefix + " Warning:" + errmsg);
		}
		else
		{
			Debug.Log(logPrefix + errmsg);
		}
	}
}
