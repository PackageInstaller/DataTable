#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using System.Threading.Tasks;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Serialization;

namespace Ase;

public class MonsterActivePoint : SerializedMonoBehaviour, IInit, IDispose
{
	public MonsterCtrl MonsterCtrl;

	public int monsterConfigId;

	public int monsterAttackCtrlId;

	public bool openAnimation;

	public float DelayTime;

	[FormerlySerializedAs("ParadoxMsg")]
	public Dictionary<string, MapDataNodeParadoxParameter> nodeParadoxMsg = new Dictionary<string, MapDataNodeParadoxParameter>();

	[SerializeField]
	private int[] addBuffs;

	private List<int> calledMonsterIds = new List<int>();

	private bool isBoss;

	private bool openBloodBar;

	protected BaseEntity entity;

	private MapDataNodeState mapDataNodeState;

	private bool IsNeedCreate;

	private bool IsNeedDestory;

	private SceneSystem sceneSystem;

	private EntityCallbacks callbacks;

	public bool isInitState => mapDataNodeState == MapDataNodeState.Unsummoned;

	public bool isCreating => mapDataNodeState == MapDataNodeState.Summoning;

	public bool isKilled => mapDataNodeState == MapDataNodeState.Dead;

	public bool isSurvival => mapDataNodeState == MapDataNodeState.Summoned;

	private WorldBase World => sceneSystem?.GetWorld();

	public void OnInit(object data = null)
	{
		sceneSystem = (SceneSystem)data;
		callbacks = new EntityCallbacks(EntityCreated, EntityOnStart, EntityDead, EntityRelease);
	}

	public async Task<BaseEntity> LoadMonster()
	{
		await UniTask.WaitForSeconds(DelayTime);
		if (mapDataNodeState == MapDataNodeState.Destorying)
		{
			IsNeedCreate = true;
			return null;
		}
		if (monsterConfigId != 0)
		{
			DRMonsterAttr drMonsterAttr = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(monsterConfigId);
			if (drMonsterAttr == null)
			{
				Log.Error($"没有找到怪物ID = {monsterConfigId}的怪物配置..");
				return null;
			}
			DRMonster drMonster = GameEntry.DataTable.GetDataRow<DRMonster>(drMonsterAttr.MonsterType);
			if (drMonster == null)
			{
				Log.Error($"没有找到怪物种类 {drMonsterAttr.MonsterType} 的怪物配置..");
				return null;
			}
			mapDataNodeState = MapDataNodeState.Summoning;
			if (!(await sceneSystem.GetSystem<ParadoxSystem>().PreLoadParadoxGraph(drMonster.AIParadoxId)))
			{
				mapDataNodeState = MapDataNodeState.Unsummoned;
				return null;
			}
			isBoss = drMonster.IsBoss;
			GameObject entityObject = await LoadEntityView(drMonster.Id, drMonster.AssetPath);
			entity = CreateMonsterEntity(drMonster.Id, entityObject, callbacks, drMonster.IsBoss, drMonster, drMonsterAttr);
			if (isInitState)
			{
				return null;
			}
		}
		return entity;
	}

	public void KillMonster()
	{
		if (isCreating)
		{
			if (!isKilled)
			{
				mapDataNodeState = MapDataNodeState.Dead;
			}
			IsNeedDestory = true;
			return;
		}
		if (entity != null && (entity.IsStandby || entity.IsSurvival))
		{
			entity.DoEntityRelease();
		}
		entity = null;
		if (!isKilled)
		{
			mapDataNodeState = MapDataNodeState.Dead;
		}
		ReleaseCalledMonster();
	}

	private void AddEntityToSystemRelease(bool isLevelReset)
	{
		if (isCreating)
		{
			IsNeedDestory = true;
		}
		else if (entity != null && entity.IsSurvival)
		{
			entity.DoEntityRelease();
			entity = null;
			if (!isKilled | isLevelReset)
			{
				mapDataNodeState = MapDataNodeState.Destorying;
			}
		}
		else if (!isKilled | isLevelReset)
		{
			mapDataNodeState = MapDataNodeState.Unsummoned;
		}
	}

	private MonsterEntity CreateMonsterEntity(int entityId, GameObject entityObject, EntityCallbacks callbacks, bool isBoss, object userData, object userDataPam)
	{
		return World.GetSystem<EntitySystem>().CreateEntity<MonsterEntity>(entityId, new EntityData
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
			userDataPam = userDataPam,
			campType = CampType.Monster
		});
	}

	private async void EntityCreated(BaseEntity baseEntity)
	{
		if (isBoss)
		{
			sceneSystem.OnBossCreate();
		}
		mapDataNodeState = MapDataNodeState.Summoned;
		InitParadoxMessage();
		int[] array = addBuffs;
		foreach (int buffId in array)
		{
			sceneSystem.GetSystem<BuffSystem>().CheckAndAcquireBuff(baseEntity.EntityId, baseEntity.EntityId, buffId);
		}
		MonsterCtrl.OnEntityCreated();
	}

	private async void EntityOnStart(BaseEntity baseEntity)
	{
		OnEntityStart();
	}

	protected virtual void OnEntityStart()
	{
	}

	private async void InitParadoxMessage()
	{
		await UniTask.WaitUntil(() => entity == null || entity.GetComponent<AIParadoxComponent>().IsLoadingFinished());
		if (nodeParadoxMsg != null)
		{
			foreach (KeyValuePair<string, MapDataNodeParadoxParameter> item in nodeParadoxMsg)
			{
				SetParadoxMessage(item.Key, item.Value);
			}
		}
		SetParadoxMessage(MonsterGroup.LOW_MONSTER_BORNANIMATION_KEY, MapDataNodeParadoxParameter.CreateBoolParameter(openAnimation));
	}

	private void EntityDead(BaseEntity baseEntity, bool isnormal)
	{
		MonsterCtrl.OnEntityDead(this);
	}

	private void EntityRelease(BaseEntity baseEntity, bool isnormal)
	{
		if (isBoss)
		{
			sceneSystem.OnBossRelease(openBloodBar);
		}
		if (!isKilled)
		{
			mapDataNodeState = MapDataNodeState.Unsummoned;
		}
	}

	protected void SetParadoxMessage(string key, MapDataNodeParadoxParameter mapDataNodeParadoxParameter)
	{
		if (entity != null)
		{
			AIParadoxComponent aiParadoxComponent = entity.GetComponent<AIParadoxComponent>();
			if (aiParadoxComponent != null)
			{
				mapDataNodeParadoxParameter.parameter.InjectData(key, ref aiParadoxComponent);
			}
		}
	}

	public void OpenBossBloodBar(bool value)
	{
		if (isBoss)
		{
			openBloodBar = true;
		}
	}

	private async Task<GameObject> LoadEntityView(int entityId, string assetPath)
	{
		return await World.GetSystem<EntityViewCacheSystem>().AsyncLoadEntityView(entityId, assetPath);
	}

	private void AddCallMonster(int monsterEntityId)
	{
		if (!calledMonsterIds.Contains(monsterEntityId))
		{
			calledMonsterIds.Add(monsterEntityId);
		}
	}

	private void ReleaseCalledMonster()
	{
		List<int>.Enumerator enumerator = calledMonsterIds.GetEnumerator();
		while (enumerator.MoveNext())
		{
			BaseEntity baseEntity = World.GetSystem<EntitySystem>().GetEntity(enumerator.Current);
			if (baseEntity != null && baseEntity.IsSurvival)
			{
				baseEntity.DoEntityRelease();
			}
		}
		enumerator.Dispose();
		calledMonsterIds.Clear();
	}

	public void OnDispose()
	{
		entity = null;
		sceneSystem = null;
	}
}
