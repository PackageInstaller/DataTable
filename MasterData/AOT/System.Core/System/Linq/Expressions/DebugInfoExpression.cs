using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(DebugInfoExpressionProxy))]
public class DebugInfoExpression : Expression
{
	[ExcludeFromCodeCoverage]
	public virtual int StartLine
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

	public SymbolDocumentInfo Document { get; }

	[ExcludeFromCodeCoverage]
	public virtual bool IsClear
	{
		get
		{
			throw ContractUtils.Unreachable;
		}
	}
}
