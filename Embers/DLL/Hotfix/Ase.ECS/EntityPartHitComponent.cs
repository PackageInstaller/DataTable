#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;

namespace Ase.ECS;

public class EntityPartHitComponent : BaseComponent, IObserverHandler, IPropertyChanged
{
	private DRHitBox config;

	private Dictionary<string, int> keyIndexDic;

	private Dictionary<int, EntityPartHitData> partHitDataDic;

	public override void OnStart(object data = null)
	{
		config = GetData<DRHitBox>("HitCollider");
		InitDamageInjuryData();
	}

	private void InitDamageInjuryData()
	{
		if (config == null || config.KeysGroups.IsNullOrEmpty() || config.DamageInjury.IsNullOrEmpty())
		{
			return;
		}
		if (config.KeysGroups.Count != config.DamageInjury.Count)
		{
			Log.Error($"实体部位受击组件 部位伤害阈值参数配置错误 : 实体Id {mBaseEntity.Id}");
			return;
		}
		if (config.DamageInjury.Count != config.Progressivecoefficient.Count)
		{
			Log.Error($"实体部位受击组件 阈值浮动系数配置错误 : 实体Id {mBaseEntity.Id}");
			return;
		}
		keyIndexDic = new Dictionary<string, int>();
		partHitDataDic = new Dictionary<int, EntityPartHitData>();
		for (int i = 0; i < config.KeysGroups.Count; i++)
		{
			List<string> list = config.KeysGroups[i];
			List<float> list2 = config.DamageInjury[i];
			if (list2.Count != 2)
			{
				Log.Error($"实体部位受击组件 部位伤害阈值参数配置错误 : 实体Id {mBaseEntity.Id}");
				return;
			}
			foreach (string item in list)
			{
				if (!keyIndexDic.ContainsKey(item))
				{
					keyIndexDic.Add(item, i);
				}
			}
			EntityPartHitData entityPartHitData = new EntityPartHitData();
			entityPartHitData.Init(i, list2[0], (int)list2[1], config.Progressivecoefficient[i]);
			partHitDataDic.Add(i, entityPartHitData);
		}
		mBaseEntity.GetPropertyData("Hp")?.RegisterOnChangedCallback(this);
		mBaseEntity.GetSystem<BattleObserverSystem>()?.Attach(BattleObserverEventEnum.Damage, this);
		RefreshPartMaxHp();
	}

	public void OnPropertyChanged(string propertyName, PropertyChangedEnum changedEnum, float delta)
	{
		if (propertyName == "Hp" && changedEnum == PropertyChangedEnum.MaxValue)
		{
			RefreshPartMaxHp();
		}
	}

	private void RefreshPartMaxHp()
	{
		float propertyMax = mBaseEntity.GetPropertyMax("Hp");
		foreach (EntityPartHitData value in partHitDataDic.Values)
		{
			value.RefreshHpThreshold(propertyMax);
		}
	}

	public void OnNotify(IObserverParams param)
	{
		if (param == null || param.Trigger.Id != mBaseEntity.Id || !(param is ObserverDamageProgressParams observerDamageProgressParams))
		{
			return;
		}
		string text = observerDamageProgressParams.Get<string>("PartName");
		if (!string.IsNullOrEmpty(text) && keyIndexDic.TryGetValue(text, out var value) && partHitDataDic.TryGetValue(value, out var value2))
		{
			int damage = observerDamageProgressParams.Get<int>("Damage");
			value2.AddHitDamage(damage);
			bool num = observerDamageProgressParams.Get<bool>("KnockDown");
			bool flag = observerDamageProgressParams.Get<bool>("BossDownState");
			if (!(num | flag) && value2.CheckState())
			{
				mBaseEntity.GetComponent<StateComponent>()?.AddState(value2.GetStateId(), observerDamageProgressParams.Attacker.Id);
				value2.RefreshState();
				float propertyMax = mBaseEntity.GetPropertyMax("Hp");
				value2.RefreshHpThreshold(propertyMax);
			}
		}
	}

	public void OnModifyPartGroupDamage(int index, int value)
	{
		if (config == null || config.KeysGroups.IsNullOrEmpty())
		{
			return;
		}
		if (config.KeysGroups.Count <= index)
		{
			Log.Error("修改部位组伤害值错误，索引超出");
			return;
		}
		_ = config.KeysGroups[index];
		if (partHitDataDic.TryGetValue(index, out var value2))
		{
			value2.ResetDamage(value);
		}
	}

	public void OnModifyPartProcessCount(int index, int value)
	{
		if (config == null || config.KeysGroups.IsNullOrEmpty())
		{
			return;
		}
		if (config.KeysGroups.Count <= index)
		{
			Log.Error("修改部位组阈值层数，索引超出");
			return;
		}
		if (partHitDataDic.TryGetValue(index, out var value2))
		{
			value2.ResetProcessCount(value);
		}
		RefreshPartMaxHp();
	}

	public override void OnDispose()
	{
		mBaseEntity.GetPropertyData("Hp")?.RemoveOnChangedCallback(this);
		mBaseEntity.GetSystem<BattleObserverSystem>()?.Detach(BattleObserverEventEnum.Damage, this);
		keyIndexDic?.Clear();
		partHitDataDic?.Clear();
	}
}
