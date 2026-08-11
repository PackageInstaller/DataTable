namespace GameFramework.Runtime;

public class LiteralSourceProxyFactory : TypedSourceProxyFactory<LiteralSourceDescription>
{
	protected override bool TryCreateProxy(object source, LiteralSourceDescription description, out ISourceProxy proxy)
	{
		object literal = description.Literal;
		if (literal != null && literal is IObservableProperty)
		{
			proxy = new ObservableLiteralSourceProxy(literal as IObservableProperty);
		}
		else
		{
			proxy = new LiteralSourceProxy(literal);
		}
		return true;
	}
}
