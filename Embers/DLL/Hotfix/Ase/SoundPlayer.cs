using System;
using System.Collections.Generic;
using FMOD.Studio;
using FMODUnity;
using UnityEngine;

namespace Ase;

public class SoundPlayer : MonoBehaviour
{
	[Flags]
	public enum TriggerModeEnum
	{
		Custom = 2,
		ObjectStart = 4,
		OnEnable = 8
	}

	[Flags]
	public enum StopModeEnum
	{
		Custom = 2,
		OnDisable = 4
	}

	public enum PlayModeEnum
	{
		Restart,
		RestartOrResume
	}

	public bool developEnable;

	public EventReference testSound;

	public TriggerModeEnum TriggerModes = TriggerModeEnum.Custom;

	public PlayModeEnum PlayMode;

	public StopModeEnum StopModes = StopModeEnum.Custom | StopModeEnum.OnDisable;

	public int configId;

	public float volume = 1f;

	public List<AudioParameterSerializable> paramList = new List<AudioParameterSerializable>();

	private EventInstance _eventInstance;

	private bool _isOneShot;

	private bool _is3D;

	private void Play()
	{
		if (!((EventInstance)(ref _eventInstance)).isValid() || developEnable)
		{
			CreateInstance();
			if (!((EventInstance)(ref _eventInstance)).isValid())
			{
				Dispose();
				return;
			}
		}
		if (_isOneShot)
		{
			CreateInstance();
		}
		if (((EventInstance)(ref _eventInstance)).isValid())
		{
			SetPosition();
			DoPlay();
		}
		else
		{
			Dispose();
		}
	}

	private void Stop()
	{
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		if (((EventInstance)(ref _eventInstance)).isValid())
		{
			if (PlayMode == PlayModeEnum.Restart)
			{
				((EventInstance)(ref _eventInstance)).stop((STOP_MODE)0);
			}
			else if (PlayMode == PlayModeEnum.RestartOrResume)
			{
				((EventInstance)(ref _eventInstance)).setPaused(true);
			}
		}
	}

	private void Dispose()
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		if (((EventInstance)(ref _eventInstance)).isValid())
		{
			((EventInstance)(ref _eventInstance)).stop((STOP_MODE)0);
		}
		((EventInstance)(ref _eventInstance)).release();
		((EventInstance)(ref _eventInstance)).clearHandle();
	}

	private void Start()
	{
		if (TriggerModes.HasFlag(TriggerModeEnum.ObjectStart))
		{
			Play();
		}
	}

	private void OnEnable()
	{
		if (TriggerModes.HasFlag(TriggerModeEnum.OnEnable))
		{
			Play();
		}
	}

	private void OnDisable()
	{
		if (StopModes.HasFlag(StopModeEnum.OnDisable))
		{
			Stop();
		}
	}

	private void OnDestroy()
	{
		Dispose();
	}

	private void CreateInstance()
	{
		//IL_00b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00df: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		if (developEnable)
		{
			if (((EventReference)(ref testSound)).IsNull)
			{
				return;
			}
			Dispose();
			_eventInstance = RuntimeManager.CreateInstance(testSound);
			((EventInstance)(ref _eventInstance)).setVolume(volume);
			if (paramList != null)
			{
				foreach (AudioParameterSerializable param in paramList)
				{
					((EventInstance)(ref _eventInstance)).setParameterByName(param.Key, param.Value, false);
				}
			}
		}
		else
		{
			Dispose();
			_eventInstance = Singleton<AudioSystem>.Instance.CreateInstance(configId, volume, paramList);
		}
		EventDescription val = default(EventDescription);
		((EventInstance)(ref _eventInstance)).getDescription(ref val);
		((EventDescription)(ref val)).isOneshot(ref _isOneShot);
		((EventDescription)(ref val)).is3D(ref _is3D);
	}

	private void SetPosition()
	{
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		if (_is3D)
		{
			if (_isOneShot)
			{
				((EventInstance)(ref _eventInstance)).set3DAttributes(RuntimeUtils.To3DAttributes(base.gameObject));
			}
			else
			{
				RuntimeManager.AttachInstanceToGameObject(_eventInstance, base.transform);
			}
		}
	}

	private void DoPlay()
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0058: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		if (_isOneShot)
		{
			((EventInstance)(ref _eventInstance)).start();
		}
		else if (PlayMode == PlayModeEnum.Restart)
		{
			((EventInstance)(ref _eventInstance)).start();
		}
		else if (PlayMode == PlayModeEnum.RestartOrResume)
		{
			bool flag = default(bool);
			((EventInstance)(ref _eventInstance)).getPaused(ref flag);
			if (flag)
			{
				((EventInstance)(ref _eventInstance)).setPaused(false);
			}
			else
			{
				((EventInstance)(ref _eventInstance)).start();
			}
		}
	}
}
