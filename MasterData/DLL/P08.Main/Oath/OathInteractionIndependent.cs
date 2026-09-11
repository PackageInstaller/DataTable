using System;

namespace Oath;

[Serializable]
public class OathInteractionIndependent : OathInteractionNode
{
	public bool isEnterIndependentBranch;

	public override bool IsNeedAloneClear => true;

	public override void StartEvent()
	{
		base.IsFinish = true;
	}

	public override void ClearBrotherNode()
	{
	}

	public override void AddChildEvent()
	{
		if (isEnterIndependentBranch)
		{
			base.AddChildEvent();
		}
	}
}
