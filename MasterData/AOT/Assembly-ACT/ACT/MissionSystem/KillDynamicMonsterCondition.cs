using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class KillDynamicMonsterCondition : MissionCondition
{
	private LocalizedString m_Description;

	public override IEnumerable<ConditionDescription> GetDescriptions()
	{
		if (m_Description == null)
		{
			m_Description = new LocalizedString(LocalizationUtility.localizeTableName_shortcommon, Desc);
		}
		yield return new ConditionDescription
		{
			HaveContent = (Desc != 0),
			DescriptionContent = m_Description,
			HaveProgress = true,
			Progress = GetState().Progress,
			TotalProgress = (Param as KillDynamicMonsterConditionParam).count
		};
	}

	protected override void OnInMissionWorld()
	{
		if (TryGetParam(out var param) && GetState() != null)
		{
			if (CheckCondition())
			{
				IReadOnlyConditionState state = GetState();
				UpdateState(Math.Max(state.Progress, param.count), success: true);
			}
			else
			{
				Singleton<EventManager>.instance.AddEventListener(ClientEvent.MonsterDieCount, OnMonsterDie);
			}
		}
	}

	protected override void OnOutMissionWorld()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MonsterDieCount, OnMonsterDie);
	}

	private void OnMonsterDie(BaseEventContent obj)
	{
		if (obj is EntityDieEvt entityDieEvt && entityDieEvt.entity.IsValid && entityDieEvt.entity.TryGetCompMonster(out CompMonster component) && TryGetParam(out var param) && param.monsterIds.Contains(component.id))
		{
			IReadOnlyConditionState state = GetState();
			if (state != null && !state.Finished)
			{
				int num = state.Progress + 1;
				UpdateState(num, num >= param.count);
			}
		}
	}

	public override bool PreCheckCondition()
	{
		return CheckCondition();
	}

	private bool CheckCondition()
	{
		if (!TryGetParam(out var param))
		{
			return false;
		}
		IReadOnlyConditionState state = GetState();
		if (state != null)
		{
			return state.Progress >= param.count;
		}
		return false;
	}

	private bool TryGetParam(out KillDynamicMonsterConditionParam param)
	{
		param = Param as KillDynamicMonsterConditionParam;
		if (param != null)
		{
			return param.monsterIds != null;
		}
		return false;
	}
}
