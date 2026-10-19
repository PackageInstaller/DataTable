using System;
using UnityEngine;

namespace Unity.VisualScripting;

[SerializationVersion("A", new Type[] { })]
public sealed class GraphGroup : GraphElement<IGraph>
{
	[DoNotSerialize]
	public static readonly Color defaultColor = new Color(0f, 0f, 0f);

	[Serialize]
	public Rect position { get; set; }

	[Serialize]
	public string label { get; set; } = "Group";

	[InspectorTextArea(minLines = 1f, maxLines = 10f)]
	[Serialize]
	public string comment { get; set; }

	[Serialize]
	[Inspectable]
	public Color color { get; set; } = defaultColor;
}
