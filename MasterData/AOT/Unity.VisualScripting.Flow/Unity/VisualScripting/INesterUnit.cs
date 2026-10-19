using System;

namespace Unity.VisualScripting;

public interface INesterUnit : IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable, IGraphNesterElement, IGraphParentElement, IGraphParent, IGraphNester
{
}
