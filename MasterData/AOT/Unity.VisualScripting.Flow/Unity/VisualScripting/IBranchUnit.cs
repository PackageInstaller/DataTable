using System;

namespace Unity.VisualScripting;

[TypeIconPriority]
public interface IBranchUnit : IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	ControlInput enter { get; }
}
