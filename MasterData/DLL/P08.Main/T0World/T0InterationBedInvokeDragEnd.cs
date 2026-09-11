using System;

namespace T0World;

[Serializable]
public class T0InterationBedInvokeDragEnd : T0InterationBedSelectBase
{
	public override T0BedClickType GetSelectType()
	{
		return T0BedClickType.INVOKE_DRAG_END;
	}
}
