using System.Collections;
using ACT.Model;
using Unity.VisualScripting;

namespace ACT.BluePrint;

[UnitCategory("ACT")]
public class StartGuideUnit : WaitUnit
{
	[DoNotSerialize]
	private ValueInput _guideId;

	protected override void Definition()
	{
		base.Definition();
		_guideId = ValueInput("_guideId", 0);
	}

	protected override IEnumerator Await(Flow flow)
	{
		int guideId = flow.GetValue<int>(_guideId);
		yield return StartGuide(guideId);
		yield return (!Model<GuideModel>.Interface.InGuide(guideId)) ? exit : null;
	}

	private IEnumerator StartGuide(int guideId)
	{
		Model<GuideModel>.Interface.StartGuide(guideId);
		while (!Model<GuideModel>.Interface.GuideHasTriggeredAndFinsh(guideId))
		{
			yield return null;
		}
	}
}
