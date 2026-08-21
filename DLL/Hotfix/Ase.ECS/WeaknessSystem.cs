using System;
using System.Collections.Generic;
using GameFramework;

namespace Ase.ECS;

public class WeaknessSystem : BaseSystem
{
	private bool ignoreTimeScale;

	private readonly LinkedList<BaseWeaknessData> _allWeakness = new LinkedList<BaseWeaknessData>();

	public readonly Dictionary<int, LinkedListNode<BaseWeaknessData>> AllWeaknessDic = new Dictionary<int, LinkedListNode<BaseWeaknessData>>();

	private DRWeaknessUIData _config;

	private int _idIndex;

	private bool isUsedWeakness;

	private static Action<LinkedListNode<BaseWeaknessData>> s_action;

	private float _fixDT;

	public DRWeaknessUIData Config => _config;

	protected override bool IsLogicSystem => true;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		_config = GameEntry.DataTable.GetDataRow<DRWeaknessUIData>(1);
		CreateWeaknessCheckDelegate();
		isUsedWeakness = true;
	}

	public void SetUsedWeakness(bool isUsed)
	{
		isUsedWeakness = isUsed;
	}

	public int CreateNormalWeakness(float lifeTime, List<MomentWeaknessData> configData, BaseEntity entity, string boneName, bool isShowWeaknessBar, string pointName)
	{
		WeaknessComponent component = entity.GetComponent<WeaknessComponent>();
		if (component != null)
		{
			NormalWeaknessData normalWeaknessData = ReferencePool.Acquire<NormalWeaknessData>();
			normalWeaknessData.Lifetime = lifeTime;
			normalWeaknessData.boneName = boneName;
			normalWeaknessData.weaknessConfig = new List<MomentWeaknessData>(configData);
			normalWeaknessData.monsterEntity = entity;
			normalWeaknessData.isShowWeaknessBar = isShowWeaknessBar;
			normalWeaknessData.Id = ++_idIndex;
			normalWeaknessData.Init(_config);
			entity.GetComponent<WeaknessComponent>()?.ShowWeaknessBar(normalWeaknessData);
			AddWeaknessData(normalWeaknessData);
			component.CreateWeaknessData(normalWeaknessData, pointName);
		}
		return -1;
	}

	public int CreateCutFlavourWeakness(float lifeTime, List<FoundWeaknessData> configData, BaseEntity entity, string boneName, bool isShowWeaknessBar, string pointName)
	{
		if (!isUsedWeakness)
		{
			return 0;
		}
		WeaknessComponent weaknessComponent = entity?.GetComponent<WeaknessComponent>();
		if (weaknessComponent != null)
		{
			CutFlavourWeaknessData cutFlavourWeaknessData = ReferencePool.Acquire<CutFlavourWeaknessData>();
			cutFlavourWeaknessData.Lifetime = lifeTime;
			cutFlavourWeaknessData.boneName = boneName;
			cutFlavourWeaknessData.weaknessConfig = new List<FoundWeaknessData>();
			for (int i = 0; i < configData.Count; i++)
			{
				FoundWeaknessData foundWeaknessData = ReferencePool.Acquire<FoundWeaknessData>();
				foundWeaknessData.Clone(configData[i]);
				foundWeaknessData.CalcEntityTimeBuff(entity);
				cutFlavourWeaknessData.weaknessConfig.Add(foundWeaknessData);
			}
			cutFlavourWeaknessData.monsterEntity = entity;
			cutFlavourWeaknessData.isShowWeaknessBar = isShowWeaknessBar;
			cutFlavourWeaknessData.otherWeaknessTimer = entity.GetWorld().BattleConfig.oneWeaknessDataTimer;
			cutFlavourWeaknessData.Id = ++_idIndex;
			cutFlavourWeaknessData.Init(_config);
			weaknessComponent.CreateWeaknessData(cutFlavourWeaknessData, pointName);
			entity.GetComponent<WeaknessComponent>()?.ShowWeaknessBar(cutFlavourWeaknessData);
			AddWeaknessData(cutFlavourWeaknessData);
			ObserverWeaknessBarParams observerWeaknessBarParams = ReferencePool.Acquire<ObserverWeaknessBarParams>();
			observerWeaknessBarParams.Init(cutFlavourWeaknessData, isShow: true);
			entity.GetSystem<BattleObserverSystem>().Notify(BattleObserverEventEnum.WeaknessBar, observerWeaknessBarParams);
			ReferencePool.Release(observerWeaknessBarParams);
		}
		return -1;
	}

	public void OnMonsterEntityDie(BaseWeaknessData data)
	{
		data.Runtime = data.Lifetime;
	}

	private void OnWeaknessEntityDie(BaseWeaknessData data)
	{
		WeaknessComponent weaknessComponent = data.monsterEntity?.GetComponent<WeaknessComponent>() ?? null;
		if (weaknessComponent != null)
		{
			weaknessComponent.RemoveWeaknessData(data);
			weaknessComponent.HideWeaknessBar();
			ObserverWeaknessBarParams observerWeaknessBarParams = ReferencePool.Acquire<ObserverWeaknessBarParams>();
			observerWeaknessBarParams.Init(data, isShow: false);
			data.monsterEntity.GetSystem<BattleObserverSystem>().Notify(BattleObserverEventEnum.WeaknessBar, observerWeaknessBarParams);
			ReferencePool.Release(observerWeaknessBarParams);
		}
		RemoveWeaknessData(data);
	}

	public void RemoveCacheData(BaseWeaknessData weaknessData)
	{
		if (weaknessData != null)
		{
			RemoveWeaknessData(weaknessData);
		}
	}

	private void AddWeaknessData(BaseWeaknessData data)
	{
		LinkedListNode<BaseWeaknessData> value = _allWeakness.AddLast(data);
		AllWeaknessDic.Add(data.Id, value);
	}

	private void RemoveWeaknessData(BaseWeaknessData data)
	{
		_allWeakness.Remove(data);
		AllWeaknessDic.Remove(data.Id);
		ReferencePool.Release(data);
	}

	private void CreateWeaknessCheckDelegate()
	{
		s_action = delegate(LinkedListNode<BaseWeaknessData> weaknessLinkNode)
		{
			weaknessLinkNode.Value.Runtime += _fixDT;
			weaknessLinkNode.Value.monsterEntity.GetComponent<WeaknessComponent>()?.UpdateWeaknessBar(_fixDT);
			if (weaknessLinkNode.Value.Runtime >= weaknessLinkNode.Value.Lifetime + Config.WeaknessKeepTime)
			{
				OnWeaknessEntityDie(weaknessLinkNode.Value);
			}
		};
	}

	public override void OnGameSpeedChanged(float beforeTheChangeSpeed, float gameSpeed)
	{
		base.OnGameSpeedChanged(beforeTheChangeSpeed, gameSpeed);
		ignoreTimeScale = !world.TimeScaleEffectWeakness();
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (updateType == WorldUpdateType.Authority || updateType == WorldUpdateType.All)
		{
			if (ignoreTimeScale)
			{
				_fixDT = 0.033f;
			}
			else
			{
				_fixDT = deltaTime;
			}
			UtilGame.ForeachLinkList(_allWeakness, s_action);
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		foreach (BaseWeaknessData item in _allWeakness)
		{
			ReferencePool.Release(item);
		}
		_allWeakness.Clear();
		AllWeaknessDic.Clear();
		_idIndex = 0;
	}
}
