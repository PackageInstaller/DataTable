public readonly struct SummerRaceTransientPhasePolicy(bool hasStartPhase, SummerRacePresentationPhase endPhase)
{
	public readonly bool HasStartPhase = hasStartPhase;

	public readonly SummerRacePresentationPhase EndPhase = endPhase;
}
