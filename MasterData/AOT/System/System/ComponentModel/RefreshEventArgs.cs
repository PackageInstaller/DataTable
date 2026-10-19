using System.Runtime.CompilerServices;

namespace System.ComponentModel;

public class RefreshEventArgs : EventArgs
{
	[CompilerGenerated]
	private readonly Type TypeChanged__BackingField;

	public RefreshEventArgs(Type typeChanged)
	{
		TypeChanged__BackingField = typeChanged;
	}
}
