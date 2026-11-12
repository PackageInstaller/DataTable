using System;
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._11401;

public class ReflectWeapon
{
	public long uid;

	public string firBullet;

	public string sedBullet;

	public int reflectCount;

	public FP reboundRange;

	public TSVector2 Position;

	public FP PositionY;

	public AdventureActor owner;

	public Action<ReflectWeapon> OnFinish;

	public Action<ReflectWeapon> OnOnceFinish;

	private LogicEntity _atkTarget;

	private CoroutineNode corMain;

	public bool isFinished;

	private long _curBulletId;

	private bool _curBulletFinished;

	private LogicEntity atkTarget
	{
		get
		{
			if (_atkTarget == null)
			{
				return null;
			}
			if (_atkTarget is AdventureActor adventureActor)
			{
				if (!adventureActor.isSneak && !adventureActor.isPenetrate && adventureActor.actorHealthInfo.isAlive)
				{
					return _atkTarget;
				}
				return null;
			}
			return null;
		}
		set
		{
			_atkTarget = value;
		}
	}

	public void Shoot(LogicEntity target, TSVector2 shootPosXZ, FP shootPosY = default(FP))
	{
		isFinished = false;
		_atkTarget = target;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_FINISH", OnBulletFinish);
		corMain = owner.StartLogicCoroutine(OnMainLogic(shootPosXZ, shootPosY), runImmediately: true);
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (evt is AdventureBulletFinishEvent adventureBulletFinishEvent && adventureBulletFinishEvent.id == _curBulletId)
		{
			_curBulletFinished = true;
		}
	}

	private IEnumerator OnMainLogic(TSVector2 shootPosXZ, FP shootPosY)
	{
		string bulletAlias = firBullet;
		AdventureActor actor = owner;
		LogicEntity target = atkTarget;
		AdventureBulletBase bullet = ILRuntimeAPI.Shoot(bulletAlias, actor, default, shootPosXZ, shootPosY, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
		if (bullet == null)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
			yield break;
		}
		TSVector2 lastPos = atkTarget.tsTransform.Position;
		_curBulletId = bullet.Id;
		_curBulletFinished = false;
		while (!_curBulletFinished)
		{
			Position = bullet.tsTransform.Position;
			PositionY = bullet.tsTransform.PositionY;
			yield return null;
		}
		LogicEntity lastTarget = atkTarget;
		for (int i = 0; i < reflectCount; i++)
		{
			LogicEntity reboundTarget = GetReboundTarget(Position, lastTarget);
			if (reboundTarget == null)
			{
				break;
			}
			lastTarget = reboundTarget;
			string bulletAlias2 = sedBullet;
			AdventureActor actor2 = owner;
			TSVector2 position = lastPos;
			target = reboundTarget;
			bullet = ILRuntimeAPI.Shoot(bulletAlias2, actor2, default, position, shootPosY, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
			if (bullet == null)
			{
				break;
			}
			bullet.tagUid = uid;
			lastPos = reboundTarget.tsTransform.Position;
			_curBulletId = bullet.Id;
			_curBulletFinished = false;
			while (!_curBulletFinished)
			{
				Position = bullet.tsTransform.Position;
				PositionY = bullet.tsTransform.PositionY;
				yield return null;
			}
			OnOnceFinish?.Invoke(this);
		}
		Finish();
	}

	private LogicEntity GetReboundTarget(TSVector2 center, LogicEntity lastEntity)
	{
		List<LogicEntity> list = ILRuntimeAPI.SearchByRangeAndPosition(owner, center, reboundRange, null, isConfront: true, onlyAlive: true, includeSelf: false, (LogicEntity entity) => entity != lastEntity);
		if (list.Count > 0)
		{
			return list.get_Item(TSRandom.Range(0, list.Count));
		}
		return null;
	}

	public void Finish()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		OnFinish?.Invoke(this);
		isFinished = true;
		owner.StopLogicCoroutine(corMain);
		corMain = null;
		owner = null;
		_atkTarget = null;
		OnFinish = null;
		OnOnceFinish = null;
	}
}
