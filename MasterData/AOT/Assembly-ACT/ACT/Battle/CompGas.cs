using ACT.GameplayAbilitySystem;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public class CompGas : EcsComponent, IGameplayComponent
{
	public bool IsInitialized { get; private set; }

	public bool IsActive { get; private set; }

	public GameplayAbilityContainer GameplayAbilityContainer { get; private set; }

	public GameplayEffectContainer GameplayEffectContainer { get; private set; }

	public AttributeContainer AttributeContainer { get; private set; }

	public GameplayTagAggregator GameplayTagAggregator { get; private set; }

	public float TickTime => owner.GetCompTime()?.fixedDeltaTime ?? 0f;

	internal Entity OwnerEntity => owner;

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
	}

	public void OnCreate()
	{
		GameplayAbilityContainer = new GameplayAbilityContainer(this);
		GameplayEffectContainer = new GameplayEffectContainer(this);
		AttributeContainer = new AttributeContainer(this);
		GameplayTagAggregator = new GameplayTagAggregator(this);
		IsInitialized = true;
	}

	public void OnDestroy()
	{
		GameplayAbilityContainer.Dispose();
		GameplayEffectContainer.Dispose();
		AttributeContainer.Dispose();
		GameplayTagAggregator.Dispose();
		IsInitialized = false;
	}

	public void OnActive()
	{
		IsActive = true;
	}

	public void OnUnactive()
	{
		IsActive = false;
	}

	public void Tick()
	{
		if (IsActive)
		{
			GameplayAbilityContainer.Tick();
			GameplayEffectContainer.Tick();
		}
	}

	public bool HasTag(GameplayTagCount gameplayTag)
	{
		return GameplayTagAggregator.HasTag(gameplayTag);
	}

	public bool HasAllTags(GameplayTagSet tags)
	{
		return GameplayTagAggregator.HasAllTags(tags);
	}

	public bool HasAnyTags(GameplayTagSet tags)
	{
		return GameplayTagAggregator.HasAnyTags(tags);
	}

	public bool HasNoneTags(GameplayTagSet tags)
	{
		return GameplayTagAggregator.HasNoneTags(tags);
	}

	public void CompDispatchEvent(IGameplayEvent @event, GasContext context)
	{
		if (@event.CanDispatchOwner(this, context))
		{
			GameplayAbilityContainer.DispatchEvent(@event, context);
		}
		GameplayAbilityContainer.DispatchGlobalEvent(@event, context);
	}

	public void AddGameplayAbility(IGameplayAbilityData abilityData, GasContext context)
	{
		GameplayAbilityContainer.AddAbility(abilityData, context);
	}

	public void RemoveGameplayAbility(string abilityName, GasContext context)
	{
		GameplayAbilityContainer.RemoveAbility(abilityName, context);
	}

	public bool HasGameplayAbility(string abilityName)
	{
		return GameplayAbilityContainer.HasAbility(abilityName);
	}

	public GameplayEffect AddGameplayEffectTo(GameplayEffect gameplayEffect, IGameplayComponent target, GasContext context)
	{
		context.Target = target;
		if (target is CompGas compGas)
		{
			compGas.OwnerEntity.WakeTick();
		}
		return target.AddGameplayEffect(gameplayEffect, context);
	}

	public GameplayEffect AddGameplayEffect(GameplayEffect gameplayEffect, GasContext context)
	{
		if (context.Ability != null)
		{
			return context.Ability.AbilityAddGameplayEffect(gameplayEffect, context);
		}
		return GameplayEffectContainer.AddEffect(gameplayEffect, context);
	}

	public bool HasGameplayEffect(string gameplayEffect)
	{
		GameplayEffect gameplayEffect2;
		return GameplayEffectContainer.TryGetGameplayEffect(gameplayEffect, out gameplayEffect2);
	}

	public int GetGameplayEffectStack(string gameplayEffect)
	{
		if (!GameplayEffectContainer.TryGetGameplayEffect(gameplayEffect, out var gameplayEffect2))
		{
			return 0;
		}
		return gameplayEffect2.StackCount;
	}

	public void RemoveGameplayEffect(GameplayEffect gameplayEffect, GasContext context)
	{
		GameplayEffectContainer.RemoveGameplayEffect(gameplayEffect, context);
	}

	public void AddAttributes(IAttributesConfig config)
	{
		AttributeContainer.AddAttributes(config);
	}

	public float? GetAttributeValue(string attributeName)
	{
		return AttributeContainer.GetAttributeValue(attributeName);
	}

	public T GetGameplayEvent<T>() where T : class, IGameplayEvent, new()
	{
		return Singleton<GameManager>.instance.ecsManager.systemGas.GetGameplayEvent<T>();
	}

	public void RecycleGameplayEvent<T>(T eventToRecycle) where T : class, IGameplayEvent, new()
	{
		Singleton<GameManager>.instance.ecsManager.systemGas.RecycleGameplayEvent(eventToRecycle);
	}

	public void DispatchEvent(IGameplayEvent evt, GasContext context)
	{
		Singleton<GameManager>.instance.ecsManager.systemGas.DispatchEvent(evt, context);
	}

	public void DispatchEvent(IGameplayEvent evt, IGameplayComponent instigator, IGameplayComponent owner, IGameplayComponent target, GameplayAbility ability, GameplayEffect effect)
	{
		Singleton<GameManager>.instance.ecsManager.systemGas.DispatchEvent(evt, instigator, owner, target, ability, effect);
	}
}
