using System;

namespace Oath;

[Serializable]
public class OathInteractionEmpty : OathInteractionNode
{
	public override void StartEvent()
	{
		base.IsFinish = true;
	}
}
