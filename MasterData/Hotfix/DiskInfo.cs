using System;
using System.Collections.Generic;

[Serializable]
public class DiskInfo
{
	public int Id;

	public List<DiscSkillInfo> skillInfos = new List<DiscSkillInfo>();

	public void LoadFrom(DiskInfo other)
	{
		Id = other.Id;
		skillInfos = other.skillInfos;
	}
}
