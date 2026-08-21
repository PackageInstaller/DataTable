using System;

namespace UnityEngine.Playables;

public enum PlayState
{
	Paused,
	Playing,
	[Obsolete("Delayed is obsolete; use a custom ScriptPlayable to implement this feature", false)]
	Delayed
}
