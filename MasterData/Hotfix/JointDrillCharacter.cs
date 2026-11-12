using System.Collections.Generic;

public struct JointDrillCharacter(int nCharId, int nHp)
{
	public long nCharId = nCharId;

	public long nHp = nHp;

	public List<StarTowerEffect> tbEffect = new List<StarTowerEffect>();

	public List<StarTowerBuffInfo> tbBuff = new List<StarTowerBuffInfo>();

	public StarTowerState stateInfo = default;

	public StarTowerAmmoInfo ammoInfo = default;
}
