using System;
using System.Collections.Generic;
using System.Linq;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.Battle;

public class SystemProduct : EntitySystem
{
	public Dictionary<AbilityEntityType, float> productEntityCountLimit;

	public Dictionary<AbilityEntityType, float> productEntityCountAdd;

	public Dictionary<AbilityEntityType, float> productEntityCountMul;

	public List<AbilityEntityType> abilityEntityType;

	private const int LimitedProductBufferCapacity = 32;

	private static readonly AbilityEntityType[] LimitedProductTypes = new AbilityEntityType[8]
	{
		AbilityEntityType.Gravity,
		AbilityEntityType.Tear,
		AbilityEntityType.Shadow,
		AbilityEntityType.FollowDrones,
		AbilityEntityType.DefenceDrones,
		AbilityEntityType.FlyingThunderGod,
		AbilityEntityType.SpotLightDrone,
		AbilityEntityType.Fireball
	};

	private Filter _filter;

	private EntityAction<CompProduct> _fixedUpdateEntityAction;

	private Dictionary<AbilityEntityType, List<Entity>> _limitedProductBuffers;

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompProduct>().Build();
		_fixedUpdateEntityAction = FixedUpdateEntity;
		productEntityCountLimit = new Dictionary<AbilityEntityType, float>();
		productEntityCountAdd = new Dictionary<AbilityEntityType, float>();
		productEntityCountMul = new Dictionary<AbilityEntityType, float>();
		IEnumerable<AbilityEntityType> enumerable = Enum.GetValues(typeof(AbilityEntityType)).Cast<AbilityEntityType>();
		abilityEntityType = new List<AbilityEntityType>();
		foreach (AbilityEntityType item in enumerable)
		{
			abilityEntityType.Add(item);
		}
		foreach (AbilityEntityType item2 in abilityEntityType)
		{
			productEntityCountLimit[item2] = 0f;
			productEntityCountMul[item2] = 1f;
			productEntityCountAdd[item2] = 0f;
		}
		_limitedProductBuffers = new Dictionary<AbilityEntityType, List<Entity>>(LimitedProductTypes.Length);
		for (int i = 0; i < LimitedProductTypes.Length; i++)
		{
			_limitedProductBuffers[LimitedProductTypes[i]] = new List<Entity>(32);
		}
		if (!GameLoader.IsMetaLoaded)
		{
			UniTask.WaitUntil(() => GameLoader.IsMetaLoaded).GetAwaiter().OnCompleted(InitMeta);
		}
		else
		{
			InitMeta();
		}
	}

	private void InitMeta()
	{
		foreach (KeyValuePair<AbilityEntityType, int> item in GameLoader.meta.abilityEntityCountLimit)
		{
			productEntityCountLimit[item.Key] = item.Value;
		}
	}

	public override void FixedUpdate()
	{
		ClearLimitedProductBuffers();
		_filter.ForEach(_fixedUpdateEntityAction);
		TrimLimitedProducts();
	}

	private void FixedUpdateEntity(Entity entity, CompProduct compProduct)
	{
		if (compProduct.lifeTime > 0f)
		{
			compProduct.lifeTime -= entity.GetCompTime().fixedDeltaTime;
			if (compProduct.lifeTime <= 0f)
			{
				switch (compProduct.productLifeTimeMode)
				{
				case ProductLifeTimeMode.control:
					entity.KillEntity();
					return;
				case ProductLifeTimeMode.outOfContorl:
					compProduct.onOutOfControl?.Invoke(entity);
					break;
				}
			}
		}
		CollectLimitedProduct(entity, compProduct);
	}

	private void ClearLimitedProductBuffers()
	{
		for (int i = 0; i < LimitedProductTypes.Length; i++)
		{
			_limitedProductBuffers[LimitedProductTypes[i]].Clear();
		}
	}

	private void CollectLimitedProduct(Entity entity, CompProduct compProduct)
	{
		if (entity.IsAlive() && !compProduct.disengage && _limitedProductBuffers.TryGetValue(compProduct.AbilityEntityType, out var value))
		{
			value.Add(entity);
		}
	}

	private void TrimLimitedProducts()
	{
		for (int i = 0; i < LimitedProductTypes.Length; i++)
		{
			AbilityEntityType abilityEntityType = LimitedProductTypes[i];
			TrimLimitedProducts(abilityEntityType, _limitedProductBuffers[abilityEntityType]);
		}
	}

	private void TrimLimitedProducts(AbilityEntityType type, List<Entity> products)
	{
		if (products.Count == 0)
		{
			return;
		}
		float num = productEntityCountLimit[type] * productEntityCountMul[type] + productEntityCountAdd[type];
		if ((float)products.Count <= num)
		{
			return;
		}
		float num2 = (float)products.Count - num;
		if (!(num2 > 0f))
		{
			return;
		}
		for (int i = 0; i < products.Count; i++)
		{
			Entity entity = products[i];
			CompProduct compProduct = entity.GetCompProduct();
			if (compProduct.productLifeTimeMode == ProductLifeTimeMode.control)
			{
				entity.KillEntity();
			}
			else
			{
				compProduct.disengage = true;
				compProduct.onOutOfControl?.Invoke(entity);
			}
			num2--;
			if (num2 == 0f)
			{
				break;
			}
		}
	}

	private void OnAdd(Entity entity)
	{
	}

	public static void GetCasterProductEntity(Entity eb, ref List<Entity> list, bool isCaster = true)
	{
		list.Clear();
		foreach (Entity item in Singleton<GameManager>.instance.ecsManager.systemProduct._filter)
		{
			if (item.TryGetCompProduct(out CompProduct component))
			{
				Entity entity = (isCaster ? component.caster : component.productOwner);
				if (entity.IsValid && entity == eb)
				{
					list.Add(item);
				}
			}
		}
	}

	public void OperateDerivativeTypeForProduct(Func<Entity, bool> condition, DerivativeType target, bool isAttach)
	{
		foreach (Entity item in Singleton<GameManager>.instance.ecsManager.systemProduct._filter)
		{
			CompProduct compProduct = item.GetCompProduct();
			Entity caster = compProduct.caster;
			if (caster.IsValid && condition(item))
			{
				if (isAttach)
				{
					compProduct.derivativeType |= target;
				}
				else
				{
					compProduct.derivativeType &= ~target;
				}
			}
		}
	}

	public void OperateDerivativeSubTypeForProducts(Func<Entity, bool> condition, DerivativeSubType target, bool isAttach)
	{
		foreach (Entity item in Singleton<GameManager>.instance.ecsManager.systemProduct._filter)
		{
			CompProduct compProduct = item.GetCompProduct();
			Entity caster = compProduct.caster;
			if (caster.IsValid && condition(item))
			{
				if (isAttach)
				{
					compProduct.derivativeSubType |= target;
				}
				else
				{
					compProduct.derivativeSubType &= ~target;
				}
			}
		}
	}

	public static void EntityOperateDerivativeType(Entity entity, DerivativeType target, bool isAttach)
	{
		CompProduct compProduct = entity.GetCompProduct();
		if (isAttach)
		{
			compProduct.derivativeType |= target;
		}
		else
		{
			compProduct.derivativeType &= ~target;
		}
	}

	public static void EntityOperateDerivativeSubType(Entity entity, DerivativeSubType target, bool isAttach)
	{
		CompProduct compProduct = entity.GetCompProduct();
		if (isAttach)
		{
			compProduct.derivativeSubType |= target;
		}
		else
		{
			compProduct.derivativeSubType &= ~target;
		}
	}

	public static DerivativeType GetDefaultDerivativeType(AbilityEntityType entityType)
	{
		return GameLoader.meta.abilityEntityDerivativeType.GetValueOrDefault(entityType);
	}

	public static DerivativeSubType GetDefaultDerivativeSubType(AbilityEntityType entityType)
	{
		return GameLoader.meta.abilityEntityDerivativeSubType.GetValueOrDefault(entityType);
	}
}
