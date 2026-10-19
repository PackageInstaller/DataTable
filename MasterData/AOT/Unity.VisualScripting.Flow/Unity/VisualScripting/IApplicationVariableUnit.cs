using System;

namespace Unity.VisualScripting;

[TypeIconPriority]
public interface IApplicationVariableUnit : IVariableUnit, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
}
