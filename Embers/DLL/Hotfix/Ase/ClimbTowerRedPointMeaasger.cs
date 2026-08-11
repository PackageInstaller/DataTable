using GameFramework.Runtime;

namespace Ase;

public class ClimbTowerRedPointMeaasger : MessageBase
{
	private bool talentRedPoint;

	private bool areaRedPoint;

	public bool TalentRedPoint => talentRedPoint;

	public bool AreaRedPoint => areaRedPoint;

	public ClimbTowerRedPointMeaasger(object sender, bool talentRedPoint, bool areaRedPoint)
		: base(sender)
	{
		this.talentRedPoint = talentRedPoint;
		this.areaRedPoint = areaRedPoint;
	}
}
