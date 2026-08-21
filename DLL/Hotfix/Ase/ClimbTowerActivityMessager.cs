using GameFramework.Runtime;

namespace Ase;

public class ClimbTowerActivityMessager : MessageBase
{
	private bool? canUpTalent;

	private bool? areaRedPoint;

	public bool? CanUpTalent => canUpTalent;

	public bool? AreaRedPoint => areaRedPoint;

	public ClimbTowerActivityMessager(object sender, bool? canUp, bool? areaRedPoint)
		: base(sender)
	{
		if (canUp.HasValue)
		{
			canUpTalent = canUp.Value;
		}
		if (areaRedPoint.HasValue)
		{
			this.areaRedPoint = areaRedPoint.Value;
		}
	}
}
