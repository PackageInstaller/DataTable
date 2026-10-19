using UnityEngine.Pool;

namespace ACT.MissionSystem;

public class AfterFinishConditionStateTaskParam
{
	private static ObjectPool<AfterFinishConditionStateTaskParam> s_Pool = new ObjectPool<AfterFinishConditionStateTaskParam>(() => new AfterFinishConditionStateTaskParam(), (AfterFinishConditionStateTaskParam o) =>
	{
		o.Reset();
	}, (AfterFinishConditionStateTaskParam o) =>
	{
		o.Reset();
	});

	public int MissionId;

	public int ConditionId;

	public bool IsFirst;

	public static AfterFinishConditionStateTaskParam Create()
	{
		return s_Pool.Get();
	}

	public static void Release(AfterFinishConditionStateTaskParam instance)
	{
		if (instance != null)
		{
			s_Pool.Release(instance);
		}
	}

	private AfterFinishConditionStateTaskParam()
	{
	}

	private void Reset()
	{
		MissionId = 0;
		ConditionId = 0;
		IsFirst = false;
	}
}
