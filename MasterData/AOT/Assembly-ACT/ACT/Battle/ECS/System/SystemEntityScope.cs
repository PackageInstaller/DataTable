using System;
using System.Collections.Generic;
using ACT.Event;
using ACT.Game;
using Bamboo.ECS;
using Fundamental;
using Google.Protobuf.Collections;

namespace ACT.Battle.ECS.System;

public class SystemEntityScope : EntitySystem
{
	public Dictionary<Scope, List<Entity>> m_ScopeEntities;

	private Dictionary<Scope, Action<Entity, ScopeChangeSource>> m_ScopeAddAction;

	private Dictionary<Scope, Action<Entity, ScopeChangeSource>> m_ScopeRemoveAction;

	private Filter _filter;

	private EntityAction _initializeScopeEntityAction;

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompAbility>().Build();
		_initializeScopeEntityAction = InitializeScopeEntity;
		m_ScopeEntities = new Dictionary<Scope, List<Entity>>();
		m_ScopeAddAction = new Dictionary<Scope, Action<Entity, ScopeChangeSource>>();
		m_ScopeRemoveAction = new Dictionary<Scope, Action<Entity, ScopeChangeSource>>();
		foreach (Scope value in Enum.GetValues(typeof(Scope)))
		{
			m_ScopeEntities.Add(value, new List<Entity>());
			m_ScopeAddAction.Add(value, null);
			m_ScopeRemoveAction.Add(value, null);
		}
		_filter.ForEach(_initializeScopeEntityAction);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, (BaseEventContent content) =>
		{
			BattleCharacterChangeEvt battleCharacterChangeEvt = content as BattleCharacterChangeEvt;
			m_ScopeEntities[Scope.FrontCharacter].Remove(battleCharacterChangeEvt.lastEb);
			m_ScopeEntities[Scope.BackCharacter].Remove(battleCharacterChangeEvt.newEb);
			m_ScopeEntities[Scope.BackCharacter].Add(battleCharacterChangeEvt.lastEb);
			m_ScopeEntities[Scope.FrontCharacter].Add(battleCharacterChangeEvt.newEb);
			m_ScopeRemoveAction[Scope.FrontCharacter]?.Invoke(battleCharacterChangeEvt.lastEb, ScopeChangeSource.BattleCharacterChange);
			m_ScopeRemoveAction[Scope.BackCharacter]?.Invoke(battleCharacterChangeEvt.newEb, ScopeChangeSource.BattleCharacterChange);
			m_ScopeAddAction[Scope.FrontCharacter]?.Invoke(battleCharacterChangeEvt.newEb, ScopeChangeSource.BattleCharacterChange);
			m_ScopeAddAction[Scope.BackCharacter]?.Invoke(battleCharacterChangeEvt.lastEb, ScopeChangeSource.BattleCharacterChange);
		});
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Team_ServerInfoChange, (BaseEventContent content) =>
		{
			ServerTeamCharacterChange obj = content as ServerTeamCharacterChange;
			int battleCharacterIdx = obj.teamProfile.BattleCharacterIdx;
			RepeatedField<int> characterIds = obj.teamProfile.CharacterIds;
			if (obj.index == G.localPlayer.teamInfo.MainTeamIdx)
			{
				if (characterIds[battleCharacterIdx] != m_ScopeEntities[Scope.FrontCharacter][0].GetCompCharacter()?.characterSource.Id())
				{
					Entity entity = m_ScopeEntities[Scope.FrontCharacter][0];
					Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(0);
					m_ScopeEntities[Scope.FrontCharacter].Remove(entity);
					m_ScopeEntities[Scope.FrontCharacter].Add(teamCharacter);
					m_ScopeRemoveAction[Scope.FrontCharacter]?.Invoke(entity, ScopeChangeSource.TeamCharacterChange);
					m_ScopeAddAction[Scope.FrontCharacter]?.Invoke(teamCharacter, ScopeChangeSource.TeamCharacterChange);
				}
				for (int num = m_ScopeEntities[Scope.BackCharacter].Count - 1; num >= 0; num--)
				{
					int? num2 = m_ScopeEntities[Scope.BackCharacter][num].GetCompCharacter()?.characterSource.Id();
					bool flag = false;
					for (int i = 0; i < characterIds.Count; i++)
					{
						int num3 = characterIds[i];
						if (i != battleCharacterIdx && num3 != 0 && num2 == characterIds[i])
						{
							flag = true;
							break;
						}
					}
					if (!flag)
					{
						Entity arg = m_ScopeEntities[Scope.BackCharacter][num];
						m_ScopeEntities[Scope.BackCharacter].RemoveAt(num);
						m_ScopeRemoveAction[Scope.BackCharacter]?.Invoke(arg, ScopeChangeSource.TeamCharacterChange);
					}
				}
				for (int j = 0; j < characterIds.Count; j++)
				{
					if (j == battleCharacterIdx || characterIds[j] != 0)
					{
						int num4 = characterIds[j];
						bool flag2 = false;
						foreach (Entity item in m_ScopeEntities[Scope.BackCharacter])
						{
							CompCharacter? compCharacter = item.GetCompCharacter();
							if (compCharacter != null && compCharacter.characterSource.Id() == num4)
							{
								flag2 = true;
								break;
							}
						}
						if (!flag2)
						{
							Entity teamCharacter2 = MonoECS.instance.localPlayer.GetTeamCharacter(j);
							if (teamCharacter2 != null)
							{
								m_ScopeEntities[Scope.BackCharacter].Add(teamCharacter2);
								m_ScopeAddAction[Scope.BackCharacter]?.Invoke(teamCharacter2, ScopeChangeSource.TeamCharacterChange);
							}
						}
					}
				}
			}
		});
	}

	private void InitializeScopeEntity(Entity entity)
	{
		foreach (Scope value in Enum.GetValues(typeof(Scope)))
		{
			if (InScope(value, entity))
			{
				m_ScopeEntities[value].Add(entity);
			}
		}
	}

	public void RegisterScopeAddAction(Scope scope, Action<Entity, ScopeChangeSource> action)
	{
		Dictionary<Scope, Action<Entity, ScopeChangeSource>> scopeAddAction = m_ScopeAddAction;
		scopeAddAction[scope] = (Action<Entity, ScopeChangeSource>)Delegate.Combine(scopeAddAction[scope], action);
	}

	public void UnRegisterScopeAddAction(Scope scope, Action<Entity, ScopeChangeSource> action)
	{
		Dictionary<Scope, Action<Entity, ScopeChangeSource>> scopeAddAction = m_ScopeAddAction;
		scopeAddAction[scope] = (Action<Entity, ScopeChangeSource>)Delegate.Remove(scopeAddAction[scope], action);
	}

	public void RegisterScopeRemoveAction(Scope scope, Action<Entity, ScopeChangeSource> action)
	{
		Dictionary<Scope, Action<Entity, ScopeChangeSource>> scopeRemoveAction = m_ScopeRemoveAction;
		scopeRemoveAction[scope] = (Action<Entity, ScopeChangeSource>)Delegate.Combine(scopeRemoveAction[scope], action);
	}

	public void UnRegisterScopeRemoveAction(Scope scope, Action<Entity, ScopeChangeSource> action)
	{
		Dictionary<Scope, Action<Entity, ScopeChangeSource>> scopeRemoveAction = m_ScopeRemoveAction;
		scopeRemoveAction[scope] = (Action<Entity, ScopeChangeSource>)Delegate.Remove(scopeRemoveAction[scope], action);
	}

	public List<Entity> GetScopeEntities(Scope scope)
	{
		return m_ScopeEntities[scope];
	}

	public void OnAbilityAdd(CompAbility compAbility)
	{
		foreach (Scope value in Enum.GetValues(typeof(Scope)))
		{
			if (InScope(value, compAbility.owner))
			{
				m_ScopeEntities[value].Add(compAbility.owner);
				m_ScopeAddAction[value]?.Invoke(compAbility.owner, ScopeChangeSource.CharacterSpawnRelease);
			}
		}
	}

	public void OnAbilityRemove(CompAbility compAbility)
	{
		foreach (Scope value in Enum.GetValues(typeof(Scope)))
		{
			if (InScope(value, compAbility.owner))
			{
				m_ScopeEntities[value].Remove(compAbility.owner);
				m_ScopeRemoveAction[value]?.Invoke(compAbility.owner, ScopeChangeSource.CharacterSpawnRelease);
			}
		}
	}

	public static bool InScope(Scope scope, Entity entityBehave)
	{
		switch (scope)
		{
		case Scope.FrontCharacter:
			return entityBehave == MonoECS.instance.mainEntity;
		case Scope.BackCharacter:
			if (entityBehave.IsCharacter())
			{
				return entityBehave != MonoECS.instance.mainEntity;
			}
			return false;
		case Scope.Character:
			return entityBehave.IsCharacter();
		case Scope.Enemy:
			return entityBehave.IsMonster();
		case Scope.All:
			if (!entityBehave.IsMonster())
			{
				return entityBehave.IsCharacter();
			}
			return true;
		default:
			return false;
		}
	}
}
