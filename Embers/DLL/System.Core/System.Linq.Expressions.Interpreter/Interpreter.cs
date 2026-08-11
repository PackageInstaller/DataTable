using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class Interpreter
{
	internal static readonly object NoValue = new object();

	private readonly InstructionArray _instructions;

	internal readonly object[] _objects;

	internal readonly RuntimeLabel[] _labels;

	internal readonly DebugInfo[] _debugInfos;

	internal string Name { get; }

	internal int LocalCount { get; }

	internal int ClosureSize => ClosureVariables?.Count ?? 0;

	internal InstructionArray Instructions => _instructions;

	internal Dictionary<ParameterExpression, LocalVariable> ClosureVariables { get; }

	internal Interpreter(string name, LocalVariables locals, InstructionArray instructions, DebugInfo[] debugInfos)
	{
		Name = name;
		LocalCount = locals.LocalCount;
		ClosureVariables = locals.ClosureVariables;
		_instructions = instructions;
		_objects = instructions.Objects;
		_labels = instructions.Labels;
		_debugInfos = debugInfos;
	}

	[MethodImpl((MethodImplOptions)8)]
	public void Run(InterpretedFrame frame)
	{
		Instruction[] instructions = _instructions.Instructions;
		for (int num = frame.InstructionIndex; num < instructions.Length; num = (frame.InstructionIndex = num + instructions[num].Run(frame)))
		{
		}
	}
}
