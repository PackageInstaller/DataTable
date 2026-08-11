namespace System.Linq.Expressions;

internal sealed class ClearDebugInfoExpression : DebugInfoExpression
{
	public override bool IsClear => true;

	public override int StartLine => 16707566;

	public override int StartColumn => 0;

	public override int EndLine => 16707566;

	public override int EndColumn => 0;

	internal ClearDebugInfoExpression(SymbolDocumentInfo document)
		: base(document)
	{
	}
}
