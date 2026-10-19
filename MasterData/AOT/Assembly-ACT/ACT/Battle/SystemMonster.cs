using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class SystemMonster : EntitySystem
{
	public readonly List<int> SendSeverList = new List<int>();

	private Filter _newMonsterFilter;

	private Filter _filter;

	private EntityAction<CompMonster> _updateNewMonsterAction;

	private EntityAction _releaseMonsterAction;

	private EntityAction _clearMonsterHatredAndHideAction;

	private EntityAction _clearMonsterHatredAction;

	private EntityAction _showMonsterRendererAction;

	private EntityAction<CompMonster> _collectAliveMonsterAction;

	private List<Entity> _aliveMonsterResults;

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_newMonsterFilter = World.NewFilter().All<CompMonster, CompMonsterNew>().Build();
		_filter = World.NewFilter().All<CompMonster>().Build();
		_updateNewMonsterAction = UpdateNewMonster;
		_releaseMonsterAction = ReleaseMonster;
		_clearMonsterHatredAndHideAction = ClearMonsterHatredAndHide;
		_clearMonsterHatredAction = ClearMonsterHatred;
		_showMonsterRendererAction = ShowMonsterRenderer;
		_collectAliveMonsterAction = CollectAliveMonster;
	}

	public override void Update()
	{
		if (MonoECS.instance.mainEntity.IsValid)
		{
			_newMonsterFilter.ForEach(_updateNewMonsterAction);
		}
	}

	public void CollectAliveMonsters(List<Entity> results)
	{
		results.Clear();
		_aliveMonsterResults = results;
		_filter.ForEachStable(_collectAliveMonsterAction);
		_aliveMonsterResults = null;
	}

	private void CollectAliveMonster(Entity entity, CompMonster compMonster)
	{
		if (entity.IsActive() && entity.IsAlive())
		{
			_aliveMonsterResults.Add(entity);
		}
	}

	private void UpdateNewMonster(Entity entity, CompMonster compMonster)
	{
		MonoEntity mono = entity.GetMono();
		if ((object)mono == null)
		{
			return;
		}
		EntityEnemyData data = CoreUtils.GetData(compMonster.id, RuntimeConfigs.data.entityEnemyDatas);
		if (Model<MonsterHandModel>.Interface != null && !Model<MonsterHandModel>.Interface.MonsterIsUnLock(data.enemyType) && data.enemyType != 0)
		{
			int enemyType = data.enemyType;
			if (GameUtility.IsInView(mono.GetAttachPoint(BattleConsts.AIM_ATTACH_POINT).position))
			{
				SendSeverList.Add(enemyType);
				Model<MonsterHandModel>.Interface.SendUnLockMonster(enemyType);
			}
			entity.RemoveComponent<CompMonsterNew>();
		}
	}

	public void ReleaseAllMonster()
	{
		_filter.ForEach(_releaseMonsterAction);
	}

	private void ReleaseMonster(Entity entity)
	{
		GameManager.hatredSystem.OnEntityRemoving(entity);
		World.DestroyEntity(entity.Id);
	}

	public void ClearAllMonsterHatredAndHide()
	{
		_filter.ForEach(_clearMonsterHatredAndHideAction);
	}

	public void ClearAllMonsterHatred()
	{
		_filter.ForEach(_clearMonsterHatredAction);
	}

	public void ShowAllMonsterRenderer()
	{
		_filter.ForEach(_showMonsterRendererAction);
	}

	private void ClearMonsterHatredAndHide(Entity entity)
	{
		if (entity.GetEntityType() == EntityType.Boss)
		{
			return;
		}
		SetEntityVisible(entity, visible: false);
		ClearMonsterHatred(entity);
		if (entity.TryGetCompEffect(out CompEffect component))
		{
			List<EffectRuntimeItem> myEffects = component.myEffects;
			for (int num = myEffects.Count - 1; num >= 0; num--)
			{
				myEffects[num].SyncEffectActiveOrNot(isShow: false);
			}
		}
		if (entity.TryGetCompTime(out CompTime component2))
		{
			component2.motionScale = 0f;
		}
	}

	private void SetEntityVisible(Entity entity, bool visible)
	{
		MonoEntity mono = entity.GetMono();
		if ((object)mono != null)
		{
			Renderer[] renderers = mono.renderers;
			for (int i = 0; i < renderers.Length; i++)
			{
				renderers[i].enabled = visible;
			}
			if (entity.TryGetCompTime(out CompTime component))
			{
				component.motionScale = (visible ? 1 : 0);
			}
		}
	}

	private void ClearMonsterHatred(Entity entity)
	{
		entity.GetCompHatred()?.ClearHatred();
	}

	private void ShowMonsterRenderer(Entity entity)
	{
		SetEntityVisible(entity, visible: true);
		ResetTimelineMotionState(entity);
		ClearMonsterHatred(entity);
	}

	private void ResetTimelineMotionState(Entity entity)
	{
		if (entity.GetEntityType() != EntityType.Boss && entity.IsAlive() && entity.TryGetCompMotion(out CompMotion _))
		{
			GameManager.behaveSystem.TimelineStop(entity, force: false);
		}
	}
}
