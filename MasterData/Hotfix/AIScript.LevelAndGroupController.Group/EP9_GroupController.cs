using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.LevelAndGroupController.Group;

public class EP9_GroupController : GroupControllerBase
{
	private bool CanSummon;

	private PlayFX _sandStormFX;

	protected override void OnStart()
	{
		base.OnStart();
		(GetCurrentPlayer() as AdventureActor).LockHpAbs(1L);
		CanSummon = true;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_HP_CHANGED", OnHPchanged);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("INTERACTIVEID", OnGetInteractiveId);
	}

	protected override void OnStop()
	{
		base.OnStop();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_HP_CHANGED", OnHPchanged);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("INTERACTIVEID", OnGetInteractiveId);
		_sandStormFX?.Stop();
		_sandStormFX = null;
	}

	private void OnHPchanged(IEvent iEvt)
	{
		AdventureActor adventureActor = ((AdventureActorHpChangedEvent)iEvt).sender as AdventureActor;
		if (adventureActor == GetCurrentPlayer() && adventureActor.actorHealthInfo.hpPercentage <= (FP)0.3 && CanSummon)
		{
			TriggerOpListener("CureHuifeng");
			LogicEntity logicEntity = adventureActor;
			TSVector2 entityPosition = GetEntityPosition(logicEntity, logicEntity);
			FP radius = 5;
			FP innerRadius = 4;
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, adventureActor, isReachable: true);
			SummonMonster(adventureActor, 1900111, shapeRandomPoint, GetEntityPosition(logicEntity, logicEntity) - shapeRandomPoint);
			StartCor(CoundDown());
		}
	}

	private IEnumerator CoundDown()
	{
		CanSummon = false;
		yield return WaitTime(3);
		CanSummon = true;
	}

	private void OnGetInteractiveId(IEvent iEvt)
	{
		AdventureInteractiveIDTrigger adventureInteractiveIDTrigger = (AdventureInteractiveIDTrigger)iEvt;
		if (adventureInteractiveIDTrigger.interactiveID == "StartDustStorm")
		{
			_sandStormFX = new PlayFX();
			_sandStormFX.Play(GetCurrentPlayer() as AdventureActor, null, "Environment/Desert/FX/fx_screen_sendwind_change90_1", default, TSVector2.zero, default);
		}
		else if (adventureInteractiveIDTrigger.interactiveID == "ChangeDustStorm")
		{
			_sandStormFX?.Stop();
		}
	}
}
