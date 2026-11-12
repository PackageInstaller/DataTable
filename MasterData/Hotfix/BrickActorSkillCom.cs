using System.Collections.Generic;
using TrueSync;

public class BrickActorSkillCom : LogicComponent
{
	private FP recoveryEnerey = 10;

	private FP recoveryEnerey_rate = 1;

	private readonly Dictionary<int, BrickSkillInfo> DicSkill = new Dictionary<int, BrickSkillInfo>();

	public BrickActor Owner => (BrickActor)Entity;

	public override void OnActive()
	{
		base.OnActive();
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
	}

	public void RegisterAllSkill(List<BrickSkillInfo> skillInfos)
	{
		for (int i = 0; i < skillInfos.Count; i++)
		{
			BrickSkillInfo brickSkillInfo = skillInfos.get_Item(i);
			brickSkillInfo.OnInit();
			DicSkill.Add(brickSkillInfo.skillId, brickSkillInfo);
		}
	}

	public void UnRegisterAllSkill()
	{
		DicSkill.Clear();
	}

	public void SetRecoveryEnerey(FP Enerey)
	{
		recoveryEnerey = Enerey;
	}

	public void SetRecoveryEnerey_Rate(FP rate)
	{
		recoveryEnerey_rate = rate;
	}

	public void OnLogicUpdate(FP deltaTime)
	{
		foreach (BrickSkillInfo value in DicSkill.Values)
		{
			if (!value.IsFull || (value.autoCd && value.curTime > 0))
			{
				FP val = value.curSkillEnergy + recoveryEnerey_rate * recoveryEnerey * deltaTime;
				FP maxSkillEnergy = value.maxSkillEnergy;
				value.curSkillEnergy = TSMath.Min(val, maxSkillEnergy);
				value.curTime -= deltaTime;
				value.curTime = ((value.curTime < 0) ? ((FP)0) : value.curTime);
				SyncLua(value);
			}
		}
	}

	public bool CanExcute(int skillId)
	{
		if (DicSkill.TryGetValue(skillId, out var value))
		{
			return value.IsFull;
		}
		return false;
	}

	public void ResetEnergy(int skillId, bool auto = true)
	{
		foreach (BrickSkillInfo value in DicSkill.Values)
		{
			if (value.skillId == skillId)
			{
				value.Clear();
				value.autoCd = auto;
				SyncLua(value);
			}
		}
	}

	public void ModifyEnergyByAbs(int skillId, FP energy)
	{
		if (DicSkill.TryGetValue(skillId, out var value))
		{
			value.curSkillEnergy += energy * recoveryEnerey_rate;
			value.curSkillEnergy = TSMath.Min(value.curSkillEnergy, value.maxSkillEnergy);
			SyncLua(value);
		}
	}

	public void ModifyEnergyByPercent(int skillId, FP percent)
	{
		if (DicSkill.TryGetValue(skillId, out var value))
		{
			value.curSkillEnergy += value.maxSkillEnergy * percent / 100;
			value.curSkillEnergy = TSMath.Min(value.curSkillEnergy, value.maxSkillEnergy);
			SyncLua(value);
		}
	}

	private void SyncLua(BrickSkillInfo skillInfo)
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("BrickActorEnergy", Owner.dataID, skillInfo.skillId, (float)skillInfo.curSkillEnergy, (float)skillInfo.maxSkillEnergy, (float)skillInfo.curTime);
	}
}
