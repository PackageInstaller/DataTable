using System;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Enum)]
public sealed class InspectorOrderAttribute : PropertyAttribute
{
	internal InspectorSort m_inspectorSort { get; }

	internal InspectorSortDirection m_sortDirection { get; }
}
