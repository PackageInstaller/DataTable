#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using UnityEngine;

namespace Ase;

public class CampaignMonsterGroup : CampaignNodeBase
{
	private const float BattleResetTolerance = 1f;

	private readonly List<CampaignMonsterNode> monsterNodes = new List<CampaignMonsterNode>();

	private readonly List<CampaignMonsterNode> fixedMonsterLoadNodes = new List<CampaignMonsterNode>();

	private readonly CampaignBattleContext context;

	private bool hasAppliedBornBuff;

	private bool isWaitingForBattleReset;

	private bool isOtherGroupDelayCounting;

	private float otherGroupCompleteElapsedTime;

	private bool isExternalActivationDelayCounting;

	private float externalActivationDelay;

	private float externalActivationElapsedTime;

	private int fixedMonsterLoadIndex;

	public CampaignMonsterGroupData Data { get; private set; }

	public IReadOnlyList<CampaignMonsterNode> MonsterNodes => monsterNodes;

	public float ElapsedTime { get; private set; }

	public bool IsAlertAreaEntered { get; private set; }

	public bool HasMonsterOutsideActivityArea { get; private set; }

	public bool IsCampaignBattleActive { get; private set; }

	public Vector3 GroupCenter => Data?.monsterGroupPos ?? Vector3.zero;

	public Vector3 ActivityCenter => GetActivityCenter();

	public int GroupId => Data?.groupId ?? 0;

	public bool IsRangeEnabled => Data?.enableRange ?? false;

	public CampaignMonsterGroup(CampaignMonsterGroupData data, CampaignBattleContext context)
	{
		Data = data;
		this.context = context;
		if (data?.monsterNodes == null)
		{
			return;
		}
		for (int i = 0; i < data.monsterNodes.Count; i++)
		{
			CampaignMonsterNodeData campaignMonsterNodeData = data.monsterNodes[i];
			if (campaignMonsterNodeData != null)
			{
				monsterNodes.Add(new CampaignMonsterNode(this, campaignMonsterNodeData, context));
			}
		}
		BuildFixedMonsterLoadNodes();
	}

	public void Tick(float deltaTime)
	{
		if (base.IsWaiting && (IsExternalActivationConditionMet(deltaTime) || IsActiveConditionMet(deltaTime)))
		{
			Activate();
		}
		if (!base.IsActive)
		{
			return;
		}
		UpdateAreaState();
		if (IsFixedMonsterCountEnabled())
		{
			TickFixedMonsterNodes(deltaTime);
		}
		else
		{
			for (int i = 0; i < monsterNodes.Count; i++)
			{
				monsterNodes[i].Tick(deltaTime);
			}
		}
		TryApplyBornBuff();
		UpdateMonsterBattleActiveState();
		if (IsAllMonsterCompleted())
		{
			Complete();
		}
	}

	public CampaignMonsterNode GetMonsterNode(int monsterIndex)
	{
		for (int i = 0; i < monsterNodes.Count; i++)
		{
			if (monsterNodes[i].MonsterIndex == monsterIndex)
			{
				return monsterNodes[i];
			}
		}
		return null;
	}

	public bool IsAllMonsterCompleted()
	{
		if (monsterNodes.Count == 0)
		{
			return base.IsActive;
		}
		for (int i = 0; i < monsterNodes.Count; i++)
		{
			if (!monsterNodes[i].IsCompleted)
			{
				return false;
			}
		}
		return true;
	}

	public float GetAlertAreaRange()
	{
		if (!IsRangeEnabled)
		{
			return 0f;
		}
		return Data?.alertAreaRange ?? 0f;
	}

	public float GetActivityAreaRange()
	{
		if (!IsRangeEnabled)
		{
			return 0f;
		}
		return Data?.activityAreaRange ?? 0f;
	}

	public Vector2 GetActivityAreaRangeOffset()
	{
		if (!IsRangeEnabled)
		{
			return Vector2.zero;
		}
		return Data?.activityAreaRangeOffset ?? Vector2.zero;
	}

	public Vector3 GetActivityCenter()
	{
		Vector2 activityAreaRangeOffset = GetActivityAreaRangeOffset();
		return GroupCenter + new Vector3(activityAreaRangeOffset.x, 0f, activityAreaRangeOffset.y);
	}

	public bool IsPositionOutsideActivityArea(Vector3 position)
	{
		float activityAreaRange = GetActivityAreaRange();
		if (activityAreaRange <= 0f)
		{
			return false;
		}
		return SqrDistanceXZ(position, ActivityCenter) > activityAreaRange * activityAreaRange;
	}

	public override void Activate()
	{
		if (base.IsWaiting)
		{
			base.Activate();
			ElapsedTime = 0f;
			hasAppliedBornBuff = false;
			isExternalActivationDelayCounting = false;
			externalActivationElapsedTime = 0f;
			SetAirWallsActive(active: true);
			PlayActivePopup();
		}
	}

	public bool RequestExternalActivation(float delayTime)
	{
		if (!base.IsWaiting)
		{
			return true;
		}
		if (!IsExternalActivationType())
		{
			return false;
		}
		if (delayTime <= 0f)
		{
			Activate();
			return true;
		}
		isExternalActivationDelayCounting = true;
		externalActivationDelay = delayTime;
		externalActivationElapsedTime = 0f;
		return true;
	}

	public void HideConfiguredAirWalls()
	{
		if (Data != null && Data.controlAirWall && Data.airWallIds != null && Data.airWallIds.Count != 0)
		{
			context.QueueAirWallsActive(Data.airWallIds, active: false);
		}
	}

	public override void Complete()
	{
		if (!base.IsCompleted)
		{
			base.Complete();
			context.RemoveFollowBuffsForGroup(GroupId);
			ApplyBuffs(Data?.deadBuffNodeIds, "Dead");
			HideConfiguredAirWalls();
			ExecuteCompleteEvent();
		}
	}

	public override void Reset()
	{
		base.Reset();
		context.RemoveFollowBuffsForGroup(GroupId);
		ElapsedTime = 0f;
		hasAppliedBornBuff = false;
		IsAlertAreaEntered = false;
		HasMonsterOutsideActivityArea = false;
		IsCampaignBattleActive = false;
		isWaitingForBattleReset = false;
		isOtherGroupDelayCounting = false;
		otherGroupCompleteElapsedTime = 0f;
		isExternalActivationDelayCounting = false;
		externalActivationDelay = 0f;
		externalActivationElapsedTime = 0f;
		HideConfiguredAirWalls();
		for (int i = 0; i < monsterNodes.Count; i++)
		{
			monsterNodes[i].Reset();
		}
		fixedMonsterLoadIndex = 0;
	}

	private void TickFixedMonsterNodes(float deltaTime)
	{
		OpenFixedMonsterLoadSlots();
		for (int i = 0; i < fixedMonsterLoadIndex && i < fixedMonsterLoadNodes.Count; i++)
		{
			fixedMonsterLoadNodes[i]?.Tick(deltaTime);
		}
		OpenFixedMonsterLoadSlots();
	}

	private void OpenFixedMonsterLoadSlots()
	{
		int num = Mathf.Min(Data.fixedMonsterCountValue, fixedMonsterLoadNodes.Count);
		int num2 = GetFixedMonsterLoadingCount();
		while (num2 < num && fixedMonsterLoadIndex < fixedMonsterLoadNodes.Count)
		{
			CampaignMonsterNode campaignMonsterNode = fixedMonsterLoadNodes[fixedMonsterLoadIndex];
			fixedMonsterLoadIndex++;
			if (campaignMonsterNode != null && !campaignMonsterNode.IsCompleted)
			{
				num2++;
			}
		}
	}

	private int GetFixedMonsterLoadingCount()
	{
		int num = 0;
		for (int i = 0; i < fixedMonsterLoadIndex && i < fixedMonsterLoadNodes.Count; i++)
		{
			CampaignMonsterNode campaignMonsterNode = fixedMonsterLoadNodes[i];
			if (campaignMonsterNode != null && !campaignMonsterNode.IsCompleted)
			{
				num++;
			}
		}
		return num;
	}

	private bool IsFixedMonsterCountEnabled()
	{
		if (Data != null && Data.fixedMonsterCount && Data.fixedMonsterCountValue > 0 && Data.fixedMonsterCountValue < monsterNodes.Count)
		{
			return fixedMonsterLoadNodes.Count > 0;
		}
		return false;
	}

	private void BuildFixedMonsterLoadNodes()
	{
		fixedMonsterLoadNodes.Clear();
		fixedMonsterLoadIndex = 0;
		if (Data == null || !Data.fixedMonsterCount)
		{
			return;
		}
		if (Data.fixedMonsterCountValue <= 0)
		{
			Log.Error($"[Campaign] 怪物组固定数量配置无效。组Id={GroupId}，固定数量={Data.fixedMonsterCountValue}。");
		}
		else
		{
			if (monsterNodes.Count == 0)
			{
				return;
			}
			Dictionary<int, CampaignMonsterNode> dictionary = new Dictionary<int, CampaignMonsterNode>();
			for (int i = 0; i < monsterNodes.Count; i++)
			{
				CampaignMonsterNode campaignMonsterNode = monsterNodes[i];
				if (campaignMonsterNode != null)
				{
					if (dictionary.ContainsKey(campaignMonsterNode.MonsterIndex))
					{
						Log.Error($"[Campaign] 怪物组存在重复怪物序号，固定数量顺序将回退为节点编号顺序。组Id={GroupId}，怪物序号={campaignMonsterNode.MonsterIndex}。");
						AddSortedFixedMonsterLoadNodes();
						return;
					}
					dictionary.Add(campaignMonsterNode.MonsterIndex, campaignMonsterNode);
				}
			}
			if (!TryBuildFixedMonsterLoadNodesByOrder(dictionary))
			{
				AddSortedFixedMonsterLoadNodes();
			}
		}
	}

	private bool TryBuildFixedMonsterLoadNodesByOrder(Dictionary<int, CampaignMonsterNode> nodeByIndex)
	{
		if (Data.fixedMonsterLoadOrder == null || Data.fixedMonsterLoadOrder.Count == 0)
		{
			Log.Error($"[Campaign] 怪物组固定数量缺少加载顺序，将回退为节点编号顺序。组Id={GroupId}。");
			return false;
		}
		if (Data.fixedMonsterLoadOrder.Count != monsterNodes.Count)
		{
			Log.Error($"[Campaign] 怪物组固定数量加载顺序数量错误，将回退为节点编号顺序。组Id={GroupId}，顺序数量={Data.fixedMonsterLoadOrder.Count}，节点数量={monsterNodes.Count}。");
			return false;
		}
		HashSet<int> hashSet = new HashSet<int>();
		for (int i = 0; i < Data.fixedMonsterLoadOrder.Count; i++)
		{
			int num = Data.fixedMonsterLoadOrder[i];
			if (!nodeByIndex.TryGetValue(num, out var value))
			{
				Log.Error($"[Campaign] 怪物组固定数量加载顺序包含不存在的怪物序号，将回退为节点编号顺序。组Id={GroupId}，怪物序号={num}。");
				fixedMonsterLoadNodes.Clear();
				return false;
			}
			if (!hashSet.Add(num))
			{
				Log.Error($"[Campaign] 怪物组固定数量加载顺序包含重复怪物序号，将回退为节点编号顺序。组Id={GroupId}，怪物序号={num}。");
				fixedMonsterLoadNodes.Clear();
				return false;
			}
			fixedMonsterLoadNodes.Add(value);
		}
		return true;
	}

	private void AddSortedFixedMonsterLoadNodes()
	{
		fixedMonsterLoadNodes.Clear();
		fixedMonsterLoadNodes.AddRange(monsterNodes);
		fixedMonsterLoadNodes.Sort(CompareMonsterNodeIndex);
	}

	private static int CompareMonsterNodeIndex(CampaignMonsterNode left, CampaignMonsterNode right)
	{
		int num = left?.MonsterIndex ?? 0;
		int value = right?.MonsterIndex ?? 0;
		return num.CompareTo(value);
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
			return Data.startActive;
		case CampaignMonsterGroupActiveType.DelayTime:
			ElapsedTime += deltaTime;
			return ElapsedTime >= Data.delayTime;
		case CampaignMonsterGroupActiveType.FollowGroup:
			return context.IsPreviousGroupCompleted(this);
		case CampaignMonsterGroupActiveType.OtherGroupComplete:
			return IsOtherGroupCompleteConditionMet(deltaTime);
		default:
			return false;
		}
	}

	private bool IsExternalActivationType()
	{
		if (Data == null)
		{
			return false;
		}
		if (Data.activeType == CampaignMonsterGroupActiveType.None)
		{
			return !Data.startActive;
		}
		return false;
	}

	private bool IsExternalActivationConditionMet(float deltaTime)
	{
		if (!isExternalActivationDelayCounting)
		{
			return false;
		}
		externalActivationElapsedTime += deltaTime;
		return externalActivationElapsedTime >= externalActivationDelay;
	}

	private bool IsOtherGroupCompleteConditionMet(float deltaTime)
	{
		if (!context.IsMonsterGroupCompleted(Data.otherGroupId))
		{
			isOtherGroupDelayCounting = false;
			otherGroupCompleteElapsedTime = 0f;
			return false;
		}
		if (!isOtherGroupDelayCounting)
		{
			isOtherGroupDelayCounting = true;
			otherGroupCompleteElapsedTime = 0f;
		}
		otherGroupCompleteElapsedTime += deltaTime;
		return otherGroupCompleteElapsedTime >= Data.delayBornTime;
	}

	private void UpdateAreaState()
	{
		if (!IsRangeEnabled)
		{
			IsAlertAreaEntered = true;
			HasMonsterOutsideActivityArea = false;
		}
		else
		{
			IsAlertAreaEntered = context.IsHeroInRange(GroupCenter, GetAlertAreaRange());
			HasMonsterOutsideActivityArea = IsAnyMonsterOutsideActivityArea();
		}
	}

	private void TryApplyBornBuff()
	{
		if (!hasAppliedBornBuff && (!IsGroupBuffTargetNeedSpawnedMonster() || monsterNodes.Count <= 0 || HasAnySpawnedMonster()))
		{
			hasAppliedBornBuff = true;
			ApplyBuffs(Data?.bornBuffNodeIds, "Born");
		}
	}

	private bool IsGroupBuffTargetNeedSpawnedMonster()
	{
		if (Data != null)
		{
			return context.DoesAnyBuffNeedSpawnedMonster(Data.bornBuffNodeIds);
		}
		return false;
	}

	private bool HasAnySpawnedMonster()
	{
		for (int i = 0; i < monsterNodes.Count; i++)
		{
			if (monsterNodes[i]?.Entity != null)
			{
				return true;
			}
		}
		return false;
	}

	private bool IsAnyMonsterOutsideActivityArea()
	{
		if (!IsRangeEnabled || GetActivityAreaRange() <= 0f)
		{
			return false;
		}
		for (int i = 0; i < monsterNodes.Count; i++)
		{
			CampaignMonsterNode campaignMonsterNode = monsterNodes[i];
			if (campaignMonsterNode?.Entity != null && campaignMonsterNode.Entity.IsSurvival && IsPositionOutsideActivityArea(campaignMonsterNode.Entity.transform.position))
			{
				return true;
			}
		}
		return false;
	}

	private void UpdateMonsterBattleActiveState()
	{
		if (!IsRangeEnabled)
		{
			isWaitingForBattleReset = false;
			SetMonsterBattleActive(active: true);
			return;
		}
		if (HasMonsterOutsideActivityArea)
		{
			isWaitingForBattleReset = true;
			SetMonsterBattleActive(active: false);
			return;
		}
		if (isWaitingForBattleReset)
		{
			SetMonsterBattleActive(active: false);
			if (!IsBattleResetFinished())
			{
				return;
			}
			isWaitingForBattleReset = false;
		}
		if (IsAlertAreaEntered)
		{
			SetMonsterBattleActive(active: true);
		}
	}

	private void SetMonsterBattleActive(bool active)
	{
		IsCampaignBattleActive = active;
		for (int i = 0; i < monsterNodes.Count; i++)
		{
			CampaignMonsterNode campaignMonsterNode = monsterNodes[i];
			if (campaignMonsterNode?.Entity != null && campaignMonsterNode.Entity.IsSurvival)
			{
				campaignMonsterNode.SetCampaignBattleActive(active, force: false);
			}
		}
	}

	private bool IsBattleResetFinished()
	{
		float num = 1f;
		for (int i = 0; i < monsterNodes.Count; i++)
		{
			CampaignMonsterNode campaignMonsterNode = monsterNodes[i];
			if (campaignMonsterNode?.Entity != null && campaignMonsterNode.Entity.IsSurvival && campaignMonsterNode.Data != null && SqrDistanceXZ(campaignMonsterNode.Entity.transform.position, campaignMonsterNode.Data.monsterPos) > num)
			{
				return false;
			}
		}
		return true;
	}

	private void ApplyBuffs(List<int> buffNodeIds, string timing)
	{
		if (buffNodeIds != null && buffNodeIds.Count != 0)
		{
			context.ApplyCampaignBuffs(buffNodeIds, this);
		}
	}

	private void SetAirWallsActive(bool active)
	{
		if (Data != null && Data.controlAirWall && Data.airWallIds != null && Data.airWallIds.Count != 0)
		{
			context.QueueAirWallsActive(Data.airWallIds, active);
		}
	}

	private void ExecuteCompleteEvent()
	{
		if (Data != null && Data.addEventOnComplete)
		{
			switch (Data.addEvent)
			{
			case CampaignTriggerType.Monster:
				context.ActivateMonsterGroup(Data.nextGroupId, Data.nextGroupDelayBornTime);
				break;
			case CampaignTriggerType.Buff:
				context.ApplyCampaignBuffs(Data.completeBuffNodeIds, this);
				break;
			case CampaignTriggerType.Win:
				context.GameSettlement(GameSettlementType.MonsterDead);
				break;
			case CampaignTriggerType.Popup:
				context.PlayPopupTip(Data.completePopupTipType, Data.completePopupId);
				break;
			}
		}
	}

	private void PlayActivePopup()
	{
		if (Data != null && Data.openPopupOnActive)
		{
			context.PlayPopupTip(Data.activePopupTipType, Data.activePopupId);
		}
	}

	private static float SqrDistanceXZ(Vector3 a, Vector3 b)
	{
		float num = a.x - b.x;
		float num2 = a.z - b.z;
		return num * num + num2 * num2;
	}
}
