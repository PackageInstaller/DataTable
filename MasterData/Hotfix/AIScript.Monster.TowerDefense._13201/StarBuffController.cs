using System;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.TowerDefense._13201;

public class StarBuffController
{
	private const int buffId = 801320030;

	private static readonly FP duration = 13;

	private AdventureActor _actor;

	private long _targetId;

	private AdventureActor _target;

	private int _maxBuffCount;

	private FP _duration;

	private Action<AdventureActor> _reduceCountCallBack;

	public StarBuffController(AdventureActor actor)
	{
		_actor = actor;
		_maxBuffCount = 0;
		_duration = duration;
	}

	public void Init(AdventureActor target, int maxBuffCount, Action<AdventureActor> reduceCountCallBack)
	{
		_target = target;
		_targetId = target.Id;
		_maxBuffCount = maxBuffCount;
		_reduceCountCallBack = reduceCountCallBack;
	}

	public void AddBuff(int addBuffCount)
	{
		if (addBuffCount <= 0 || !IsValid())
		{
			return;
		}
		for (int i = 0; i < addBuffCount; i++)
		{
			if (GetBuffCount() >= _maxBuffCount)
			{
				break;
			}
			_target.buffComponent.AddBuff(801320030, _actor);
		}
	}

	public void Update(FP deltaTime)
	{
		if (!IsValid())
		{
			return;
		}
		if (GetBuffCount() > 0)
		{
			if (_duration > 0)
			{
				_duration -= deltaTime;
				return;
			}
			_duration = duration;
			_target.buffComponent.RemoveBuffByBuffId(801320030, 1);
			_reduceCountCallBack?.Invoke(_target);
		}
		else
		{
			_duration = duration;
		}
	}

	public void TriggerAll()
	{
		if (IsValid())
		{
			int buffCount = GetBuffCount();
			for (int i = 0; i < buffCount; i++)
			{
				_target.buffComponent.RemoveBuffByBuffId(801320030, 1);
				_reduceCountCallBack?.Invoke(_target);
			}
			_duration = duration;
		}
	}

	public int GetBuffCount()
	{
		if (!IsValid())
		{
			return 0;
		}
		return _target.buffComponent.GetBuffNumByID(801320030);
	}

	public long GetTargetId()
	{
		return _targetId;
	}

	public AdventureActor GetTarget()
	{
		return _target;
	}

	private bool IsValid()
	{
		if (_actor == null)
		{
			return false;
		}
		return CommonUtils.CheckTargetIsValid(_target, _targetId, ingoreSearchedImmunity: true);
	}

	public void Clear()
	{
		_targetId = 0L;
		_target = null;
		_reduceCountCallBack = null;
	}
}
