using TrueSync;

public class BrickSkillInfo
{
	public int skillId;

	public FP curSkillEnergy;

	public FP maxSkillEnergy;

	public FP curTime;

	public FP skillCd;

	public bool autoCd;

	public bool IsFull
	{
		get
		{
			if (curSkillEnergy >= maxSkillEnergy)
			{
				return curTime <= 0;
			}
			return false;
		}
	}

	public BrickSkillInfo(int skillId, float maxSkillEnergy, float Cd)
	{
		this.skillId = skillId;
		this.maxSkillEnergy = FP.FromConfigFloat(maxSkillEnergy);
		skillCd = FP.FromConfigFloat(Cd);
	}

	public void OnInit()
	{
		curSkillEnergy = 0;
		curTime = 0;
		autoCd = true;
	}

	public void Clear()
	{
		curSkillEnergy = 0;
		curTime = skillCd;
		autoCd = true;
	}
}
