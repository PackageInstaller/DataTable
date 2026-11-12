using Pathfinding.RVO;
using TrueSync;
using UnityEngine;

public class DeterministicRVOSimulator : RVOSimulator
{
	protected override void Awake()
	{
		base.Awake();
		if (Application.isPlaying)
		{
			Simulator simulator = GetSimulator();
			simulator.DesiredDeltaTime = FP.One / desiredSimulationFPS;
			simulator.symmetryBreakingBias = symmetryBreakingBias;
		}
	}

	private void Update()
	{
	}
}
