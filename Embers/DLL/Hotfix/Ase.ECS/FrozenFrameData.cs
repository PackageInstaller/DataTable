using System.Collections.Generic;
using GameFramework;

namespace Ase.ECS;

public class FrozenFrameData : IReference
{
	private int _priority;

	private BaseEntity _targetEntity;

	public int localId;

	private int _frozenFrame;

	public float FrozenTime;

	public bool IsIgnoreStateEndFrozen;

	private List<(BaseEntity, int)> frozenEntities = new List<(BaseEntity, int)>();

	private bool _isFrozenLogic;

	public int Priority => _priority;

	public int TargetEntityId => _targetEntity?.Id ?? 0;

	public BaseEntity TargetEntity => _targetEntity;

	public void InitData(int frame, int id, bool isIgnoreStateEndFrozen)
	{
		_frozenFrame = frame;
		localId = id;
		FrozenTime = (float)_frozenFrame * 0.033f;
		IsIgnoreStateEndFrozen = isIgnoreStateEndFrozen;
	}

	public void RegisterTargetEntity(BaseEntity targetEntity, int frozenType, int priority)
	{
		_targetEntity = targetEntity;
		_priority = priority;
		if (frozenType == 1 || frozenType == 3)
		{
			_isFrozenLogic = true;
		}
	}

	public void AddFrozenEntity(float speed, BaseEntity baseEntity, int frozenType)
	{
		if (!baseEntity.IsFrozen)
		{
			baseEntity.DoFrozen(speed, frozenType, _isFrozenLogic);
			frozenEntities.Add((baseEntity, frozenType));
		}
	}

	public void EndFrozen()
	{
		foreach (var frozenEntity in frozenEntities)
		{
			frozenEntity.Item1.DoUnFrozen(1f);
		}
		ReferencePool.Release(this);
	}

	public void EndFrozen(int frozenType)
	{
		for (int num = frozenEntities.Count - 1; num >= 0; num--)
		{
			if (frozenType == 3)
			{
				frozenEntities[num].Item1.DoUnFrozen(1f);
				frozenEntities.RemoveAt(num);
			}
			else if (frozenEntities[num].Item2 == frozenType)
			{
				frozenEntities[num].Item1.DoUnFrozen(1f);
				frozenEntities.RemoveAt(num);
			}
		}
	}

	public void OnDispose()
	{
		ReferencePool.Release(this);
	}

	public void Clear()
	{
		_targetEntity = null;
		frozenEntities.Clear();
		IsIgnoreStateEndFrozen = false;
		_isFrozenLogic = false;
	}
}
