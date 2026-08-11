using System.Collections.Generic;

namespace Ase;

public class ArmourPresetApplyResultData
{
	public List<ArmourPresetConflictData> Conflicts { get; } = new List<ArmourPresetConflictData>();

	public bool HasConflicts => Conflicts.Count > 0;
}
