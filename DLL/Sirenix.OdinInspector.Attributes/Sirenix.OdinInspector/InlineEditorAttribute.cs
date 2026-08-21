using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All)]
public class InlineEditorAttribute : Attribute
{
	private bool expanded;

	public bool DrawHeader;

	public bool DrawGUI;

	public bool DrawPreview;

	public float MaxHeight;

	public float PreviewWidth = 100f;

	public float PreviewHeight = 35f;

	public bool IncrementInlineEditorDrawerDepth = true;

	public InlineEditorObjectFieldModes ObjectFieldMode;

	public bool DisableGUIForVCSLockedAssets = true;

	public PreviewAlignment PreviewAlignment = PreviewAlignment.Right;

	public bool Expanded
	{
		get
		{
			return expanded;
		}
		set
		{
			expanded = value;
			ExpandedHasValue = true;
		}
	}

	public bool ExpandedHasValue { get; private set; }

	public InlineEditorAttribute(InlineEditorModes inlineEditorMode = InlineEditorModes.GUIOnly, InlineEditorObjectFieldModes objectFieldMode = InlineEditorObjectFieldModes.Boxed)
	{
		ObjectFieldMode = objectFieldMode;
		switch (inlineEditorMode)
		{
		case InlineEditorModes.GUIOnly:
			DrawGUI = true;
			break;
		case InlineEditorModes.GUIAndHeader:
			DrawGUI = true;
			DrawHeader = true;
			break;
		case InlineEditorModes.GUIAndPreview:
			DrawGUI = true;
			DrawPreview = true;
			break;
		case InlineEditorModes.SmallPreview:
			expanded = true;
			DrawPreview = true;
			break;
		case InlineEditorModes.LargePreview:
			expanded = true;
			DrawPreview = true;
			PreviewHeight = 170f;
			break;
		case InlineEditorModes.FullEditor:
			DrawGUI = true;
			DrawHeader = true;
			DrawPreview = true;
			break;
		default:
			throw new NotImplementedException();
		}
	}

	public InlineEditorAttribute(InlineEditorObjectFieldModes objectFieldMode)
		: this(InlineEditorModes.GUIOnly, objectFieldMode)
	{
	}
}
