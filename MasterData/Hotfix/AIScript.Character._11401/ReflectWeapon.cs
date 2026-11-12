using System;
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11401;

public class ReflectWeapon
{
	public long uid;

	public int weaponType;

	public string firBullet;

	public int reflectCount;

	public int extraCount;

	public string sedBullet_1;

	public FP reboundRange;

	public string sedBullet_2;

	public FP scale_2;

	public TSVector2 Position;

	public FP PositionY;

	public AdventureActor owner;

	public Action<ReflectWeapon> OnFinish;

	public Action<ReflectWeapon> OnOnceFinish;

	private LogicEntity _atkTarget;

	public long targetId;

	private CoroutineNode corMain;

	private Dictionary<long, int> shootCache = new Dictionary<long, int>();

	private FP curScale;

	public bool isFinished;

	private long _curBulletId;

	private bool _curBulletFinished;

	public long totleDmg;

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
		totleDmg = 0L;
		curScale = 0;
		isFinished = false;
		extraCount = 0;
		_atkTarget = target;
		targetId = target.Id;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_FINISH", OnBulletFinish);
		corMain = owner.StartLogicCoroutine(OnMainLogic(shootPosXZ, shootPosY), runImmediately: true);
	}

	public void AddExtraCount(int count)
	{
		extraCount += count;
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
		TSVector2 lastPos = atkTarget.tsTransform.Position;
		if (weaponType != 2)
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
		LogicEntity lastTarget = atkTarget;
		for (int i = 0; i < reflectCount + extraCount; i++)
		{
			LogicEntity logicEntity = ((weaponType == 2) ? atkTarget : GetReboundTarget(Position, lastTarget));
			if (logicEntity == null || logicEntity == lastTarget)
			{
				break;
			}
			lastTarget = logicEntity;
			string bulletAlias2 = ((weaponType == 2) ? sedBullet_2 : sedBullet_1);
			AdventureActor actor2 = owner;
			TSVector2 position = lastPos;
			LogicEntity target = logicEntity;
			AdventureBulletBase bullet = ILRuntimeAPI.Shoot(bulletAlias2, actor2, default, position, shootPosY, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
			if (bullet == null)
			{
				break;
			}
			bullet.tagUid = uid;
			if (weaponType == 2)
			{
				curScale += scale_2;
				if (curScale > 0)
				{
					(bullet as AdventureVerticalProjectile).ChangeTrailFxSize(curScale.AsFloat());
				}
			}
			lastPos = logicEntity.tsTransform.Position;
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
		shootCache.Clear();
		owner.StopLogicCoroutine(corMain);
		corMain = null;
		owner = null;
		atkTarget = null;
		OnFinish = null;
		OnOnceFinish = null;
	}
}
