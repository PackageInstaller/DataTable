using System.Collections.Generic;
using Ase.ECS;
using GameFramework;

namespace Ase;

public class BaseWeaknessData : IReference
{
	public int weaknessAttackPower;

	private Dictionary<int, WeaknessDamageData> _weaknessDamageData = new Dictionary<int, WeaknessDamageData>();

	private Dictionary<int, List<WeaknessHitInfo>> weaknessHitInfoDic = new Dictionary<int, List<WeaknessHitInfo>>();

	public string boneName;

	public int Id;

	public bool isShowWeaknessBar;

	public BaseEntity monsterEntity;

	public float Runtime;

	public List<WeaknessStateInfo> weaknessState = new List<WeaknessStateInfo>();

	public bool AttackedThisFrame;

	public float SingleWeakLiftTime;

	public int WeakConfigCount;

	public float Lifetime { get; set; }

	public float DamagePercent
	{
		get
		{
			int num = CurrentState();
			if (num >= 0)
			{
				return weaknessState[num].DamagePercent;
			}
			return 0f;
		}
	}

	public int Level
	{
		get
		{
			int num = CurrentState();
			if (num >= 0)
			{
				return weaknessState[num].WeaknessLevel;
			}
			return 0;
		}
	}

	public bool IsWarnWeakness
	{
		get
		{
			int num = CurrentState();
			if (num >= 0)
			{
				return weaknessState[num].IsWarnWeakness;
			}
			return false;
		}
	}

	public string DamageType
	{
		get
		{
			int num = CurrentState();
			if (num >= 0)
			{
				return weaknessState[num].WeaknessDamageTextType;
			}
			return null;
		}
	}

	public string WeaknessCriticalDamageTextType
	{
		get
		{
			int num = CurrentState();
			if (num >= 0)
			{
				return weaknessState[num].WeaknessCriticalDamageTextType;
			}
			return null;
		}
	}

	public float Xp
	{
		get
		{
			int num = CurrentState();
			if (num >= 0)
			{
				return weaknessState[num].XpIncrease;
			}
			return 0f;
		}
	}

	public List<int> EffectList
	{
		get
		{
			int num = CurrentState();
			if (num >= 0)
			{
				return weaknessState[num].EffectList;
			}
			return null;
		}
	}

	public List<int> EffectCoolingList
	{
		get
		{
			int num = CurrentState();
			if (num >= 0)
			{
				return weaknessState[num].EffectCoolingList;
			}
			return null;
		}
	}

	public int CurrentStateId
	{
		get
		{
			int num = CurrentState();
			if (num >= 0)
			{
				return weaknessState[num].ConfigId;
			}
			return -1;
		}
	}

	public float TenacityDamagePercent
	{
		get
		{
			int num = CurrentState();
			if (num >= 0)
			{
				return weaknessState[num].ToughDamagePercent;
			}
			return 0f;
		}
	}

	public Dictionary<int, List<WeaknessHitInfo>> GetWeaknessHitInfos()
	{
		return weaknessHitInfoDic;
	}

	public virtual void Clear()
	{
		Runtime = 0f;
		Lifetime = 0f;
		boneName = null;
		monsterEntity = null;
		SingleWeakLiftTime = 0f;
		WeakConfigCount = 0;
		foreach (WeaknessStateInfo item in weaknessState)
		{
			ReferencePool.Release(item);
		}
		weaknessState.Clear();
		weaknessHitInfoDic.Clear();
		isShowWeaknessBar = false;
		ClearAttackHistory();
	}

	public int CurrentState()
	{
		float num = Runtime / Lifetime;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"BaseWeakNessData  Runtime {Runtime} Lifetime {Lifetime} ", monsterEntity);
		}
		if (num < 0f)
		{
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance.WriteAuthorityEntityId($"BaseWeakNessData  currentRuntime {num} int -1 ", monsterEntity);
			}
			return -1;
		}
		int num2 = 0;
		for (int i = 0; i < weaknessState.Count; i++)
		{
			if (num > weaknessState[i].StateScale)
			{
				num -= weaknessState[i].StateScale;
				num2++;
				if (LockstepData.Instance != null)
				{
					LockstepData.Instance.WriteAuthorityEntityId("BaseWeakNessData  currentRuntime " + $"{num} weaknessState[i].StateScale {weaknessState[i].StateScale} state {num2} ", monsterEntity);
				}
				continue;
			}
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance.WriteAuthorityEntityId($"BaseWeakNessData  currentRuntime {num} state {num2} ", monsterEntity);
			}
			return num2;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"BaseWeakNessData  weaknessState.Count {weaknessState.Count} state -1 ", monsterEntity);
		}
		return -1;
	}

	public bool IsSelfAttacker()
	{
		WeaknessDamageData value;
		return _weaknessDamageData.TryGetValue(monsterEntity.GetWorld().ActorId, out value);
	}

	public bool IsSelfAttackerSummoned()
	{
		return false;
	}

	public virtual void Init(DRWeaknessUIData config)
	{
	}

	public void RecodeWeaknessData(BaseEntity entity)
	{
		if (entity == null)
		{
			return;
		}
		int id = entity.Id;
		if (entity.GetEntityType() == EntityType.SummonedEntity)
		{
			if (entity.Parent == null)
			{
				return;
			}
			id = entity.Parent.Id;
		}
		AttackedThisFrame = true;
		if (_weaknessDamageData.TryGetValue(id, out var value))
		{
			value.Tick = entity.Tick;
			return;
		}
		WeaknessDamageData value2 = new WeaknessDamageData
		{
			EntityId = id,
			Tick = entity.Tick
		};
		_weaknessDamageData.Add(id, value2);
	}

	public void RecordWeaknessHitInfo(BaseEntity attacker, int skillId)
	{
		if (attacker == null)
		{
			return;
		}
		int id = attacker.Id;
		if (attacker.GetEntityType() == EntityType.SummonedEntity)
		{
			if (attacker.Parent == null)
			{
				return;
			}
			id = attacker.Parent.Id;
		}
		WeaknessHitInfo weaknessHitInfo = new WeaknessHitInfo
		{
			entityId = id,
			skillId = skillId,
			level = Level
		};
		if (!weaknessHitInfoDic.TryGetValue(id, out var value))
		{
			value = new List<WeaknessHitInfo>();
			value.Add(weaknessHitInfo);
			weaknessHitInfoDic.Add(id, value);
			return;
		}
		for (int i = 0; i < value.Count; i++)
		{
			if (value[i].level < weaknessHitInfo.level)
			{
				value.Insert(i, weaknessHitInfo);
				return;
			}
		}
		value.Add(weaknessHitInfo);
	}

	public void ClearAttackHistory()
	{
		_weaknessDamageData.Clear();
		AttackedThisFrame = false;
	}
}
