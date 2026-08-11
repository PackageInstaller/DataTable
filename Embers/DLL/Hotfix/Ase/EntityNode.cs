using Ase.ECS;
using Cysharp.Threading.Tasks;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Ase;

public abstract class EntityNode : SerializedMonoBehaviour, IStart, IReset
{
	protected BaseEntity entity;

	protected StoryWorld world;

	protected int nodeIndex;

	public bool IsEmpty
	{
		get
		{
			if (entity != null)
			{
				return !entity.IsSurvival;
			}
			return true;
		}
	}

	public virtual void Init(object data, int index)
	{
		world = (StoryWorld)data;
		nodeIndex = index;
	}

	public virtual void OnStart(object data = null)
	{
	}

	public void OnReset()
	{
	}

	public abstract UniTask<BaseEntity> CallEntity(int entityId = 0);

	protected async UniTask<GameObject> LoadEntityView(int entityId, string assetPath)
	{
		return await world.GetSystem<EntityViewCacheSystem>().AsyncLoadEntityView(entityId, assetPath);
	}

	protected T CreateEntity<T>(int entityId, GameObject entityObject, object userData) where T : BaseEntity, new()
	{
		return world.GetSystem<EntitySystem>().CreateEntity<T>(entityId, new EntityData
		{
			pointData = new EntityPositionData
			{
				position = ((Component)this).transform.position,
				scale = entityObject.transform.localScale,
				rotation = ((Component)this).transform.eulerAngles
			},
			entityObject = entityObject,
			userData = userData
		});
	}

	protected MonsterEntity CreateMonsterEntity(int entityId, GameObject entityObject, EntityCallbacks callbacks, bool isBoss, object userData)
	{
		return world.GetSystem<EntitySystem>().CreateEntity<MonsterEntity>(entityId, new EntityData
		{
			pointData = new EntityPositionData
			{
				position = ((Component)this).transform.position,
				scale = entityObject.transform.localScale,
				rotation = ((Component)this).transform.eulerAngles
			},
			callbacks = callbacks,
			entityObject = entityObject,
			updateType = EntityUpdateType.Local,
			logicType = EntityLogicType.None,
			collisionLayer = (isBoss ? CollisionSetting.CollisionLayer.Boss : CollisionSetting.CollisionLayer.Monster),
			collisionMass = 2,
			userData = userData,
			campType = CampType.Monster
		});
	}

	public void ResetEntity()
	{
		entity = null;
	}

	public virtual void DebugSceneEntity()
	{
	}
}
