using System.Collections.Generic;

public struct StarTowerTempData(int a)
{
	public List<StarTowerSkill> skillInfo = new List<StarTowerSkill>();

	public List<StarTowerCharacter> characterInfo = new List<StarTowerCharacter>();
}
