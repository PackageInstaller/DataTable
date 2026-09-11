using System;
using System.Collections.Generic;

namespace ParadoxNotion.Serialization;

public interface IfsGraphLookupType
{
	int CurIndex { get; set; }

	Dictionary<int, Type> Types { get; }
}
