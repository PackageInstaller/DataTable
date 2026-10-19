namespace ACT;

public interface IConnectionSO<TValue>
{
	IConnection<TValue> CreateConnection(ISettingWithValue<TValue> owner);
}
