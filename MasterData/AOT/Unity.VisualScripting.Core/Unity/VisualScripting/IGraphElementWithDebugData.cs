using System;

namespace Unity.VisualScripting;

public interface IGraphElementWithDebugData : IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	IGraphElementDebugData CreateDebugData();
}
