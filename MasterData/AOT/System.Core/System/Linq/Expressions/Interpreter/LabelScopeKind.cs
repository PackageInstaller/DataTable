namespace System.Linq.Expressions.Interpreter;

internal enum LabelScopeKind
{
	Statement,
	Block,
	Switch,
	Lambda,
	Try,
	Catch,
	Finally,
	Filter,
	Expression
}
