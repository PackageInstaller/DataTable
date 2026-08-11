using System.Collections.Generic;
using FMOD.Studio;
using UnityEngine;

namespace Ase;

public class SnapshotGroup
{
	private Transform followTransform;

	private Dictionary<int, AudioItem> audioItems = new Dictionary<int, AudioItem>();

	public SnapshotGroup(Transform followTransform)
	{
		this.followTransform = followTransform;
	}

	public bool PlaySnapshot(int id, AudioInfo audioInfo, EventInstance eventInstance, float volume = 1f, List<AudioParameter> audioParams = null, Transform transform = null)
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		if (audioItems.ContainsKey(id) || followTransform != transform)
		{
			return false;
		}
		AudioItem audioItem = AudioItem.Create(audioInfo, eventInstance, int.MinValue, volume, audioParams, transform, clearStack: false, (STOP_MODE)0);
		audioItems.Add(id, audioItem);
		audioItem.SetAttributes();
		audioItem.Start();
		return true;
	}

	public bool StopSnapshot(int id, STOP_MODE stopMode = (STOP_MODE)0)
	{
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		if (!audioItems.ContainsKey(id))
		{
			return false;
		}
		audioItems[id].OriClear(stopMode);
		audioItems.Remove(id);
		return true;
	}

	public bool ClearSnapshot()
	{
		if (audioItems == null)
		{
			return true;
		}
		foreach (AudioItem value in audioItems.Values)
		{
			value.OriClear((STOP_MODE)0);
		}
		audioItems.Clear();
		return true;
	}

	public void Dispose()
	{
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		followTransform = null;
		foreach (KeyValuePair<int, AudioItem> audioItem in audioItems)
		{
			audioItem.Value.GetPaused(out var isPaused);
			if (audioItem.Value.Valid() && !isPaused)
			{
				audioItem.Value.Stop(audioItem.Value.StopMode);
			}
		}
		audioItems.Clear();
	}

	public int GetCount()
	{
		return audioItems.Count;
	}
}
