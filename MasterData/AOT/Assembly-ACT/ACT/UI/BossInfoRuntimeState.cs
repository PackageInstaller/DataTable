using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.UI;

internal sealed class BossInfoRuntimeState
{
	private struct BossInfoMemberState
	{
		public int MonsterId;

		public int BasicMaxHp;

		public int CurMaxHp;

		public int CurHp;

		public int BasicBloodNum;

		public static BossInfoMemberState Create(AddBossHatredEvt evt)
		{
			return new BossInfoMemberState
			{
				MonsterId = evt.id,
				BasicMaxHp = evt.basicMaxHp,
				CurMaxHp = evt.curMaxHp,
				CurHp = evt.curHp,
				BasicBloodNum = CalculateBasicBloodNum(evt.id, evt.level)
			};
		}

		public static bool TryCreate(Entity entity, out BossInfoMemberState state)
		{
			state = default;
			if (!entity.IsValid || !entity.TryGetCompMonster(out CompMonster component) || !entity.TryGetCompAbility(out CompAbility component2))
			{
				return false;
			}
			state = new BossInfoMemberState
			{
				MonsterId = component.id,
				BasicMaxHp = component2.maxHP,
				CurMaxHp = component2.maxHP,
				CurHp = component2.hp,
				BasicBloodNum = CalculateBasicBloodNum(component.id, component.level)
			};
			return true;
		}

		public void ApplyHpChange(EntityHpChangeEvt evt)
		{
			BasicMaxHp = evt.basicMaxHp;
			CurMaxHp = evt.curMaxHp;
			CurHp = evt.curHp;
		}

		private static int CalculateBasicBloodNum(int monsterId, int level)
		{
			EntityEnemyData data = CoreUtils.GetData(monsterId, RuntimeConfigs.data.entityEnemyDatas);
			TierHPLevelParm data2 = CoreUtils.GetData(level, RuntimeConfigs.data.tierHPLevelParms);
			return Mathf.CeilToInt((float)data.tierHPBase * data2.tierHPLevelParm);
		}
	}

	private readonly Dictionary<EntityId, BossInfoMemberState> _members = new Dictionary<EntityId, BossInfoMemberState>();

	private EntityId _singleEntityId;

	public bool IsInitialized { get; private set; }

	public bool IsSharedGroup { get; private set; }

	public int GroupUid { get; private set; } = -1;

	public EntityId FocusEntityId { get; private set; }

	public int CharacterDamageType { get; private set; }

	public bool CanHandle(AddBossHatredEvt evt)
	{
		if (!IsInitialized)
		{
			return false;
		}
		if (!evt.shareBossInfoUI || evt.bossInfoGroupUid < 0)
		{
			if (!IsSharedGroup)
			{
				return _singleEntityId == evt.entityId;
			}
			return false;
		}
		if (IsSharedGroup)
		{
			return GroupUid == evt.bossInfoGroupUid;
		}
		return false;
	}

	public bool Initialize(AddBossHatredEvt evt, Entity focusEntity)
	{
		Clear();
		IsSharedGroup = evt.shareBossInfoUI && evt.bossInfoGroupUid >= 0;
		GroupUid = (IsSharedGroup ? evt.bossInfoGroupUid : (-1));
		FocusEntityId = evt.entityId;
		CharacterDamageType = evt.damageType;
		if (IsSharedGroup)
		{
			List<Entity> members = BossInfoGroupUtility.GetMembers(GroupUid);
			if (members.Count == 0)
			{
				members.Add(focusEntity);
			}
			foreach (Entity item in members)
			{
				TryAddMember(item);
			}
		}
		else
		{
			_singleEntityId = evt.entityId;
			_members[evt.entityId] = BossInfoMemberState.Create(evt);
		}
		IsInitialized = _members.Count > 0;
		return IsInitialized;
	}

	public bool TryAddSharedGroupMember(EntityId entityId)
	{
		if (!IsSharedGroup || _members.ContainsKey(entityId))
		{
			return false;
		}
		Entity entity = GameManager.entities.GetEntity(entityId);
		if (!BossInfoGroupUtility.IsMember(entity, GroupUid))
		{
			return false;
		}
		return TryAddMember(entity);
	}

	public bool ContainsMember(EntityId entityId)
	{
		return _members.ContainsKey(entityId);
	}

	public void SetFocus(EntityId entityId)
	{
		FocusEntityId = entityId;
	}

	public void SetCharacterDamageType(int characterDamageType)
	{
		CharacterDamageType = characterDamageType;
	}

	public bool TryGetMonsterId(EntityId entityId, out int monsterId)
	{
		if (_members.TryGetValue(entityId, out var value))
		{
			monsterId = value.MonsterId;
			return monsterId > 0;
		}
		monsterId = 0;
		return false;
	}

	public void Clear()
	{
		_members.Clear();
		_singleEntityId = default;
		IsInitialized = false;
		IsSharedGroup = false;
		GroupUid = -1;
		FocusEntityId = default;
		CharacterDamageType = 0;
	}

	private bool TryAddMember(Entity member)
	{
		if (!member.IsValid || !member.TryGetCompBehave(out CompBehave component) || component.IsToRemove() || component.IsOnRemove() || !BossInfoMemberState.TryCreate(member, out var state))
		{
			return false;
		}
		_members[member.Id] = state;
		return true;
	}

	public bool TryApplyHpChange(EntityHpChangeEvt evt)
	{
		if (!_members.TryGetValue(evt.entityId, out var value))
		{
			return false;
		}
		value.ApplyHpChange(evt);
		_members[evt.entityId] = value;
		return true;
	}

	public BossBloodBarSnapshot CreateBloodBarSnapshot(bool inWeak)
	{
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		int num4 = 0;
		foreach (BossInfoMemberState value in _members.Values)
		{
			num += value.BasicMaxHp;
			num2 += value.CurMaxHp;
			num3 += value.CurHp;
			num4 += value.BasicBloodNum;
		}
		return new BossBloodBarSnapshot(num, num2, num3, num4, CharacterDamageType, inWeak);
	}
}
