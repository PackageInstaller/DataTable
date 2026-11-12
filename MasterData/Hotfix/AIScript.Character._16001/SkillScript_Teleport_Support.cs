using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16001;

public class SkillScript_Teleport_Support : SkillAdvancedBase
{
	private bool _hasTeleport;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.logicVariable.ToggleLogicTag("CanTrace_Teleport", value: false);
		_hasTeleport = false;
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("160_Sup_Transmit", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Event_160_Sup_CloseArea"))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = Config_Support.eventHashCode_CloseAreaEffect;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		if (string.Equals(eventName, "Event_160_Sup_Transmit"))
		{
			Teleport();
		}
	}

	private void Teleport()
	{
		if (!_hasTeleport)
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			TSVector2 result = ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Circle,
				position = activedPlayerActor.tsTransform.Position,
				innerRadius = activedPlayerActor.GetRadius(),
				radius = Config_Support.randomRadius_Teleport
			});
			if (!_actor.QueryPositionWalkable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			_actor.Teleport(result);
			_actor.logicVariable.ToggleLogicTag("CanTrace_Teleport", value: true);
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = Config_Support.eventHashCode_TeleportFinish;
			_actor.DispatchEvent(adventureActorCustomEvent);
			_hasTeleport = true;
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (!_hasTeleport)
		{
			Teleport();
		}
		_actor.logicVariable.ToggleLogicTag("CanTrace_Teleport", value: false);
		_hasTeleport = false;
	}
}
