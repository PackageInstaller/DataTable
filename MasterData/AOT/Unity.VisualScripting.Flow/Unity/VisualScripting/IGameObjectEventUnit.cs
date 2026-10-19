using System;

namespace Unity.VisualScripting;

public interface IGameObjectEventUnit : IEventUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable, IGraphEventListener
{
	Type MessageListenerType { get; }
}
