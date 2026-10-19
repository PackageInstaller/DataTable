using System;
using System.Diagnostics;
using UnityEngine;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public class PreviewFieldAttribute : Attribute
{
	private ObjectFieldAlignment alignment;

	private bool alignmentHasValue;

	private string previewGetter;

	public float Height;

	public FilterMode FilterMode = FilterMode.Bilinear;

	public ObjectFieldAlignment Alignment
	{
		get
		{
			return alignment;
		}
		set
		{
			alignment = value;
			alignmentHasValue = true;
		}
	}

	public bool AlignmentHasValue => alignmentHasValue;

	public string PreviewGetter
	{
		get
		{
			return previewGetter;
		}
		set
		{
			previewGetter = value;
			PreviewGetterHasValue = true;
		}
	}

	public bool PreviewGetterHasValue { get; private set; }

	public PreviewFieldAttribute()
	{
		Height = 0f;
	}

	public PreviewFieldAttribute(float height)
	{
		Height = height;
	}

	public PreviewFieldAttribute(string previewGetter, FilterMode filterMode = FilterMode.Bilinear)
	{
		PreviewGetter = previewGetter;
		FilterMode = filterMode;
	}

	public PreviewFieldAttribute(string previewGetter, float height, FilterMode filterMode = FilterMode.Bilinear)
	{
		PreviewGetter = previewGetter;
		Height = height;
		FilterMode = filterMode;
	}

	public PreviewFieldAttribute(float height, ObjectFieldAlignment alignment)
	{
		Height = height;
		Alignment = alignment;
	}

	public PreviewFieldAttribute(string previewGetter, ObjectFieldAlignment alignment, FilterMode filterMode = FilterMode.Bilinear)
	{
		PreviewGetter = previewGetter;
		Alignment = alignment;
		FilterMode = filterMode;
	}

	public PreviewFieldAttribute(string previewGetter, float height, ObjectFieldAlignment alignment, FilterMode filterMode = FilterMode.Bilinear)
	{
		PreviewGetter = previewGetter;
		Height = height;
		Alignment = alignment;
		FilterMode = filterMode;
	}

	public PreviewFieldAttribute(ObjectFieldAlignment alignment)
	{
		Alignment = alignment;
	}
}
