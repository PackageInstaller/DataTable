namespace Ase;

public class RoleExpData : OptionBase
{
	private float expFill;

	private long expAdd;

	private int index;

	private HeroModel heroModel;

	public HeroModel HeroModel
	{
		get
		{
			return heroModel;
		}
		private set
		{
			Set(ref heroModel, value, "HeroModel");
		}
	}

	public float ExpFill
	{
		get
		{
			return expFill;
		}
		private set
		{
			Set(ref expFill, value, "ExpFill");
		}
	}

	public long ExpAdd
	{
		get
		{
			return expAdd;
		}
		private set
		{
			Set(ref expAdd, value, "ExpAdd");
		}
	}

	public RoleExpData(OptionBase parent, HeroModel heroModel)
	{
		base.parent = parent;
		this.heroModel = heroModel;
		index = 0;
	}

	public void SetLevelData(int level, long exp, long addExp)
	{
		ExpAdd = addExp;
		index = level - heroModel.Level;
		if (level < heroModel.TotalMaxLevel)
		{
			DRHeroGrade dataRow = GameEntry.DataTable.GetDataTable<DRHeroGrade>().GetDataRow(level + 1);
			Singleton<ServiceSystem>.Instance.GetService<IHeroService>().HeroUpgradeByBattle(heroModel.Id, level, exp);
			ExpFill = (float)exp / (float)dataRow.NeedExp;
		}
		else
		{
			Singleton<ServiceSystem>.Instance.GetService<IHeroService>().HeroUpgradeByBattle(heroModel.Id, level, 0L);
			ExpFill = 1f;
		}
	}
}
