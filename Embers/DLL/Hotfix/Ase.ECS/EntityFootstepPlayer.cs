#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using FMOD.Studio;
using FMODUnity;
using GameFramework;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Ase.ECS;

public class EntityFootstepPlayer : SerializedMonoBehaviour
{
	public Dictionary<int, EventInfo> EventInfos = new Dictionary<int, EventInfo>();

	private Dictionary<int, EventInstance> eventInstances = new Dictionary<int, EventInstance>();

	private int person = 1;

	public void PlayFootstep(int index)
	{
		//IL_00ff: Unknown result type (might be due to invalid IL or missing references)
		//IL_0104: Unknown result type (might be due to invalid IL or missing references)
		//IL_010c: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		//IL_009d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d8: Unknown result type (might be due to invalid IL or missing references)
		if (!eventInstances.ContainsKey(index))
		{
			try
			{
				if (!EventInfos.ContainsKey(index))
				{
					return;
				}
				EventInfo eventInfo = EventInfos[index];
				EventInstance value = Singleton<AudioSystem>.Instance.CreateInstance(eventInfo.ConfigId);
				if (!((EventInstance)(ref value)).isValid())
				{
					return;
				}
				foreach (EventParameter item in eventInfo.Params)
				{
					if (item.Key.Equals("Volume"))
					{
						((EventInstance)(ref value)).setVolume(item.Value);
					}
					else
					{
						((EventInstance)(ref value)).setParameterByName(item.Key, item.Value, false);
					}
				}
				((EventInstance)(ref value)).setParameterByName("Playerfootstep", (float)person, false);
				eventInstances.Add(index, value);
			}
			catch (Exception message)
			{
				Log.Error(message);
			}
		}
		if (eventInstances.TryGetValue(index, out var value2))
		{
			((EventInstance)(ref value2)).set3DAttributes(RuntimeUtils.To3DAttributes(((Component)this).transform));
			((EventInstance)(ref value2)).start();
		}
	}

	public void ChangeAiControl(bool isAi)
	{
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		person = ((!isAi) ? 1 : 3);
		foreach (EventInstance value in eventInstances.Values)
		{
			EventInstance current = value;
			((EventInstance)(ref current)).setParameterByName("Playerfootstep", (float)person, false);
		}
	}

	public void PlayOneShotSound(int eventKey)
	{
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_007f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ac: Unknown result type (might be due to invalid IL or missing references)
		//IL_00de: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00eb: Unknown result type (might be due to invalid IL or missing references)
		try
		{
			if (!EventInfos.ContainsKey(eventKey))
			{
				return;
			}
			EventInfo eventInfo = EventInfos[eventKey];
			EventInstance val = Singleton<AudioSystem>.Instance.CreateInstance(eventInfo.ConfigId);
			foreach (EventParameter item in eventInfo.Params)
			{
				if (item.Key.Equals("Volume"))
				{
					((EventInstance)(ref val)).setVolume(item.Value);
				}
				else
				{
					((EventInstance)(ref val)).setParameterByName(item.Key, item.Value, false);
				}
			}
			EventDescription val2 = default(EventDescription);
			((EventInstance)(ref val)).getDescription(ref val2);
			bool flag = default(bool);
			((EventDescription)(ref val2)).is3D(ref flag);
			if (flag)
			{
				((EventInstance)(ref val)).set3DAttributes(RuntimeUtils.To3DAttributes(((Component)this).gameObject));
				RuntimeManager.AttachInstanceToGameObject(val, ((Component)this).transform);
			}
			else
			{
				((EventInstance)(ref val)).set3DAttributes(RuntimeUtils.To3DAttributes(((Component)this).gameObject));
			}
			((EventInstance)(ref val)).start();
		}
		catch (Exception message)
		{
			Log.Error(message);
		}
	}

	private void OnDestroy()
	{
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		foreach (EventInstance value in eventInstances.Values)
		{
			EventInstance current = value;
			((EventInstance)(ref current)).release();
		}
		eventInstances = null;
	}
}
