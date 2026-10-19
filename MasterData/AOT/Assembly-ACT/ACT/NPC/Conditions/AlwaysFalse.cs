using System;

namespace ACT.NPC.Conditions;

[Serializable]
public class AlwaysFalse : NpcConditionUnit
{
	public override int ConditionId => 6;

	protected override bool CheckCondition()
	{
		return false;
	}

	public override void RegisterToConditionModel()
	{
	}

	public override void UnRegisterToConditionModel()
	{
	}
}
