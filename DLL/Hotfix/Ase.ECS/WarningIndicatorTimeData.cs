using GameFramework;

namespace Ase.ECS;

public class WarningIndicatorTimeData : IReference
{
	public float delayLifeTimer;

	public float fillTimer;

	public float delayDiffuseTimer;

	public float diffuseTimer;

	public void Clear()
	{
		fillTimer = 0f;
		delayLifeTimer = 0f;
		delayDiffuseTimer = 0f;
		diffuseTimer = 0f;
	}
}
