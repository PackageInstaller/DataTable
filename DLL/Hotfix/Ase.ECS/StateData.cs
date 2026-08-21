using GameFramework;

namespace Ase.ECS;

public class StateData : IReference
{
	private DRState stateConfig;

	private float stateTime;

	public DRState StateConfig => stateConfig;

	public int Id => stateConfig?.Id ?? 0;

	public int Priority => stateConfig?.Priority ?? 0;

	public void Clear()
	{
	}

	public bool IsNormal()
	{
		return stateConfig.Id == 0;
	}

	public static StateData Create(DRState state)
	{
		StateData stateData = ReferencePool.Acquire<StateData>();
		stateData.stateConfig = state;
		return stateData;
	}

	public void Dispose()
	{
		ReferencePool.Release(this);
	}
}
