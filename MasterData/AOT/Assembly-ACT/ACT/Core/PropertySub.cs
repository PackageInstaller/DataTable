using System;

namespace ACT.Core;

public enum PropertySub
{
	Base,
	Add,
	Mul,
	[Obsolete("语义错误，建议用Base代替")]
	Max
}
