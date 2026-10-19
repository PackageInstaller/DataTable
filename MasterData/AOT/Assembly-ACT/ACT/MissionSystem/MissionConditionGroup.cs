using System;
using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

public sealed class MissionConditionGroup
{
	private readonly int m_ConditionGroupIndex;

	private readonly MissionConditionGroupData m_Data;

	public MissionCondition[] Conditions;

	public MissionAction[] Actions;

	private MissionStage m_Stage;

	public MissionStageCheckMode LogicMode => m_Data.LogicMode;

	public MissionStageActionMode ActionMode => m_Data.ActionMode;

	public MissionConditionGroupTriggerType ActionTriggerMode => m_Data.ActionTriggerMode;

	public bool IsRepeatGroup => m_Data.ActionTriggerMode == MissionConditionGroupTriggerType.Repeated;

	public bool IsActive { get; private set; }

	public MissionConditionGroup(int conditionGroupIndex, MissionConditionGroupData conditionGroupData)
	{
		m_ConditionGroupIndex = conditionGroupIndex;
		m_Data = conditionGroupData;
	}

	public void Init(MissionStage missionStage)
	{
		m_Stage = missionStage;
	}

	internal bool NeedsConditions(IReadOnlyStageState stageState)
	{
		if (!IsRepeatGroup)
		{
			return !stageState.ConditionGroupStates[m_ConditionGroupIndex].IsAchieve();
		}
		return true;
	}

	internal void SetActive(bool active)
	{
		IsActive = active;
	}

	public async UniTask ExecuteActions(IReadOnlyConditionGroupState conditionGroupState, CancellationToken token)
	{
		switch (ActionMode)
		{
		case MissionStageActionMode.Parallel:
		{
			List<UniTask> tasks = ListPool<UniTask>.Get();
			try
			{
				for (int j = 0; j < Actions.Length; j++)
				{
					MissionAction missionAction2 = Actions[j];
					if (missionAction2 != null)
					{
						IReadonlyActionState actionState2 = conditionGroupState.GetActionState(missionAction2.Id);
						bool num2 = !actionState2.Finished || missionAction2.MustDo || IsRepeatGroup;
						bool fromMustDo2 = actionState2.Finished && missionAction2.MustDo;
						if (num2)
						{
							tasks.Add(missionAction2.Invoke(m_ConditionGroupIndex, ParallelQuestContext.Instance, fromMustDo2, token));
						}
					}
				}
				await UniTask.WhenAll(tasks).AttachExternalCancellation(token).SuppressCancellationThrow();
				break;
			}
			catch (Exception message3)
			{
				Debug.LogError(message3);
				break;
			}
			finally
			{
				ListPool<UniTask>.Release(tasks);
			}
		}
		case MissionStageActionMode.Sequence:
		{
			QueueQuestContext context = QueueQuestContext.Create();
			try
			{
				for (int i = 0; i < Actions.Length; i++)
				{
					MissionAction missionAction = Actions[i];
					if (missionAction != null)
					{
						IReadonlyActionState actionState = conditionGroupState.GetActionState(missionAction.Id);
						bool num = actionState == null || !actionState.Finished || missionAction.MustDo || IsRepeatGroup;
						bool fromMustDo = actionState.Finished && missionAction.MustDo;
						if (num)
						{
							await missionAction.Invoke(m_ConditionGroupIndex, context, fromMustDo, token);
						}
						if (token.IsCancellationRequested)
						{
							break;
						}
					}
				}
			}
			catch (Exception message)
			{
				Debug.LogError(message);
			}
			try
			{
				await context.EndAllScope(token);
				break;
			}
			catch (Exception message2)
			{
				Debug.LogError(message2);
				break;
			}
			finally
			{
				QueueQuestContext.Release(context);
			}
		}
		}
	}
}
