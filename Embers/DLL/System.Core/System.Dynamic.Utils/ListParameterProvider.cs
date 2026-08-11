using System.Linq.Expressions;

namespace System.Dynamic.Utils;

internal sealed class ListParameterProvider : ListProvider<ParameterExpression>
{
	private readonly IParameterProvider _provider;

	private readonly ParameterExpression _arg0;

	protected override ParameterExpression First => _arg0;

	protected override int ElementCount => _provider.ParameterCount;

	internal ListParameterProvider(IParameterProvider provider, ParameterExpression arg0)
	{
		_provider = provider;
		_arg0 = arg0;
	}

	protected override ParameterExpression GetElement(int index)
	{
		return _provider.GetParameter(index);
	}
}
