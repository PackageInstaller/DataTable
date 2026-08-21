using UnityEngine;

namespace Ase;

public class CampaignTriggerNode : CampaignNodeBase
{
	private readonly CampaignBattleContext context;

	private int executedCount;

	private float enterElapsedTime;

	private bool hasExecutedThisEnter;

	public GameObject Cube;

	public CampaignTriggerData Data { get; private set; }

	public float ElapsedTime { get; private set; }

	public bool IsWinTrigger { get; private set; }

	public CampaignTriggerNode(CampaignTriggerData data, CampaignBattleContext context)
	{
		Data = data;
		this.context = context;
	}

	public bool Tick(float deltaTime)
	{
		if (base.IsCompleted)
		{
			return false;
		}
		ElapsedTime += deltaTime;
		if (IsTriggerCountReached() || !IsDelayReady())
		{
			return false;
		}
		if (!context.IsHeroEnterTriggerArea(Data))
		{
			enterElapsedTime = 0f;
			hasExecutedThisEnter = false;
			return false;
		}
		if (hasExecutedThisEnter)
		{
			return false;
		}
		if (IsWinTriggerWaitingForEnterTime(deltaTime))
		{
			return false;
		}
		return Execute();
	}

	public bool IsDelayReady()
	{
		if (Data != null)
		{
			return ElapsedTime >= Data.delayTime;
		}
		return true;
	}

	public override void Reset()
	{
		base.Reset();
		ElapsedTime = 0f;
		IsWinTrigger = false;
		executedCount = 0;
		enterElapsedTime = 0f;
		hasExecutedThisEnter = false;
	}

	private bool Execute()
	{
		if (Data == null)
		{
			Complete();
			return true;
		}
		switch (Data.triggerType)
		{
		case CampaignTriggerType.Monster:
			context.ActivateMonsterGroup(Data.monsterGroupId);
			break;
		case CampaignTriggerType.Buff:
			ApplyBuff();
			break;
		case CampaignTriggerType.Win:
			IsWinTrigger = true;
			context.GameSettlement(GameSettlementType.MonsterDead);
			break;
		case CampaignTriggerType.Popup:
			context.PlayPopupTip(Data.popupTipType, Data.popupId);
			break;
		}
		executedCount++;
		enterElapsedTime = 0f;
		hasExecutedThisEnter = true;
		if (IsWinTrigger || IsTriggerCountReached())
		{
			Complete();
		}
		Cube?.SetActive(value: false);
		return true;
	}

	public override void Complete()
	{
		base.Complete();
	}

	private bool IsTriggerCountReached()
	{
		return executedCount >= GetTriggerCount();
	}

	private int GetTriggerCount()
	{
		if (Data != null && Data.triggerCount > 0)
		{
			return Data.triggerCount;
		}
		return 1;
	}

	private bool IsWinTriggerWaitingForEnterTime(float deltaTime)
	{
		if (Data == null || Data.triggerType != CampaignTriggerType.Win || Data.winEnterTime <= 0f)
		{
			return false;
		}
		enterElapsedTime += deltaTime;
		return enterElapsedTime < Data.winEnterTime;
	}

	private void ApplyBuff()
	{
		if (Data != null && Data.buffNodeIds != null && Data.buffNodeIds.Count != 0)
		{
			context.ApplyCampaignBuffs(Data.buffNodeIds, null, null, Data);
		}
	}
}
