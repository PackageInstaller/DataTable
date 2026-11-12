#define LOG_DEBUG
using System;
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Utils;

public class Skill_Bullet_Summon
{
	private AdventureActor _actor;

	private AdventureSkill _skill;

	private string _customEventName;

	private int _search_inner_radius;

	private int _search_outer_radius;

	private int _summon_count = 3;

	private string _bullet_alias;

	private string _bullet_tag;

	private bool _alreadyShoot;

	private int _bulletCount;

	private FP _forceShootTime = 3;

	private CoroutineNode _waitForForceShootCoroutine;

	public void OnStart(AdventureActor actor, ComboAttack comboAttack, ComboInputBuffer.ActionKey[] actionKeys, AdventureSkill skill, string customEventName, int summonCount, string bulletAlias, string bulletTag, int searchInnerRadius, int searchOuterRadius, FP forceShootTime = default(FP))
	{
		_actor = actor;
		_skill = skill;
		_customEventName = customEventName;
		_summon_count = summonCount;
		_bullet_alias = bulletAlias;
		_bullet_tag = bulletTag;
		_search_inner_radius = searchInnerRadius;
		_search_outer_radius = searchOuterRadius;
		if (forceShootTime != default(FP) && forceShootTime > 0)
		{
			_forceShootTime = forceShootTime;
		}
		int skillId = ((skill != null) ? skill.skillId : 0);
		Action onInterrupt = Interrupt;
		Action onComboFinish = Finish;
		Action<string> onCustomEvent = OnCustomEvent;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
		_waitForForceShootCoroutine = _actor.StartLogicCoroutine(ForceShoot(_forceShootTime));
	}

	public void OnClear()
	{
		_alreadyShoot = false;
		_bulletCount = 0;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		if (_waitForForceShootCoroutine != null)
		{
			_actor.StopLogicCoroutine(_waitForForceShootCoroutine);
			_waitForForceShootCoroutine = null;
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (eventName.Equals(_customEventName) && !_alreadyShoot)
		{
			ShootBehaviour();
		}
	}

	private void ShootBehaviour()
	{
		_alreadyShoot = true;
		int num = 360 / _summon_count;
		TSVector2 tSVector = _actor.tsTransform.Forward;
		Shoot(tSVector);
		for (int i = 1; i < _summon_count; i++)
		{
			tSVector = TSVector2.Rotate(tSVector, num);
			Shoot(tSVector);
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_FINISH", OnBulletFinish);
		if (_bulletCount == 0)
		{
			_skill.Clear();
		}
	}

	protected void OnBulletFinish(IEvent evt)
	{
		AdventureBulletFinishEvent adventureBulletFinishEvent = evt as AdventureBulletFinishEvent;
		if (!(adventureBulletFinishEvent.owner == null) && !(adventureBulletFinishEvent.owner != _actor) && string.Equals(adventureBulletFinishEvent.tag, _bullet_tag))
		{
			_bulletCount--;
			if (_bulletCount == 0)
			{
				_skill.Clear();
			}
		}
	}

	private void Shoot(TSVector2 direction)
	{
		TSVector2 position = _actor.tsTransform.Position;
		int num = TSRandom.Range(_search_inner_radius, _search_outer_radius);
		TSVector2 tSVector = position + direction * num;
		if (!_actor.QueryPositionReachable(tSVector))
		{
			tSVector = GetRandomPoint(position);
		}
		if (position != tSVector)
		{
			string bullet_alias = _bullet_alias;
			AdventureActor actor = _actor;
			TSVector2 targetPosition = tSVector;
			if (ILRuntimeAPI.Shoot(bullet_alias, actor, default, position, default, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget) != null)
			{
				_bulletCount++;
			}
		}
	}

	private TSVector2 GetRandomPoint(TSVector2 position)
	{
		DeterministicShape deterministicCircleShape = CommonUtils.GetDeterministicCircleShape(_search_outer_radius, _search_inner_radius, position);
		return ILRuntimeAPI.GetRandomPointInShape(_actor, deterministicCircleShape);
	}

	private void Interrupt()
	{
		if (!_alreadyShoot)
		{
			ShootBehaviour();
		}
	}

	private void Finish()
	{
		if (!_alreadyShoot)
		{
			ShootBehaviour();
		}
	}

	private IEnumerator ForceShoot(FP forceShootTime)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(forceShootTime));
		if (!_alreadyShoot)
		{
			NovaLogger.Debug("Skill_Bullet_Summon 触发强制发射子弹");
			ShootBehaviour();
		}
	}
}
