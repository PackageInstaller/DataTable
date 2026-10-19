using System;

namespace Unity.VisualScripting;

public interface IUnifiedVariableUnit : IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	VariableKind kind { get; }

	ValueInput name { get; }
}
