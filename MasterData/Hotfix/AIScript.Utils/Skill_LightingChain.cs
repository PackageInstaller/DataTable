using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Utils;

public class Skill_LightingChain
{
	private readonly int _hitDamageId;

	private readonly string _hitFxPath;

	private readonly int _hitDamageId_for_secend;

	private readonly string _hitFxPath_for_secend;

	private readonly FP _doubleHitInterval;

	private readonly FP _linkHitInterval;

	private readonly FP _linkCheckRange;

	private readonly int _maxLinkTime;

	private readonly FP _maxCoolingTime;

	private readonly FP _executeRate;

	private readonly AdventureActor _actor;

	private int _linkTimes;

	private CoroutineNode _waitForDoubleHitCoroutine;

	private CoroutineNode _waitForLinkHitCoroutine;

	private readonly List<LogicEntity> _ridList = new List<LogicEntity>();

	private FP _coolingTime;

	private CoroutineNode _cdCoroutine;

	public Skill_LightingChain(AdventureActor from, int hitDamageId, string hitFxPath, int hitDamageIdForSecond, string hitFxPathForSecond, FP doubleHitInterval, FP linkHitInterval, FP linkCheckRange, int maxLinkTime, FP maxCoolingTime, FP executeRate)
	{
		_hitDamageId = hitDamageId;
		_hitFxPath = hitFxPath;
		_hitDamageId_for_secend = hitDamageIdForSecond;
		_hitFxPath_for_secend = hitFxPathForSecond;
		_doubleHitInterval = doubleHitInterval;
		_doubleHitInterval = doubleHitInterval;
		_linkHitInterval = linkHitInterval;
		_linkCheckRange = linkCheckRange;
		_maxLinkTime = maxLinkTime;
		_maxCoolingTime = maxCoolingTime;
		_executeRate = executeRate;
		_actor = from;
	}

	public void Start(AdventureActor target, bool doubleHit = true)
	{
		if (!(_coolingTime > 0) && !(TSRandom.value > _executeRate))
		{
			_coolingTime = _maxCoolingTime;
			_cdCoroutine = _actor.StartLogicCoroutine(CdHandler());
			if (doubleHit)
			{
				_waitForDoubleHitCoroutine = _actor.StartLogicCoroutine(WaitForDoubleHit(target));
			}
			else
			{
				ExtraHit(target, firstCheck: true);
			}
		}
	}

	private IEnumerator CdHandler()
	{
		while (_coolingTime > 0)
		{
			_coolingTime -= _actor.LogicDeltaTime;
			yield return null;
		}
	}

	private IEnumerator WaitForDoubleHit(AdventureActor target)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_doubleHitInterval));
		if (target != null && target.actorHealthInfo.isAlive)
		{
			ILRuntimeAPI.HitActor(_actor, target, _hitDamageId_for_secend, null, _hitFxPath_for_secend, attackFxPlayOnTarget: true);
			ExtraHit(target, firstCheck: true);
		}
		else
		{
			OnFinish();
		}
	}

	private void ExtraHit(AdventureActor target, bool firstCheck = false)
	{
		if (_linkTimes >= _maxLinkTime)
		{
			OnFinish();
			return;
		}
		if (firstCheck)
		{
			_ridList.Add(_actor);
		}
		_ridList.Add(target);
		ILRuntimeAPI.SearchByRange(target, _linkCheckRange, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				for (int i = 0; i < _ridList.Count; i++)
				{
					if (result.Contains(_ridList.get_Item(i)))
					{
						result.Remove(_ridList.get_Item(i));
					}
				}
			}
			if (result.Count == 0)
			{
				OnFinish();
			}
			else
			{
				LogicEntity logicEntity = result.get_Item(0);
				_actor.hitBox.hurtEffectSource = target.gameObject;
				ILRuntimeAPI.HitActor(_actor, logicEntity as AdventureActor, _hitDamageId, null, _hitFxPath, attackFxPlayOnTarget: true);
				_actor.hitBox.hurtEffectSource = null;
				_linkTimes++;
				_waitForLinkHitCoroutine = _actor.StartLogicCoroutine(WaitForLinkHit(logicEntity as AdventureActor));
			}
		});
	}

	private IEnumerator WaitForLinkHit(AdventureActor target)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_linkHitInterval));
		ExtraHit(target);
	}

	public void OnFinish()
	{
		if (_waitForDoubleHitCoroutine != null)
		{
			_actor.StopLogicCoroutine(_waitForDoubleHitCoroutine);
			_waitForDoubleHitCoroutine = null;
		}
		if (_waitForLinkHitCoroutine != null)
		{
			_actor.StopLogicCoroutine(_waitForLinkHitCoroutine);
			_waitForLinkHitCoroutine = null;
		}
		_ridList.Clear();
		_linkTimes = 0;
	}

	public void Clear()
	{
		if (_cdCoroutine != null)
		{
			_actor.StopLogicCoroutine(_cdCoroutine);
			_cdCoroutine = null;
		}
		_coolingTime = 0;
	}
}
