using System;
using System.Collections.ObjectModel;

namespace Unity.VisualScripting;

public interface IMultiInputUnit : IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	int inputCount { get; set; }

	ReadOnlyCollection<ValueInput> multiInputs { get; }
}
