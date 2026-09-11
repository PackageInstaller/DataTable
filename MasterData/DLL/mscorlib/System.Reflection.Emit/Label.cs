using System.Runtime.InteropServices;

namespace System.Reflection.Emit;

[Serializable]
[ComVisible(true)]
public readonly struct Label : IEquatable<Label>
{
	internal readonly int label;

	public override bool Equals(object obj)
	{
		bool flag = obj is Label;
		if (flag)
		{
			Label label = (Label)obj;
			flag = this.label == label.label;
		}
		return flag;
	}

	public bool Equals(Label obj)
	{
		return label == obj.label;
	}

	public override int GetHashCode()
	{
		return label.GetHashCode();
	}
}
