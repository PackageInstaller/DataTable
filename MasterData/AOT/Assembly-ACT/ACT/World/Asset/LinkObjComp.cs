using System;
using System.Collections.Generic;

namespace ACT.World.Asset;

[Serializable]
public class LinkObjComp : IDataToBake
{
	public StateWorldUid stateWorldUid;

	public List<StateMapping> stateMappings = new List<StateMapping>
	{
		new StateMapping
		{
			switchState = "默认状态 (0)",
			targetState = 0
		},
		new StateMapping
		{
			switchState = "中间状态 (1)",
			targetState = 0
		},
		new StateMapping
		{
			switchState = "最终状态 (-1)",
			targetState = 0
		}
	};
}
