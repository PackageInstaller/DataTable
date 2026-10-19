using System;
using ACT.Battle;

namespace Bamboo.ECS;

public static class Entity_Extensions
{
	public static CompAbility? GetCompAbility(this Entity entity)
	{
		if (!entity.TryGetComponent<CompAbility>(out CompAbility component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompAbility(this Entity entity)
	{
		entity.AddComponent<CompAbility>();
		return entity;
	}

	public static bool HasCompAbility(this Entity entity)
	{
		return entity.HasComponent<CompAbility>();
	}

	public static Entity RemoveCompAbility(this Entity entity)
	{
		entity.RemoveComponent<CompAbility>();
		return entity;
	}

	public static bool TryGetCompAbility(this Entity entity, out CompAbility component)
	{
		return entity.TryGetComponent<CompAbility>(out component);
	}

	public static Entity IfHasCompAbility(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompAbility())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompAI? GetCompAI(this Entity entity)
	{
		if (!entity.TryGetComponent<CompAI>(out CompAI component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompAI(this Entity entity)
	{
		entity.AddComponent<CompAI>();
		return entity;
	}

	public static bool HasCompAI(this Entity entity)
	{
		return entity.HasComponent<CompAI>();
	}

	public static Entity RemoveCompAI(this Entity entity)
	{
		entity.RemoveComponent<CompAI>();
		return entity;
	}

	public static bool TryGetCompAI(this Entity entity, out CompAI component)
	{
		return entity.TryGetComponent<CompAI>(out component);
	}

	public static Entity IfHasCompAI(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompAI())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompAIInput? GetCompAIInput(this Entity entity)
	{
		if (!entity.TryGetComponent<CompAIInput>(out CompAIInput component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompAIInput(this Entity entity)
	{
		entity.AddComponent<CompAIInput>();
		return entity;
	}

	public static bool HasCompAIInput(this Entity entity)
	{
		return entity.HasComponent<CompAIInput>();
	}

	public static Entity RemoveCompAIInput(this Entity entity)
	{
		entity.RemoveComponent<CompAIInput>();
		return entity;
	}

	public static bool TryGetCompAIInput(this Entity entity, out CompAIInput component)
	{
		return entity.TryGetComponent<CompAIInput>(out component);
	}

	public static Entity IfHasCompAIInput(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompAIInput())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompAim? GetCompAim(this Entity entity)
	{
		if (!entity.TryGetComponent<CompAim>(out CompAim component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompAim(this Entity entity)
	{
		entity.AddComponent<CompAim>();
		return entity;
	}

	public static bool HasCompAim(this Entity entity)
	{
		return entity.HasComponent<CompAim>();
	}

	public static Entity RemoveCompAim(this Entity entity)
	{
		entity.RemoveComponent<CompAim>();
		return entity;
	}

	public static bool TryGetCompAim(this Entity entity, out CompAim component)
	{
		return entity.TryGetComponent<CompAim>(out component);
	}

	public static Entity IfHasCompAim(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompAim())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompAlliance? GetCompAlliance(this Entity entity)
	{
		if (!entity.TryGetComponent<CompAlliance>(out CompAlliance component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompAlliance(this Entity entity)
	{
		entity.AddComponent<CompAlliance>();
		return entity;
	}

	public static bool HasCompAlliance(this Entity entity)
	{
		return entity.HasComponent<CompAlliance>();
	}

	public static Entity RemoveCompAlliance(this Entity entity)
	{
		entity.RemoveComponent<CompAlliance>();
		return entity;
	}

	public static bool TryGetCompAlliance(this Entity entity, out CompAlliance component)
	{
		return entity.TryGetComponent<CompAlliance>(out component);
	}

	public static Entity IfHasCompAlliance(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompAlliance())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompAssistNpc? GetCompAssistNpc(this Entity entity)
	{
		if (!entity.TryGetComponent<CompAssistNpc>(out CompAssistNpc component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompAssistNpc(this Entity entity)
	{
		entity.AddComponent<CompAssistNpc>();
		return entity;
	}

	public static bool HasCompAssistNpc(this Entity entity)
	{
		return entity.HasComponent<CompAssistNpc>();
	}

	public static Entity RemoveCompAssistNpc(this Entity entity)
	{
		entity.RemoveComponent<CompAssistNpc>();
		return entity;
	}

	public static bool TryGetCompAssistNpc(this Entity entity, out CompAssistNpc component)
	{
		return entity.TryGetComponent<CompAssistNpc>(out component);
	}

	public static Entity IfHasCompAssistNpc(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompAssistNpc())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompBehave? GetCompBehave(this Entity entity)
	{
		if (!entity.TryGetComponent<CompBehave>(out CompBehave component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompBehave(this Entity entity)
	{
		entity.AddComponent<CompBehave>();
		return entity;
	}

	public static bool HasCompBehave(this Entity entity)
	{
		return entity.HasComponent<CompBehave>();
	}

	public static Entity RemoveCompBehave(this Entity entity)
	{
		entity.RemoveComponent<CompBehave>();
		return entity;
	}

	public static bool TryGetCompBehave(this Entity entity, out CompBehave component)
	{
		return entity.TryGetComponent<CompBehave>(out component);
	}

	public static Entity IfHasCompBehave(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompBehave())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompCharacter? GetCompCharacter(this Entity entity)
	{
		if (!entity.TryGetComponent<CompCharacter>(out CompCharacter component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompCharacter(this Entity entity)
	{
		entity.AddComponent<CompCharacter>();
		return entity;
	}

	public static bool HasCompCharacter(this Entity entity)
	{
		return entity.HasComponent<CompCharacter>();
	}

	public static Entity RemoveCompCharacter(this Entity entity)
	{
		entity.RemoveComponent<CompCharacter>();
		return entity;
	}

	public static bool TryGetCompCharacter(this Entity entity, out CompCharacter component)
	{
		return entity.TryGetComponent<CompCharacter>(out component);
	}

	public static Entity IfHasCompCharacter(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompCharacter())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompEffect? GetCompEffect(this Entity entity)
	{
		if (!entity.TryGetComponent<CompEffect>(out CompEffect component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompEffect(this Entity entity)
	{
		entity.AddComponent<CompEffect>();
		return entity;
	}

	public static bool HasCompEffect(this Entity entity)
	{
		return entity.HasComponent<CompEffect>();
	}

	public static Entity RemoveCompEffect(this Entity entity)
	{
		entity.RemoveComponent<CompEffect>();
		return entity;
	}

	public static bool TryGetCompEffect(this Entity entity, out CompEffect component)
	{
		return entity.TryGetComponent<CompEffect>(out component);
	}

	public static Entity IfHasCompEffect(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompEffect())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompFollow? GetCompFollow(this Entity entity)
	{
		if (!entity.TryGetComponent<CompFollow>(out CompFollow component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompFollow(this Entity entity)
	{
		entity.AddComponent<CompFollow>();
		return entity;
	}

	public static bool HasCompFollow(this Entity entity)
	{
		return entity.HasComponent<CompFollow>();
	}

	public static Entity RemoveCompFollow(this Entity entity)
	{
		entity.RemoveComponent<CompFollow>();
		return entity;
	}

	public static bool TryGetCompFollow(this Entity entity, out CompFollow component)
	{
		return entity.TryGetComponent<CompFollow>(out component);
	}

	public static Entity IfHasCompFollow(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompFollow())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompGas? GetCompGas(this Entity entity)
	{
		if (!entity.TryGetComponent<CompGas>(out CompGas component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompGas(this Entity entity)
	{
		entity.AddComponent<CompGas>();
		return entity;
	}

	public static bool HasCompGas(this Entity entity)
	{
		return entity.HasComponent<CompGas>();
	}

	public static Entity RemoveCompGas(this Entity entity)
	{
		entity.RemoveComponent<CompGas>();
		return entity;
	}

	public static bool TryGetCompGas(this Entity entity, out CompGas component)
	{
		return entity.TryGetComponent<CompGas>(out component);
	}

	public static Entity IfHasCompGas(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompGas())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompGroupAI? GetCompGroupAI(this Entity entity)
	{
		if (!entity.TryGetComponent<CompGroupAI>(out CompGroupAI component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompGroupAI(this Entity entity)
	{
		entity.AddComponent<CompGroupAI>();
		return entity;
	}

	public static bool HasCompGroupAI(this Entity entity)
	{
		return entity.HasComponent<CompGroupAI>();
	}

	public static Entity RemoveCompGroupAI(this Entity entity)
	{
		entity.RemoveComponent<CompGroupAI>();
		return entity;
	}

	public static bool TryGetCompGroupAI(this Entity entity, out CompGroupAI component)
	{
		return entity.TryGetComponent<CompGroupAI>(out component);
	}

	public static Entity IfHasCompGroupAI(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompGroupAI())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompHatred? GetCompHatred(this Entity entity)
	{
		if (!entity.TryGetComponent<CompHatred>(out CompHatred component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompHatred(this Entity entity)
	{
		entity.AddComponent<CompHatred>();
		return entity;
	}

	public static bool HasCompHatred(this Entity entity)
	{
		return entity.HasComponent<CompHatred>();
	}

	public static Entity RemoveCompHatred(this Entity entity)
	{
		entity.RemoveComponent<CompHatred>();
		return entity;
	}

	public static bool TryGetCompHatred(this Entity entity, out CompHatred component)
	{
		return entity.TryGetComponent<CompHatred>(out component);
	}

	public static Entity IfHasCompHatred(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompHatred())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompInput? GetCompInput(this Entity entity)
	{
		if (!entity.TryGetComponent<CompInput>(out CompInput component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompInput(this Entity entity)
	{
		entity.AddComponent<CompInput>();
		return entity;
	}

	public static bool HasCompInput(this Entity entity)
	{
		return entity.HasComponent<CompInput>();
	}

	public static Entity RemoveCompInput(this Entity entity)
	{
		entity.RemoveComponent<CompInput>();
		return entity;
	}

	public static bool TryGetCompInput(this Entity entity, out CompInput component)
	{
		return entity.TryGetComponent<CompInput>(out component);
	}

	public static Entity IfHasCompInput(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompInput())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompInteract? GetCompInteract(this Entity entity)
	{
		if (!entity.TryGetComponent<CompInteract>(out CompInteract component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompInteract(this Entity entity)
	{
		entity.AddComponent<CompInteract>();
		return entity;
	}

	public static bool HasCompInteract(this Entity entity)
	{
		return entity.HasComponent<CompInteract>();
	}

	public static Entity RemoveCompInteract(this Entity entity)
	{
		entity.RemoveComponent<CompInteract>();
		return entity;
	}

	public static bool TryGetCompInteract(this Entity entity, out CompInteract component)
	{
		return entity.TryGetComponent<CompInteract>(out component);
	}

	public static Entity IfHasCompInteract(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompInteract())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompLaser? GetCompLaser(this Entity entity)
	{
		if (!entity.TryGetComponent<CompLaser>(out CompLaser component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompLaser(this Entity entity)
	{
		entity.AddComponent<CompLaser>();
		return entity;
	}

	public static bool HasCompLaser(this Entity entity)
	{
		return entity.HasComponent<CompLaser>();
	}

	public static Entity RemoveCompLaser(this Entity entity)
	{
		entity.RemoveComponent<CompLaser>();
		return entity;
	}

	public static bool TryGetCompLaser(this Entity entity, out CompLaser component)
	{
		return entity.TryGetComponent<CompLaser>(out component);
	}

	public static Entity IfHasCompLaser(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompLaser())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompLocalInput? GetCompLocalInput(this Entity entity)
	{
		if (!entity.TryGetComponent<CompLocalInput>(out CompLocalInput component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompLocalInput(this Entity entity)
	{
		entity.AddComponent<CompLocalInput>();
		return entity;
	}

	public static bool HasCompLocalInput(this Entity entity)
	{
		return entity.HasComponent<CompLocalInput>();
	}

	public static Entity RemoveCompLocalInput(this Entity entity)
	{
		entity.RemoveComponent<CompLocalInput>();
		return entity;
	}

	public static bool TryGetCompLocalInput(this Entity entity, out CompLocalInput component)
	{
		return entity.TryGetComponent<CompLocalInput>(out component);
	}

	public static Entity IfHasCompLocalInput(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompLocalInput())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompMonster? GetCompMonster(this Entity entity)
	{
		if (!entity.TryGetComponent<CompMonster>(out CompMonster component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompMonster(this Entity entity)
	{
		entity.AddComponent<CompMonster>();
		return entity;
	}

	public static bool HasCompMonster(this Entity entity)
	{
		return entity.HasComponent<CompMonster>();
	}

	public static Entity RemoveCompMonster(this Entity entity)
	{
		entity.RemoveComponent<CompMonster>();
		return entity;
	}

	public static bool TryGetCompMonster(this Entity entity, out CompMonster component)
	{
		return entity.TryGetComponent<CompMonster>(out component);
	}

	public static Entity IfHasCompMonster(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompMonster())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompMonsterNew? GetCompMonsterNew(this Entity entity)
	{
		if (!entity.TryGetComponent<CompMonsterNew>(out CompMonsterNew component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompMonsterNew(this Entity entity)
	{
		entity.AddComponent<CompMonsterNew>();
		return entity;
	}

	public static bool HasCompMonsterNew(this Entity entity)
	{
		return entity.HasComponent<CompMonsterNew>();
	}

	public static Entity RemoveCompMonsterNew(this Entity entity)
	{
		entity.RemoveComponent<CompMonsterNew>();
		return entity;
	}

	public static bool TryGetCompMonsterNew(this Entity entity, out CompMonsterNew component)
	{
		return entity.TryGetComponent<CompMonsterNew>(out component);
	}

	public static Entity IfHasCompMonsterNew(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompMonsterNew())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompMotion? GetCompMotion(this Entity entity)
	{
		if (!entity.TryGetComponent<CompMotion>(out CompMotion component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompMotion(this Entity entity)
	{
		entity.AddComponent<CompMotion>();
		return entity;
	}

	public static bool HasCompMotion(this Entity entity)
	{
		return entity.HasComponent<CompMotion>();
	}

	public static Entity RemoveCompMotion(this Entity entity)
	{
		entity.RemoveComponent<CompMotion>();
		return entity;
	}

	public static bool TryGetCompMotion(this Entity entity, out CompMotion component)
	{
		return entity.TryGetComponent<CompMotion>(out component);
	}

	public static Entity IfHasCompMotion(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompMotion())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompNav? GetCompNav(this Entity entity)
	{
		if (!entity.TryGetComponent<CompNav>(out CompNav component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompNav(this Entity entity)
	{
		entity.AddComponent<CompNav>();
		return entity;
	}

	public static bool HasCompNav(this Entity entity)
	{
		return entity.HasComponent<CompNav>();
	}

	public static Entity RemoveCompNav(this Entity entity)
	{
		entity.RemoveComponent<CompNav>();
		return entity;
	}

	public static bool TryGetCompNav(this Entity entity, out CompNav component)
	{
		return entity.TryGetComponent<CompNav>(out component);
	}

	public static Entity IfHasCompNav(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompNav())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompNeutral? GetCompNeutral(this Entity entity)
	{
		if (!entity.TryGetComponent<CompNeutral>(out CompNeutral component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompNeutral(this Entity entity)
	{
		entity.AddComponent<CompNeutral>();
		return entity;
	}

	public static bool HasCompNeutral(this Entity entity)
	{
		return entity.HasComponent<CompNeutral>();
	}

	public static Entity RemoveCompNeutral(this Entity entity)
	{
		entity.RemoveComponent<CompNeutral>();
		return entity;
	}

	public static bool TryGetCompNeutral(this Entity entity, out CompNeutral component)
	{
		return entity.TryGetComponent<CompNeutral>(out component);
	}

	public static Entity IfHasCompNeutral(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompNeutral())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompNpc? GetCompNpc(this Entity entity)
	{
		if (!entity.TryGetComponent<CompNpc>(out CompNpc component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompNpc(this Entity entity)
	{
		entity.AddComponent<CompNpc>();
		return entity;
	}

	public static bool HasCompNpc(this Entity entity)
	{
		return entity.HasComponent<CompNpc>();
	}

	public static Entity RemoveCompNpc(this Entity entity)
	{
		entity.RemoveComponent<CompNpc>();
		return entity;
	}

	public static bool TryGetCompNpc(this Entity entity, out CompNpc component)
	{
		return entity.TryGetComponent<CompNpc>(out component);
	}

	public static Entity IfHasCompNpc(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompNpc())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompPhysics? GetCompPhysics(this Entity entity)
	{
		if (!entity.TryGetComponent<CompPhysics>(out CompPhysics component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompPhysics(this Entity entity)
	{
		entity.AddComponent<CompPhysics>();
		return entity;
	}

	public static bool HasCompPhysics(this Entity entity)
	{
		return entity.HasComponent<CompPhysics>();
	}

	public static Entity RemoveCompPhysics(this Entity entity)
	{
		entity.RemoveComponent<CompPhysics>();
		return entity;
	}

	public static bool TryGetCompPhysics(this Entity entity, out CompPhysics component)
	{
		return entity.TryGetComponent<CompPhysics>(out component);
	}

	public static Entity IfHasCompPhysics(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompPhysics())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompProduct? GetCompProduct(this Entity entity)
	{
		if (!entity.TryGetComponent<CompProduct>(out CompProduct component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompProduct(this Entity entity)
	{
		entity.AddComponent<CompProduct>();
		return entity;
	}

	public static bool HasCompProduct(this Entity entity)
	{
		return entity.HasComponent<CompProduct>();
	}

	public static Entity RemoveCompProduct(this Entity entity)
	{
		entity.RemoveComponent<CompProduct>();
		return entity;
	}

	public static bool TryGetCompProduct(this Entity entity, out CompProduct component)
	{
		return entity.TryGetComponent<CompProduct>(out component);
	}

	public static Entity IfHasCompProduct(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompProduct())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompRobot? GetCompRobot(this Entity entity)
	{
		if (!entity.TryGetComponent<CompRobot>(out CompRobot component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompRobot(this Entity entity)
	{
		entity.AddComponent<CompRobot>();
		return entity;
	}

	public static bool HasCompRobot(this Entity entity)
	{
		return entity.HasComponent<CompRobot>();
	}

	public static Entity RemoveCompRobot(this Entity entity)
	{
		entity.RemoveComponent<CompRobot>();
		return entity;
	}

	public static bool TryGetCompRobot(this Entity entity, out CompRobot component)
	{
		return entity.TryGetComponent<CompRobot>(out component);
	}

	public static Entity IfHasCompRobot(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompRobot())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompSound? GetCompSound(this Entity entity)
	{
		if (!entity.TryGetComponent<CompSound>(out CompSound component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompSound(this Entity entity)
	{
		entity.AddComponent<CompSound>();
		return entity;
	}

	public static bool HasCompSound(this Entity entity)
	{
		return entity.HasComponent<CompSound>();
	}

	public static Entity RemoveCompSound(this Entity entity)
	{
		entity.RemoveComponent<CompSound>();
		return entity;
	}

	public static bool TryGetCompSound(this Entity entity, out CompSound component)
	{
		return entity.TryGetComponent<CompSound>(out component);
	}

	public static Entity IfHasCompSound(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompSound())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompSpotLightBuffer? GetCompSpotLightBuffer(this Entity entity)
	{
		if (!entity.TryGetComponent<CompSpotLightBuffer>(out CompSpotLightBuffer component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompSpotLightBuffer(this Entity entity)
	{
		entity.AddComponent<CompSpotLightBuffer>();
		return entity;
	}

	public static bool HasCompSpotLightBuffer(this Entity entity)
	{
		return entity.HasComponent<CompSpotLightBuffer>();
	}

	public static Entity RemoveCompSpotLightBuffer(this Entity entity)
	{
		entity.RemoveComponent<CompSpotLightBuffer>();
		return entity;
	}

	public static bool TryGetCompSpotLightBuffer(this Entity entity, out CompSpotLightBuffer component)
	{
		return entity.TryGetComponent<CompSpotLightBuffer>(out component);
	}

	public static Entity IfHasCompSpotLightBuffer(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompSpotLightBuffer())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompStateObject? GetCompStateObject(this Entity entity)
	{
		if (!entity.TryGetComponent<CompStateObject>(out CompStateObject component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompStateObject(this Entity entity)
	{
		entity.AddComponent<CompStateObject>();
		return entity;
	}

	public static bool HasCompStateObject(this Entity entity)
	{
		return entity.HasComponent<CompStateObject>();
	}

	public static Entity RemoveCompStateObject(this Entity entity)
	{
		entity.RemoveComponent<CompStateObject>();
		return entity;
	}

	public static bool TryGetCompStateObject(this Entity entity, out CompStateObject component)
	{
		return entity.TryGetComponent<CompStateObject>(out component);
	}

	public static Entity IfHasCompStateObject(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompStateObject())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompTime? GetCompTime(this Entity entity)
	{
		if (!entity.TryGetComponent<CompTime>(out CompTime component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompTime(this Entity entity)
	{
		entity.AddComponent<CompTime>();
		return entity;
	}

	public static bool HasCompTime(this Entity entity)
	{
		return entity.HasComponent<CompTime>();
	}

	public static Entity RemoveCompTime(this Entity entity)
	{
		entity.RemoveComponent<CompTime>();
		return entity;
	}

	public static bool TryGetCompTime(this Entity entity, out CompTime component)
	{
		return entity.TryGetComponent<CompTime>(out component);
	}

	public static Entity IfHasCompTime(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompTime())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompTrajectory? GetCompTrajectory(this Entity entity)
	{
		if (!entity.TryGetComponent<CompTrajectory>(out CompTrajectory component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompTrajectory(this Entity entity)
	{
		entity.AddComponent<CompTrajectory>();
		return entity;
	}

	public static bool HasCompTrajectory(this Entity entity)
	{
		return entity.HasComponent<CompTrajectory>();
	}

	public static Entity RemoveCompTrajectory(this Entity entity)
	{
		entity.RemoveComponent<CompTrajectory>();
		return entity;
	}

	public static bool TryGetCompTrajectory(this Entity entity, out CompTrajectory component)
	{
		return entity.TryGetComponent<CompTrajectory>(out component);
	}

	public static Entity IfHasCompTrajectory(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompTrajectory())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompTransform? GetCompTransform(this Entity entity)
	{
		if (!entity.TryGetComponent<CompTransform>(out CompTransform component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompTransform(this Entity entity)
	{
		entity.AddComponent<CompTransform>();
		return entity;
	}

	public static bool HasCompTransform(this Entity entity)
	{
		return entity.HasComponent<CompTransform>();
	}

	public static Entity RemoveCompTransform(this Entity entity)
	{
		entity.RemoveComponent<CompTransform>();
		return entity;
	}

	public static bool TryGetCompTransform(this Entity entity, out CompTransform component)
	{
		return entity.TryGetComponent<CompTransform>(out component);
	}

	public static Entity IfHasCompTransform(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompTransform())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompTrigger? GetCompTrigger(this Entity entity)
	{
		if (!entity.TryGetComponent<CompTrigger>(out CompTrigger component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompTrigger(this Entity entity)
	{
		entity.AddComponent<CompTrigger>();
		return entity;
	}

	public static bool HasCompTrigger(this Entity entity)
	{
		return entity.HasComponent<CompTrigger>();
	}

	public static Entity RemoveCompTrigger(this Entity entity)
	{
		entity.RemoveComponent<CompTrigger>();
		return entity;
	}

	public static bool TryGetCompTrigger(this Entity entity, out CompTrigger component)
	{
		return entity.TryGetComponent<CompTrigger>(out component);
	}

	public static Entity IfHasCompTrigger(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompTrigger())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompVelocity? GetCompVelocity(this Entity entity)
	{
		if (!entity.TryGetComponent<CompVelocity>(out CompVelocity component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompVelocity(this Entity entity)
	{
		entity.AddComponent<CompVelocity>();
		return entity;
	}

	public static bool HasCompVelocity(this Entity entity)
	{
		return entity.HasComponent<CompVelocity>();
	}

	public static Entity RemoveCompVelocity(this Entity entity)
	{
		entity.RemoveComponent<CompVelocity>();
		return entity;
	}

	public static bool TryGetCompVelocity(this Entity entity, out CompVelocity component)
	{
		return entity.TryGetComponent<CompVelocity>(out component);
	}

	public static Entity IfHasCompVelocity(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompVelocity())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompBubble? GetCompBubble(this Entity entity)
	{
		if (!entity.TryGetComponent<CompBubble>(out CompBubble component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompBubble(this Entity entity)
	{
		entity.AddComponent<CompBubble>();
		return entity;
	}

	public static bool HasCompBubble(this Entity entity)
	{
		return entity.HasComponent<CompBubble>();
	}

	public static Entity RemoveCompBubble(this Entity entity)
	{
		entity.RemoveComponent<CompBubble>();
		return entity;
	}

	public static bool TryGetCompBubble(this Entity entity, out CompBubble component)
	{
		return entity.TryGetComponent<CompBubble>(out component);
	}

	public static Entity IfHasCompBubble(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompBubble())
		{
			action?.Invoke(entity);
		}
		return entity;
	}

	public static CompOperateBtn? GetCompOperateBtn(this Entity entity)
	{
		if (!entity.TryGetComponent<CompOperateBtn>(out CompOperateBtn component))
		{
			return null;
		}
		return component;
	}

	public static Entity AddCompOperateBtn(this Entity entity)
	{
		entity.AddComponent<CompOperateBtn>();
		return entity;
	}

	public static bool HasCompOperateBtn(this Entity entity)
	{
		return entity.HasComponent<CompOperateBtn>();
	}

	public static Entity RemoveCompOperateBtn(this Entity entity)
	{
		entity.RemoveComponent<CompOperateBtn>();
		return entity;
	}

	public static bool TryGetCompOperateBtn(this Entity entity, out CompOperateBtn component)
	{
		return entity.TryGetComponent<CompOperateBtn>(out component);
	}

	public static Entity IfHasCompOperateBtn(this Entity entity, Action<Entity> action)
	{
		if (entity.HasCompOperateBtn())
		{
			action?.Invoke(entity);
		}
		return entity;
	}
}
