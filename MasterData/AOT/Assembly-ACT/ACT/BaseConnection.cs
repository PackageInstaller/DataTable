namespace ACT;

public abstract class BaseConnection<T> : IConnection<T>, IConnection
{
	protected ConnectionSO<T> m_ConnectionSO;

	protected ISettingWithValue<T> m_Setting;

	public BaseConnection(ConnectionSO<T> connectionSO, ISettingWithValue<T> setting)
	{
		m_ConnectionSO = connectionSO;
		m_Setting = setting;
	}

	public virtual bool GetUsable()
	{
		return true;
	}

	public abstract T GetDefault();

	public abstract void Init(T value);

	public abstract void Set(T value);
}
