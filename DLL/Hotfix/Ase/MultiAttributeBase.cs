using System;
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine.Pool;

namespace Ase;

[Obsolete("现在使用 MultiAttributeBuffs")]
public abstract class MultiAttributeBase : IReference
{
	protected DRAttributeMatching attributeMatchingCfg;

	protected MultiPlayerSystem multiPlayerSystem;

	protected HeroAttributeEnum attributeEnum;

	protected int attributeEntityCount;

	protected List<int> addBuffList;

	public void Init()
	{
		OnInitAttribute();
		OnInit();
	}

	protected void OnInitAttribute()
	{
		_ = attributeMatchingCfg;
	}

	public void OnStart()
	{
		string conditionBuffs = attributeMatchingCfg.ConditionBuffs;
		if (conditionBuffs == null || string.IsNullOrEmpty(conditionBuffs))
		{
			return;
		}
		string[] array = conditionBuffs.Split('#');
		if (array == null || array.Length == 0)
		{
			return;
		}
		List<(int, int[])> list = CollectionPool<List<(int, int[])>, (int, int[])>.Get();
		for (int i = 0; i < array.Length; i++)
		{
			string[] array2 = array[i].Split(',');
			if (array2 != null && array2.Length >= 2)
			{
				int[] array3 = new int[array2.Length - 1];
				for (int j = 0; j < array3.Length; j++)
				{
					array3[j] = int.Parse(array2[j + 1]);
				}
				list.Add((int.Parse(array2[0]), array3));
			}
		}
		attributeEntityCount = multiPlayerSystem.GetSystem<EntitySystem>().GetTeamAttributeCountByEntity(attributeEnum);
		addBuffList = CollectionPool<List<int>, int>.Get();
		for (int num = list.Count - 1; num >= 0; num--)
		{
			if (list[num].Item1 == attributeEntityCount)
			{
				addBuffList.AddRange(list[num].Item2);
			}
		}
		CollectionPool<List<(int, int[])>, (int, int[])>.Release(list);
	}

	public virtual void OnStartAfter()
	{
	}

	protected abstract void OnInit();

	public virtual void OnUpdate(float delta)
	{
	}

	public virtual void OnFixUpdate(WorldUpdateType updateType, float delta)
	{
	}

	public virtual void OnAddBuffs(BaseEntity entity)
	{
		if (addBuffList == null || addBuffList.Count == 0)
		{
			return;
		}
		BuffSystem system = multiPlayerSystem.GetSystem<BuffSystem>();
		if (system != null && IsConditionEntity(entity))
		{
			for (int i = 0; i < addBuffList.Count; i++)
			{
				system.CheckAndAcquireBuff(entity, entity, addBuffList[i]);
			}
		}
	}

	public virtual void CreateEntityMessager(BaseEntity entity)
	{
	}

	public virtual void SkillReleaseMessager(BaseEntity entity, HeroSkillTypeEnum skillTypeEnum, int skillId)
	{
	}

	public void Clear()
	{
		if (addBuffList != null)
		{
			CollectionPool<List<int>, int>.Release(addBuffList);
		}
		OnClear();
	}

	public abstract void OnClear();

	protected bool IsConditionEntity(BaseEntity entity)
	{
		if (attributeMatchingCfg == null || attributeMatchingCfg.Targets == null)
		{
			return false;
		}
		foreach (string target in attributeMatchingCfg.Targets)
		{
			EntityTeamType teamType = (EntityTeamType)Enum.Parse(typeof(EntityTeamType), target);
			if (IsConditionEntityByTeamType(entity, teamType))
			{
				return true;
			}
		}
		return false;
	}

	private bool IsConditionEntityByTeamType(BaseEntity entity, EntityTeamType teamType)
	{
		return ConditionUtility.CompareTargetInTeamType(entity, teamType);
	}
}
