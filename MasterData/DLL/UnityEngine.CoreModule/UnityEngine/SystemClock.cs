using System;
using UnityEngine.Bindings;

namespace UnityEngine;

[VisibleToOtherModules]
internal class SystemClock
{
	private static readonly DateTime s_Epoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);

	public static DateTime now => DateTime.Now;
}
