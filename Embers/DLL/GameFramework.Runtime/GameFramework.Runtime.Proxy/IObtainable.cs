namespace GameFramework.Runtime.Proxy;

public interface IObtainable
{
	object GetValue();

	TValue GetValue<TValue>();
}
