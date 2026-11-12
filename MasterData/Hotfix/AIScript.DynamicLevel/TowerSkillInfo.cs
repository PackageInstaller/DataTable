using System;
using TrueSync;

namespace AIScript.DynamicLevel;

public class TowerSkillInfo
{
	public int skillId;

	public FP curSkillEnergy;

	public FP maxSkillEnergy;

	public FP curTime;

	public bool autoCd;

	public Func<bool> CheckCondition;

	public bool isFull => curSkillEnergy >= maxSkillEnergy;

	public TowerSkillInfo(int skillId, FP maxSkillEnergy, FP curSkillEnergy)
	{
		this.skillId = skillId;
		this.maxSkillEnergy = maxSkillEnergy;
		this.curSkillEnergy = curSkillEnergy;
		curTime = 0;
	}

	public void Clear()
	{
		curTime = 0;
		curSkillEnergy = 0;
	}
}
