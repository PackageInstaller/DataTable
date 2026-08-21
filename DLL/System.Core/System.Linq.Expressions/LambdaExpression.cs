using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;
using System.Dynamic.Utils;
using System.Linq.Expressions.Interpreter;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(LambdaExpressionProxy))]
public abstract class LambdaExpression : Expression, IParameterProvider
{
	private readonly Expression _body;

	public sealed override Type Type => TypeCore;

	internal abstract Type TypeCore { get; }

	internal abstract Type PublicType { get; }

	public sealed override ExpressionType NodeType => ExpressionType.Lambda;

	public ReadOnlyCollection<ParameterExpression> Parameters => GetOrMakeParameters();

	public string Name => NameCore;

	internal virtual string NameCore => null;

	public Expression Body => _body;

	public Type ReturnType => Type.GetInvokeMethod().ReturnType;

	public bool TailCall => TailCallCore;

	internal virtual bool TailCallCore => false;

	[ExcludeFromCodeCoverage]
	int IParameterProvider.ParameterCount => ParameterCount;

	[ExcludeFromCodeCoverage]
	internal virtual int ParameterCount
	{
		get
		{
			throw ContractUtils.Unreachable;
		}
	}

	internal LambdaExpression(Expression body)
	{
		_body = body;
	}

	[ExcludeFromCodeCoverage]
	internal virtual ReadOnlyCollection<ParameterExpression> GetOrMakeParameters()
	{
		throw ContractUtils.Unreachable;
	}

	[ExcludeFromCodeCoverage]
	ParameterExpression IParameterProvider.GetParameter(int index)
	{
		return GetParameter(index);
	}

	[ExcludeFromCodeCoverage]
	internal virtual ParameterExpression GetParameter(int index)
	{
		throw ContractUtils.Unreachable;
	}

	public Delegate Compile()
	{
		return Compile(preferInterpretation: false);
	}

	public Delegate Compile(bool preferInterpretation)
	{
		return new LightCompiler().CompileTop(this).CreateDelegate();
	}
}
