using System;

namespace Sirenix.OdinInspector;

[Flags]
public enum TypeInclusionFilter
{
	None = 0,
	IncludeConcreteTypes = 1,
	IncludeGenerics = 2,
	IncludeAbstracts = 4,
	IncludeInterfaces = 8,
	IncludeAll = IncludeConcreteTypes | IncludeGenerics | IncludeAbstracts | IncludeInterfaces
}
