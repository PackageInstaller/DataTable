using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/特殊实体/散射飞镖")]
[DisallowMultipleComponent]
public class ScatteringDartsEntity : LogicEntity, ISpecialEntity
{
	protected struct DartsPosition(TSVector2 position, FP positionY, TSVector2 direction)
	{
		public TSVector2 position = position;

		public TSVector2 direction = direction;

		public Vector3 fxPosition = new Vector3((float)position.x, (float)positionY, (float)position.y);

		public Quaternion fxRotation = Quaternion.Euler(0f, 0f - (float)direction.GetAngle(), 0f);
	}

	public int dartsCount = 1;

	public GameObject dartsFx;

	public FP dartsPositionY = 0;

	public FP radius = 1;

	public GameObject bullet;

	public FP shootDelay = 1;

	public FP shootInterval = 1;

	public int shootRoundCount = 1;

	protected AdventureActor _owner;

	protected List<DartsPosition> _dartsPositionList;

	protected List<AdventureFXPlayer> _fxPlayerList;

	protected int _shootRoundCount;

	protected CoroutineNode _shootCor;

	public long tagUid;

	public Action OnBeforeEnd;

	public AdventureActor Owner => _owner;

	protected override void OnInit()
	{
		base.OnInit();
	}

	public void Setup(AdventureActor owner)
	{
		_owner = owner;
		_shootRoundCount = 0;
		CalculatePosition();
		if (_shootCor != null)
		{
			_owner.StopLogicCoroutine(_shootCor);
			_shootCor = null;
		}
		_shootCor = _owner.StartLogicCoroutine(SingleRoundShoot());
	}

	protected void CalculatePosition()
	{
		if (_dartsPositionList == null)
		{
			_dartsPositionList = new List<DartsPosition>(20);
		}
		else
		{
			_dartsPositionList.Clear();
		}
		int num = 360 / dartsCount;
		for (int i = 0; i < dartsCount; i++)
		{
			TSVector2 position = tsTransform.Position + TSVector2.Rotate(new TSVector2(0, radius), -num * i);
			TSVector2 normalized = TSVector2.Rotate(tsTransform.Forward, -num * i).normalized;
			_dartsPositionList.Add(new DartsPosition(position, tsTransform.PositionY + dartsPositionY, normalized));
		}
	}

	protected IEnumerator SingleRoundShoot()
	{
		PlayDartsFx();
		if (shootDelay > 0)
		{
			yield return (float)shootDelay;
		}
		int shootCount = 0;
		while (shootCount < dartsCount)
		{
			ShootDarts(shootCount);
			shootCount++;
			if (shootInterval > 0)
			{
				yield return (float)shootInterval;
			}
		}
		_shootRoundCount++;
		OnSingleRoundShootFinish();
	}

	protected void PlayDartsFx()
	{
		if (_fxPlayerList == null)
		{
			_fxPlayerList = new List<AdventureFXPlayer>(20);
		}
		else
		{
			ClearFx();
		}
		for (int i = 0; i < _dartsPositionList.Count; i++)
		{
			AdventureFXPlayer item = null;
			if (dartsFx != null)
			{
				item = AdventureFXPlayer.PlayFX(dartsFx, (float)logicTimeScale, _dartsPositionList.get_Item(i).fxPosition, _dartsPositionList.get_Item(i).fxRotation);
			}
			_fxPlayerList.Add(item);
		}
	}

	protected void ShootDarts(int index)
	{
		_fxPlayerList.get_Item(index)?.Stop();
		if (bullet != null)
		{
			AdventureBulletBase adventureBulletBase = _owner?.shootBehaviour.Shoot(bullet, _dartsPositionList.get_Item(index).position, tsTransform.PositionY + dartsPositionY, _dartsPositionList.get_Item(index).direction);
			if (adventureBulletBase != null && tagUid != 0L)
			{
				adventureBulletBase.tagUid = tagUid;
			}
		}
	}

	protected void OnSingleRoundShootFinish()
	{
		if (_shootRoundCount == 1)
		{
			OnBeforeEnd?.Invoke();
		}
		if (_shootRoundCount < shootRoundCount)
		{
			_shootCor = _owner.StartLogicCoroutine(SingleRoundShoot());
		}
		else
		{
			Finish();
		}
	}

	protected void ClearFx()
	{
		for (int i = 0; i < _fxPlayerList.Count; i++)
		{
			_fxPlayerList.get_Item(i)?.Stop(dontPlaySubFX: true);
		}
		_fxPlayerList.Clear();
	}

	public void Finish()
	{
		SceneSingleton<SpecialEntityManager>.Instance.Despawn(transform);
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		if (_shootCor != null)
		{
			_owner.StopLogicCoroutine(_shootCor);
		}
		_shootCor = null;
		ClearFx();
		_dartsPositionList?.Clear();
		_shootRoundCount = 0;
		tagUid = 0L;
		_owner = null;
		OnBeforeEnd = null;
	}
}
