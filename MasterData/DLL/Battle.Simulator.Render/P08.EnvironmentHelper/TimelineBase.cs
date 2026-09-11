using System;
using System.Collections.Generic;
using UnityEngine;

namespace P08.EnvironmentHelper;

public abstract class TimelineBase : CMonoBehaviour
{
	public List<ClipBase> _runtimeClip = new List<ClipBase>(5);

	private bool _stopped;

	private bool _pause;

	protected abstract void OnResetData();

	protected abstract void OnRemovingClip(ClipBase pClipBase);

	protected abstract void OnRemovedClip(List<ClipBase> pRuntimeClip, int pLastestRemoveIndex);

	protected abstract void OnUpdateClip(List<ClipBase> pRuntimeClip);

	protected abstract void OnAddingClip(List<ClipBase> pRuntimeClip, int pIndex);

	protected abstract void OnObsoleting(ClipBase pClipBase);

	public override void LateUpdateBehavior()
	{
		if (_pause)
		{
			return;
		}
		int num = -1;
		for (int num2 = _runtimeClip.Count - 1; num2 >= 0; num2--)
		{
			if (_runtimeClip[num2].IsObsolete)
			{
				RemoveClip(num2, pNeedUpdate: false);
				num = num2;
			}
		}
		if (num != -1)
		{
			OnRemovedClip(_runtimeClip, num);
		}
		if (_runtimeClip.Count <= 0)
		{
			if (!_stopped)
			{
				ResetData();
			}
			_stopped = true;
			return;
		}
		_stopped = false;
		for (int i = 0; i < _runtimeClip.Count; i++)
		{
			ClipBase clipBase = _runtimeClip[i];
			if (clipBase.IsAuto)
			{
				clipBase.Normalized += Time.deltaTime / clipBase.Length;
				if (clipBase.Normalized >= 1f)
				{
					clipBase.Normalized = 1f;
					SetClipObsolete(clipBase);
				}
			}
		}
		OnUpdateClip(_runtimeClip);
	}

	public void ResetData()
	{
		OnResetData();
	}

	protected void RemoveClip(int pIndex, bool pNeedUpdate = true)
	{
		ClipBase clipBase = _runtimeClip[pIndex];
		_runtimeClip.RemoveAt(pIndex);
		clipBase.ResetData();
		OnRemovingClip(clipBase);
		if (pNeedUpdate)
		{
			OnUpdateClip(_runtimeClip);
		}
	}

	protected void AddClip(ClipBase pClip, int pIndex = -1, bool pNeedUpdate = true)
	{
		if (pIndex == -1 || pIndex >= _runtimeClip.Count)
		{
			_runtimeClip.Add(pClip);
			pIndex = _runtimeClip.Count - 1;
		}
		else
		{
			_runtimeClip.Insert(pIndex, pClip);
		}
		OnAddingClip(_runtimeClip, pIndex);
		if (pNeedUpdate && !_pause)
		{
			OnUpdateClip(_runtimeClip);
		}
		_stopped = false;
	}

	public void ForeachRuntimeClip(Func<ClipBase, bool> funcToBreak, bool desc = false)
	{
		if (desc)
		{
			int num = _runtimeClip.Count - 1;
			while (num >= 0 && !funcToBreak(_runtimeClip[num]))
			{
				num--;
			}
		}
		else
		{
			for (int i = 0; i < _runtimeClip.Count && !funcToBreak(_runtimeClip[i]); i++)
			{
			}
		}
	}

	private void SetClipObsolete(ClipBase pClipBase)
	{
		pClipBase.IsObsolete = true;
		OnObsoleting(pClipBase);
	}

	public void Pause(bool pCleanEffect = false)
	{
		_pause = true;
		if (pCleanEffect)
		{
			ResetData();
		}
	}

	public void Resume()
	{
		_pause = false;
	}

	public override void DestroyBehavior()
	{
		for (int num = _runtimeClip.Count - 1; num >= 0; num--)
		{
			OnRemovingClip(_runtimeClip[num]);
		}
		_runtimeClip.Clear();
		_stopped = false;
		_pause = false;
		ResetData();
	}
}
