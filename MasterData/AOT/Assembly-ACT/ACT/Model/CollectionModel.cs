using System.Collections.Generic;
using ACT.Model.Jump;

namespace ACT.Model;

public class CollectionModel : Model<CollectionModel>, IJumpable
{
	public LuminModelType JumpSourceType => LuminModelType.CollectionPoints;

	protected override void Init()
	{
	}

	protected override void UnInit()
	{
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		if (jumpData.Params.Count < 3)
		{
			List<int> list = new List<int>
			{
				jumpData.Params[0],
				2,
				jumpData.Params[1]
			};
			jumpData.Params = list;
		}
		return Model<MapModel>.Interface.CanJump(jumpData);
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		if (jumpData.Params.Count < 3)
		{
			List<int> list = new List<int>
			{
				jumpData.Params[0],
				2,
				jumpData.Params[1]
			};
			jumpData.Params = list;
		}
		Model<MapModel>.Interface.Jump(jumpData);
	}
}
