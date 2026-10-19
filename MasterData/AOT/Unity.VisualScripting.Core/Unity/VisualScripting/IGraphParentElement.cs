using System;

namespace Unity.VisualScripting;

public interface IGraphParentElement : IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable, IGraphParent
{
}
