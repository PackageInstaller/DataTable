using System;
using System.Collections.Generic;

[Serializable]
public struct ABCharactorInfo
{
	public int Id;

	public float hpPre;

	public int Level;

	public int Advance;

	public int SkillLv;

	public int mainPotentialLv;

	public List<int> mainPotential;

	public int subPotentialLv;

	public List<int> subPotential;

	public int talentLv;
}
