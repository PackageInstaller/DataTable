using System.Runtime.InteropServices;

namespace System.Reflection;

[StructLayout(LayoutKind.Sequential)]
[ComVisible(true)]
public class LocalVariableInfo
{
	internal Type type;

	internal bool is_pinned;

	internal ushort position;

	public virtual int LocalIndex => position;

	public virtual Type LocalType => type;

	protected LocalVariableInfo()
	{
	}

	public override string ToString()
	{
		if (is_pinned)
		{
			return $"{type} ({position}) (pinned)";
		}
		return $"{type} ({position})";
	}
}
