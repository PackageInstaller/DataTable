using System.Collections.Generic;

public struct JointDrillTempData(int a)
{
	public JointDrillBoss bossInfo = default;

	public List<StarTowerSkill> skillInfo = new List<StarTowerSkill>();

	public List<JointDrillCharacter> characterInfo = new List<JointDrillCharacter>();

	public List<Lua2CSharpInfo_SummonMonsterInfo> summonMonsterInfo = new List<Lua2CSharpInfo_SummonMonsterInfo>();
}
