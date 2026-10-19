using System.Collections.Generic;
using ACT.Event;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle.ECS.System;

public class SystemHatred : EntitySystem
{
	public List<Entity> hatredList = new List<Entity>();

	private List<Entity> bossHatredList = new List<Entity>();

	private Entity bossUIEntity;

	private int bossUIGroupUid = -1;

	public override Filter MajorFilter => null;

	protected override void OnCreate()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AddHatred, AddHatred);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RemoveHatred, RemoveHatred);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ClearHatred, ClearHatred);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnRemoveEntityBeahve, OnRemoveEntityBehave);
	}

	protected override void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AddHatred, AddHatred);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RemoveHatred, RemoveHatred);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ClearHatred, ClearHatred);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnRemoveEntityBeahve, OnRemoveEntityBehave);
	}

	public void AddHatred(BaseEventContent evt)
	{
		if (evt is HatredEntity { entity: var entity } && !hatredList.Contains(entity) && !(entity.GetModel() == null) && entity.GetModel().activeSelf)
		{
			hatredList.Add(entity);
			if (entity.GetEntityType() == EntityType.Boss)
			{
				AddBossHatred(entity);
			}
			RefreshBattleState();
		}
	}

	public void RemoveHatred(BaseEventContent evt)
	{
		if (evt is HatredEntity hatredEntity && hatredList.Contains(hatredEntity.entity))
		{
			hatredList.Remove(hatredEntity.entity);
			if (hatredEntity.entity.GetEntityType() == EntityType.Boss)
			{
				RemoveBossHatred(hatredEntity.entity);
			}
			RefreshBattleState();
		}
	}

	public void ClearHatred(BaseEventContent evt)
	{
		hatredList.Clear();
		bossHatredList.Clear();
		RefreshBattleState();
		HideBossBloodBar();
	}

	public void RefreshBattleState()
	{
		BattleState battleState = CheckBattleState();
		if (battleState != BattleState.None)
		{
			MonoECS.instance.playState = PlayState.Battle;
		}
		else
		{
			MonoECS.instance.playState = PlayState.UnBattle;
		}
		Singleton<GameState>.instance.SetBattleState(battleState);
	}

	private BattleState CheckBattleState()
	{
		BattleState battleState = BattleState.None;
		foreach (Entity hatred in hatredList)
		{
			if (!hatred.TryGetCompHatred(out CompHatred component))
			{
				continue;
			}
			Entity hatredTarget = component.hatredTarget;
			if (!hatredTarget.IsValid)
			{
				continue;
			}
			switch (hatred.GetEntityType())
			{
			case EntityType.Boss:
				return BattleState.Boss;
			case EntityType.Elite:
				battleState = BattleState.Elite;
				break;
			case EntityType.Monster:
				if (battleState == BattleState.None)
				{
					battleState = BattleState.Normal;
				}
				break;
			}
		}
		return battleState;
	}

	private void OnRemoveEntityBehave(BaseEventContent evt)
	{
		if (evt is RemoveEntityBehaveEvt removeEntityBehaveEvt)
		{
			OnEntityRemoving(removeEntityBehaveEvt.entityBehave);
		}
	}

	internal void OnEntityRemoving(Entity entity)
	{
		if (bossUIGroupUid >= 0 && BossInfoGroupUtility.IsMember(entity, bossUIGroupUid) && !BossInfoGroupUtility.HasAliveMember(bossUIGroupUid, entity))
		{
			HideBossBloodBar();
		}
	}

	private void AddBossHatred(Entity entityBehave)
	{
		if (!bossHatredList.Contains(entityBehave))
		{
			bossHatredList.Add(entityBehave);
			ShowBossBloodBar(entityBehave);
		}
	}

	private void RemoveBossHatred(Entity entityBehave)
	{
		if (!bossHatredList.Contains(entityBehave))
		{
			return;
		}
		bossHatredList.Remove(entityBehave);
		if ((bossUIEntity.IsValid || bossUIEntity == entityBehave) && bossHatredList.Count > 0)
		{
			List<Entity> list = bossHatredList;
			ShowBossBloodBar(list[list.Count - 1]);
		}
		if (bossHatredList.Count == 0)
		{
			if (BossInfoGroupUtility.TryGetGroupId(entityBehave, out var groupId) && BossInfoGroupUtility.HasAliveMember(groupId))
			{
				bossUIEntity = default;
				return;
			}
			bossUIEntity = default;
			HideBossBloodBar();
		}
	}

	private void ShowBossBloodBar(Entity eb)
	{
		bossUIEntity = eb;
		EventManager instance = Singleton<EventManager>.instance;
		AddBossHatredEvt evt = instance.GetEvt<AddBossHatredEvt>();
		evt.entityId = eb.Id;
		CompMonster compMonster = eb.GetCompMonster();
		evt.id = compMonster.id;
		evt.level = compMonster.level;
		evt.shareBossInfoUI = BossInfoGroupUtility.TryGetGroupId(eb, out var groupId);
		evt.bossInfoGroupUid = groupId;
		bossUIGroupUid = (evt.shareBossInfoUI ? groupId : (-1));
		CompAbility compAbility = eb.GetCompAbility();
		evt.basicMaxHp = compAbility.maxHP;
		evt.curMaxHp = compAbility.maxHP;
		evt.curHp = compAbility.hp;
		evt.inPosture = compAbility.IsHavePosture;
		evt.maxPosture = compAbility.maxPosture;
		evt.curPosture = compAbility.posture;
		evt.curPosturePercentage = (float)compAbility.posture / (float)compAbility.maxPosture;
		evt.inWeak = compAbility.IsWeak;
		evt.curWeakPercentage = compAbility.revivePostureProgress;
		evt.inBurst = compAbility.IsPostureBurst;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Boss_AddHatred, evt);
		instance.ReleaseEvt(evt);
	}

	public void RefreshBossBloodBar(Entity eb)
	{
		if (bossHatredList.Contains(eb))
		{
			ShowBossBloodBar(eb);
		}
	}

	public void HideBossBloodBar()
	{
		bossUIGroupUid = -1;
		EventManager instance = Singleton<EventManager>.instance;
		RemoveBossHatredEvt evt = instance.GetEvt<RemoveBossHatredEvt>();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Boss_RemoveHatred, evt);
		instance.ReleaseEvt(evt);
	}
}
