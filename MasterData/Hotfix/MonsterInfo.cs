using TrueSync;

public class MonsterInfo : LogicComponent
{
	public HotfixEnum.monsterBloodType bloodType;

	public FP barHeight;

	public string Tag1;

	public string Tag2;

	public string Tag3;

	public string Tag4;

	public string Tag5;

	public int[] trapTagIds;

	private string _force;

	public int currentEnergy;

	public int maxEnergy;

	public HotfixEnum.monsterEpicType originEpicType { get; set; }

	public HotfixEnum.monsterEpicType epicType { get; set; } = HotfixEnum.monsterEpicType.NORMAL;

	public HotfixEnum.subBossType subBossType { get; set; } = HotfixEnum.subBossType.NORMAL;

	public HotfixEnum.monsterSubType subType { get; set; }

	public string force
	{
		get
		{
			return _force;
		}
		set
		{
			if (!(_force == value))
			{
				_force = value;
				forceHashCode = CommonHelper.StringToHash(_force);
			}
		}
	}

	public int forceHashCode { get; private set; }

	public int teamId { get; set; }

	public bool CheckTag(string tag)
	{
		if (string.IsNullOrEmpty(tag))
		{
			return false;
		}
		if (string.Equals(Tag1, tag))
		{
			return true;
		}
		if (string.Equals(Tag2, tag))
		{
			return true;
		}
		if (string.Equals(Tag3, tag))
		{
			return true;
		}
		if (string.Equals(Tag4, tag))
		{
			return true;
		}
		if (string.Equals(Tag5, tag))
		{
			return true;
		}
		return false;
	}
}
