namespace System.Linq.Expressions.Interpreter;

internal interface IBoxableInstruction
{
	Instruction BoxIfIndexMatches(int index);
}
