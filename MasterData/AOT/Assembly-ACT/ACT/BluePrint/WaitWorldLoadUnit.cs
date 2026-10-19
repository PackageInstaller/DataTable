using System;
using System.Collections;
using Unity.VisualScripting;

namespace ACT.BluePrint;

[UnitCategory("ACT")]
public class WaitWorldLoadUnit : WaitUnit, IGraphElementWithData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	private class Data : IGraphElementData
	{
	}

	public IGraphElementData CreateData()
	{
		return new Data();
	}

	protected override IEnumerator Await(Flow flow)
	{
		yield return exit;
	}
}
