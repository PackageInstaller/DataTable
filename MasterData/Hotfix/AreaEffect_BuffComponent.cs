using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/AreaEffect/AreaEffectComponents/区域效果组件_Buff")]
[RequireComponent(typeof(AreaEffectEntity))]
public class AreaEffect_BuffComponent : AreaEffect_Component
{
	public List<int> addBuffIdList;

	public FP addInterval = 1;

	public TargetFilterCriteriaInfo addCriteriaInfo;

	[Space]
	public List<int> removeBuffIdList;

	public int removeBuffGroupId;

	public string removeBuffTag;

	public FP removeInterval = 1;

	public TargetFilterCriteriaInfo removeCriteriaInfo;

	public int removeBuffCount;

	[Space]
	public bool executeImmediately = true;

	public bool triggerEnter;

	public TargetFilterCriteriaInfo triggerEnterCriteriaInfo;

	public bool finish_TriggerEnter;

	[Space]
	public bool triggerExit;

	public TargetFilterCriteriaInfo triggerExitCriteriaInfo;

	public bool finish_TriggerExit;

	private FP _addTime;

	private FP _removeTime;

	private List<DeterministicCollider> _actorCollider;

	protected override void OnSetup()
	{
		base.OnSetup();
		_addTime = addInterval;
		_removeTime = removeInterval;
	}

	protected override void OnStartLogic()
	{
		base.OnStartLogic();
		if (executeImmediately)
		{
			AddBuff();
			RemoveBuff();
		}
	}

	public void FixAddTime(FP _time)
	{
		addInterval = _time;
		_addTime = _time;
	}

	protected override void OnLogicUpdate(FP logicDeltaTime)
	{
		base.OnLogicUpdate(logicDeltaTime);
		if (addInterval > 0)
		{
			_addTime -= logicDeltaTime;
			if (_addTime <= 0)
			{
				AddBuff();
				_addTime = addInterval;
			}
		}
		if (removeInterval > 0)
		{
			_removeTime -= logicDeltaTime;
			if (_removeTime <= 0)
			{
				RemoveBuff();
				_removeTime = removeInterval;
			}
		}
	}

	private void AddBuff()
	{
		if (_actorCollider == null)
		{
			_actorCollider = new List<DeterministicCollider>(16);
		}
		_context.DeterministicCollision(_actorCollider, 256, checkTargetWithTag ? _checkTagHashCode : 0);
		for (int i = 0; i < _actorCollider.Count; i++)
		{
			if (_context.CheckEntitySearchable(_actorCollider.get_Item(i).Entity))
			{
				AdventureActor adventureActor = _actorCollider.get_Item(i).Entity as AdventureActor;
				if (!(adventureActor == null) && _context.CheckTarget(adventureActor, addCriteriaInfo))
				{
					CurAddBuff(adventureActor);
				}
			}
		}
		_actorCollider.Clear();
	}

	private void CurAddBuff(AdventureActor actor)
	{
		List<int> list = addBuffIdList;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		foreach (int addBuffId in addBuffIdList)
		{
			if (addBuffId > 0)
			{
				actor.buffComponent?.AddBuff(addBuffId, _owner);
			}
		}
	}

	private void RemoveBuff()
	{
		if (_actorCollider == null)
		{
			_actorCollider = new List<DeterministicCollider>(16);
		}
		_context.DeterministicCollision(_actorCollider, 256, checkTargetWithTag ? _checkTagHashCode : 0);
		for (int i = 0; i < _actorCollider.Count; i++)
		{
			if (_context.CheckEntitySearchable(_actorCollider.get_Item(i).Entity))
			{
				AdventureActor adventureActor = _actorCollider.get_Item(i).Entity as AdventureActor;
				if (!(adventureActor == null) && _context.CheckTarget(adventureActor, removeCriteriaInfo))
				{
					CurRemoveBuff(adventureActor);
				}
			}
		}
		_actorCollider.Clear();
	}

	private void CurRemoveBuff(AdventureActor actor)
	{
		List<int> list = removeBuffIdList;
		if (list != null && list.Count > 0)
		{
			for (int i = 0; i < removeBuffIdList.Count; i++)
			{
				int num = removeBuffIdList.get_Item(i);
				if (num > 0)
				{
					actor.buffComponent?.RemoveBuffByBuffId(num, removeBuffCount);
				}
			}
		}
		if (removeBuffGroupId > 0)
		{
			actor.buffComponent?.RemoveBuffByGroupId(removeBuffGroupId);
		}
		if (!string.IsNullOrEmpty(removeBuffTag))
		{
			actor.buffComponent?.RemoveBuffByTag(CommonHelper.StringToHash(removeBuffTag));
		}
	}

	protected override void OnDeterministicCollisionEnter(LogicEntity entity)
	{
		base.OnDeterministicCollisionEnter(entity);
		if (_context.CheckEntitySearchable(entity) && triggerEnter && entity is AdventureActor adventureActor && _context.CheckTarget(adventureActor, triggerEnterCriteriaInfo) && (!checkTargetWithTag || _checkTagHashCode == 0 || adventureActor.CheckTag(_checkTagHashCode)))
		{
			CurAddBuff(adventureActor);
			CurRemoveBuff(adventureActor);
			if (finish_TriggerEnter)
			{
				FinishAreaEffect = true;
			}
		}
	}

	protected override void OnDeterministicCollisionExit(LogicEntity entity)
	{
		base.OnDeterministicCollisionEnter(entity);
		if (_context.CheckEntitySearchable(entity) && triggerExit && entity is AdventureActor adventureActor && _context.CheckTarget(adventureActor, triggerExitCriteriaInfo) && (!checkTargetWithTag || _checkTagHashCode == 0 || adventureActor.CheckTag(_checkTagHashCode)))
		{
			CurAddBuff(adventureActor);
			CurRemoveBuff(adventureActor);
			if (finish_TriggerExit)
			{
				FinishAreaEffect = true;
			}
		}
	}
}
