using System.Collections.Generic;
using System.Diagnostics;
using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

[DebuggerTypeProxy(typeof(DebugView))]
internal readonly struct InstructionArray
{
	internal sealed class DebugView
	{
		private readonly InstructionArray _array;

		public DebugView(InstructionArray array)
		{
			ContractUtils.RequiresNotNull(array, "array");
			_array = array;
		}

		public InstructionList.DebugView.InstructionView[] GetInstructionViews(bool includeDebugCookies = false)
		{
			return InstructionList.DebugView.GetInstructionViews(_array.Instructions, _array.Objects, (int index) => _array.Labels[index].Index, includeDebugCookies ? _array.DebugCookies : null);
		}
	}

	internal readonly int MaxStackDepth;

	internal readonly int MaxContinuationDepth;

	internal readonly Instruction[] Instructions;

	internal readonly object[] Objects;

	internal readonly RuntimeLabel[] Labels;

	internal readonly List<KeyValuePair<int, object>> DebugCookies;

	internal InstructionArray(int maxStackDepth, int maxContinuationDepth, Instruction[] instructions, object[] objects, RuntimeLabel[] labels, List<KeyValuePair<int, object>> debugCookies)
	{
		MaxStackDepth = maxStackDepth;
		MaxContinuationDepth = maxContinuationDepth;
		Instructions = instructions;
		DebugCookies = debugCookies;
		Objects = objects;
		Labels = labels;
	}
}
