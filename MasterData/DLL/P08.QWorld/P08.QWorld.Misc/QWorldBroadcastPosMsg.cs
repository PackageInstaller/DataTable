using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace P08.QWorld.Misc;

public static class QWorldBroadcastPosMsg
{
	internal const float PLAYER_QUERY_RANGE = 4f;

	private static bool IsInRange(ILODControlledLogic logic, Vector3 pos, float sqrRange)
	{
		if (logic.Bounds.SqrDistance(pos) <= sqrRange)
		{
			return true;
		}
		return false;
	}

	internal static void Emit<T>(Vector3 pos, float range, IEnumerable<ILODControlledLogic> logics, Action<T> action) where T : class, ILODControlledLogic
	{
		float sqrRange = range * range;
		foreach (ILODControlledLogic item in logics.Where((ILODControlledLogic logic) => logic is T && IsInRange(logic, pos, sqrRange)))
		{
			action(item as T);
		}
	}

	internal static void Emit<T>(Vector3 pos, float range, Action<T> action) where T : class, ILODControlledLogic
	{
		Emit(pos, range, QWorldScene.Scene.lodComScheduler.scheduledLogic, action);
	}
}
