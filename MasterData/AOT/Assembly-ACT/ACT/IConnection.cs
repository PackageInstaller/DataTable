namespace ACT;

public interface IConnection
{
}
public interface IConnection<TValue> : IConnection
{
	bool GetUsable();

	TValue GetDefault();

	void Init(TValue value);

	void Set(TValue value);
}
