using UnityEngine;

namespace Pathfinding;

public class FleePath : RandomPath
{
	public static FleePath Construct(Int3 start, Int3 avoid, int searchLength, OnPathDelegate callback = null)
	{
		FleePath fleePath = PathPool.GetPath<FleePath>();
		fleePath.Setup(start, avoid, searchLength, callback);
		return fleePath;
	}

	protected void Setup(Int3 start, Int3 avoid, int searchLength, OnPathDelegate callback)
	{
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		Setup(start, searchLength, callback);
		aim = (Vector3)(avoid - start);
		aim *= 10f;
		aim = (Vector3)start - aim;
	}
}
