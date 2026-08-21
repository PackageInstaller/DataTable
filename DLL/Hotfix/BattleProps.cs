using Ase;

public class BattleProps
{
	public int Id;

	public int AiTreeId;

	public int SkillId;

	public int CarryPropNumber;

	public int TotalPropNumber;

	public int CarryMax;

	public int Level;

	public int TeamId;

	public static BattleProps Create(BPData bpData)
	{
		BattleProps battleProps = new BattleProps();
		if (bpData != null)
		{
			battleProps.Id = bpData.Id;
			battleProps.AiTreeId = bpData.AiTreeId;
			battleProps.SkillId = bpData.SkillId;
			battleProps.CarryPropNumber = bpData.CarryPropNumber;
			battleProps.Level = bpData.Level;
			battleProps.TeamId = bpData.TeamId;
			battleProps.TotalPropNumber = bpData.Count;
			battleProps.CarryMax = bpData.CarryMax;
		}
		return battleProps;
	}

	public void Release()
	{
		Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().UseBattleProp(TeamId);
	}

	public void SetBpDataMax(int index)
	{
		CarryPropNumber = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().SetCarryPropDataMax(index);
	}

	public void SetCurBpDataMax()
	{
		BPData bpDataById = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetBpDataById(TeamId);
		if (bpDataById != null)
		{
			bpDataById.SetCarryPropNumberToMax();
			CarryPropNumber = bpDataById.CarryPropNumber;
		}
	}
}
