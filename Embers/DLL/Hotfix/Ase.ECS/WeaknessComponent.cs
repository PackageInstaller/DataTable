using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class WeaknessComponent : BaseComponent
{
	private string _pointName;

	private BaseWeaknessData _baseWeaknesses;

	private bool _isWeaknessTimer;

	private bool teachShowWeak;

	private WeaknessBarItem weaknessBarItem;

	public bool IsWeaknessTimer => _isWeaknessTimer;

	public override void OnInit(object data)
	{
		base.OnInit(data);
		_isWeaknessTimer = false;
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		teachShowWeak = GetData("TEACHSHOWWEAK", defaultValue: false);
	}

	public void CreateWeaknessData(BaseWeaknessData data, string pointName)
	{
		mBaseEntity.GetSystem<WeaknessSystem>().RemoveCacheData(_baseWeaknesses);
		_baseWeaknesses = data;
		_isWeaknessTimer = true;
		_pointName = pointName;
	}

	public void RemoveWeaknessData(BaseWeaknessData data)
	{
		_isWeaknessTimer = false;
		_baseWeaknesses = null;
	}

	public override void OnEntityRelease()
	{
		base.OnEntityRelease();
		_isWeaknessTimer = false;
		if (_baseWeaknesses != null)
		{
			mBaseEntity.GetSystem<WeaknessSystem>().OnMonsterEntityDie(_baseWeaknesses);
		}
		HideWeaknessBar();
	}

	public BaseWeaknessData GetMonsterWeaknessData()
	{
		return _baseWeaknesses;
	}

	public BaseWeaknessData GetUsageWeakness()
	{
		if (_baseWeaknesses != null && (_baseWeaknesses.Runtime < 0f || _baseWeaknesses.Runtime > _baseWeaknesses.Lifetime))
		{
			return null;
		}
		return _baseWeaknesses;
	}

	public int GetWeaknessLevel()
	{
		if (_baseWeaknesses != null)
		{
			return _baseWeaknesses.Level;
		}
		return 0;
	}

	public override void OnEntityDead()
	{
		base.OnEntityDead();
		HideWeaknessBar();
	}

	public void ShowWeaknessBar(BaseWeaknessData data)
	{
		if (weaknessBarItem != null)
		{
			HideWeaknessBar();
		}
		weaknessBarItem = mBaseEntity.GetSystem<WeaknessBarSystem>().ShowWeaknessBar(data, GetData<bool>("IsBoss"), mBaseEntity.GetSystem<WeaknessSystem>().Config);
		if (weaknessBarItem == null)
		{
			return;
		}
		Transform transform = null;
		EntityBoneComponent component = mBaseEntity.GetComponent<EntityBoneComponent>();
		if (component == null)
		{
			transform = mBaseEntity.GetComponent<EntityViewComponent>().Transform;
		}
		else
		{
			if (!string.IsNullOrEmpty(_pointName))
			{
				transform = component.GetBoneRoot(_pointName);
			}
			if (transform == null)
			{
				transform = mBaseEntity.GetComponent<EntityViewComponent>().Transform;
			}
		}
		weaknessBarItem.BindFollowRoot(transform);
		weaknessBarItem.ShowUI();
		if (teachShowWeak)
		{
			teachShowWeak = false;
			ObserverTeachGuideParams observerTeachGuideParams = ReferencePool.Acquire<ObserverTeachGuideParams>();
			observerTeachGuideParams.Init(mBaseEntity, weaknessBarItem.transform);
			mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.TeachWeaknessBar, observerTeachGuideParams);
			ReferencePool.Release(observerTeachGuideParams);
		}
	}

	public void UpdateWeaknessBar(float deltaTime)
	{
		mBaseEntity.GetSystem<WeaknessBarSystem>().UpdateWeaknessBar(weaknessBarItem, deltaTime);
	}

	public void HideWeaknessBar()
	{
		if (!(weaknessBarItem == null))
		{
			weaknessBarItem.Recovery();
			if (mBaseEntity != null)
			{
				mBaseEntity.GetSystem<WeaknessBarSystem>()?.HideWeaknessBar(GetData<bool>("IsBoss"), weaknessBarItem);
			}
			weaknessBarItem = null;
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		HideWeaknessBar();
		_isWeaknessTimer = true;
	}
}
