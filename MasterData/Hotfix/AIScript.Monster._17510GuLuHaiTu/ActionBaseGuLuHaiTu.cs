#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._17510GuLuHaiTu;

public class ActionBaseGuLuHaiTu : MonsterActionBase
{
	private readonly string actionStateTag = "AcitonFinish";

	private readonly string sinkStateTag = "SinkFinish";

	protected FP winTime = 2;

	protected int idleSkill;

	protected readonly int idExhale;

	protected readonly int Skill_Exhale = 1751001;

	protected readonly int idWave = 1;

	protected readonly int Skill_WaveAcross_Clone = 1751002;

	protected readonly int idEWCombo = 2;

	protected readonly int Skill_EWCombo = 1751003;

	protected readonly int idFishShoot = 3;

	protected readonly int Skill_FishShoot = 1751004;

	protected readonly int idFrontalRepulse = 4;

	protected readonly int Skill_FrontalRepulse = 1751005;

	protected readonly int idPointRepulse = 5;

	protected readonly int Skill_PointRepulse = 1751006;

	protected readonly int idFloorBreak = 6;

	protected readonly int Skill_FloorBreak = 1751007;

	protected readonly int idRepulse = 7;

	protected readonly int Skill_Repulse = 1751008;

	protected readonly int idInitialization = 8;

	protected readonly int Skill_Initialization = 1751010;

	protected readonly int idFloorBreakStrong = 9;

	protected readonly int Skill_FloorBreakStrong = 1751016;

	protected readonly int idWanderAction = 10;

	protected readonly int Skill_WanderAction = 1751017;

	protected int castTime;

	protected FP curWinTime;

	protected virtual Dictionary<int, bool> dicSkill { get; }

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		castTime = 0;
		SetLogicTagFpValue(_actor, "CastTime", castTime);
	}

	protected IEnumerator ExhaleCondition()
	{
		if (CheckAcitonState())
		{
			CastSkill(Skill_Exhale);
			yield return WaitSkillFinish();
			yield return StartCor(DoWaitInputTime(Skill_Exhale));
		}
		else
		{
			SetPoolBranchCD(idExhale, 3);
			NovaLogger.Debug("咕噜海兔.AI脚本.脱手技能未完成,当前技能延后3秒");
		}
	}

	protected IEnumerator WaveAcrossCondition()
	{
		if (CheckAcitonState())
		{
			CastSkill(Skill_WaveAcross_Clone);
			yield return WaitSkillFinish();
			yield return StartCor(DoWaitInputTime(Skill_WaveAcross_Clone));
		}
		else
		{
			SetPoolBranchCD(idWave, 3);
			NovaLogger.Debug("咕噜海兔.AI脚本.脱手技能未完成,当前技能延后3秒");
		}
	}

	protected IEnumerator EWComboCondition()
	{
		if (CheckAcitonState())
		{
			CastSkill(Skill_EWCombo);
			yield return WaitSkillFinish();
			yield return StartCor(DoWaitInputTime(Skill_EWCombo));
		}
		else
		{
			SetPoolBranchCD(idEWCombo, 3);
			NovaLogger.Debug("咕噜海兔.AI脚本.脱手技能未完成,当前技能延后3秒");
		}
	}

	protected IEnumerator fishShootCondition()
	{
		if (CheckAcitonState())
		{
			CastSkill(Skill_FishShoot);
			yield return WaitSkillFinish();
			yield return StartCor(DoWaitInputTime(Skill_FishShoot));
		}
		else
		{
			SetPoolBranchCD(idFishShoot, 3);
			NovaLogger.Debug("咕噜海兔.AI脚本.脱手技能未完成,当前技能延后3秒");
		}
	}

	protected IEnumerator FrontalRepulseCondition()
	{
		if (CheckAcitonState())
		{
			CastSkill(Skill_FrontalRepulse);
			yield return WaitSkillFinish();
			yield return StartCor(DoWaitInputTime(Skill_FrontalRepulse));
		}
		else
		{
			SetPoolBranchCD(idFrontalRepulse, 3);
			NovaLogger.Debug("咕噜海兔.AI脚本.脱手技能未完成,当前技能延后3秒");
		}
	}

	protected IEnumerator POSRepulseCondition()
	{
		if (CheckAcitonState())
		{
			CastSkill(Skill_PointRepulse);
			yield return WaitSkillFinish();
			yield return StartCor(DoWaitInputTime(Skill_PointRepulse));
		}
		else
		{
			SetPoolBranchCD(idPointRepulse, 3);
			NovaLogger.Debug("咕噜海兔.AI脚本.脱手技能未完成,当前技能延后3秒");
		}
	}

	protected IEnumerator FloorBreakCondition()
	{
		bool flag = CheckAcitonState();
		bool flag2 = CheckPlayerSinkState();
		if (flag & flag2)
		{
			CastSkill(Skill_FloorBreak);
			yield return WaitSkillFinish();
			yield return StartCor(DoWaitInputTime(Skill_FloorBreak));
		}
		else
		{
			SetPoolBranchCD(idFloorBreak, 3);
			NovaLogger.Debug("咕噜海兔.AI脚本.脱手技能未完成,当前技能延后3秒");
		}
	}

	protected IEnumerator FloorBreakStrongCondition()
	{
		bool flag = CheckAcitonState();
		bool flag2 = CheckPlayerSinkState();
		if (flag & flag2)
		{
			SetLogicTagFpValue(_actor, "CastTime", castTime += 1);
			CastSkill(Skill_FloorBreakStrong);
			yield return WaitSkillFinish();
			yield return StartCor(DoWaitInputTime(Skill_FloorBreakStrong));
		}
		else
		{
			SetPoolBranchCD(idFloorBreakStrong, 3);
			NovaLogger.Debug("咕噜海兔.AI脚本.脱手技能未完成,当前技能延后3秒");
		}
	}

	protected IEnumerator RepulseCondition()
	{
		if (CheckAcitonState())
		{
			CastSkill(Skill_Repulse);
			yield return WaitSkillFinish();
			yield return StartCor(DoWaitInputTime(Skill_Repulse));
		}
		else
		{
			SetPoolBranchCD(idRepulse, 3);
			NovaLogger.Debug("咕噜海兔.AI脚本.脱手技能未完成,当前技能延后3秒");
		}
	}

	protected IEnumerator InitializationCondition()
	{
		CastSkill(Skill_Initialization);
		yield return WaitSkillFinish();
		SetPoolBranchActive(idInitialization, active: false);
	}

	protected IEnumerator WanderActionCondition()
	{
		CastSkill(Skill_WanderAction);
		yield return WaitSkillFinish();
	}

	protected bool CheckAcitonState()
	{
		return GetLogicTagToggleValue(_actor, actionStateTag);
	}

	protected void InitActionState()
	{
		SetLogicTagToggleValue(_actor, actionStateTag, value: true);
	}

	protected bool CheckPlayerSinkState()
	{
		return GetLogicTagToggleValue(_actor, sinkStateTag);
	}

	protected IEnumerator DoWaitInputTime(int skillId)
	{
		if (dicSkill != null && dicSkill.TryGetValue(skillId, out var value) && value)
		{
			curWinTime = _actor.LogicTime;
			CastSkill(skillId);
			while (!(_actor.LogicTime - curWinTime > winTime))
			{
				yield return null;
			}
			_actor.InterruptAttack(force: true);
		}
	}
}
