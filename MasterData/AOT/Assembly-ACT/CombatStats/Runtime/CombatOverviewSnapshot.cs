using System;
using System.Collections.Generic;

namespace CombatStats.Runtime;

[Serializable]
public sealed class CombatOverviewSnapshot
{
	public int SelectedSegmentId;

	public CombatOverviewViewType ViewType;

	public List<SegmentListItemSnapshot> Segments = new List<SegmentListItemSnapshot>();

	public List<CharacterDamageRowSnapshot> DamageRows = new List<CharacterDamageRowSnapshot>();

	public List<SkillDamageRowSnapshot> SkillRows = new List<SkillDamageRowSnapshot>();
}
