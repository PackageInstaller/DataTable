using System.Collections.Generic;
using Ase.ECS;
using UnityEngine;

namespace Ase;

public class CampaignMonsterNode : CampaignNodeBase
{
	private readonly CampaignBattleContext context;

	private bool isKillDelayCounting;

	private float killDelayElapsedTime;

	public CampaignMonsterGroup OwnerGroup { get; private set; }

	public CampaignMonsterNodeData Data { get; private set; }

	public MonsterEntity Entity { get; private set; }

	public float ElapsedTime { get; private set; }

	public bool IsCampaignBattleActive { get; private set; }

	public int MonsterIndex => Data?.monsterIndex ?? 0;

	public int MonsterNodeKey => Data?.monsterNodeKey ?? 0;

	public int MonsterId => Data?.monsterId ?? 0;

	public bool IsAlive
	{
		get
		{
			if (Entity != null)
			{
				return Entity.IsSurvival;
			}
			return false;
		}
	}

	public CampaignMonsterNode(CampaignMonsterGroup ownerGroup, CampaignMonsterNodeData data, CampaignBattleContext context)
	{
		OwnerGroup = ownerGroup;
		Data = data;
		this.context = context;
	}

	public void Tick(float deltaTime)
	{
		if (base.IsWaiting)
		{
			ElapsedTime += deltaTime;
			if (IsActiveConditionMet(deltaTime))
			{
				context.SpawnMonsterNode(this);
			}
		}
	}

	public void BindEntity(MonsterEntity entity)
	{
		Entity = entity;
		Activate();
		InitializeCampaignBlackboard();
		context.ApplyFutureMonsterBuffs(this);
		ApplyBuffs(Data?.bornBuffNodeIds, "Born");
	}

	public void SetCampaignBattleActive(bool active, bool force)
	{
		if (Entity == null)
		{
			IsCampaignBattleActive = false;
		}
		else
		{
			if (!force && IsCampaignBattleActive == active)
			{
				return;
			}
			IsCampaignBattleActive = active;
			if (OwnerGroup.IsRangeEnabled)
			{
				AIParadoxComponent component = Entity.GetComponent<AIParadoxComponent>();
				component?.SetVariableValues("s_campaignBattleActive", !active);
				if (!active)
				{
					component?.SetVariableValues("e_targetID", 0);
				}
			}
		}
	}

	public void OnEntityDead()
	{
		ApplyBuffs(Data?.deadBuffNodeIds, "Dead");
		Complete();
	}

	public override void Complete()
	{
		base.Complete();
		IsCampaignBattleActive = false;
		Entity = null;
	}

	public override void Reset()
	{
		base.Reset();
		Entity = null;
		ElapsedTime = 0f;
		IsCampaignBattleActive = false;
		isKillDelayCounting = false;
		killDelayElapsedTime = 0f;
	}

	private void InitializeCampaignBlackboard()
	{
		if (Entity != null)
		{
			AIParadoxComponent component = Entity.GetComponent<AIParadoxComponent>();
			if (component != null)
			{
				Vector3 paramValue = ((Data != null) ? Data.monsterPos : Entity.transform.position);
				component.SetVariableValues("s_bornPos", paramValue);
				SetCampaignBattleActive(OwnerGroup != null && OwnerGroup.IsAlertAreaEntered, force: true);
			}
		}
	}

	private bool IsActiveConditionMet(float deltaTime)
	{
		if (Data == null)
		{
			return false;
		}
		switch (Data.activeType)
		{
		case CampaignMonsterGroupActiveType.None:
		case CampaignMonsterGroupActiveType.FollowGroup:
		case CampaignMonsterGroupActiveType.OtherGroupComplete:
			if (OwnerGroup != null)
			{
				return OwnerGroup.IsActive;
			}
			return false;
		case CampaignMonsterGroupActiveType.DelayTime:
			if (OwnerGroup != null && OwnerGroup.IsActive)
			{
				return ElapsedTime >= Data.monsterDelay;
			}
			return false;
		case CampaignMonsterGroupActiveType.PlayerKillSpecificMonster:
			return IsKillMonsterConditionMet(deltaTime);
		default:
			return false;
		}
	}

	private bool IsKillMonsterConditionMet(float deltaTime)
	{
		if (OwnerGroup == null || !OwnerGroup.IsActive || !context.IsMonsterNodeCompleted(Data.monsterStartConditionKey))
		{
			isKillDelayCounting = false;
			killDelayElapsedTime = 0f;
			return false;
		}
		if (Data.monsterKillDelay <= 0f)
		{
			return true;
		}
		if (!isKillDelayCounting)
		{
			isKillDelayCounting = true;
			killDelayElapsedTime = 0f;
		}
		killDelayElapsedTime += deltaTime;
		return killDelayElapsedTime >= Data.monsterKillDelay;
	}

	private void ApplyBuffs(List<int> buffNodeIds, string timing)
	{
		if (buffNodeIds != null && buffNodeIds.Count != 0)
		{
			context.ApplyCampaignBuffs(buffNodeIds, OwnerGroup, this);
		}
	}
}
