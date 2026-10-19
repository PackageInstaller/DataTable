using System;
using UnityEngine;

namespace Unity.VisualScripting.Community;

[Serializable]
[UnitTitle("Comment")]
[UnitShortTitle("")]
[UnitCategory("Community\\Documentation")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.Units.Documenting.CommentUnit")]
[TypeIcon(typeof(CommentNode))]
[RenamedFrom("Lasm.Bolt.Comments.CommentUnit")]
[RenamedFrom("Lasm.BoltAddons.Helpers.CommentUnit")]
public class CommentNode : Unit
{
	public static CommentPalette style;

	public bool refresh = true;

	[Serialize]
	[Inspectable]
	public (int palette, int row, int col) paletteSelection = (palette: 0, row: 0, col: 0);

	[Inspectable]
	public bool customPalette;

	[Inspectable]
	public bool fontColorize;

	[Inspectable]
	public bool lockedToPalette;

	[Inspectable]
	public bool fontBold;

	[Inspectable]
	public bool fontItalic;

	[Inspectable]
	public bool autoWidth = true;

	[Inspectable]
	public bool hasOutline;

	[Inspectable]
	public bool hasTitle;

	[Inspectable]
	public bool alignCentre;

	[Inspectable]
	public int fontSize = 13;

	[Inspectable]
	public int maxWidth = 500;

	[InspectorTextArea]
	[UnitHeaderInspectable]
	[Inspectable]
	public string title;

	[InspectorTextArea]
	[UnitHeaderInspectable]
	[Inspectable]
	public string comment;

	[Inspectable]
	public Color color = new Color(0.1961f, 0.3333f, 0.7176f, 1f);

	[Inspectable]
	public Color fontColor = new Color(1f, 1f, 1f, 1f);

	public override bool isControlRoot => true;

	protected override void Definition()
	{
	}
}
