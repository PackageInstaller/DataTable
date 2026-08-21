using System.Collections.Generic;

namespace Ase;

public class PassportInfo
{
	public int Point;

	public int Grade;

	public int Level;

	public int LevelMax;

	public int WeeklyPoint;

	public int WeeklyPointMax;

	public List<int> Reward;

	public long EndTime;

	private Timer timer;
}
