using System.Collections.Generic;

public struct StarTowerCharacter(int nCharId)
{
	public long nCharId = nCharId;

	public List<StarTowerEffect> tbEffect = new List<StarTowerEffect>();

	public List<StarTowerBuffInfo> tbBuff = new List<StarTowerBuffInfo>();

	public StarTowerState stateInfo = default;

	public StarTowerAmmoInfo ammoInfo = default;
}
