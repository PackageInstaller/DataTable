using System;

namespace ACT.Battle.Configs;

public enum ModifyDamageType
{
	BaseDamagePhase,
	FinalPhaseMul,
	ElementPhase,
	MultiPowerPhase,
	TenacityAtkPhase,
	criticalPhaseAdd,
	defPenetrationPhaseAdd,
	criticalMulPhaseAdd,
	postureBaseAdd,
	weakPhaseAdd,
	[Obsolete]
	extraMulPhaseAdd,
	MultiPosturePhase,
	[Obsolete]
	decayPhaseMul,
	FinalPhaseAdd,
	MannerDamagePhase,
	ForceWeakElement,
	ForceStrongWeakElement,
	PartWeakPhaseAdd
}
