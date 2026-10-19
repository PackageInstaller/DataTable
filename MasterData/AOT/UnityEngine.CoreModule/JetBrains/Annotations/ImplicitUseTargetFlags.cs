using System;

namespace JetBrains.Annotations;

[Flags]
public enum ImplicitUseTargetFlags
{
	Default = 1,
	Itself = Default,
	Members = 2,
	WithMembers = Default | Members
}
