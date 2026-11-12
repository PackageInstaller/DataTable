using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/间歇生成区域效果")]
public class WeaponFeatureIntermittentTriggerAreaEffect : WeaponFeature
{
	public bool isBindWeaponLifeCycle;

	public FP delay;

	public bool isIntermittent;

	public FP interval = 0.3f;

	[Space]
	public GameObject areaEffectPrefab;

	private FP _elapsed;

	private bool _isTriggered;

	private bool _isFinish;

	private List<long> _areaEffectIds;

	private FP _defaultTerrainHeight;

	public override void OnStart()
	{
		base.OnStart();
		_defaultTerrainHeight = CommonHelper.GetTerrainHeight(attachedWeapon.tsTransform.Position, attachedWeapon.tsTransform.PositionY, out var raycastHit);
		if (!raycastHit)
		{
			_defaultTerrainHeight = attachedWeapon.owner.tsTransform.PositionY;
		}
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		if (_isFinish)
		{
			return;
		}
		_elapsed += attachedWeapon.LogicDeltaTime;
		if (!_isTriggered && _elapsed < delay)
		{
			return;
		}
		if (!_isTriggered)
		{
			OnExecute();
			_isTriggered = true;
			_elapsed = 0;
			if (!isIntermittent)
			{
				_isFinish = true;
			}
		}
		if (_elapsed >= interval)
		{
			_elapsed = 0;
			OnExecute();
		}
	}

	public override bool OnEnd()
	{
		_elapsed = 0;
		_isTriggered = false;
		_isFinish = false;
		List<long> areaEffectIds = _areaEffectIds;
		if (areaEffectIds != null && areaEffectIds.Count > 0)
		{
			foreach (long areaEffectId in _areaEffectIds)
			{
				SceneSingleton<AreaEffectManager>.Instance.StopAreaEffect(areaEffectId);
			}
			_areaEffectIds.Clear();
			_areaEffectIds = null;
		}
		return base.OnEnd();
	}

	private void OnExecute()
	{
		AdventureActor adventureActor = attachedWeapon.owner as AdventureActor;
		if (areaEffectPrefab == null || adventureActor == null)
		{
			return;
		}
		FP fP = CommonHelper.GetTerrainHeight(attachedWeapon.tsTransform.Position, attachedWeapon.tsTransform.PositionY, out var raycastHit);
		if (!raycastHit)
		{
			fP = _defaultTerrainHeight;
		}
		Vector3 spawnPosition = new Vector3((float)attachedWeapon.tsTransform.Position.x, (float)fP, (float)attachedWeapon.tsTransform.Position.y);
		long item = SceneSingleton<AreaEffectManager>.Instance.PlayAreaEffect(adventureActor, areaEffectPrefab, spawnPosition, attachedWeapon.transform.rotation);
		if (isBindWeaponLifeCycle)
		{
			if (_areaEffectIds == null)
			{
				_areaEffectIds = new List<long>();
			}
			_areaEffectIds.Add(item);
		}
	}
}
