namespace System.Linq.Expressions;

internal sealed class SpanDebugInfoExpression : DebugInfoExpression
{
	private readonly int _startLine;

	private readonly int _startColumn;

	private readonly int _endLine;

	private readonly int _endColumn;

	public override int StartLine => _startLine;

	public override int StartColumn => _startColumn;

	public override int EndLine => _endLine;

	public override int EndColumn => _endColumn;

	public override bool IsClear => false;

	internal SpanDebugInfoExpression(SymbolDocumentInfo document, int startLine, int startColumn, int endLine, int endColumn)
		: base(document)
	{
		_startLine = startLine;
		_startColumn = startColumn;
		_endLine = endLine;
		_endColumn = endColumn;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitDebugInfo(this);
	}
}
