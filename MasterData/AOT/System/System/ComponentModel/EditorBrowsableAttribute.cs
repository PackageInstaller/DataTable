namespace System.ComponentModel;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Enum | AttributeTargets.Constructor | AttributeTargets.Method | AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Event | AttributeTargets.Interface | AttributeTargets.Delegate)]
public sealed class EditorBrowsableAttribute : Attribute
{
	private EditorBrowsableState browsableState;

	public EditorBrowsableState State => browsableState;

	public EditorBrowsableAttribute(EditorBrowsableState state)
	{
		browsableState = state;
	}

	public EditorBrowsableAttribute()
		: this(EditorBrowsableState.Always)
	{
	}

	public override bool Equals(object obj)
	{
		if (obj == this)
		{
			return true;
		}
		if (obj is EditorBrowsableAttribute editorBrowsableAttribute)
		{
			return editorBrowsableAttribute.browsableState == browsableState;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}
}
