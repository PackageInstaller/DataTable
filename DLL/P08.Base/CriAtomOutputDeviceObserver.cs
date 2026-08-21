using System.Runtime.InteropServices;
using UnityEngine;

public class CriAtomOutputDeviceObserver : CriMonoBehaviour
{
	public enum OutputDeviceType
	{
		BuiltinSpeaker,
		WiredDevice,
		WirelessDevice
	}

	public delegate void DeviceConnectionChangeCallback(bool isConnected, OutputDeviceType deviceType);

	private static class UnsafeNativeMethods
	{
		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomUnity_StartOutputDeviceObserver_WASAPI();

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern void criAtomUnity_StopOutputDeviceObserver_WASAPI();

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern bool criAtomUnity_IsOutputDeviceConnected_WASAPI();
	}

	[SerializeField]
	private bool dontDestroyOnLoad;

	private bool lastIsConnected;

	private bool isConnected;

	private OutputDeviceType lastDeviceType;

	private OutputDeviceType deviceType;

	private static CriAtomOutputDeviceObserver instance;

	public static bool IsDeviceConnected
	{
		get
		{
			if (instance == null)
			{
				return false;
			}
			return UnsafeNativeMethods.criAtomUnity_IsOutputDeviceConnected_WASAPI();
		}
	}

	public static OutputDeviceType DeviceType
	{
		get
		{
			_ = instance == null;
			return OutputDeviceType.BuiltinSpeaker;
		}
	}

	public static event DeviceConnectionChangeCallback OnDeviceConnectionChanged
	{
		add
		{
			_onDeviceConnectionChanged += value;
			if ((bool)instance)
			{
				value(IsDeviceConnected, DeviceType);
			}
		}
		remove
		{
			_onDeviceConnectionChanged -= value;
		}
	}

	private static event DeviceConnectionChangeCallback _onDeviceConnectionChanged;

	private void Awake()
	{
		if (instance != null)
		{
			Object.Destroy(this);
			return;
		}
		if (!CriAtomPlugin.IsLibraryInitialized())
		{
			Debug.LogError("[CRIWARE] Atom library is not initialized. Cannot setup CriAtomExOutputDeviceObserver.");
			Object.Destroy(this);
			return;
		}
		instance = this;
		UnsafeNativeMethods.criAtomUnity_StartOutputDeviceObserver_WASAPI();
		isConnected = (lastIsConnected = IsDeviceConnected);
		deviceType = (lastDeviceType = DeviceType);
		if (_onDeviceConnectionChanged != null)
		{
			_onDeviceConnectionChanged(isConnected, deviceType);
		}
		if (dontDestroyOnLoad)
		{
			Object.DontDestroyOnLoad(base.gameObject);
		}
	}

	private void OnDestroy()
	{
		if (!(instance != this))
		{
			instance = null;
			UnsafeNativeMethods.criAtomUnity_StopOutputDeviceObserver_WASAPI();
		}
	}

	public override void CriInternalUpdate()
	{
		isConnected = IsDeviceConnected;
		deviceType = DeviceType;
		if ((isConnected != lastIsConnected || deviceType != lastDeviceType) && _onDeviceConnectionChanged != null)
		{
			_onDeviceConnectionChanged(isConnected, deviceType);
		}
		lastIsConnected = isConnected;
		lastDeviceType = deviceType;
	}

	public override void CriInternalLateUpdate()
	{
	}
}
