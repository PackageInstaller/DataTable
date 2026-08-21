using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class LightDelegateCreator
{
	private readonly LambdaExpression _lambda;

	internal Interpreter Interpreter { get; }

	internal LightDelegateCreator(Interpreter interpreter, LambdaExpression lambda)
	{
		Interpreter = interpreter;
		_lambda = lambda;
	}

	public Delegate CreateDelegate()
	{
		return CreateDelegate(null);
	}

	internal Delegate CreateDelegate(IStrongBox[] closure)
	{
		return new LightLambda(this, closure).MakeDelegate(_lambda.Type);
	}
}
