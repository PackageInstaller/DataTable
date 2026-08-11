using System;
using System.Collections.Generic;
using FMOD.Studio;
using FMODUnity;
using UnityEngine;

namespace Ase;

public class LoopSoundPlayer : MonoBehaviour
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

	private void SetPosition()
	{
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		EventDescription val = default(EventDescription);
		((EventInstance)(ref _eventInstance)).getDescription(ref val);
		bool flag = default(bool);
		((EventDescription)(ref val)).is3D(ref flag);
		if (flag)
		{
			RuntimeManager.AttachInstanceToGameObject(_eventInstance, base.transform);
		}
		else
		{
			((EventInstance)(ref _eventInstance)).set3DAttributes(RuntimeUtils.To3DAttributes(base.gameObject));
		}
	}

	private void Play()
	{
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_007f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0072: Unknown result type (might be due to invalid IL or missing references)
		if (!((EventInstance)(ref _eventInstance)).isValid() || developEnable)
		{
			CreateInstance();
			if (!((EventInstance)(ref _eventInstance)).isValid())
			{
				return;
			}
		}
		if (((EventInstance)(ref _eventInstance)).isValid())
		{
			SetPosition();
			if (PlayMode == PlayModeEnum.Restart)
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
		else
		{
			((EventInstance)(ref _eventInstance)).release();
			((EventInstance)(ref _eventInstance)).clearHandle();
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
		//IL_00d6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00db: Unknown result type (might be due to invalid IL or missing references)
		//IL_004c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0051: Unknown result type (might be due to invalid IL or missing references)
		//IL_0056: Unknown result type (might be due to invalid IL or missing references)
		//IL_0067: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		//IL_009e: Unknown result type (might be due to invalid IL or missing references)
		if (developEnable)
		{
			if (((EventReference)(ref testSound)).IsNull)
			{
				return;
			}
			if (((EventInstance)(ref _eventInstance)).isValid())
			{
				((EventInstance)(ref _eventInstance)).stop((STOP_MODE)0);
				((EventInstance)(ref _eventInstance)).release();
				((EventInstance)(ref _eventInstance)).clearHandle();
			}
			_eventInstance = RuntimeManager.CreateInstance(testSound);
			((EventInstance)(ref _eventInstance)).setVolume(volume);
			if (paramList == null)
			{
				return;
			}
			{
				foreach (AudioParameterSerializable param in paramList)
				{
					((EventInstance)(ref _eventInstance)).setParameterByName(param.Key, param.Value, false);
				}
				return;
			}
		}
		_eventInstance = Singleton<AudioSystem>.Instance.CreateInstance(configId, volume, paramList);
	}
}
