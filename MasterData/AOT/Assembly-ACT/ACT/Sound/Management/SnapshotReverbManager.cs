using System;
using System.Collections.Generic;
using ACT.Sound.Core;
using Fundamental;
using UnityEngine;

namespace ACT.Sound.Management;

public class SnapshotReverbManager : Singleton<SnapshotReverbManager>
{
	private Stack<SnapshotReverbInfo> _reverbStack;

	private int _nextReverbIndex;

	public SnapshotReverbManager()
	{
		_reverbStack = new Stack<SnapshotReverbInfo>();
		_nextReverbIndex = 0;
	}

	public int SetSnapshotReverb(string eventPath)
	{
		if (string.IsNullOrEmpty(eventPath))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("[SnapshotReverbManager] Event path is null or empty");
			}
			return -1;
		}
		try
		{
			int num = _nextReverbIndex++;
			if (_reverbStack.Count > 0)
			{
				SnapshotReverbInfo snapshotReverbInfo = _reverbStack.Peek();
				if (snapshotReverbInfo.instance != null && snapshotReverbInfo.instance.IsValid)
				{
					snapshotReverbInfo.instance.Stop(allowFadeOut: false);
					if (LuminApplication.LogEnabled)
					{
						Debug.Log("[SnapshotReverbManager] Stopped previous reverb: " + snapshotReverbInfo.name);
					}
				}
			}
			IAudioInstance audioInstance = AudioCore.CreateInstance(eventPath);
			if (audioInstance == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogWarning("[SnapshotReverbManager] Failed to create instance: " + eventPath);
				}
				return -1;
			}
			SnapshotReverbInfo item = new SnapshotReverbInfo
			{
				name = num.ToString(),
				instance = audioInstance
			};
			_reverbStack.Push(item);
			audioInstance.Start();
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"[SnapshotReverbManager] Set reverb: ID={num}, Path={eventPath}, Stack Count={_reverbStack.Count}");
			}
			return num;
		}
		catch (Exception ex)
		{
			Debug.LogError("[SnapshotReverbManager] Error setting reverb: " + ex.Message);
			return -1;
		}
	}

	public void StopSnapshotReverb(int reverbId)
	{
		if (reverbId < 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("[SnapshotReverbManager] Invalid reverb ID");
			}
			return;
		}
		try
		{
			string text = reverbId.ToString();
			if (_reverbStack.Count == 0)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.Log($"[SnapshotReverbManager] Reverb stack is empty, ID={reverbId}");
				}
				return;
			}
			SnapshotReverbInfo snapshotReverbInfo = _reverbStack.Peek();
			if (snapshotReverbInfo.name == text)
			{
				_reverbStack.Pop();
				if (snapshotReverbInfo.instance != null && snapshotReverbInfo.instance.IsValid)
				{
					snapshotReverbInfo.instance.Stop();
					snapshotReverbInfo.instance.Release();
					if (LuminApplication.LogEnabled)
					{
						Debug.Log($"[SnapshotReverbManager] Stopped top reverb: ID={reverbId}, Stack Count={_reverbStack.Count}");
					}
				}
				if (_reverbStack.Count <= 0)
				{
					return;
				}
				SnapshotReverbInfo snapshotReverbInfo2 = _reverbStack.Peek();
				if (snapshotReverbInfo2.instance != null && snapshotReverbInfo2.instance.IsValid)
				{
					snapshotReverbInfo2.instance.Start();
					if (LuminApplication.LogEnabled)
					{
						Debug.Log("[SnapshotReverbManager] Resumed reverb: " + snapshotReverbInfo2.name);
					}
				}
				return;
			}
			Stack<SnapshotReverbInfo> stack = new Stack<SnapshotReverbInfo>();
			bool flag = false;
			while (_reverbStack.Count > 0)
			{
				SnapshotReverbInfo item = _reverbStack.Pop();
				if (item.name == text && !flag)
				{
					flag = true;
					if (item.instance != null && item.instance.IsValid)
					{
						item.instance.Stop();
						item.instance.Release();
					}
					if (LuminApplication.LogEnabled)
					{
						Debug.Log($"[SnapshotReverbManager] Removed reverb from middle of stack: ID={reverbId}");
					}
				}
				else
				{
					stack.Push(item);
				}
			}
			while (stack.Count > 0)
			{
				_reverbStack.Push(stack.Pop());
			}
			if (flag)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.Log($"[SnapshotReverbManager] Removed reverb: ID={reverbId}, Stack Count={_reverbStack.Count}");
				}
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"[SnapshotReverbManager] Reverb not found in stack: ID={reverbId}");
			}
		}
		catch (Exception ex)
		{
			Debug.LogError("[SnapshotReverbManager] Error stopping reverb: " + ex.Message);
		}
	}

	public void StopAllReverbs()
	{
		try
		{
			while (_reverbStack.Count > 0)
			{
				SnapshotReverbInfo snapshotReverbInfo = _reverbStack.Pop();
				if (snapshotReverbInfo.instance != null && snapshotReverbInfo.instance.IsValid)
				{
					snapshotReverbInfo.instance.Stop(allowFadeOut: false);
					snapshotReverbInfo.instance.Release();
				}
			}
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("[SnapshotReverbManager] Stopped all reverbs");
			}
		}
		catch (Exception ex)
		{
			Debug.LogError("[SnapshotReverbManager] Error stopping all reverbs: " + ex.Message);
		}
	}

	public int GetCurrentReverbId()
	{
		if (_reverbStack.Count == 0)
		{
			return -1;
		}
		if (int.TryParse(_reverbStack.Peek().name, out var result))
		{
			return result;
		}
		return -1;
	}

	public int GetReverbStackCount()
	{
		return _reverbStack.Count;
	}

	public void Clear()
	{
		StopAllReverbs();
		_nextReverbIndex = 0;
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("[SnapshotReverbManager] Cleared");
		}
	}
}
