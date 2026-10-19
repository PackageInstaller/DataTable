using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Parameter, AllowMultiple = false, Inherited = true)]
public sealed class InspectorTextAreaAttribute : Attribute
{
	private float? _minLines;

	private float? _maxLines;

	public float minLines
	{
		get
		{
			return _minLines.GetValueOrDefault();
		}
		set
		{
			_minLines = value;
		}
	}

	public bool hasMinLines => _minLines.HasValue;

	public float maxLines
	{
		get
		{
			return _maxLines.GetValueOrDefault();
		}
		set
		{
			_maxLines = value;
		}
	}

	public bool hasMaxLines => _maxLines.HasValue;
}
