using System.Collections.Generic;

namespace System.Linq.Expressions.Interpreter;

internal abstract class OffsetInstruction : Instruction
{
	protected int _offset = int.MinValue;

	public abstract Instruction[] Cache { get; }

	public Instruction Fixup(int offset)
	{
		_offset = offset;
		Instruction[] cache = Cache;
		if (cache != null && offset >= 0 && offset < cache.Length)
		{
			return cache[offset] ?? (cache[offset] = this);
		}
		return this;
	}

	public override string ToDebugString(int instructionIndex, object cookie, Func<int, int> labelIndexer, IReadOnlyList<object> objects)
	{
		return ToString() + ((_offset != int.MinValue) ? (" -> " + (instructionIndex + _offset)) : "");
	}

	public override string ToString()
	{
		return InstructionName + ((_offset == int.MinValue) ? "(?)" : ("(" + _offset + ")"));
	}
}
