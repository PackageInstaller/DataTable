using System;

namespace UnityEngine.Events;

[Serializable]
public enum PersistentListenerMode
{
	EventDefined,
	Void,
	Object,
	Int,
	Float,
	String,
	Bool
}
