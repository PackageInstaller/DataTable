using System;
using System.Collections.Generic;

namespace CombatStats.Runtime;

[Serializable]
public sealed class CombatFloatingSnapshot
{
	public string SegmentId;

	public bool HasActiveSegment;

	public bool IsCollapsed;

	public float Duration;

	public long TotalDamage;

	public List<CharacterDamageRowSnapshot> TopCharacters = new List<CharacterDamageRowSnapshot>();
}
