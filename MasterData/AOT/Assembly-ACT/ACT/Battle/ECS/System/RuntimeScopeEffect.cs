using System;
using System.Collections.Generic;
using ACT.MultiPlayer;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.Battle.ECS.System;

public class RuntimeScopeEffect
{
	public static readonly ObjectPool<RuntimeScopeEffect> Pool = new ObjectPool<RuntimeScopeEffect>(() => new RuntimeScopeEffect(), null, (RuntimeScopeEffect effect) =>
	{
		effect.Reset();
	});

	private int m_Id;

	private bool m_Active;

	private string m_Ability;

	private EffectSource m_EffectSource;

	private List<Entity> m_Entities;

	private int m_SkillId;

	private bool m_InheritOnChangeCharacter;

	public Scope Scope { get; private set; }

	public bool Active
	{
		get
		{
			return m_Active;
		}
		set
		{
			m_Active = value;
			if (value)
			{
				OnEffectActive();
			}
			else
			{
				OnEffectDeActive();
			}
		}
	}

	public int Id
	{
		get
		{
			return m_Id;
		}
		protected set
		{
			m_Id = value;
		}
	}

	private AbilitySource AbilitySource => m_EffectSource switch
	{
		EffectSource.Trigger => AbilitySource.RogueTrigger, 
		EffectSource.Card => AbilitySource.RogueCard, 
		EffectSource.Artifact => AbilitySource.RogueArtifact, 
		EffectSource.Environment => AbilitySource.Environment, 
		_ => throw new ArgumentOutOfRangeException(), 
	};

	public void Init(int id, Scope scope, string ability, EffectSource effectSource, int skillId)
	{
		m_Id = id;
		m_EffectSource = effectSource;
		Scope = scope;
		SystemEntityScope entityScopeSystem = GameManager.entityScopeSystem;
		m_Entities = entityScopeSystem.m_ScopeEntities[Scope];
		m_Ability = ability;
		m_SkillId = skillId;
		entityScopeSystem.RegisterScopeAddAction(Scope, OnScopeAdd);
		entityScopeSystem.RegisterScopeRemoveAction(Scope, OnScopeRemove);
		if (EngineConfigs.ability.TryGetValue(ability, out var value))
		{
			m_InheritOnChangeCharacter = value.inheritOnChangeCharacter;
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"{m_EffectSource} : {m_Id} 找不到ability id ： {ability}");
		}
	}

	public void OnEffectActive()
	{
		MPSkill skillLevelInfo = new MPSkill
		{
			id = m_SkillId,
			level = 1
		};
		foreach (Entity entity in m_Entities)
		{
			entity.GetCompAbility()?.AddAbility(entity, m_Ability, AbilitySource, skillLevelInfo, 1, Id);
		}
	}

	public void OnEffectDeActive()
	{
		foreach (Entity entity in m_Entities)
		{
			entity.GetCompAbility().RemoveAbility(m_Ability);
		}
	}

	public void OnScopeAdd(Entity entity, ScopeChangeSource scopeChangeSource)
	{
		if (Active && (scopeChangeSource != ScopeChangeSource.BattleCharacterChange || !m_InheritOnChangeCharacter || Scope != Scope.FrontCharacter))
		{
			entity.GetCompAbility()?.AddAbility(entity, m_Ability, AbilitySource, new MPSkill
			{
				id = m_SkillId,
				level = 1
			}, 1, Id);
		}
	}

	public void OnScopeRemove(Entity entity, ScopeChangeSource scopeChangeSource)
	{
		if (Active && (scopeChangeSource != ScopeChangeSource.BattleCharacterChange || !m_InheritOnChangeCharacter || Scope != Scope.FrontCharacter))
		{
			entity.GetCompAbility()?.RemoveAbility(m_Ability);
		}
	}

	public void Reset()
	{
		foreach (Entity entity in m_Entities)
		{
			entity.GetCompAbility()?.RemoveAbilityFormSource(Id, AbilitySource);
		}
		Active = false;
		SystemEntityScope entityScopeSystem = GameManager.entityScopeSystem;
		entityScopeSystem.UnRegisterScopeAddAction(Scope, OnScopeAdd);
		entityScopeSystem.UnRegisterScopeRemoveAction(Scope, OnScopeRemove);
		m_Id = 0;
		Scope = Scope.FrontCharacter;
		m_Ability = null;
		m_EffectSource = EffectSource.Trigger;
		m_Entities = null;
		m_SkillId = 0;
		m_InheritOnChangeCharacter = false;
	}
}
