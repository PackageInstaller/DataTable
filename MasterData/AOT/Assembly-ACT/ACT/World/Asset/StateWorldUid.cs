using System;

namespace ACT.World.Asset;

[Serializable]
public class StateWorldUid : IDataToBake
{
	public const int INVALID_SWID = int.MinValue;

	public int value;

	public bool isValid => value != int.MinValue;

	public StateWorldUid()
	{
		value = int.MinValue;
	}

	public StateWorldUid(int value)
	{
		this.value = value;
	}

	public static implicit operator int(StateWorldUid StateWorldUid)
	{
		return StateWorldUid.value;
	}

	public static implicit operator StateWorldUid(int value)
	{
		return new StateWorldUid(value);
	}
}
