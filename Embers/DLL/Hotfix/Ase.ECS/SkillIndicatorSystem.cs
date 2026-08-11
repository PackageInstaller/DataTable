using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class SkillIndicatorSystem : BaseSystem
{
	private readonly int skillRangeIndicatorIndex;

	private int serialId;

	private Dictionary<int, IObjectPool<GameObject>> indicatorPools = new Dictionary<int, IObjectPool<GameObject>>();

	private Dictionary<int, SkillIndicatorEntity> executeSkillIndicators = new Dictionary<int, SkillIndicatorEntity>();

	private int curIndicatorSkinId;

	private int curHeroId;

	protected override bool IsLogicSystem => false;

	public override async UniTask<bool> OnGamePreparationEnd(object data = null)
	{
		return await InitAllIndicators(data);
	}

	private async UniTask<bool> InitAllIndicators(object data)
	{
		var (heroId, skinId) = GetActorHeroAndSkin();
		return await LoadIndicators(heroId, skinId);
	}

	private HeroEntity GetActorHeroEntity()
	{
		if (world == null)
		{
			return null;
		}
		int actorId = world.ActorId;
		EntitySystem system = GetSystem<EntitySystem>();
		if (system == null)
		{
			return null;
		}
		BaseEntity entity = system.GetEntity(actorId, isGetCache: true);
		if (entity == null)
		{
			return null;
		}
		return entity as HeroEntity;
	}

	private (int heroId, int skinId) GetActorHeroAndSkin()
	{
		HeroEntity actorHeroEntity = GetActorHeroEntity();
		if (actorHeroEntity == null)
		{
			return (heroId: 0, skinId: 0);
		}
		int id = actorHeroEntity.BattleHeroData.HeroModel.Id;
		int item = 0;
		if (actorHeroEntity.BattleHeroData.HeroModel.IsSkin)
		{
			item = actorHeroEntity.BattleHeroData.HeroModel.SkinConfigId;
		}
		return (heroId: id, skinId: item);
	}

	public async UniTask ChangeEntityLoadIndicators(int heroId, int skinId)
	{
		if (skinId == curIndicatorSkinId && curHeroId == heroId)
		{
			return;
		}
		if (indicatorPools != null)
		{
			foreach (KeyValuePair<int, IObjectPool<GameObject>> indicatorPool in indicatorPools)
			{
				indicatorPool.Value.Dispose();
			}
			indicatorPools.Clear();
		}
		await LoadIndicators(heroId, skinId);
	}

	private async UniTask<bool> LoadIndicators(int heroId, int skinId)
	{
		curIndicatorSkinId = skinId;
		curHeroId = heroId;
		DRHero dataRow = GameEntry.DataTable.GetDataRow<DRHero>(heroId);
		if (dataRow == null)
		{
			return false;
		}
		List<int> indicatorGroup = dataRow.IndicatorGroup;
		if (indicatorGroup == null || indicatorGroup.Count == 0)
		{
			return true;
		}
		for (int i = 0; i < indicatorGroup.Count; i++)
		{
			int id = indicatorGroup[i];
			DRIndicatorType indicatorType = GameEntry.DataTable.GetDataRow<DRIndicatorType>(id);
			if (indicatorType == null)
			{
				continue;
			}
			string indicatorPath = indicatorType.AssetPath;
			if (skinId != 0)
			{
				int num = indicatorType.SkinId.IndexOf(skinId);
				if (num != -1 && indicatorType.SkinIndicatorAssetPath.Count > num)
				{
					indicatorPath = indicatorType.SkinIndicatorAssetPath[num];
				}
			}
			indicatorPath = AssetUtility.GetEntityAsset(indicatorPath);
			GameObject gameObject = await GetSystem<GameResourceSystem>().LoadAssetAsync<GameObject>(indicatorPath);
			indicatorPools.Add(indicatorType.Id, new ObjectPool<GameObject>(new SkillIndicatorViewFactory(indicatorPath, gameObject, world.SkillIndicatorRoot), 4));
			if (gameObject == null)
			{
				return false;
			}
		}
		return true;
	}

	public override void OnUpdate(float deltaTime)
	{
		lock (executeSkillIndicators)
		{
			foreach (SkillIndicatorEntity value in executeSkillIndicators.Values)
			{
				value.OnUpdate(deltaTime);
			}
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		lock (executeSkillIndicators)
		{
			foreach (SkillIndicatorEntity value in executeSkillIndicators.Values)
			{
				value.OnFixedUpdate(deltaTime);
			}
		}
	}

	public SkillIndicatorEntity GetSkillIndicatorEntity(BaseEntity entity, int skillid)
	{
		foreach (SkillIndicatorEntity value in executeSkillIndicators.Values)
		{
			if (value.IndicatorData.SkillId == skillid && value.BindEntity == entity)
			{
				return value;
			}
		}
		return null;
	}

	public SkillIndicatorEntity CreateSkillIndicatorEntity(SkillIndicatorData data, int entityId, Vector3? angleDir)
	{
		int num = ++serialId;
		BaseEntity entity = GetSystem<EntitySystem>().GetEntity(entityId);
		if (entity == null)
		{
			return null;
		}
		SkillIndicatorEntity skillIndicatorEntity = ReferencePool.Acquire<SkillIndicatorEntity>();
		skillIndicatorEntity.InitData(num, data, entity);
		if (data.SkillRange > 0f)
		{
			indicatorPools.TryGetValue(skillRangeIndicatorIndex, out var value);
			if (value != null)
			{
				skillIndicatorEntity.AddSkillRangeIndicator(value.Allocate().GetComponent<SkillIndicatorView>());
			}
		}
		if (data.SkillWidth > 0f)
		{
			indicatorPools.TryGetValue(data.Type, out var value2);
			if (value2 != null)
			{
				skillIndicatorEntity.AddSkillDirectionIndicator(value2.Allocate().GetComponent<SkillIndicatorView>());
			}
		}
		lock (executeSkillIndicators)
		{
			executeSkillIndicators.Add(num, skillIndicatorEntity);
		}
		skillIndicatorEntity.Show(angleDir);
		return skillIndicatorEntity;
	}

	public void DeleteSkillIndicator(int indicatorId)
	{
		lock (executeSkillIndicators)
		{
			executeSkillIndicators.TryGetValue(indicatorId, out var value);
			if (value != null)
			{
				value.DeleteChangeIndicatorData();
				executeSkillIndicators.Remove(indicatorId);
				ReferencePool.Release(value);
			}
		}
	}

	public override void OnDispose()
	{
		foreach (KeyValuePair<int, IObjectPool<GameObject>> indicatorPool in indicatorPools)
		{
			indicatorPool.Value.Dispose();
		}
		indicatorPools.Clear();
		indicatorPools = null;
		lock (executeSkillIndicators)
		{
			executeSkillIndicators.Clear();
			executeSkillIndicators = null;
		}
	}
}
