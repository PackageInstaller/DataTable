using System;

namespace Unity.VisualScripting;

public interface IGraphElementWithData : IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	IGraphElementData CreateData();
}
