using System.Linq.Expressions;

namespace System.Dynamic.Utils;

internal sealed class ListArgumentProvider : ListProvider<Expression>
{
	private readonly IArgumentProvider _provider;

	private readonly Expression _arg0;

	protected override Expression First => _arg0;

	protected override int ElementCount => _provider.ArgumentCount;

	internal ListArgumentProvider(IArgumentProvider provider, Expression arg0)
	{
		_provider = provider;
		_arg0 = arg0;
	}

	protected override Expression GetElement(int index)
	{
		return _provider.GetArgument(index);
	}
}
