using System;

namespace FlowCanvas.Nodes;

[Flags]
public enum E_SkillIterateMode
{
	AllSkills = 1,
	Avoid = 2,
	Melee = 4
}
