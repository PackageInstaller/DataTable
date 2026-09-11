using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(DebugInfoExpressionProxy))]
public class DebugInfoExpression : Expression
{
	public sealed override Type Type => typeof(void);

	public sealed override ExpressionType NodeType => ExpressionType.DebugInfo;

	[ExcludeFromCodeCoverage]
	public virtual int StartLine
	{
		get
		{
			throw ContractUtils.Unreachable;
		}
	}

	[ExcludeFromCodeCoverage]
	public virtual int StartColumn
	{
		get
		{
			throw ContractUtils.Unreachable;
		}
	}

	[ExcludeFromCodeCoverage]
	public virtual int EndLine
	{
		get
		{
			throw ContractUtils.Unreachable;
		}
	}

	[ExcludeFromCodeCoverage]
	public virtual int EndColumn
	{
		get
		{
			throw ContractUtils.Unreachable;
		}
	}

	public SymbolDocumentInfo Document { get; }

	[ExcludeFromCodeCoverage]
	public virtual bool IsClear
	{
		get
		{
			throw ContractUtils.Unreachable;
		}
	}

	internal DebugInfoExpression(SymbolDocumentInfo document)
	{
		Document = document;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitDebugInfo(this);
	}
}
