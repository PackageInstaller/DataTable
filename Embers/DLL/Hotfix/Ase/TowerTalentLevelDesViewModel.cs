namespace Ase;

public class TowerTalentLevelDesViewModel : OptionBase
{
	private bool curLevel;

	private int talentLevel;

	private string talentDes;

	public bool CurLevel
	{
		get
		{
			return curLevel;
		}
		set
		{
			Set(ref curLevel, value, "CurLevel");
		}
	}

	public int TalentLevel
	{
		get
		{
			return talentLevel;
		}
		set
		{
			Set(ref talentLevel, value, "TalentLevel");
		}
	}

	public string TalentDes
	{
		get
		{
			return talentDes;
		}
		set
		{
			Set(ref talentDes, value, "TalentDes");
		}
	}

	public TowerTalentLevelDesViewModel(int level, string des, bool curLevel)
	{
		talentLevel = level;
		talentDes = des;
		this.curLevel = curLevel;
	}
}
