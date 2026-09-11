using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.LowLevel;

[MovedFrom("UnityEngine.Experimental.LowLevel")]
public class PlayerLoop
{
	public static PlayerLoopSystem GetCurrentPlayerLoop()
	{
		PlayerLoopSystemInternal[] currentPlayerLoopInternal = GetCurrentPlayerLoopInternal();
		int offset = 0;
		return InternalToPlayerLoopSystem(currentPlayerLoopInternal, ref offset);
	}

	public static void SetPlayerLoop(PlayerLoopSystem loop)
	{
		List<PlayerLoopSystemInternal> internalSys = new List<PlayerLoopSystemInternal>();
		PlayerLoopSystemToInternal(loop, ref internalSys);
		SetPlayerLoopInternal(internalSys.ToArray());
	}

	private static int PlayerLoopSystemToInternal(PlayerLoopSystem sys, ref List<PlayerLoopSystemInternal> internalSys)
	{
		int count = internalSys.Count;
		PlayerLoopSystemInternal playerLoopSystemInternal = new PlayerLoopSystemInternal
		{
			type = sys.type,
			updateDelegate = sys.updateDelegate,
			updateFunction = sys.updateFunction,
			loopConditionFunction = sys.loopConditionFunction,
			numSubSystems = 0
		};
		internalSys.Add(playerLoopSystemInternal);
		if (sys.subSystemList != null)
		{
			for (int i = 0; i < sys.subSystemList.Length; i++)
			{
				playerLoopSystemInternal.numSubSystems += PlayerLoopSystemToInternal(sys.subSystemList[i], ref internalSys);
			}
		}
		internalSys[count] = playerLoopSystemInternal;
		return playerLoopSystemInternal.numSubSystems + 1;
	}

	private static PlayerLoopSystem InternalToPlayerLoopSystem(PlayerLoopSystemInternal[] internalSys, ref int offset)
	{
		PlayerLoopSystem result = new PlayerLoopSystem
		{
			type = internalSys[offset].type,
			updateDelegate = internalSys[offset].updateDelegate,
			updateFunction = internalSys[offset].updateFunction,
			loopConditionFunction = internalSys[offset].loopConditionFunction,
			subSystemList = null
		};
		int num = offset++;
		if (internalSys[num].numSubSystems > 0)
		{
			List<PlayerLoopSystem> list = new List<PlayerLoopSystem>();
			while (offset <= num + internalSys[num].numSubSystems)
			{
				list.Add(InternalToPlayerLoopSystem(internalSys, ref offset));
			}
			result.subSystemList = list.ToArray();
		}
		return result;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(IsFreeFunction = true)]
	private static extern PlayerLoopSystemInternal[] GetCurrentPlayerLoopInternal();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(IsFreeFunction = true)]
	private static extern void SetPlayerLoopInternal(PlayerLoopSystemInternal[] loop);
}
