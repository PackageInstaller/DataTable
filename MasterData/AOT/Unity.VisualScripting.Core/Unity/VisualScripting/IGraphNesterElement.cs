using System;

namespace Unity.VisualScripting;

public interface IGraphNesterElement : IGraphParentElement, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable, IGraphParent, IGraphNester
{
}
