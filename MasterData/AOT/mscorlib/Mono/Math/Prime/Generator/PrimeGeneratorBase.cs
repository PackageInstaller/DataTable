namespace Mono.Math.Prime.Generator;

internal abstract class PrimeGeneratorBase
{
	public virtual ConfidenceFactor Confidence => ConfidenceFactor.Medium;

	public virtual PrimalityTest PrimalityTest => PrimalityTests.RabinMillerTest;

	public virtual int TrialDivisionBounds => 4000;

	public abstract BigInteger GenerateNewPrime(int bits);
}
