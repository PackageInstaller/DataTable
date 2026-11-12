using System.Collections.Generic;
using TrueSync;

namespace AIScript.DynamicLevel;

public class TowerCharacterSkillCom : LogicComponent
{
	private FP recoveryRatio;

	private Dictionary<int, TowerSkillInfo> dicSkill = new Dictionary<int, TowerSkillInfo>();

	private bool isInRecoveryEnergyCD;

	private FP totleSkillTime;

	private FP curSkillTime;

	private int curSkillId;

	public TowerDefenseCharacterActor owner => (TowerDefenseCharacterActor)Entity;

	public void LogicActive()
	{
		isInRecoveryEnergyCD = false;
		recoveryRatio = 1;
		foreach (KeyValuePair<int, TowerSkillInfo> item in dicSkill)
		{
			InitEnergy(item.Key);
		}
	}

	public override void OnActive()
	{
		base.OnActive();
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
	}

	public void RegisterAllSkill(List<TowerSkillInfo> skillInfos)
	{
		for (int i = 0; i < skillInfos.Count; i++)
		{
			TowerSkillInfo towerSkillInfo = skillInfos.get_Item(i);
			dicSkill.Add(towerSkillInfo.skillId, towerSkillInfo);
		}
	}

	public void UnRegisterAllSkill()
	{
		dicSkill.Clear();
	}

	public void OnLogicUpdate(FP deltaTime)
	{
		foreach (TowerSkillInfo value in dicSkill.Values)
		{
			if (!value.isFull && value.autoCd)
			{
				FP val = value.curSkillEnergy + owner.LogicDeltaTime * recoveryRatio;
				FP maxSkillEnergy = value.maxSkillEnergy;
				value.curSkillEnergy = TSMath.Min(val, maxSkillEnergy);
			}
		}
		if (isInRecoveryEnergyCD)
		{
			curSkillTime += deltaTime;
			if (curSkillTime >= totleSkillTime)
			{
				EndRecoveryEnergyCD();
			}
		}
	}

	public bool CheckFull(int skillId)
	{
		if (dicSkill.TryGetValue(skillId, out var value))
		{
			return value.isFull;
		}
		return false;
	}

	public bool HasCastSkill()
	{
		foreach (TowerSkillInfo value in dicSkill.Values)
		{
			if (value.isFull)
			{
				if (value.CheckCondition == null)
				{
					return owner.attackTarget != null;
				}
				if (value.CheckCondition())
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool GetAllCastSkill(ref List<TowerSkillInfo> skillInfos)
	{
		skillInfos.Clear();
		foreach (TowerSkillInfo value in dicSkill.Values)
		{
			if (!value.isFull)
			{
				continue;
			}
			if (value.CheckCondition != null)
			{
				if (value.CheckCondition())
				{
					skillInfos.Add(value);
				}
			}
			else if (owner.attackTarget != null)
			{
				skillInfos.Add(value);
			}
		}
		return skillInfos.Count > 0;
	}

	public void InitEnergy(int skillId)
	{
		if (dicSkill.TryGetValue(skillId, out var value))
		{
			value.autoCd = true;
			SyncLua(skillId, value, auto: true);
		}
	}

	public void ResetEnergy(int skillId, bool auto)
	{
		if (dicSkill.TryGetValue(skillId, out var value))
		{
			value.Clear();
			value.autoCd = auto;
			SyncLua(skillId, value, auto);
		}
	}

	public void BeginEnergy(int skillId)
	{
		if (dicSkill.TryGetValue(skillId, out var value))
		{
			value.autoCd = true;
			SyncLua(skillId, value, value.autoCd);
		}
	}

	public void ModifyEnergyByAbs(int skillId, FP energy)
	{
		if (dicSkill.TryGetValue(skillId, out var value))
		{
			value.curSkillEnergy += energy;
			value.curSkillEnergy = TSMath.Min(value.curSkillEnergy, value.maxSkillEnergy);
			SyncLua(skillId, value, value.autoCd);
		}
	}

	public void ModifyEnergyByPercent(int skillId, FP percent)
	{
		if (dicSkill.TryGetValue(skillId, out var value))
		{
			value.curSkillEnergy += value.maxSkillEnergy * percent / 100f;
			value.curSkillEnergy = TSMath.Min(value.curSkillEnergy, value.maxSkillEnergy);
			SyncLua(skillId, value, value.autoCd);
		}
	}

	public void PauseEnergy(int skillId)
	{
		if (dicSkill.TryGetValue(skillId, out var value))
		{
			value.autoCd = false;
			SyncLua(skillId, value, auto: false);
		}
	}

	public IEnumerable<int> GetAllSkillIds()
	{
		return dicSkill.Keys;
	}

	public void AddRecoveryEnergyRatio(int skillId, int radio)
	{
		if (dicSkill.TryGetValue(skillId, out var value))
		{
			recoveryRatio += (FP)((float)radio / 100f);
			SyncLua(skillId, value, value.autoCd);
		}
	}

	private void SyncLua(int skillId, TowerSkillInfo skillInfo, bool auto)
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("ResetEnergy", owner.Id, owner.dataID, skillId, skillInfo.curSkillEnergy / recoveryRatio, skillInfo.maxSkillEnergy / recoveryRatio, auto);
	}

	public void BeginRecoveryEnergyCD(int skillId, FP totleSkillTime)
	{
		isInRecoveryEnergyCD = true;
		curSkillId = skillId;
		this.totleSkillTime = totleSkillTime;
		curSkillTime = 0;
		MonoSingleton<LuaManager>.Instance?.FireEvent("BeginSkill", owner.Id, owner.dataID, skillId, totleSkillTime);
	}

	public void EndRecoveryEnergyCD()
	{
		isInRecoveryEnergyCD = false;
		BeginEnergy(curSkillId);
	}
}
