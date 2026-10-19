using System;
using Newtonsoft.Json.Linq;

namespace ACT.World.Asset;

[Serializable]
public struct StateSwapGroup
{
	public int stateA;

	public int stateB;

	public bool SwapState(int state, out int otherState)
	{
		otherState = 0;
		if (state == stateA)
		{
			otherState = stateB;
			return true;
		}
		if (state == stateB)
		{
			otherState = stateA;
			return true;
		}
		return false;
	}

	public JToken ToToken()
	{
		return JToken.FromObject(this);
	}
}
