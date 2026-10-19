using System;

namespace ACT.Config;

[Serializable]
public class ElementResonanceData
{
	public readonly int id;

	public readonly string abilityName = "";

	public readonly int skillid;

	public readonly string abilityName1 = "";

	public readonly int skillid1;

	public readonly int inactivatedSmallIcon;

	public readonly int activatedSmallIcon;

	public readonly int activatedBigIcon;

	public readonly int activatedTeamIcon;

	public ElementResonanceData(int id, string abilityName, int skillid, string abilityName1, int skillid1, int inactivatedSmallIcon, int activatedSmallIcon, int activatedBigIcon, int activatedTeamIcon)
	{
		this.id = id;
		this.abilityName = abilityName;
		this.skillid = skillid;
		this.abilityName1 = abilityName1;
		this.skillid1 = skillid1;
		this.inactivatedSmallIcon = inactivatedSmallIcon;
		this.activatedSmallIcon = activatedSmallIcon;
		this.activatedBigIcon = activatedBigIcon;
		this.activatedTeamIcon = activatedTeamIcon;
	}
}
