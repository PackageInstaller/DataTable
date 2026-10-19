using System;

namespace Unity.VisualScripting;

[TypeIconPriority]
public interface ISelectUnit : IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	ValueOutput selection { get; }
}
