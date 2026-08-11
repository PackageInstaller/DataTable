using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class RuntimeVariables : IRuntimeVariables
{
	private readonly IStrongBox[] _boxes;

	private RuntimeVariables(IStrongBox[] boxes)
	{
		_boxes = boxes;
	}

	internal static IRuntimeVariables Create(IStrongBox[] boxes)
	{
		return new RuntimeVariables(boxes);
	}
}
