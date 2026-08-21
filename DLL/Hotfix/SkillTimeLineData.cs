using Ase;
using Ase.ECS;
using GameFramework;
using UnityEngine;

public class SkillTimeLineData : IReference
{
	private int _executeId;

	private SkillTimelineLauncher _skillTimelineLauncher;

	private GameObject _gameObject;

	public int ExecuteId => _executeId;

	public void Init(int id, BaseEntity baseEntity, GameObject skillTimeLineObj, SkillTimelineLauncher skillTimelineLauncher)
	{
		_executeId = id;
		_gameObject = skillTimeLineObj;
		_skillTimelineLauncher = skillTimelineLauncher;
		_skillTimelineLauncher.BindEntity(baseEntity);
		CacheAssets();
	}

	private void CacheAssets()
	{
		if (!(_skillTimelineLauncher == null))
		{
			_skillTimelineLauncher.InitAssets();
		}
	}

	public void RefreshInitState()
	{
		_skillTimelineLauncher.RefreshInitState();
	}

	public PlayableStateEnum Execute(float deltaTime)
	{
		if (_skillTimelineLauncher == null)
		{
			return PlayableStateEnum.Error;
		}
		return _skillTimelineLauncher.UpdateTick(deltaTime);
	}

	public PlayableStateEnum ExecuteState()
	{
		return _skillTimelineLauncher?.ExecuteState() ?? PlayableStateEnum.Error;
	}

	public void Stop()
	{
		if (!(_skillTimelineLauncher == null))
		{
			_skillTimelineLauncher.ForceExecuteStop();
		}
	}

	public void Release()
	{
		FreeBack();
	}

	public void Pause(bool isPause)
	{
		if (!(_skillTimelineLauncher == null))
		{
			_skillTimelineLauncher.Pause(isPause);
		}
	}

	public void Clear()
	{
		if (_skillTimelineLauncher != null)
		{
			_skillTimelineLauncher.Release();
			_skillTimelineLauncher = null;
		}
		_executeId = 0;
	}

	private void FreeBack()
	{
		if (!(_gameObject == null))
		{
			_gameObject.GetComponent<IPooledObject>()?.Free();
			ReferencePool.Release(this);
		}
	}
}
