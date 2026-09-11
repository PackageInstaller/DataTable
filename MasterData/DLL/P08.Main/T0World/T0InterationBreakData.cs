using System;

namespace T0World;

[Serializable]
public class T0InterationBreakData : T0InterationBaseData
{
	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Break;
	}
}
