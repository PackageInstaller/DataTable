using System.Collections.Generic;

namespace ACT.Model.Jump;

public struct RuntimeJumpData
{
	public LuminModelType ModelType;

	public int JumpType;

	public int ItemID;

	public List<int> Params;

	public int NavigationID;

	public JumpResult Result;

	public SystemType FromSystem;
}
