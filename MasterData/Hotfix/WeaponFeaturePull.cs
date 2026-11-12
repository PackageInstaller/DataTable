using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/牵引力")]
[DisallowMultipleComponent]
public class WeaponFeaturePull : WeaponFeature
{
	[HideInInspector]
	public bool isPull = true;

	public FP pullInterval = 0.1;

	public FP pullRange = 3;

	public FP pullSpeed = 3;

	public int pullLevel = 99;

	public FP strength = 4;

	public bool pullWithRadius;

	public bool changeTargetDirection = true;

	protected FP _pullTime;

	public override void OnActive()
	{
		base.OnActive();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("TRIGGER_BULLUT_FINISH", OnBullutFinish);
		_pullTime = 0;
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_BULLUT_FINISH", OnBullutFinish);
	}

	public void OnBullutFinish(IEvent evt)
	{
		if (evt is AdventureBullutFinishTrigger adventureBullutFinishTrigger && adventureBullutFinishTrigger.actor == attachedWeapon.owner)
		{
			attachedWeapon.Finish();
		}
	}

	public override void OnUpdate()
	{
		if (isPull && !(pullInterval <= 0))
		{
			FP logicDeltaTime = attachedWeapon.LogicDeltaTime;
			_pullTime -= logicDeltaTime;
			if (!(_pullTime > 0))
			{
				ILRuntimeAPI.SearchByRangeAndPosition(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor, attachedWeapon.tsTransform.Position, pullRange, Pull, isConfront: true);
				_pullTime = pullInterval;
			}
		}
	}

	protected void Pull(List<LogicEntity> targets)
	{
		if (targets != null && targets.Count > 0)
		{
			targets.RemoveAll((LogicEntity target) => !CheckEntitySearchable(target));
			FP distance = pullSpeed * pullInterval;
			ILRuntimeAPI.ForceMoveByDistanceToPosition(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor, attachedWeapon.tsTransform.Position, targets, distance, pullSpeed, strength, pullLevel, isPull: true, pullWithRadius, isCoExist: true, changeTargetDirection);
		}
	}
}
